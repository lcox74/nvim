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

vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live grep" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })
vim.keymap.set("n", "<leader>fb", builtin.buffers, { desc = "Buffers" })
vim.keymap.set("n", "<leader>fh", builtin.help_tags, { desc = "Help tags" })
