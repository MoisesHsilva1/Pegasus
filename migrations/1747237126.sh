#!/bin/bash

PEGASUS_PATH="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_PATH" ] && PEGASUS_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

[ -f "$PEGASUS_PATH/configs/alacritty/btop.toml" ] && cp "$PEGASUS_PATH/configs/alacritty/btop.toml" ~/.config/alacritty/btop.toml 2>/dev/null || true

# Only attempt to set configuration if btop is not already set
if [ ! -f "$HOME/.config/btop/btop.conf" ]; then
  mkdir -p ~/.config/btop/themes
  [ -f "$PEGASUS_PATH/configs/btop.conf" ] && cp "$PEGASUS_PATH/configs/btop.conf" ~/.config/btop/btop.conf 2>/dev/null || true
fi
