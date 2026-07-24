#!/bin/bash

PEGASUS_DIR="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_DIR" ] && PEGASUS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../../.." && pwd)"

cd /tmp
curl -L "https://www.cursor.com/api/download?platform=linux-x64&releaseTrack=stable" | jq -r '.downloadUrl' | xargs curl -L -o cursor.appimage 2>/dev/null || true
sudo mv cursor.appimage /opt/cursor.appimage 2>/dev/null || true
sudo chmod +x /opt/cursor.appimage 2>/dev/null || true
sudo dnf install -y fuse fuse-libs 2>/dev/null || true

DESKTOP_FILE="/usr/share/applications/cursor.desktop"

sudo bash -c "cat > $DESKTOP_FILE" <<EOL
[Desktop Entry]
Name=Cursor
Comment=AI-powered code editor
Exec=/opt/cursor.appimage --no-sandbox
Icon=$PEGASUS_DIR/applications/icons/cursor.png
Type=Application
Categories=Development;IDE;
EOL
