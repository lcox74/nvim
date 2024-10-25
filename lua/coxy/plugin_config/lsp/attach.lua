local M = {}

M.attach = function(client, bufnr)
    local opts = { buffer = bufnr }

    -- LSP References & Declarations
    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, opts)
    vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)

    -- LSP Diagnosis
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, { buffer = bufnr, desc = "Go to Next Diagnostic" })
    vim.keymap.set("n", "gl", vim.diagnostic.open_float, { buffer = bufnr, desc = "Open Diagnostic Float" })
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, { buffer = bufnr, desc = "Go to Previous Diagnostic" })

    vim.keymap.set('n', '<leader>gca', function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set('n', '<leader>grn', function() vim.lsp.buf.rename() end, opts)

    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
end

return M.attach
