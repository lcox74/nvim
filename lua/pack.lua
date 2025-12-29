local pack = vim.pack

pack.add({
    -- Telescope dependency
    { src = "https://github.com/nvim-lua/plenary.nvim" },

    -- Navigation / search
    { src = "https://github.com/nvim-telescope/telescope.nvim" },

    -- Syntax / structure
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },

    -- Colour Scheme
    { src = "https://github.com/catppuccin/nvim" },

    -- Mason: optional package manager for LSP/formatters/linters
    { src = "https://github.com/mason-org/mason.nvim" },

    -- File icons
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },

    -- Buffer line
    { src = "https://github.com/romgrk/barbar.nvim" },
})
