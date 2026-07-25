#!/bin/bash

PEGASUS_DIR="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_DIR" ] && PEGASUS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

mkdir -p "$HOME/.local/share/applications"
mkdir -p "$HOME/.local/share/applications/icons"

if [ -f "$PEGASUS_DIR/applications/icons/Pegasus.png" ]; then
  cp "$PEGASUS_DIR/applications/icons/Pegasus.png" "$HOME/.local/share/applications/icons/Pegasus.png" 2>/dev/null || true
fi

ICON_PATH="$HOME/.local/share/applications/icons/Pegasus.png"
[ ! -f "$ICON_PATH" ] && ICON_PATH="preferences-desktop-personal"

cat <<EOF >~/.local/share/applications/PegasusControlCenter.desktop
[Desktop Entry]
Version=1.0
Name=Pegasus Control Center
Comment=Manage Pegasus developer setup, themes, fonts, and settings
Exec=alacritty --class=PegasusControlCenter --title="Pegasus Control Center" -e pegasus
Terminal=false
Type=Application
Icon=$ICON_PATH
Categories=Settings;GTK;
StartupNotify=true
EOF

chmod +x ~/.local/share/applications/PegasusControlCenter.desktop 2>/dev/null || true

# Also ensure Theme launcher is created
[ -f "$PEGASUS_DIR/applications/Theme.sh" ] && source "$PEGASUS_DIR/applications/Theme.sh"