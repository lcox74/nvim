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
    },
    sections = {
        lualine_a = { "mode" },
        lualine_b = { "diff", "diagnostics" },
        lualine_c = { "filename" },
        lualine_x = { "filetype" },
        lualine_y = { "progrss" },
        lualine_z = { "location" },
    },
    winbar = {
        lualine_c = { "diagnostics", { "filename", path = 1 } },
    },
    inactive_winbar = {
        lualine_c = { "diagnostics", { "filename", path = 1 } },
    },
})
