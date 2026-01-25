local ok, cmp = pcall(require, "cmp")
if not ok then
    return
end

local ok_luasnip, luasnip = pcall(require, "luasnip")
if ok_luasnip then
    require("luasnip.loaders.from_vscode").lazy_load()
end

cmp.setup({
    snippet = {
        expand = function(args)
            if ok_luasnip then
                luasnip.lsp_expand(args.body)
            else
                vim.snippet.expand(args.body)
            end
        end,
    },

    mapping = cmp.mapping.preset.insert({
        ["<C-n>"] = cmp.mapping.select_next_item(),
        ["<C-p>"] = cmp.mapping.select_prev_item(),
        ["<C-y>"] = cmp.mapping.confirm({ select = true }),
        ["<C-Space>"] = cmp.mapping.complete(),
        ["<C-e>"] = cmp.mapping.abort(),
        ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip and luasnip.expand_or_jumpable() then
                luasnip.expand_or_jump()
            else
                fallback()
            end
        end, { "i", "s" }),
        ["<S-Tab>"] = cmp.mapping(function(fallback)
            if luasnip and luasnip.jumpable(-1) then
                luasnip.jump(-1)
            else
                fallback()
            end
        end, { "i", "s" }),
    }),

    sources = cmp.config.sources({
        { name = "nvim_lsp" },
        { name = "luasnip" },
        { name = "path" },
    }, {
        { name = "buffer" },
    }),

    window = {
        completion = cmp.config.window.bordered(),
        documentation = cmp.config.window.bordered(),
    },
})

-- Extend default LSP capabilities for all servers
local ok_cmp_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")
if ok_cmp_lsp then
    vim.lsp.config("*", {
        capabilities = cmp_nvim_lsp.default_capabilities(),
    })
end
