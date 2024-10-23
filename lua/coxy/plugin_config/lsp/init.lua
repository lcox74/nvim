local lsp_zero = require('lsp-zero')

-- Import other LSP-related modules
local attach = require('coxy.plugin_config.lsp.attach')

-- LSP setup
lsp_zero.extend_lspconfig({
    sign_text = true,
    lsp_attach = attach,
    capabilities = require('cmp_nvim_lsp').default_capabilities(),
})

require('coxy.plugin_config.lsp.mason')
require('coxy.plugin_config.lsp.cmp')

