local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmt = require("luasnip.extras.fmt").fmt

-- Go snippets
ls.add_snippets("go", {
    -- Main function
    s("main", fmt([[
        package main

        import "fmt"

        func main() {{
            {}
        }}
    ]], {
        i(1, "// Your code here"),
    })),

    -- If statement
    s("if", fmt([[
        if {} {{
            {}
        }}
    ]], {
        i(1, "condition"),
        i(2, "// Your code here"),
    })),
})
