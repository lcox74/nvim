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

-- Configured packages (use :MasonInstallConfigured to install)
local configured_packages = {
    "gopls",                        -- Go
    "lua-language-server",          -- Lua
    "typescript-language-server",   -- TypeScript/JavaScript
    "html-lsp",                     -- HTML
    "css-lsp",                      -- CSS
}

-- Command to install all configured packages
vim.api.nvim_create_user_command("MasonInstallConfigured", function()
    local registry = require("mason-registry")
    registry.refresh(function()
        local to_install = {}
        for _, name in ipairs(configured_packages) do
            local has_pkg, pkg = pcall(registry.get_package, name)
            if has_pkg and not pkg:is_installed() then
                table.insert(to_install, name)
            end
        end
        if #to_install == 0 then
            vim.notify("All configured packages already installed", vim.log.levels.INFO)
        else
            vim.notify("Installing: " .. table.concat(to_install, ", "), vim.log.levels.INFO)
            for _, name in ipairs(to_install) do
                local pkg = registry.get_package(name)
                pkg:install()
            end
            vim.notify("Restart Neovim after installation completes for LSP to detect new servers", vim.log.levels.WARN)
        end
    end)
end, { desc = "Install all configured Mason packages" })
