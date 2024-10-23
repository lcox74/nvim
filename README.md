# Neovim Config

This is my config for nvim setup. I've been forcing myself to use neovim more 
as another tool to develop. I want to make this easy to install on all the 
machines I do development work on. I will probably update this every so often
depending on how comfortable I get with it.

```bash
# Install required packages
apt install neovim ripgrep

# Install Package Manager
git clone --depth 1 https://github.com/wbthomason/packer.nvim\
 ~/.local/share/nvim/site/pack/packer/start/packer.nvim

# Create Neovim config directory if it doesn't exist
mkdir -p ~/.config/nvim

# Install all the packages
nvim --headless -c 'autocmd User PackerComplete quitall' -c 'PackerSync'
```
