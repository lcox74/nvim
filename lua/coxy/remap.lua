-- Declare vim as a global variable to avoid undefined warnings
---@diagnostic disable-next-line: undefined-global
local vim = vim

vim.g.mapleader = " "

-- Open file explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex)

-- Keep cursor in the middle of the screen when joining lines
vim.keymap.set("n", "J", "mzJ`z")

-- Keep cursor in the middle of the screen when scrolling half pages
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- Keep cursor in the middle of the screen when searching
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- Paste without losing original value
vim.keymap.set("x", "<leader>p", "\"_dP")

-- Copy to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y")
vim.keymap.set("v", "<leader>y", "\"+y")
vim.keymap.set("n", "<leader>Y", "\"+Y")

-- Do nothing when pressing Q
vim.keymap.set("n", "Q", "<nop>")

-- Format file with LSP
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format()
end)

-- Search and replace word under cursor
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>")

-- Make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true })
