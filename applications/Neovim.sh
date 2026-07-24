#!/bin/bash

mkdir -p "$HOME/.local/share/applications"

cat <<EOF >~/.local/share/applications/Neovim.desktop
[Desktop Entry]
Version=1.0
Name=Neovim (LazyVim)
Comment=Vim-based text editor inside Alacritty
Exec=alacritty --class=Neovim --title=Neovim -e nvim %F
Terminal=false
Type=Application
Icon=nvim
Categories=Utilities;TextEditor;Development;
StartupNotify=true
EOF

chmod +x ~/.local/share/applications/Neovim.desktop 2>/dev/null || true
