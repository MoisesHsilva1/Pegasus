#!/bin/bash

PEGASUS_DIR="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_DIR" ] && PEGASUS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

sudo dnf install -y --skip-unavailable btop >/dev/null 2>&1 || true

# Use Pegasus btop config
mkdir -p ~/.config/btop/themes
[ -f "$PEGASUS_DIR/configs/btop.conf" ] && cp "$PEGASUS_DIR/configs/btop.conf" ~/.config/btop/btop.conf 2>/dev/null || true
[ -f "$PEGASUS_DIR/themes/tokyo-night/btop.theme" ] && cp "$PEGASUS_DIR/themes/tokyo-night/btop.theme" ~/.config/btop/themes/tokyo-night.theme 2>/dev/null || true
