-- Line numbers
vim.opt.number = true
vim.opt.relativenumber = true

-- Indentation
vim.opt.expandtab = true
vim.opt.shiftwidth = 4
vim.opt.tabstop = 4

-- UI
vim.opt.signcolumn = "yes"
vim.opt.termguicolors = true
vim.opt.cursorline = true

-- winborder is 0.12+ only
if pcall(function() local _ = vim.opt.winborder end) then
    vim.opt.winborder = "rounded"
end

-- Splits
vim.opt.splitbelow = true
vim.opt.splitright = true

-- Timing
vim.opt.updatetime = 250
vim.opt.timeoutlen = 400

-- Clipboard (uses OSC52 when available)
vim.opt.clipboard = "unnamedplus"

-- Search behavior
vim.opt.ignorecase = true -- Ignore case in search patterns
vim.opt.smartcase = true  -- Use case-sensitive search if uppercase is in the query
vim.opt.hlsearch = false  -- Disable search highlight
vim.opt.incsearch = true  -- Show incremental search results

-- Appearance
vim.opt.guicursor = ""         -- Use block cursor for all modes
vim.opt.colorcolumn = "80,120" -- Highlight column 80 for coding guidelines
vim.opt.scrolloff = 8          -- Keep 8 lines visible above/below cursor
vim.opt.sidescrolloff = 8      -- Keep 8 columns visible left/right of cursor

-- Undo persistence
vim.opt.undofile = true
vim.opt.undodir = vim.fn.stdpath("state") .. "/undo"

local completeopt = {
    "menuone",  -- always show menu
    "noselect", -- don't auto-insert junk
    "noinsert", -- don't insert text until selection
    "popup",
}
-- fuzzy is 0.12+ only
if vim.fn.has("nvim-0.12") == 1 then
    table.insert(completeopt, "fuzzy")
end
vim.opt.completeopt = completeopt
