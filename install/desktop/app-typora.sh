#!/bin/bash

# Typora is a markdown editor and reader. See https://typora.io/
flatpak install -y flathub io.typora.Typora 2>/dev/null || true

PEGASUS_DIR="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_DIR" ] && PEGASUS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

# Add iA Typora theme
mkdir -p ~/.config/Typora/themes
[ -d "$PEGASUS_DIR/configs/typora" ] && cp "$PEGASUS_DIR/configs/typora/"*.css ~/.config/Typora/themes/ 2>/dev/null || true
