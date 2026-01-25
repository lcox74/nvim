local ok, gitsigns = pcall(require, "gitsigns")
if not ok then
    return
end

local map = require("lib.map").map

gitsigns.setup({
    signs = {
        add = { text = "+" },
        change = { text = "~" },
        delete = { text = "_" },
        topdelete = { text = "-" },
        changedelete = { text = "~" },
    },
    on_attach = function(bufnr)
        local gs = gitsigns

        local function bmap(mode, l, r, desc)
            map(mode, l, r, { buffer = bufnr, desc = desc })
        end

        -- Actions
        bmap("n", "<leader>hp", gs.preview_hunk, "Preview hunk")
        bmap("n", "<leader>hb", function() gs.blame_line({ full = true }) end, "Blame line")

        -- Toggle
        bmap("n", "<leader>tb", gs.toggle_current_line_blame, "Toggle line blame")
    end,
})
