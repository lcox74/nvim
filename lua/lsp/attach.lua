---@meta
--- Sets up keymaps and behaviors when an LSP server attaches to a buffer.
--- Provides navigation, diagnostics, and code action mappings.
---@param client table The LSP client instance.
---@param bufnr number The buffer number.
return function(client, bufnr)
    local opts = { buffer = bufnr, remap = false }

    -- Navigation and References
    vim.keymap.set("n", "gd", vim.lsp.buf.definition, opts)
    vim.keymap.set("n", "gD", vim.lsp.buf.declaration, opts)
    vim.keymap.set("n", "gr", vim.lsp.buf.references, opts)
    vim.keymap.set("n", "gi", vim.lsp.buf.implementation, opts)

    -- Diagnostics
    vim.keymap.set("n", "[d", vim.diagnostic.goto_prev, opts)
    vim.keymap.set("n", "]d", vim.diagnostic.goto_next, opts)
    vim.keymap.set("n", "gl", vim.diagnostic.open_float, opts)

    -- Code Actions
    vim.keymap.set("n", "<leader>gca", vim.lsp.buf.code_action, opts)
    vim.keymap.set("n", "<leader>grn", vim.lsp.buf.rename, opts)

    -- Hover and Signature Help
    vim.keymap.set("n", "K", vim.lsp.buf.hover, opts)
    vim.keymap.set("i", "<C-h>", vim.lsp.buf.signature_help, opts)
end
