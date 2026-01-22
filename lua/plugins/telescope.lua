local ok, telescope = pcall(require, "telescope")
if not ok then
    return
end

telescope.setup({
    defaults = {
        prompt_prefix = "> ",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",
    },
})

local ok_builtin, builtin = pcall(require, "telescope.builtin")
if not ok_builtin then
    return
end

local map = require("core.map").map

map("n", "<leader>ff", builtin.find_files, "Find files")
map("n", "<leader>fg", builtin.live_grep, "Live grep")
map("n", "<leader>fd", builtin.diagnostics, "Diagnostics")
map("n", "<leader>fb", builtin.buffers, "Buffers")
map("n", "<leader>fh", builtin.help_tags, "Help tags")
