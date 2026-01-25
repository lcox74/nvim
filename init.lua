-- Core editor behavior
require("core.loader").dir("core")

-- Plugins
require("pack")

-- Tooling
require("lsp")

-- Host-level overrides (gitignored)
pcall(require, "local")

-- Project-level overrides (gitignored)
local nvim_lua = vim.fn.getcwd() .. "/.nvim.lua"
if vim.fn.filereadable(nvim_lua) == 1 then
    pcall(dofile, nvim_lua)
end
