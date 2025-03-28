return {
    "nvim-telescope/telescope.nvim",
    branch = "0.1.x",
    dependencies = { 
        "nvim-lua/plenary.nvim",
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    opts = {
        defaults = {
            mappings = {
                i = {
                    ["<C-u>"] = false, -- Disable C-u in insert mode
                },
            },
        },
    },
    config = function(_, opts)
        local telescope = require("telescope")

        telescope.setup(opts)

        telescope.load_extension("fzf");

        -- Telescope keymaps
        local builtin = require("telescope.builtin")
        vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
        vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
        vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })
        vim.keymap.set('n', '<leader>fb', builtin.buffers, { desc = 'Telescope buffers' })
        vim.keymap.set('n', '<leader>fh', builtin.help_tags, { desc = 'Telescope help tags' })
    end,
}
