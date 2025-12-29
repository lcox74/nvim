-- Core editor behavior
require("core.options")
require("core.keymaps")
require("core.autocmds")

-- Plugins
require("pack")
require("plugins.colourscheme")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.barbar")

-- Mason (must run before LSP to prepend PATH)
require("plugins.mason")

-- Tooling
require("lsp")

-- Host-level overrides (gitignored)
pcall(require, "local")

-- Project-level overrides (gitignored)
local nvim_lua = vim.fn.getcwd() .. "/.nvim.lua"
if vim.fn.filereadable(nvim_lua) == 1 then
    pcall(dofile, nvim_lua)
end
