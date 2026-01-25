local map = require("lib.map").map

-- Get list of listed buffers in order
local function get_buffers()
    local bufs = {}
    for _, buf in ipairs(vim.api.nvim_list_bufs()) do
        if vim.bo[buf].buflisted then
            table.insert(bufs, buf)
        end
    end
    return bufs
end

-- Jump to buffer by index (1-based)
local function goto_buffer(idx)
    local bufs = get_buffers()
    if bufs[idx] then
        vim.api.nvim_set_current_buf(bufs[idx])
    end
end

-- Jump to last buffer
local function goto_last_buffer()
    local bufs = get_buffers()
    if #bufs > 0 then
        vim.api.nvim_set_current_buf(bufs[#bufs])
    end
end

-- Buffer navigation
map("n", "<Tab>", "<Cmd>bnext<CR>", "Next buffer")
map("n", "<S-Tab>", "<Cmd>bprev<CR>", "Previous buffer")

-- Buffer closing
map("n", "<leader>x", "<Cmd>bdelete<CR>", "Close buffer")
map("n", "<leader>X", "<Cmd>%bdelete|edit#|bdelete#<CR>", "Close all but current")

-- Jump to buffer by number
map("n", "<leader>1", function() goto_buffer(1) end, "Buffer 1")
map("n", "<leader>2", function() goto_buffer(2) end, "Buffer 2")
map("n", "<leader>3", function() goto_buffer(3) end, "Buffer 3")
map("n", "<leader>4", function() goto_buffer(4) end, "Buffer 4")
map("n", "<leader>5", function() goto_buffer(5) end, "Buffer 5")
map("n", "<leader>6", function() goto_buffer(6) end, "Buffer 6")
map("n", "<leader>7", function() goto_buffer(7) end, "Buffer 7")
map("n", "<leader>8", function() goto_buffer(8) end, "Buffer 8")
map("n", "<leader>9", function() goto_buffer(9) end, "Buffer 9")
map("n", "<leader>0", goto_last_buffer, "Last buffer")
