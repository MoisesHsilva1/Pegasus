#!/bin/bash

cat <<EOF >~/.local/share/applications/Neovim.desktop
[Desktop Entry]
Version=1.0
Name=Neovim
Comment=Edit text files
Exec=nvim %F
Terminal=true
Type=Application
Icon=nvim
Categories=Utilities;TextEditor;Development;
StartupNotify=false
EOF
