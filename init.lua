-- Core editor behavior
require("core.options")
require("core.keymaps")
require("core.autocmds")
require("core.buffers")

-- Plugins
require("pack")
require("plugins.colourscheme")
require("plugins.telescope")
require("plugins.treesitter")
require("plugins.lualine")
require("plugins.pack")
require("plugins.cmp")
require("plugins.gitsigns")
require("plugins.autopairs")
require("plugins.comment")
require("plugins.markview")

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
