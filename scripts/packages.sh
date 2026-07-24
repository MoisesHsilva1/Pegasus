#!/bin/bash

_SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PEGASUS_DIR="${PEGASUS_DIR:-$(cd "$_SCRIPT_DIR/.." && pwd)}"
source "$PEGASUS_DIR/scripts/ui.sh"

install_packages() {
  print_section "Installing Development Libraries & System Utilities"

  # DNF System Upgrade & Core Libraries
  step_info "Updating package repositories..."
  sudo dnf check-update >/dev/null 2>&1 || true

  step_info "Installing core build tools and C/C++ development headers..."
  sudo dnf install -y --skip-unavailable --skip-broken \
    @development-tools pkgconfig autoconf bison clang rustc pipx \
    openssl-devel readline-devel zlib-devel libyaml-devel ncurses-devel libffi-devel gdbm-devel jemalloc-devel \
    vips-devel ImageMagick ImageMagick-devel mupdf mupdf-devel \
    sqlite sqlite-devel mariadb-devel postgresql >/dev/null 2>&1 || true
  step_success "Core development libraries installed"

  # CLI Utilities
  step_info "Installing CLI tools (fzf, ripgrep, bat, eza, zoxide, btop, fastfetch, gh, etc.)..."
  sudo dnf install -y --skip-unavailable --skip-broken \
    fzf ripgrep bat eza zoxide plocate httpd-tools fd-find btop fastfetch gh luarocks tree-sitter-cli >/dev/null 2>&1 || true
  step_success "CLI utilities installed"

  # Neovim Stable Binary
  step_info "Installing Neovim stable..."
  cd /tmp
  wget -qO nvim.tar.gz "https://github.com/neovim/neovim/releases/download/stable/nvim-linux-x86_64.tar.gz"
  tar -xf nvim.tar.gz
  sudo install nvim-linux-x86_64/bin/nvim /usr/local/bin/nvim
  sudo cp -R nvim-linux-x86_64/lib /usr/local/ 2>/dev/null || true
  sudo cp -R nvim-linux-x86_64/share /usr/local/ 2>/dev/null || true
  rm -rf nvim-linux-x86_64 nvim.tar.gz
  cd - >/dev/null
  step_success "Neovim installed"

  # LazyVim Configuration
  if [ ! -d "$HOME/.config/nvim" ]; then
    step_info "Configuring LazyVim starter..."
    git clone --quiet https://github.com/LazyVim/starter ~/.config/nvim
    rm -rf ~/.config/nvim/.git
    mkdir -p ~/.config/nvim/plugin/after
    [ -f "$PEGASUS_DIR/configs/neovim/transparency.lua" ] && cp "$PEGASUS_DIR/configs/neovim/transparency.lua" ~/.config/nvim/plugin/after/
    [ -f "$PEGASUS_DIR/themes/tokyo-night/neovim.lua" ] && cp "$PEGASUS_DIR/themes/tokyo-night/neovim.lua" ~/.config/nvim/lua/plugins/theme.lua 2>/dev/null || true
    echo "vim.opt.relativenumber = false" >> ~/.config/nvim/lua/config/options.lua
    step_success "LazyVim configured"
  fi

  # Lazydocker & Lazygit
  step_info "Installing Lazydocker & Lazygit TUIs..."
  cd /tmp
  LAZYDOCKER_VER=$(curl -s "https://api.github.com/repos/jesseduffield/lazydocker/releases/latest" | grep -Po '"tag_name": "v\K[^"]*' || echo "0.23.3")
  curl -sLo lazydocker.tar.gz "https://github.com/jesseduffield/lazydocker/releases/latest/download/lazydocker_${LAZYDOCKER_VER}_Linux_x86_64.tar.gz"
  tar -xf lazydocker.tar.gz lazydocker
  sudo install lazydocker /usr/local/bin
  rm -f lazydocker.tar.gz lazydocker

  LAZYGIT_VER=$(curl -s "https://api.github.com/repos/jesseduffield/lazygit/releases/latest" | grep -Po '"tag_name": "v\K[^"]*' || echo "0.44.1")
  curl -sLo lazygit.tar.gz "https://github.com/jesseduffield/lazygit/releases/latest/download/lazygit_${LAZYGIT_VER}_Linux_x86_64.tar.gz"
  tar -xf lazygit.tar.gz lazygit
  sudo install lazygit /usr/local/bin
  rm -f lazygit.tar.gz lazygit
  mkdir -p ~/.config/lazygit
  touch ~/.config/lazygit/config.yml
  cd - >/dev/null
  step_success "Lazydocker & Lazygit installed"

  # Zellij Multiplexer
  step_info "Installing Zellij multiplexer..."
  cd /tmp
  wget -qO zellij.tar.gz "https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz"
  tar -xf zellij.tar.gz zellij
  sudo install zellij /usr/local/bin
  rm -f zellij.tar.gz zellij
  mkdir -p ~/.config/zellij/themes
  [ -f "$PEGASUS_DIR/configs/zellij.kdl" ] && [ ! -f "$HOME/.config/zellij/config.kdl" ] && cp "$PEGASUS_DIR/configs/zellij.kdl" ~/.config/zellij/config.kdl
  cd - >/dev/null
  step_success "Zellij installed"

  # Mise Version Manager
  step_info "Installing Mise runtime version manager..."
  if [ ! -f /etc/yum.repos.d/mise.repo ]; then
    sudo dnf config-manager --add-repo https://mise.jdx.dev/rpm/mise.repo 2>/dev/null || true
  fi
  sudo dnf install -y --skip-unavailable mise >/dev/null 2>/dev/null || true
  step_success "Mise version manager installed"
}

install_packages
