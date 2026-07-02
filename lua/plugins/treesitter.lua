local ok, ts = pcall(require, "nvim-treesitter")
if not ok then
    return
end

local ac = require("lib.autocmd")
local autocmd = ac.autocmd
local augroup = ac.augroup

-- Parsers to install (c, lua, markdown, query, vim, vimdoc ship with Neovim)
local parsers = {
    "go",
    "gomod",

    -- Web
    "javascript",
    "typescript",
    "tsx",
    "html",
    "css",

    "bash",
    "dockerfile",
    "json",
    "just",
    "sql",
    "yaml",
    "markdown_inline",
}

-- Parser installs need the tree-sitter CLI and a C compiler
local can_install = vim.fn.executable("tree-sitter") == 1
    and vim.fn.executable("cc") == 1

-- Install any missing parsers (async, no-op for installed ones)
if can_install then
    ts.install(parsers)
else
    vim.notify(
        "treesitter: tree-sitter CLI and a C compiler are required to install parsers"
            .. " (brew install tree-sitter-cli, see :checkhealth wort)",
        vim.log.levels.WARN
    )
end

-- Highlighting and indentation are opt-in per buffer with the main branch
augroup("treesitter-start", { clear = true })
autocmd("FileType", {
    desc = "Enable treesitter highlighting and indentation",
    group = "treesitter-start",
    callback = function(ev)
        local lang = vim.treesitter.language.get_lang(ev.match)
        if not (lang and vim.treesitter.language.add(lang)) then
            return
        end
        vim.treesitter.start(ev.buf, lang)
        vim.bo[ev.buf].indentexpr = "v:lua.require'nvim-treesitter'.indentexpr()"

        -- Structural folds (scoped to this window+buffer)
        vim.wo[0][0].foldmethod = "expr"
        vim.wo[0][0].foldexpr = "v:lua.vim.treesitter.foldexpr()"
    end,
})

-- Keep parsers in sync when the plugin is updated
augroup("treesitter-pack-update", { clear = true })
autocmd("PackChanged", {
    desc = "Update treesitter parsers after plugin update",
    group = "treesitter-pack-update",
    callback = function(ev)
        if can_install and ev.data.spec.name == "nvim-treesitter" and ev.data.kind == "update" then
            ts.update()
        end
    end,
})
