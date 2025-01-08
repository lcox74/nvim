local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

-- Lua snippets
ls.add_snippets("lua", {
    -- Function snippet
    s("func", fmt("function {}({})\n  {}\nend", {
        i(1, "name"),  -- Function name
        i(2, "args"),  -- Function arguments
        i(3, "-- body"), -- Function body
    })),

    -- Print statement
    s("print", {
        t("print("),
        i(1, '"Hello, World!"'),
        t(")"),
    }),
})
