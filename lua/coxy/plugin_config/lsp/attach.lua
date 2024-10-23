local M = {}

M.attach = function(client, bufnr)
    local opts = { buffer = bufnr }

    -- LSP keybindings
    vim.keymap.set('n', 'gd', function() vim.lsp.buf.definition() end, opts)
    vim.keymap.set('n', 'gD', function() vim.lsp.buf.declaration() end, opts)
    vim.keymap.set('n', 'gr', function() vim.lsp.buf.references() end, opts)
    vim.keymap.set('n', 'gi', function() vim.lsp.buf.implementation() end, opts)

    vim.keymap.set('n', '<leader>vca', function() vim.lsp.buf.code_action() end, opts)
    vim.keymap.set('n', '<leader>vrn', function() vim.lsp.buf.rename() end, opts)

    vim.keymap.set('n', 'K', function() vim.lsp.buf.hover() end, opts)
    vim.keymap.set('i', '<C-h>', function() vim.lsp.buf.signature_help() end, opts)
end

return M.attach
