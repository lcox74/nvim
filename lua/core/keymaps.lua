vim.g.mapleader = " "

local map = require("core.map").map

-- Disable accidental Ex mode
map("n", "Q", "<nop>", "Disable Q command")

-- File Explorer
map("n", "<leader>pv", vim.cmd.Ex, "Open file explorer")

-- Paste without losing original value in visual mode
map("x", "<leader>p", "\"_dP", "Paste without overwriting register")

-- Keep cursor in the middle of the screen
map("n", "J", "mzJ`z", "Join lines and keep cursor in the middle")
map("n", "<C-d>", "<C-d>zz", "Scroll half-page down and center")
map("n", "<C-u>", "<C-u>zz", "Scroll half-page up and center")
map("n", "n", "nzzzv", "Next search result and center")
map("n", "N", "Nzzzv", "Previous search result and center")

-- Search and replace word under cursor or visually selected text
map("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
    { desc = "Search and replace word under cursor", silent = false })
map("v", "<leader>s", "y:%s/<C-r>\"/<C-r>\"/gI<Left><Left><Left>",
    { desc = "Search and replace visually selected text", silent = false })

-- Move lines up/down in-place
map("n", "<C-j>", ":m .+1<CR>==", "Move line down")
map("n", "<C-k>", ":m .-2<CR>==", "Move line up")
map("v", "<C-j>", ":m '>+1<CR>gv=gv", "Move selection down")
map("v", "<C-k>", ":m '<-2<CR>gv=gv", "Move selection up")

-- Use CTRL-space to trigger LSP completion
map("i", "<C-space>", function()
    local trigger = vim.api.nvim_replace_termcodes("<C-x><C-o>", true, false, true)
    vim.api.nvim_feedkeys(trigger, "n", false)
end, "Trigger LSP completion")


-- Stay in visual mode after indenting
map("v", "<", "<gv", "Indent left, stay in visual")
map("v", ">", ">gv", "Indent right, stay in visual")

-- Clear search highlight
map("n", "<Esc>", "<cmd>nohlsearch<CR>", "Clear search highlight")

-- Quickfix navigation
map("n", "<leader>qn", "<cmd>cnext<CR>", "Next quickfix")
map("n", "<leader>qp", "<cmd>cprev<CR>", "Prev quickfix")
map("n", "<leader>qo", "<cmd>copen<CR>", "Open quickfix")
map("n", "<leader>qc", "<cmd>cclose<CR>", "Close quickfix")

-- Terminal
map("n", "<leader>tt", "<cmd>terminal<CR>", "Open terminal")
map("t", "<Esc><Esc>", "<C-\\><C-n>", "Exit terminal mode")

-- Config shortcuts
local config_dir = vim.fn.stdpath("config")

map("n", "<leader>cc", function()
    vim.cmd.edit(config_dir .. "/lua/lsp/init.lua")
end, "Edit LSP config")

map("n", "<leader>cp", function()
    vim.cmd.edit(config_dir .. "/lua/pack.lua")
end, "Edit plugins")
