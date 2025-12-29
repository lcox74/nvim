local pack = vim.pack

local gh = function(x) return 'https://github.com/' .. x end

pack.add({
    -- Navigation
    { src = gh("nvim-lua/plenary.nvim") },
    { src = gh("nvim-telescope/telescope.nvim") },

    -- Syntax
    { src = gh("nvim-treesitter/nvim-treesitter"), build = ":TSUpdate" },

    -- LSP Package Manager
    { src = gh("mason-org/mason.nvim") },

    -- Buffer line
    { src = gh("nvim-tree/nvim-web-devicons") },
    { src = gh("romgrk/barbar.nvim") },

    -- Colour Scheme
    { src = gh("catppuccin/nvim") },
})
