-- Declare vim as a global variable to avoid undefined warnings
---@diagnostic disable-next-line: undefined-global
local vim = vim

-- Only required if you have packer configured as `opt`
vim.cmd [[packadd packer.nvim]]

return require('packer').startup(function(use)
    -- Packer can manage itself
    use 'wbthomason/packer.nvim'

    -- Telescope: Advanced file search
    use {
        'nvim-telescope/telescope.nvim', tag = '0.1.8',
        requires = { { 'nvim-lua/plenary.nvim' } },
        config = function() require("coxy.plugin_config.telescope") end
    }

    -- Colour Schemes
    use {
        'Mofiqul/vscode.nvim',
        config = vim.cmd('colorscheme vscode')
    }

    use {
        'nvim-treesitter/nvim-treesitter',
        run = ':TSUpdate',
        config = function() require("coxy.plugin_config.treesitter") end
    }

    -- LSP Zero
    use {
        'VonHeikemen/lsp-zero.nvim',
        branch = 'v4.x',
        requires = {

            -- LSP Support
            { 'neovim/nvim-lspconfig' },
            { 'williamboman/mason.nvim' },
            { 'williamboman/mason-lspconfig.nvim' },

            -- Autocomplete
            { 'hrsh7th/nvim-cmp' },
            { 'hrsh7th/cmp-buffer' },
            { 'hrsh7th/cmp-path' },
            { 'saadparwaiz1/cmp_luasnip' },
            { 'hrsh7th/cmp-nvim-lsp' },
            { 'hrsh7th/cmp-nvim-lua' },

            -- Snippets
            { 'L3MON4D3/LuaSnip' },
            { 'rafamadriz/friendly-snippets' },
        },
        config = function () require("coxy.plugin_config.lsp") end
    }

    use {
        'mbbill/undotree',
        config = function() require("coxy.plugin_config.undotree") end
    }

    use {
        'tpope/vim-fugitive',
        config = function() require("coxy.plugin_config.fugitive") end
    }

    use {
        'ray-x/go.nvim',
        config = function() require("coxy.plugin_config.lsp.go") end
    }
end)
