# Neovim Config

My old config kept breaking randomly, so I rebuilt it from scratch. The goal is simple: explicit, predictable, and portable. No plugin frameworks, no auto-installers, no magic. If a tool is missing, things just gracefully skip it instead of exploding.

Uses native Neovim features like `vim.pack` and `vim.lsp` wherever possible. Though I am lazy enough to use Mason for managing LSPs.

## Requirements

- **Neovim nightly** (v0.12+ for `vim.pack`)
- **git**, **ripgrep**, **fd**

```sh
# macOS
brew install ripgrep fd
brew install neovim --HEAD
```

LSP servers and formatters are detected at runtime - install whatever you need externally (or use Mason inside Neovim).

## Health Check

Verify your setup with the built-in health check:

```vim
:checkhealth config
```

This checks for required tools (`git`, `ripgrep`, `fd`) and shows which LSP servers are available.

## Installation

```sh
git clone https://github.com/lcox74/nvim ~/.config/nvim
nvim -c "lua vim.pack.update()"
```

Then install the configured LSP servers:

```vim
:MasonInstallConfigured
```

Restart Neovim after installation completes for LSP to detect the new servers.

## Adding a Language Server

1. Add the package name to `configured_packages` in `lua/plugins/mason.lua`
2. Run `:MasonInstallConfigured` to install it
3. Add to the servers table in `lua/lsp/init.lua`:

```lua
{ "server_name", {
    cmd = { "server-binary" },
    filetypes = { "filetype" },
    root_markers = { "project.file", ".git" },
}, "server-binary" },
```

4. Restart Neovim

For servers needing custom settings, create `lua/lsp/<lang>.lua` and require it instead of inlining the config.

**Tips:**
- Run `:Mason` to browse available packages and find the exact package name
- Check Mason for the exact binary name (some need `--stdio`)
- Run `:set filetype?` to find the right filetype
- Use the main project file as root marker with `.git` as fallback

## Overrides

**`local.lua`** - per-machine settings (gitignored), lives in your nvim config directory:

```lua
-- ~/.config/nvim/local.lua
vim.g.host = {
    disable_format = true,  -- disable format-on-save
    disable_lsp = false,
}
```

**`.nvim.lua`** - per-project settings, lives in your project root:

```lua
-- /path/to/project/.nvim.lua
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.lsp.config.gopls.settings = {
    gopls = { buildFlags = { "-tags=integration" } },
}
```
