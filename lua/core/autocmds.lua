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

-- Show diagnostic float on cursor hold
vim.api.nvim_create_autocmd("CursorHold", {
    desc = "Show diagnostic float on cursor hold",
    group = augroup("diagnostic-float", { clear = true }),
    callback = function()
        local line = vim.api.nvim_win_get_cursor(0)[1] - 1
        local diagnostics = vim.diagnostic.get(0, { lnum = line })
        if #diagnostics > 0 then
            vim.diagnostic.open_float({ focus = false, scope = "line" })
        end
    end,
})

-- Toggle relative line numbers based on mode
local relative_numbers_group = augroup("relative-numbers", { clear = true })

vim.api.nvim_create_autocmd("InsertEnter", {
    desc = "Use absolute line numbers in insert mode",
    group = relative_numbers_group,
    callback = function()
        vim.opt.relativenumber = false
    end,
})

vim.api.nvim_create_autocmd("InsertLeave", {
    desc = "Use relative line numbers in normal mode",
    group = relative_numbers_group,
    callback = function()
        vim.opt.relativenumber = true
    end,
})
