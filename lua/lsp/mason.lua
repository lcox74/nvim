---@meta
--- Handles Mason setup and ensures required LSP servers are installed.
return function()
    local mason = require("mason")
    local mason_lspconfig = require("mason-lspconfig")
    local lspconfig = require("lspconfig")

    mason.setup({
        ui = {
            icons = {
                package_installed = "i",
                package_pending = "p",
                package_uninstalled = "x"
            }
        }
    })

    mason_lspconfig.setup({
        ensure_installed = {
            "gopls",
            "html",
            "eslint",
            "tailwindcss",
            "cssls",
            "lua_ls",
        },

        automatic_installation = true,
    })
    mason_lspconfig.setup_handlers({
        function(server_name)
            lspconfig[server_name].setup({
                capabilities = require("cmp_nvim_lsp").default_capabilities(),
                on_attach = require("lsp.attach"),
            })
        end,
    })
end
