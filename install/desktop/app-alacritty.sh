#!/bin/bash

sudo dnf install -y --skip-unavailable alacritty >/dev/null 2>&1 || true

# Copy default Alacritty configuration
mkdir -p ~/.config/alacritty
PEGASUS_DIR="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_DIR" ] && PEGASUS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

if [ -d "$PEGASUS_DIR/configs/alacritty" ]; then
  cp -r "$PEGASUS_DIR/configs/alacritty/"* ~/.config/alacritty/ 2>/dev/null || true
fi

# Initialize default theme and font if missing
if [ ! -f ~/.config/alacritty/theme.toml ] && [ -f "$PEGASUS_DIR/themes/tokyo-night/alacritty.toml" ]; then
  cp "$PEGASUS_DIR/themes/tokyo-night/alacritty.toml" ~/.config/alacritty/theme.toml 2>/dev/null || true
fi

if [ ! -f ~/.config/alacritty/font.toml ] && [ -f ~/.config/alacritty/fonts/CaskaydiaMono.toml ]; then
  cp ~/.config/alacritty/fonts/CaskaydiaMono.toml ~/.config/alacritty/font.toml 2>/dev/null || true
fi
