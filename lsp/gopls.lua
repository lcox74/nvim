-- Merged over nvim-lspconfig's gopls defaults (cmd, filetypes, root markers)

-- Auto-organize imports on save
vim.api.nvim_create_autocmd("BufWritePre", {
    group = vim.api.nvim_create_augroup("GoOrganizeImports", { clear = true }),
    pattern = "*.go",
    callback = function()
        local clients = vim.lsp.get_clients({ bufnr = 0, name = "gopls" })
        if #clients == 0 then
            return
        end

        local client = clients[1]
        local encoding = client.offset_encoding or "utf-16"
        local params = vim.lsp.util.make_range_params(0, encoding)
        ---@diagnostic disable-next-line: inject-field
        params.context = { only = { "source.organizeImports" } }

        local result = vim.lsp.buf_request_sync(0, "textDocument/codeAction", params, 1000)
        for _, res in pairs(result or {}) do
            for _, r in pairs(res.result or {}) do
                if r.edit then
                    vim.lsp.util.apply_workspace_edit(r.edit, encoding)
                end
            end
        end
    end,
})

return {
    settings = {
        gopls = {
            gofumpt = true,
            staticcheck = true,
            completeUnimported = true,
            usePlaceholders = true,
            analyses = {
                unusedparams = true,
                shadow = true,
            },
        },
    },
}
