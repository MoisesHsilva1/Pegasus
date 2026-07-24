#!/bin/bash

PEGASUS_DIR="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_DIR" ] && PEGASUS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mkdir -p "$HOME/.local/share/applications"

cat <<EOF >~/.local/share/applications/Pegasus.desktop
[Desktop Entry]
Version=1.0
Name=Pegasus
Comment=Pegasus Fedora Control Center
Exec=alacritty --class=Pegasus --title="Pegasus Menu" -e pegasus
Terminal=false
Type=Application
Icon=$PEGASUS_DIR/applications/icons/Pegasus.png
Categories=Settings;GTK;
StartupNotify=true
EOF

chmod +x ~/.local/share/applications/Pegasus.desktop 2>/dev/null || true