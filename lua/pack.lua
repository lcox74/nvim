local pack = vim.pack

pack.add({
    -- Navigation
    { src = "https://github.com/nvim-lua/plenary.nvim" },
    { src = "https://github.com/nvim-telescope/telescope.nvim" },

    -- Syntax
    {
        src = "https://github.com/nvim-treesitter/nvim-treesitter",
        build = ":TSUpdate",
    },

    -- LSP Package Manager
    { src = "https://github.com/mason-org/mason.nvim" },
    
    -- Buffer line
    { src = "https://github.com/nvim-tree/nvim-web-devicons" },
    { src = "https://github.com/romgrk/barbar.nvim" },

     -- Colour Scheme
    { src = "https://github.com/catppuccin/nvim" },
})
