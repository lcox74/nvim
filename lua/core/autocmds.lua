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
