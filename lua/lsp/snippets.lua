---@meta
--- Configures LuaSnip and loads custom snippet files.

return function()
    local luasnip = require("luasnip")

    -- Load friendly-snippets
    -- require("luasnip.loaders.from_vscode").lazy_load()

    -- Load custom snippets
    require("luasnip.loaders.from_lua").lazy_load({ paths = "~/.config/nvim/snippets" })

    -- Keymaps for snippet navigation
    vim.keymap.set({ "i", "s" }, "<C-k>", function()
        if luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
        end
    end, { desc = "Expand or jump through a snippet" })

    vim.keymap.set({ "i", "s" }, "<C-j>", function()
        if luasnip.jumpable(-1) then
            luasnip.jump(-1)
        end
    end, { desc = "Jump backwards in a snippet" })

    vim.keymap.set("i", "<C-E>", function()
        if luasnip.choice_active() then
            luasnip.change_choice(1)
        end
    end, { desc = "Cycle through snippet choices" })

    print("LuaSnip setup loaded")
end
