#!/bin/bash

mkdir -p "$HOME/.local/share/applications"

cat <<EOF >~/.local/share/applications/Neovim.desktop
[Desktop Entry]
Version=1.0
Name=Neovim (LazyVim)
Comment=Vim-based text editor with LazyVim plugins
Exec=nvim %F
Terminal=true
Type=Application
Icon=nvim
Categories=Utilities;TextEditor;Development;
StartupNotify=true
EOF

chmod +x ~/.local/share/applications/Neovim.desktop 2>/dev/null || true
