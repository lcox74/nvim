# Wort

Personal Neovim configuration. My old config kept breaking randomly, so I rebuilt it from scratch. The goal is simple: explicit, predictable, and portable. No plugin frameworks, no auto-installers, no magic. If a tool is missing, things just gracefully skip it instead of exploding.

Uses native Neovim features like `vim.pack` and `vim.lsp` wherever possible. Though I am lazy enough to use Mason for managing LSPs.

## Features

- **Completion**: nvim-cmp with LSP, buffer, path sources + LuaSnip snippets
- **Status line**: lualine with diagnostics, git diff, and winbar
- **Git integration**: gitsigns for gutter signs and inline blame
- **Editing helpers**: autopairs, native `gc` commenting
- **Buffer line**: barbar with Tab/S-Tab navigation, leader+number to jump
- **File tree**: neo-tree (`<leader>e` sidebar, `<leader>pv` full window)

## Requirements

- **git**, **ripgrep**, **fd**
- **tree-sitter CLI** and a C compiler (treesitter parsers are compiled from source)

```sh
# macOS
brew install neovim ripgrep fd tree-sitter-cli
```

## Health Check

Verify your setup with the built-in health check:

```vim
:checkhealth wort
```

This checks for required tools (`git`, `ripgrep`, `fd`, `tree-sitter`, `cc`).

To check LSP server status:

```vim
:checkhealth vim.lsp
```

## Installation

```sh
git clone https://github.com/lcox74/nvim ~/.config/nvim
nvim -c "lua vim.pack.update()"
```

Mason will automatically install any missing LSP servers, linters, and formatters on startup.

## Updating

```vim
:UpdateAll
```

Updates everything in one go (also on `<leader>cu`): plugins via `vim.pack` (opens a review buffer, `:w` to apply or `:q` to abort), Mason packages, and treesitter parsers. `:PackUpdate` updates just the plugins.

## Adding a Language Server

Add the lspconfig server name to `ensure_installed` in `lua/plugins/mason.lua`. That's it - mason-lspconfig installs the server and enables it with the config that ships in nvim-lspconfig.

To override or extend a server's defaults (settings, cmd, etc.), create `lsp/<name>.lua` in this config's root. It is merged over the nvim-lspconfig defaults by native `vim.lsp.config`:

```lua
-- ~/.config/nvim/lsp/gopls.lua
return {
    settings = {
        gopls = { gofumpt = true },
    },
}
```

**Tips:**

- Server names are lspconfig names (`lua_ls`, not `lua-language-server`); browse them with `:h lspconfig-all`
- Run `:checkhealth vim.lsp` to see enabled servers and attach status
- Formatters and linters are plain Mason package names in the same file; wire formatters up per filetype in `lua/plugins/conform.lua`

## Formatting

Format on save runs conform.nvim formatters (prettier, shfmt, ...) per filetype, falling back to LSP formatting when no formatter is configured. `<leader>f` formats manually. Disable format on save per machine with `vim.g.host = { disable_format = true }` in `local.lua`.

## Overrides

**`local.lua`** - per-machine settings (gitignored), lives in your nvim config directory:

```lua
-- ~/.config/nvim/local.lua
vim.g.host = {
    disable_format = true,  -- disable format-on-save
    disable_lsp = false,
}
```

**`.nvim.lua`** - per-project settings, loaded via the native `'exrc'` option. Neovim finds it in the project directory or any parent, and prompts to trust it on first load (manage with `:trust`):

```lua
-- /path/to/project/.nvim.lua
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.lsp.config("gopls", {
    settings = {
        gopls = { buildFlags = { "-tags=integration" } },
    },
})
```
