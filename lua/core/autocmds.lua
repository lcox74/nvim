local augroup = vim.api.nvim_create_augroup

-- Highlight on yank
vim.api.nvim_create_autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = augroup("yank-highlight", { clear = true }),
    callback = function()
        vim.highlight.on_yank({ timeout = 150 })
    end,
})

-- Format on save
vim.api.nvim_create_autocmd("BufWritePre", {
    desc = "Format buffer before saving",
    group = augroup("format-on-save", { clear = true }),
    callback = function(ev)
        local host = vim.g.host or {}
        if host.disable_format then
            return
        end

        -- Only format if an LSP client with formatting capability is attached
        local clients = vim.lsp.get_clients({ bufnr = ev.buf })
        for _, client in ipairs(clients) do
            if client:supports_method("textDocument/formatting") then
                vim.lsp.buf.format({ bufnr = ev.buf, timeout_ms = 3000 })
                return
            end
        end
    end,
})

-- Restore cursor position when reopening files
vim.api.nvim_create_autocmd("BufReadPost", {
    desc = "Restore cursor position when reopening files",
    group = augroup("restore-cursor", { clear = true }),
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local line_count = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= line_count then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Close help, quickfix, man pages with 'q'
vim.api.nvim_create_autocmd("FileType", {
    desc = "Close special buffers with q",
    group = augroup("close-with-q", { clear = true }),
    pattern = { "help", "qf", "man", "lspinfo", "notify" },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
    end,
})

-- Auto-resize splits when terminal window is resized
vim.api.nvim_create_autocmd("VimResized", {
    desc = "Auto-resize splits on terminal resize",
    group = augroup("resize-splits", { clear = true }),
    callback = function()
        vim.cmd("tabdo wincmd =")
    end,
})

-- Check for external file changes on focus
vim.api.nvim_create_autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    desc = "Check for external file changes",
    group = augroup("checktime", { clear = true }),
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")
        end
    end,
})

-- Trim trailing whitespace on save
vim.api.nvim_create_autocmd("BufWritePre", {
    desc = "Trim trailing whitespace on save",
    group = augroup("trim-whitespace", { clear = true }),
    callback = function()
        local save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
})

-- Auto-create parent directories when saving a new file
vim.api.nvim_create_autocmd("BufWritePre", {
    desc = "Auto-create parent directories",
    group = augroup("auto-create-dir", { clear = true }),
    callback = function(event)
        if event.match:match("^%w%w+://") then
            return
        end
        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})
