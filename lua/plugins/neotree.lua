local ok, neotree = pcall(require, "neo-tree")
if not ok then
    return
end

local map = require("lib.map").map

neotree.setup({
    sources = { "filesystem", "buffers", "git_status", "document_symbols" },
    filesystem = {
        follow_current_file = { enabled = true },
        -- Open directories netrw-style in the current window instead of a
        -- sidebar (the sidebar hijack leaves a stray [No Name] buffer behind)
        hijack_netrw_behavior = "open_current",
        filtered_items = {
            visible = true, -- show dotfiles/gitignored dimmed instead of hidden
        },
    },
    source_selector = {
        winbar = true,
        sources = {
            { source = "filesystem" },
            { source = "git_status" },
            { source = "document_symbols" },
        },
    },
})

map("n", "<leader>e", "<cmd>Neotree focus<cr>", "Focus file tree")
map("n", "<leader>E", "<cmd>Neotree toggle reveal<cr>", "Toggle file tree")
map("n", "<leader>pv", "<cmd>Neotree current reveal<cr>", "Open file explorer")
