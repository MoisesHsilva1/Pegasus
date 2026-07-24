#!/bin/bash

PEGASUS_DIR="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_DIR" ] && PEGASUS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mkdir -p "$HOME/.local/share/applications"

cat <<EOF >~/.local/share/applications/PegasusTheme.desktop
[Desktop Entry]
Version=1.0
Name=Pegasus Theme
Comment=Change and customize the Pegasus Linux desktop appearance
Exec=alacritty --class=PegasusTheme --title="Pegasus Theme" -e pegasus theme
Terminal=false
Type=Application
Icon=preferences-desktop-theme
Categories=Settings;GTK;
StartupNotify=true
EOF

chmod +x ~/.local/share/applications/PegasusTheme.desktop 2>/dev/null || true
