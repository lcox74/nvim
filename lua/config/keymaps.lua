-- Telescope keymaps
local builtin = require("telescope.builtin")
vim.keymap.set("n", "<leader>ff", builtin.find_files, { desc = "Find Files" })
vim.keymap.set("n", "<leader>fg", builtin.live_grep, { desc = "Live Grep" })
vim.keymap.set("n", "<leader>fd", builtin.diagnostics, { desc = "Diagnostics" })

-- File Explorer
vim.keymap.set("n", "<leader>pv", vim.cmd.Ex, { desc = "Open file explorer" })

-- Keep cursor in the middle of the screen
vim.keymap.set("n", "J", "mzJ`z", { desc = "Join lines and keep cursor in the middle" })
vim.keymap.set("n", "<C-d>", "<C-d>zz", { desc = "Scroll half-page down and center" })
vim.keymap.set("n", "<C-u>", "<C-u>zz", { desc = "Scroll half-page up and center" })
vim.keymap.set("n", "n", "nzzzv", { desc = "Next search result and center" })
vim.keymap.set("n", "N", "Nzzzv", { desc = "Previous search result and center" })

-- Paste without losing original value in visual mode
vim.keymap.set("x", "<leader>p", "\"_dP", { desc = "Paste without overwriting register" })

-- Copy to system clipboard
vim.keymap.set("n", "<leader>y", "\"+y", { desc = "Copy to system clipboard" })
vim.keymap.set("v", "<leader>y", "\"+y", { desc = "Copy to system clipboard" })
vim.keymap.set("n", "<leader>Y", "\"+Y", { desc = "Yank line to system clipboard" })

-- Disable 'Q'
vim.keymap.set("n", "Q", "<nop>", { desc = "Disable Q command" })

-- Format file with LSP
vim.keymap.set("n", "<leader>f", function()
    vim.lsp.buf.format()
end, { desc = "Format file with LSP" })

-- Search and replace word under cursor or visually selected text
vim.keymap.set("n", "<leader>s", ":%s/\\<<C-r><C-w>\\>/<C-r><C-w>/gI<Left><Left><Left>", { desc = "Search and replace word under cursor" })
vim.keymap.set("v", "<leader>s", "y:%s/<C-r>\"/<C-r>\"/gI<Left><Left><Left>", { desc = "Search and replace visually selected text" })

-- Make file executable
vim.keymap.set("n", "<leader>x", "<cmd>!chmod +x %<CR>", { silent = true, desc = "Make file executable" })

-- Move lines up/down in-place
vim.keymap.set("n", "<C-j>", ":m .+1<CR>==", { desc = "Move line down" })
vim.keymap.set("n", "<C-k>", ":m .-2<CR>==", { desc = "Move line up" })
vim.keymap.set("v", "<C-j>", ":m '>+1<CR>gv=gv", { desc = "Move selection down" })
vim.keymap.set("v", "<C-k>", ":m '<-2<CR>gv=gv", { desc = "Move selection up" })

-- East Close
vim.keymap.set('n', '<leader>q', '<Cmd>qa<CR>', { desc = "Close all windows" })
vim.keymap.set('n', '<leader>Q', '<Cmd>qa!<CR>', { desc = "Close all windows without saving" })
vim.keymap.set('n', '<leader>w', '<Cmd>w<CR>', { desc = "Save current buffer" })

-- Buffers
vim.keymap.set("n", "<leader>.", ":bnext<CR>", { desc = "Next Buffer" })
vim.keymap.set("n", "<leader>,", ":bprevious<CR>", { desc = "Previous Buffer" })
vim.keymap.set("n", "<leader>bd", ":bdelete<CR>", { desc = "Delete Buffer" })