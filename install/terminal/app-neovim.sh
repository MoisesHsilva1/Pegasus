#!/bin/bash

PEGASUS_DIR="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_DIR" ] && PEGASUS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

cd /tmp
wget -O nvim.tar.gz "https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz" 2>/dev/null || true
tar -xf nvim.tar.gz 2>/dev/null || true
sudo install nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim 2>/dev/null || true
sudo cp -R nvim-linux-x86_64/lib /usr/local/ 2>/dev/null || true
sudo cp -R nvim-linux-x86_64/share /usr/local/ 2>/dev/null || true
rm -rf nvim-linux-x86_64 nvim.tar.gz
cd - >/dev/null

# Install luarocks and tree-sitter-cli to resolve lazyvim :checkhealth warnings
sudo dnf install -y --skip-unavailable luarocks tree-sitter-cli >/dev/null 2>&1 || true

# Only attempt to set configuration if Neovim has never been run
if [ ! -d "$HOME/.config/nvim" ]; then
  # Use LazyVim
  git clone https://github.com/LazyVim/starter ~/.config/nvim 2>/dev/null || true
  rm -rf ~/.config/nvim/.git

  # Make everything match the terminal transparency
  mkdir -p ~/.config/nvim/plugin/after
  [ -f "$PEGASUS_DIR/configs/neovim/transparency.lua" ] && cp "$PEGASUS_DIR/configs/neovim/transparency.lua" ~/.config/nvim/plugin/after/ 2>/dev/null || true

  # Default to Tokyo Night theme
  [ -f "$PEGASUS_DIR/themes/tokyo-night/neovim.lua" ] && cp "$PEGASUS_DIR/themes/tokyo-night/neovim.lua" ~/.config/nvim/lua/plugins/theme.lua 2>/dev/null || true

  # Turn off animated scrolling
  [ -f "$PEGASUS_DIR/configs/neovim/snacks-animated-scrolling-off.lua" ] && cp "$PEGASUS_DIR/configs/neovim/snacks-animated-scrolling-off.lua" ~/.config/nvim/lua/plugins/ 2>/dev/null || true

  # Turn off relative line numbers
  echo "vim.opt.relativenumber = false" >>~/.config/nvim/lua/config/options.lua

  # Ensure editor.neo-tree is used by default
  [ -f "$PEGASUS_DIR/configs/neovim/lazyvim.json" ] && cp "$PEGASUS_DIR/configs/neovim/lazyvim.json" ~/.config/nvim/ 2>/dev/null || true
fi

# Replace desktop launcher with one running inside Alacritty
if [[ -d ~/.local/share/applications ]]; then
  sudo rm -rf /usr/share/applications/nvim.desktop 2>/dev/null || true
  sudo rm -rf /usr/local/share/applications/nvim.desktop 2>/dev/null || true
  [ -f "$PEGASUS_DIR/applications/Neovim.sh" ] && source "$PEGASUS_DIR/applications/Neovim.sh"
fi
