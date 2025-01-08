return {
    'neovim/nvim-lspconfig',
    dependencies = {
        -- LSP Support
        { 'williamboman/mason.nvim' },
        { 'williamboman/mason-lspconfig.nvim' },

        -- Autocomplete
        { 'hrsh7th/nvim-cmp' },
        { 'hrsh7th/cmp-buffer' },
        { 'hrsh7th/cmp-path' },
        { 'hrsh7th/cmp-nvim-lsp' },
        { 'hrsh7th/cmp-nvim-lua' },

        -- Snippets
        { 'L3MON4D3/LuaSnip' },
        { 'rafamadriz/friendly-snippets' },

        -- Go Support
        { "ray-x/go.nvim" },
        { "ray-x/guihua.lua" },

    },
    config = require("lsp").setup(),
}
