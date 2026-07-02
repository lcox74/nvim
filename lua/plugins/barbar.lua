local ok, barbar = pcall(require, "barbar")
if not ok then
    return
end

local map = require("lib.map").map

barbar.setup({
    -- Shift the buffer line when the neo-tree sidebar is open
    sidebar_filetypes = {
        ["neo-tree"] = { event = "BufWipeout" },
    },
})

-- Buffer navigation
map("n", "<Tab>", "<Cmd>BufferNext<CR>", "Next buffer")
map("n", "<S-Tab>", "<Cmd>BufferPrevious<CR>", "Previous buffer")

-- Buffer closing
map("n", "<leader>x", "<Cmd>BufferClose<CR>", "Close buffer")
map("n", "<leader>X", "<Cmd>BufferCloseAllButCurrent<CR>", "Close all but current")

-- Jump to buffer by position in the buffer line
for i = 1, 9 do
    map("n", "<leader>" .. i, "<Cmd>BufferGoto " .. i .. "<CR>", "Buffer " .. i)
end
map("n", "<leader>0", "<Cmd>BufferLast<CR>", "Last buffer")
