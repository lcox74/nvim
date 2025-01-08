return {
    "VonHeikemen/lsp-zero.nvim",
    branch = 'v4.x',
    dependencies = {
        -- LSP Support
        { 'neovim/nvim-lspconfig' },
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
    opts = function()
        local lsp = require("lsp-zero")

        -- Setup
        require("lsp.mason")(lsp)
        require("lsp.languages")(lsp)
        require("lsp.cmp")()
        require("lsp.diagnostics")()
        lsp.on_attach(require("lsp.attach"))
        lsp.setup()
    end,
}
