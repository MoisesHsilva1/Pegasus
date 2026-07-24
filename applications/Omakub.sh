#!/bin/bash

cat <<EOF >~/.local/share/applications/Omakub.desktop
[Desktop Entry]
Version=1.0
Name=Pegasus Menu
Comment=Pegasus Fedora Control Center
Exec=alacritty --class=Pegasus --title="Pegasus Menu" -e pegasus
Terminal=false
Type=Application
Icon=preferences-system
Categories=GTK;Settings;
StartupNotify=true
EOF

chmod +x ~/.local/share/applications/Omakub.desktop 2>/dev/null || true
