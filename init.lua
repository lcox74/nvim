-- Hard requirement: vim.pack, vim.lsp.config, upward 'exrc' search
if vim.fn.has("nvim-0.12") == 0 then
    vim.notify("This config requires Neovim 0.12+", vim.log.levels.ERROR)
    return
end

-- Core editor behavior
require("lib.loader").dir("core")

-- Plugins
require("pack")

-- Tooling
require("lsp")
require("lib.loader").dir("tools")

-- Host-level overrides (gitignored)
pcall(require, "local")

-- Project-level overrides: sources trusted .nvim.lua from cwd and parents
-- (first load per file prompts; manage with :trust)
vim.o.exrc = true
