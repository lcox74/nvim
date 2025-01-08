---@meta
--- Configures the `nvim-cmp` autocompletion framework.
--- Includes setup for LSP, buffer, and path completion sources.
return function()
    local cmp = require("cmp")
    local cmp_select = { behavior = cmp.SelectBehavior.Select }

    cmp.setup({
        sources = {
            { name = "nvim_lsp" },
            { name = "buffer" },
            { name = "path" },
        },
        snippet = {
            expand = function(args)
                require("luasnip").lsp_expand(args.body)
            end,
        },
        mapping = cmp.mapping.preset.insert({
            ["<C-y>"] = cmp.mapping.confirm({ select = true }),
            ["<C-e>"] = cmp.mapping.abort(),
            ["<C-n>"] = cmp.mapping.select_next_item(cmp_select),
            ["<C-p>"] = cmp.mapping.select_prev_item(cmp_select),
        }),
    })
end
