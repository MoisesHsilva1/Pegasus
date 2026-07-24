#!/bin/bash

cat <<EOF >~/.local/share/applications/About.desktop
[Desktop Entry]
Version=1.0
Name=About Pegasus
Comment=About Pegasus Developer Setup
Exec=xdg-open https://github.com/MoisesHsilva1/Pegasus
Terminal=false
Type=Application
Icon=help-about
Categories=GTK;
StartupNotify=true
EOF

chmod +x ~/.local/share/applications/About.desktop 2>/dev/null || true
