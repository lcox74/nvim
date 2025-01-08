-- Set leader keys
vim.g.mapleader = " "        -- Set <leader> to space
vim.g.maplocalleader = " "   -- Set local leader to space

-- -- Set the colorscheme
-- vim.cmd.colorscheme("tokyonight")

-- Line numbers
vim.opt.number = true         -- Show absolute line numbers
vim.opt.relativenumber = true -- Show relative line numbers

-- Search behavior
vim.opt.ignorecase = true     -- Ignore case in search patterns
vim.opt.smartcase = true      -- Use case-sensitive search if uppercase is in the query
vim.opt.hlsearch = false      -- Disable search highlight
vim.opt.incsearch = true      -- Show incremental search results

-- Split behavior
vim.opt.splitbelow = true     -- Open new horizontal splits below
vim.opt.splitright = true     -- Open new vertical splits to the right

-- Appearance
vim.opt.termguicolors = true  -- Enable true color support
vim.opt.guicursor = ""        -- Use block cursor for all modes
vim.opt.colorcolumn = "80"    -- Highlight column 80 for coding guidelines

-- Tabs and indentation
vim.opt.tabstop = 4           -- Number of spaces per tab
vim.opt.softtabstop = 4       -- Number of spaces for <Tab> in insert mode
vim.opt.shiftwidth = 4        -- Number of spaces for auto-indentation
vim.opt.expandtab = true      -- Use spaces instead of tabs
vim.opt.smartindent = true    -- Enable smart indentation

-- Wrapping
vim.opt.wrap = false          -- Disable line wrapping

-- File management
vim.opt.swapfile = false      -- Disable swap files
vim.opt.backup = false        -- Disable backup files
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir" -- Set undo directory
vim.opt.undofile = true       -- Enable persistent undo

-- Scrolling and cursor behavior
vim.opt.scrolloff = 8         -- Keep 8 lines visible above/below cursor
vim.opt.signcolumn = "yes"    -- Always show the sign column
vim.opt.isfname:append("@-@") -- Append '@-@' to 'isfname' for filenames

-- Performance
vim.opt.updatetime = 50       -- Faster completion (default is 4000ms)
