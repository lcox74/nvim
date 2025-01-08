---@meta
--- Configures language-specific settings for LSP servers.
--- Includes custom configurations for Lua, GDScript, and Go.

---@param lsp_zero table The LSP Zero preset instance.
return function(lsp_zero)
    local lspconfig = require("lspconfig")

    -- Lua
    lspconfig.lua_ls.setup({
        settings = {
            Lua = {
                diagnostics = { globals = { "vim" } },
            },
        },
    })

    -- GDScript
    lspconfig.gdscript.setup({
        capabilities = lsp_zero:get_capabilities(),
    })

    -- Go
    require("go").setup({})
    local format_sync_grp = vim.api.nvim_create_augroup("goimports", {})
    vim.api.nvim_create_autocmd("BufWritePre", {
        pattern = "*.go",
        callback = function()
            require("go.format").goimports()
        end,
        group = format_sync_grp,
    })
end
