# Neovim Config

My old config kept breaking randomly, so I rebuilt it from scratch. The goal is simple: explicit, predictable, and portable. No plugin frameworks, no auto-installers, no magic. If a tool is missing, things just gracefully skip it instead of exploding.

Uses native Neovim features like `vim.pack` and `vim.lsp` wherever possible. Though I am lazy enough to use Mason for managing LSPs.

## Features

- **Completion**: nvim-cmp with LSP, buffer, path sources + LuaSnip snippets
- **Status line**: lualine with diagnostics, git diff, and winbar
- **Git integration**: gitsigns for gutter signs and inline blame
- **Editing helpers**: autopairs, Comment.nvim
- **Markdown**: markview.nvim for rendered preview
- **Native buffer management**: Tab/S-Tab navigation, leader+number to jump

## Requirements

- **Neovim nightly** (v0.12+ for `vim.pack`)
- **git**, **ripgrep**, **fd**

```sh
# macOS
brew install ripgrep fd
brew install neovim --HEAD
```

LSP servers and formatters are detected at runtime - install whatever you need externally (or use Mason inside Neovim).

To install for debian is a mild pain because of the nightly build, though this
should be handled better shortly.

```sh
# Get the host ready to install nvim
apt update
apt install -y git curl build-essential unzip ripgrep fd-find nodejs npm

# Alias fd
echo 'alias fd=fdfind' >> ~/.bashrc
source ~/.bashrc

# Install nvim
curl -LO https://github.com/neovim/neovim/releases/download/nightly/nvim-linux-x86_64.appimage
chmod u+x nvim-linux-x86_64.appimage
./nvim-linux-x86_64.appimage --appimage-extract
mv squashfs-root /opt/nvim
ln -s /opt/nvim/usr/bin/nvim /usr/local/bin/nvim
rm nvim-linux-x86_64.appimage
```

## Health Check

Verify your setup with the built-in health check:

```vim
:checkhealth wort
```

This checks for required tools (`git`, `ripgrep`, `fd`).

To check LSP server status:

```vim
:LspHealth
```

## Installation

```sh
git clone https://github.com/lcox74/nvim ~/.config/nvim
nvim -c "lua vim.pack.update()"
```

Mason will automatically install any missing LSP servers, linters, and formatters on startup.

## Adding a Language Server

1. Add the Mason package name to `ensure_installed` in `lua/plugins/mason.lua`
2. Create a server config at `lua/lsp/servers/<name>.lua`:

```lua
return {
    name = "server_name",
    cmd = "server-binary",
    config = {
        cmd = { "server-binary", "--stdio" },
        filetypes = { "filetype" },
        root_markers = { "project.file", ".git" },
    },
}
```

3. Restart Neovim (Mason auto-installs, server auto-loads)

**Tips:**
- Run `:Mason` to browse available packages and find the exact package name
- Check Mason for the exact binary name (some servers need `--stdio`)
- Run `:set filetype?` to find the right filetype
- Use the main project file as root marker with `.git` as fallback
- Run `:LspHealth` to verify the server is detected

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
