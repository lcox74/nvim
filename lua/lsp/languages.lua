---@meta
--- Configures language-specific settings for LSP servers.
--- Includes custom configurations for Lua, GDScript, and Go.

return function()
    local lspconfig = require("lspconfig")

    -- Lua
    lspconfig.lua_ls.setup({
        settings = {
            Lua = {
                diagnostics = { globals = { "vim" } },
            },
        },
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
