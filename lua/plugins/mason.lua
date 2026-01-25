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

-- Packages to ensure are installed
local ensure_installed = {
    -- Language servers
    "bash-language-server",
    "css-lsp",
    "docker-language-server",
    "gopls",
    "html-lsp",
    "just-lsp",
    "lua-language-server",
    "sqls",
    "typescript-language-server",
    "yaml-language-server",

    -- Linters
    "shellcheck",
    "sqlfluff",

    -- Formatters
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
