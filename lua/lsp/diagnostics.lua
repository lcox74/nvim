---@meta
--- Configures diagnostic settings for LSP servers.
--- Includes settings for virtual text, signs, and diagnostic floating windows.
return function()
    vim.diagnostic.config({
        virtual_text = false,
        signs = true,
        update_in_insert = false,
        underline = true,
        severity_sort = true,
        float = {
            border = "rounded",
            source = "always",
        },
    })
end
