-- Build library paths for Neovim Lua development
local library = {
    vim.env.VIMRUNTIME,
    vim.fn.stdpath("config"),
}

-- Add installed plugins to library
local pack_path = vim.fn.stdpath("data") .. "/site/pack/packages/opt"
for _, plugin in ipairs(vim.fn.glob(pack_path .. "/*", false, true)) do
    table.insert(library, plugin)
end

return {
    cmd = { "lua-language-server" },
    filetypes = { "lua" },
    root_markers = { ".luarc.json", ".git" },
    settings = {
        Lua = {
            runtime = {
                version = "LuaJIT",
            },
            workspace = {
                library = library,
                -- Disable third-party library prompts (we manually specify libraries above)
                checkThirdParty = false,
            },
            telemetry = {
                enable = false,
            },
        },
    },
}
