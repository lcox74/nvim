local host = vim.g.host or {}
local map = require("core.map").map

-- Hard disable (host-level)
if host.disable_lsp then
    return
end

-- Diagnostic configuration
vim.diagnostic.config({
    virtual_text = true,
    signs = true,
    underline = true,
    update_in_insert = false,
    severity_sort = true,
    float = {
        border = "rounded",
        source = true,
    },
})

-- LspAttach autocmd for keymaps and completion
vim.api.nvim_create_autocmd("LspAttach", {
    group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
    callback = function(ev)
        local bufnr = ev.buf
        local client = vim.lsp.get_client_by_id(ev.data.client_id)

        -- Buffer-local keymap helper
        local function bmap(mode, lhs, rhs, desc)
            map(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- Navigation and references
        bmap("n", "gd", vim.lsp.buf.definition, "Go to definition")
        bmap("n", "gr", vim.lsp.buf.references, "Find references")

        if client and client:supports_method("textDocument/declaration") then
            bmap("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        end
        if client and client:supports_method("textDocument/implementation") then
            bmap("n", "gi", vim.lsp.buf.implementation, "Go to implementation")
        end
        if client and client:supports_method("textDocument/typeDefinition") then
            bmap("n", "gy", vim.lsp.buf.type_definition, "Go to type definition")
        end

        -- Diagnostics
        local diag_prev = function() vim.diagnostic.jump({ count = -1 }) end
        local diag_next = function() vim.diagnostic.jump({ count = 1 }) end

        bmap("n", "[d", diag_prev, "Previous diagnostic")
        bmap("n", "]d", diag_next, "Next diagnostic")
        bmap("n", "gl", vim.diagnostic.open_float, "Show diagnostic")

        -- Code actions
        bmap("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
        bmap("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")

        -- Symbols
        if client and client:supports_method("textDocument/documentSymbol") then
            bmap("n", "<leader>ds", vim.lsp.buf.document_symbol, "Document symbols")
        end
        if client and client:supports_method("workspace/symbol") then
            bmap("n", "<leader>ws", vim.lsp.buf.workspace_symbol, "Workspace symbols")
        end

        -- Formatting
        bmap("n", "<leader>f", vim.lsp.buf.format, "Format buffer")

        -- Inlay hints toggle
        bmap("n", "<leader>ih", function()
            vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled())
        end, "Toggle inlay hints")

        -- Hover and signature help
        bmap("n", "K", vim.lsp.buf.hover, "Hover documentation")
        bmap("i", "<C-s>", vim.lsp.buf.signature_help, "Signature help")
    end,
})

-- Load and enable LSP servers from servers/ directory
local servers_path = vim.fn.stdpath("config") .. "/lua/lsp/servers"
for _, file in ipairs(vim.fn.glob(servers_path .. "/*.lua", false, true)) do
    local module_name = "lsp.servers." .. vim.fn.fnamemodify(file, ":t:r")
    local server = require(module_name)
    if vim.fn.executable(server.cmd) == 1 then
        vim.lsp.config[server.name] = server.config
        vim.lsp.enable(server.name)
    end
end
