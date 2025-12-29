local M = {}

function M.check()
    vim.health.start("nvim-config")

    -- Neovim version check (requires 0.12+ for vim.pack and vim.lsp.config)
    local version = vim.version()
    local version_str = string.format("%d.%d.%d", version.major, version.minor, version.patch)
    if version.major == 0 and version.minor < 12 then
        vim.health.error("Neovim 0.12+ required (found " .. version_str .. ")")
    else
        vim.health.ok("Neovim " .. version_str)
    end

    -- Required tools
    local required = {
        { "git", "Version control" },
        { "rg", "Telescope live grep (ripgrep)" },
        { "fd", "Telescope find files" },
    }

    for _, tool in ipairs(required) do
        local cmd, desc = tool[1], tool[2]
        if vim.fn.executable(cmd) == 1 then
            vim.health.ok(cmd .. " - " .. desc)
        else
            vim.health.error(cmd .. " not found - " .. desc)
        end
    end

    -- LSP servers (optional)
    vim.health.start("LSP servers")

    local servers = {
        { "gopls", "Go" },
        { "lua-language-server", "Lua" },
        { "typescript-language-server", "TypeScript/JavaScript" },
        { "vscode-html-language-server", "HTML" },
        { "vscode-css-language-server", "CSS" },
    }

    for _, server in ipairs(servers) do
        local cmd, lang = server[1], server[2]
        if vim.fn.executable(cmd) == 1 then
            vim.health.ok(cmd .. " - " .. lang)
        else
            vim.health.warn(cmd .. " not found - " .. lang .. " LSP disabled")
        end
    end
end

return M
