vim.g.mapleader = " "

-- Disable accidental Ex mode
vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Q command", silent = true })

-- Format file with LSP
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format()
end, { desc = "Format file with LSP", silent = true })

-- File Explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer", silent = true })

-- Paste without losing original value in visual mode
vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "Paste without overwriting register", silent = true })

-- Keep cursor in the middle of the screen
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor in the middle", silent = true })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll half-page down and center", silent = true })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll half-page up and center", silent = true })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result and center", silent = true })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result and center", silent = true })

-- Search and replace word under cursor or visually selected text
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>",
    { desc = "Search and replace word under cursor" })
vim.keymap.set("v", "<leader>s", "y:%s/<C-r>\"/<C-r>\"/gI<Left><Left><Left>",
    { desc = "Search and replace visually selected text" })

-- Move lines up/down in-place
vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", { desc = "Move line down", silent = true })
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { desc = "Move line up", silent = true })
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down", silent = true })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up", silent = true })

-- Use CTRL-space to trigger LSP completion
vim.keymap.set("i", "<C-space>", function()
    local trigger = vim.api.nvim_replace_termcodes("<C-x><C-o>", true, false, true)
    vim.api.nvim_feedkeys(trigger, "n", false)
end, { desc = "Trigger LSP completion", silent = true })

-- Config shortcuts
local config_dir = vim.fn.stdpath("config")

vim.keymap.set("n", "<leader>cc", function()
    vim.cmd.edit(config_dir .. "/lua/lsp/init.lua")
end, { desc = "Edit LSP config", silent = true })

vim.keymap.set("n", "<leader>cp", function()
    vim.cmd.edit(config_dir .. "/lua/pack.lua")
end, { desc = "Edit plugins", silent = true })
