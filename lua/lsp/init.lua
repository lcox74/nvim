---@meta
--- Initializes LSP configuration by requiring and setting up all LSP-related modules.

local M = {}

--- Entry point for LSP setup.
function M.setup()
    -- Core LSP setup
    require("lsp.mason")()         -- Mason setup
    require("lsp.languages")()     -- Language-specific configurations
    require("lsp.cmp")()           -- Autocompletion setup
    require("lsp.diagnostics")()   -- Diagnostics settings
end

return M