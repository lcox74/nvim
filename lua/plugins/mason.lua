local ok, mason = pcall(require, "mason")
if not ok then
    return
end

mason.setup({
    PATH = "prepend",
    ui = {
        border = "rounded",
        icons = {
            package_installed = "[+]",
            package_pending = "[~]",
            package_uninstalled = "[-]",
        },
    },
})

-- Language servers (lspconfig names): mason-lspconfig installs missing ones
-- and enables every installed server via vim.lsp.enable, using the configs
-- from nvim-lspconfig merged with any overrides in <config>/lsp/<name>.lua
local ok_mlsp, mason_lspconfig = pcall(require, "mason-lspconfig")
if ok_mlsp then
    mason_lspconfig.setup({
        ensure_installed = {
            "bashls",
            "cssls",
            "docker_language_server",
            "gopls",
            "html",
            "just",
            "lua_ls",
            "sqls",
            "ts_ls",
            "yamlls",
        },
        automatic_enable = true,
    })
end

-- Non-LSP tools (mason package names)
local ensure_installed = {
    -- Linters
    "shellcheck", -- picked up by bashls automatically
    "sqlfluff",

    -- Formatters (run by conform.nvim)
    "prettier",
    "shfmt",
}

-- Auto-install missing packages on startup
local registry = require("mason-registry")
registry.refresh(function()
    for _, name in ipairs(ensure_installed) do
        local has_pkg, pkg = pcall(registry.get_package, name)
        if has_pkg and not pkg:is_installed() then
            vim.notify("Mason: installing " .. name, vim.log.levels.INFO)
            pkg:install()
        end
    end
end)
