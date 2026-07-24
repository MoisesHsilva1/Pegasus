#!/bin/bash

PEGASUS_DIR="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_DIR" ] && PEGASUS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

sudo dnf install -y --skip-unavailable fastfetch >/dev/null 2>&1 || true

# Only attempt to set configuration if fastfetch is not already set
if [ ! -f "$HOME/.config/fastfetch/config.jsonc" ]; then
  mkdir -p ~/.config/fastfetch
  [ -f "$PEGASUS_DIR/configs/fastfetch.jsonc" ] && cp "$PEGASUS_DIR/configs/fastfetch.jsonc" ~/.config/fastfetch/config.jsonc 2>/dev/null || true
fi
