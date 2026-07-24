#!/bin/bash

PEGASUS_DIR="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_DIR" ] && PEGASUS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

if [ ! -f /etc/yum.repos.d/vscode.repo ]; then
  sudo rpm --import https://packages.microsoft.com/keys/microsoft.asc 2>/dev/null || true
  echo -e "[code]\nname=Visual Studio Code\nbaseurl=https://packages.microsoft.com/yumrepos/vscode\nenabled=1\ngpgcheck=1\ngpgkey=https://packages.microsoft.com/keys/microsoft.asc" | sudo tee /etc/yum.repos.d/vscode.repo >/dev/null
fi

sudo dnf install -y --skip-unavailable code >/dev/null 2>&1 || true

mkdir -p ~/.config/Code/User
[ -f "$PEGASUS_DIR/configs/vscode.json" ] && cp "$PEGASUS_DIR/configs/vscode.json" ~/.config/Code/User/settings.json 2>/dev/null || true

# Install default supported themes
code --install-extension enkia.tokyo-night >/dev/null 2>&1 || true