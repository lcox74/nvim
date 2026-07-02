local ac = require("lib.autocmd")
local autocmd = ac.autocmd
local augroup = ac.augroup

-- Highlight on yank
augroup("yank-highlight", { clear = true })
autocmd("TextYankPost", {
    desc = "Highlight when yanking (copying) text",
    group = "yank-highlight",
    callback = function()
        vim.hl.on_yank({ timeout = 150 })
    end,
})

-- Format on save
augroup("format-on-save", { clear = true })
autocmd("BufWritePre", {
    desc = "Format buffer before saving",
    group = "format-on-save",
    callback = function(ev)
        local host = vim.g.host or {}
        if host.disable_format then
            return
        end

        -- Prefer conform's formatters, falling back to LSP formatting
        local ok, conform = pcall(require, "conform")
        if ok then
            conform.format({ bufnr = ev.buf, timeout_ms = 3000, lsp_format = "fallback" })
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
augroup("restore-cursor", { clear = true })
autocmd("BufReadPost", {
    desc = "Restore cursor position when reopening files",
    group = "restore-cursor",
    callback = function()
        local mark = vim.api.nvim_buf_get_mark(0, '"')
        local line_count = vim.api.nvim_buf_line_count(0)
        if mark[1] > 0 and mark[1] <= line_count then
            pcall(vim.api.nvim_win_set_cursor, 0, mark)
        end
    end,
})

-- Close help, quickfix, man pages with 'q'
augroup("close-with-q", { clear = true })
autocmd("FileType", {
    desc = "Close special buffers with q",
    group = "close-with-q",
    pattern = { "help", "qf", "man", "lspinfo", "notify" },
    callback = function(event)
        vim.bo[event.buf].buflisted = false
        vim.keymap.set("n", "q", "<cmd>close<CR>", { buffer = event.buf, silent = true })
    end,
})

-- Auto-resize splits when terminal window is resized
augroup("resize-splits", { clear = true })
autocmd("VimResized", {
    desc = "Auto-resize splits on terminal resize",
    group = "resize-splits",
    callback = function()
        vim.cmd("tabdo wincmd =")
    end,
})

-- Check for external file changes on focus
augroup("checktime", { clear = true })
autocmd({ "FocusGained", "TermClose", "TermLeave" }, {
    desc = "Check for external file changes",
    group = "checktime",
    callback = function()
        if vim.o.buftype ~= "nofile" then
            vim.cmd("checktime")
        end
    end,
})

-- Trim trailing whitespace on save
augroup("trim-whitespace", { clear = true })
autocmd("BufWritePre", {
    desc = "Trim trailing whitespace on save",
    group = "trim-whitespace",
    callback = function(ev)
        -- Trailing whitespace is meaningful in these filetypes
        local ft = vim.bo[ev.buf].filetype
        if ft == "markdown" or ft == "diff" or ft == "gitsendemail" then
            return
        end

        local save_cursor = vim.fn.getpos(".")
        vim.cmd([[%s/\s\+$//e]])
        vim.fn.setpos(".", save_cursor)
    end,
})

-- Auto-create parent directories when saving a new file
augroup("auto-create-dir", { clear = true })
autocmd("BufWritePre", {
    desc = "Auto-create parent directories",
    group = "auto-create-dir",
    callback = function(event)
        if event.match:match("^%w%w+://") then
            return
        end

        local file = vim.uv.fs_realpath(event.match) or event.match
        vim.fn.mkdir(vim.fn.fnamemodify(file, ":p:h"), "p")
    end,
})

-- Toggle relative line numbers based on mode
augroup("relative-numbers", { clear = true })

-- Only touch the current window, and skip special windows (telescope
-- prompt, neo-tree, etc.) so their settings don't get clobbered
autocmd("InsertEnter", {
    desc = "Use absolute line numbers in insert mode",
    group = "relative-numbers",
    callback = function()
        if vim.bo.buftype == "" and vim.wo.number then
            vim.wo.relativenumber = false
        end
    end,
})

autocmd("InsertLeave", {
    desc = "Use relative line numbers in normal mode",
    group = "relative-numbers",
    callback = function()
        if vim.bo.buftype == "" and vim.wo.number then
            vim.wo.relativenumber = true
        end
    end,
})
