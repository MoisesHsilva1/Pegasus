#!/bin/bash

PEGASUS_PATH="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_PATH" ] && PEGASUS_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Only attempt to set configuration if fastfetch is not already set
if [ ! -f "$HOME/.config/fastfetch/config.jsonc" ]; then
  mkdir -p ~/.config/fastfetch
  [ -f "$PEGASUS_PATH/configs/fastfetch.jsonc" ] && cp "$PEGASUS_PATH/configs/fastfetch.jsonc" ~/.config/fastfetch/config.jsonc 2>/dev/null || true
fi
