local pack = vim.pack

local gh = function(x) return "https://github.com/" .. x end

pack.add({
    -- Navigation
    { src = gh("nvim-lua/plenary.nvim") },
    { src = gh("nvim-telescope/telescope.nvim") },

    -- Syntax
    { src = gh("nvim-treesitter/nvim-treesitter"), build = ":TSUpdate" },

    -- LSP Package Manager
    { src = gh("mason-org/mason.nvim") },

    -- Completion
    { src = gh("hrsh7th/nvim-cmp") },
    { src = gh("hrsh7th/cmp-nvim-lsp") },
    { src = gh("hrsh7th/cmp-buffer") },
    { src = gh("hrsh7th/cmp-path") },

    -- Snippets
    { src = gh("L3MON4D3/LuaSnip") },
    { src = gh("saadparwaiz1/cmp_luasnip") },
    { src = gh("rafamadriz/friendly-snippets") },

    -- Git
    { src = gh("lewis6991/gitsigns.nvim") },

    -- Editing
    { src = gh("windwp/nvim-autopairs") },
    { src = gh("numToStr/Comment.nvim") },

    -- Markdown
    { src = gh("OXY2DEV/markview.nvim") },

    -- Icons (used by lualine, telescope, etc.)
    { src = gh("nvim-tree/nvim-web-devicons") },

    -- Status line
    { src = gh("nvim-lualine/lualine.nvim") },

    -- Colour Scheme
    { src = gh("catppuccin/nvim") },
})

-- Load plugins from plugins/ directory
require("core.loader").dir("plugins")
