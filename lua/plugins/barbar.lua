local ok = pcall(require, "barbar")
if not ok then
    return
end

local opts = { silent = true }

local function map(mode, lhs, rhs, desc)
    vim.keymap.set(mode, lhs, rhs, vim.tbl_extend("force", opts, { desc = desc }))
end

-- Buffer navigation
map("n", "<Tab>", "<Cmd>BufferNext<CR>", "Next buffer")
map("n", "<S-Tab>", "<Cmd>BufferPrevious<CR>", "Previous buffer")

-- Buffer closing
map("n", "<leader>x", "<Cmd>BufferClose<CR>", "Close buffer")
map("n", "<leader>X", "<Cmd>BufferCloseAllButCurrent<CR>", "Close all but current")

-- Buffer reordering
map("n", "<A-<>", "<Cmd>BufferMovePrevious<CR>", "Move buffer left")
map("n", "<A->>", "<Cmd>BufferMoveNext<CR>", "Move buffer right")

-- Jump to buffer by number
map("n", "<leader>1", "<Cmd>BufferGoto 1<CR>", "Buffer 1")
map("n", "<leader>2", "<Cmd>BufferGoto 2<CR>", "Buffer 2")
map("n", "<leader>3", "<Cmd>BufferGoto 3<CR>", "Buffer 3")
map("n", "<leader>4", "<Cmd>BufferGoto 4<CR>", "Buffer 4")
map("n", "<leader>5", "<Cmd>BufferGoto 5<CR>", "Buffer 5")
map("n", "<leader>6", "<Cmd>BufferGoto 6<CR>", "Buffer 6")
map("n", "<leader>7", "<Cmd>BufferGoto 7<CR>", "Buffer 7")
map("n", "<leader>8", "<Cmd>BufferGoto 8<CR>", "Buffer 8")
map("n", "<leader>9", "<Cmd>BufferGoto 9<CR>", "Buffer 9")
map("n", "<leader>0", "<Cmd>BufferLast<CR>", "Last buffer")

-- Buffer pinning and ordering
map("n", "<leader>bp", "<Cmd>BufferPin<CR>", "Pin buffer")
map("n", "<leader>bo", "<Cmd>BufferOrderByDirectory<CR>", "Order by directory")
