-- Build library paths for Neovim Lua development
local library = {
    vim.env.VIMRUNTIME,
    vim.fn.stdpath("config"),
}

-- Add installed plugins to library
local pack_path = vim.fn.stdpath("data") .. "/site/pack"
for _, plugin in ipairs(vim.fn.glob(pack_path .. "/*/opt/*", false, true)) do
    table.insert(library, plugin)
end
for _, plugin in ipairs(vim.fn.glob(pack_path .. "/*/start/*", false, true)) do
    table.insert(library, plugin)
end

return {
    name = "lua_ls",
    cmd = "lua-language-server",
    config = {
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
                    checkThirdParty = false,
                },
                telemetry = {
                    enable = false,
                },
            },
        },
    },
}
