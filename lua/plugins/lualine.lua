local ok, lualine = pcall(require, "lualine")
if not ok then
    return
end

lualine.setup({
    options = {
        globalstatus = true,
        icons_enabled = true,
        theme = "auto",
        component_separators = { left = "", right = "" },
        section_separators = { left = "", right = "" },
        -- Neo-tree draws its own winbar (the source selector tabs)
        disabled_filetypes = {
            winbar = { "neo-tree" },
        },
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "filetype" },
        lualine_y = { "progress" },
        lualine_z = { "location" },
    },
    winbar = {
        lualine_c = { "diagnostics", { "filename", path = 1 } },
    },
    inactive_winbar = {
        lualine_c = { "diagnostics", { "filename", path = 1 } },
    },
})
