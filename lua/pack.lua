local pack = vim.pack

local gh = function(x) return "https://github.com/" .. x end

-- Barbar configures itself in plugins/barbar.lua
vim.g.barbar_auto_setup = false

pack.add({
    -- Navigation
    { src = gh("nvim-lua/plenary.nvim") },
    { src = gh("nvim-telescope/telescope.nvim") },
    { src = gh("MunifTanjim/nui.nvim") },
    { src = gh("nvim-neo-tree/neo-tree.nvim"), version = "v3.x" },

    -- Syntax
    { src = gh("nvim-treesitter/nvim-treesitter") },

    -- LSP
    { src = gh("neovim/nvim-lspconfig") },
    { src = gh("mason-org/mason.nvim") },
    { src = gh("mason-org/mason-lspconfig.nvim") },

    -- Formatting
    { src = gh("stevearc/conform.nvim") },

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

    -- Icons (used by lualine, telescope, etc.)
    { src = gh("nvim-tree/nvim-web-devicons") },

    -- Status line
    { src = gh("nvim-lualine/lualine.nvim") },

    -- Buffer line
    { src = gh("romgrk/barbar.nvim"), version = vim.version.range("1.x") },

    -- Colour Scheme
    { src = gh("catppuccin/nvim"), name = "catppuccin" },
})

-- Load plugins from plugins/ directory
require("lib.loader").dir("plugins")
