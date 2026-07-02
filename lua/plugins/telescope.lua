local ok, telescope = pcall(require, "telescope")
if not ok then
    return
end

telescope.setup({
    defaults = {
        prompt_prefix = "> ",
        sorting_strategy = "ascending",
        layout_strategy = "horizontal",

        -- Open picks in a normal window, never a special one (e.g. the
        -- neo-tree sidebar), falling back to the current window
        get_selection_window = function()
            if vim.bo.buftype == "" then
                return vim.api.nvim_get_current_win()
            end
            for _, win in ipairs(vim.api.nvim_list_wins()) do
                local buf = vim.api.nvim_win_get_buf(win)
                if vim.bo[buf].buftype == "" then
                    return win
                end
            end
            return 0
        end,
    },
})

local ok_builtin, builtin = pcall(require, "telescope.builtin")
if not ok_builtin then
    return
end

local map = require("lib.map").map

map("n", "<leader>ff", builtin.find_files, "Find files")
map("n", "<leader>fg", builtin.live_grep, "Live grep")
map("n", "<leader>fd", builtin.diagnostics, "Diagnostics")
map("n", "<leader>fb", builtin.buffers, "Buffers")
map("n", "<leader>fh", builtin.help_tags, "Help tags")
map("n", "<leader>fk", builtin.keymaps, "Keymaps")
