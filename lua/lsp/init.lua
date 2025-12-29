local host = vim.g.host or {}

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

        -- Enable built-in LSP completion
        if client and client:supports_method("textDocument/completion") then
            vim.lsp.completion.enable(true, client.id, bufnr, { autotrigger = true })
        end

        -- Keymaps
        local function map(mode, lhs, rhs, desc)
            vim.keymap.set(mode, lhs, rhs, { buffer = bufnr, desc = desc })
        end

        -- Navigation and references
        map("n", "gd", vim.lsp.buf.definition, "Go to definition")
        map("n", "gD", vim.lsp.buf.declaration, "Go to declaration")
        map("n", "gr", vim.lsp.buf.references, "Find references")
        map("n", "gi", vim.lsp.buf.implementation, "Go to implementation")

        -- Diagnostics
        map("n", "[d", vim.diagnostic.goto_prev, "Previous diagnostic")
        map("n", "]d", vim.diagnostic.goto_next, "Next diagnostic")
        map("n", "gl", vim.diagnostic.open_float, "Show diagnostic")

        -- Code actions
        map("n", "<leader>ca", vim.lsp.buf.code_action, "Code action")
        map("n", "<leader>rn", vim.lsp.buf.rename, "Rename symbol")

        -- Hover and signature help
        map("n", "K", vim.lsp.buf.hover, "Hover documentation")
        map("i", "<C-s>", vim.lsp.buf.signature_help, "Signature help")
    end,
})

-- LSP server configurations
-- Each entry: { name, config, executable }
local servers = {
    -- Complex configs (separate files)
    { "gopls", require("lsp.go"), "gopls" },
    { "lua_ls", require("lsp.lua"), "lua-language-server" },

    { "ts_ls", {
        cmd = { "typescript-language-server", "--stdio" },
        filetypes = { "javascript", "javascriptreact", "typescript", "typescriptreact" },
        root_markers = { "tsconfig.json", "package.json", ".git" },
    }, "typescript-language-server" },

    { "html", {
        cmd = { "vscode-html-language-server", "--stdio" },
        filetypes = { "html" },
        root_markers = { ".git" },
    }, "vscode-html-language-server" },

    { "cssls", {
        cmd = { "vscode-css-language-server", "--stdio" },
        filetypes = { "css", "scss" },
        root_markers = { ".git" },
    }, "vscode-css-language-server" },
}

for _, server in ipairs(servers) do
    local name, config, cmd = server[1], server[2], server[3]
    if vim.fn.executable(cmd) == 1 then
        vim.lsp.config[name] = config
        vim.lsp.enable(name)
    end
end
