---@meta
--- Handles the setup of Mason and the installation of LSP servers.
--- Ensures required servers are installed and configured via Mason.

---@param lsp_zero table The LSP Zero preset instance.
return function(lsp_zero)
    require("mason").setup()
    require("mason-lspconfig").setup({
        handlers = {
            function(server_name)
                require("lspconfig")[server_name].setup({
                    capabilities = lsp_zero:get_capabilities(),
                })
            end,
        },
    })
end
