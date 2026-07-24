#!/bin/bash

PEGASUS_DIR="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_DIR" ] && PEGASUS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mkdir -p "$HOME/.local/share/applications"

cat <<EOF >~/.local/share/applications/Docker.desktop
[Desktop Entry]
Version=1.0
Name=Docker (LazyDocker)
Comment=Manage Docker containers with LazyDocker inside Alacritty
Exec=alacritty --class=Docker --title=LazyDocker -e lazydocker
Terminal=false
Type=Application
Icon=$PEGASUS_DIR/applications/icons/Docker.png
Categories=Development;System;GTK;
StartupNotify=true
EOF

chmod +x ~/.local/share/applications/Docker.desktop 2>/dev/null || true
