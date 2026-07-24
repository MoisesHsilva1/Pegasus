#!/bin/bash

PEGASUS_PATH="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_PATH" ] && PEGASUS_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

[ -d "$PEGASUS_PATH/configs/alacritty" ] && cp "$PEGASUS_PATH/configs/alacritty/"* ~/.config/alacritty/ 2>/dev/null || true

[ -f "$PEGASUS_PATH/applications/About.sh" ] && source "$PEGASUS_PATH/applications/About.sh"
[ -f "$PEGASUS_PATH/applications/Activity.sh" ] && source "$PEGASUS_PATH/applications/Activity.sh"
[ -f "$PEGASUS_PATH/applications/Neovim.sh" ] && source "$PEGASUS_PATH/applications/Neovim.sh"
[ -f "$PEGASUS_PATH/applications/Docker.sh" ] && source "$PEGASUS_PATH/applications/Docker.sh"
[ -f "$PEGASUS_PATH/applications/pegasus.sh" ] && source "$PEGASUS_PATH/applications/pegasus.sh"
[ -f "$PEGASUS_PATH/applications/Theme.sh" ] && source "$PEGASUS_PATH/applications/Theme.sh"

alacritty migrate 2>/dev/null || true
alacritty migrate -c ~/.config/alacritty/pane.toml 2>/dev/null || true
alacritty migrate -c ~/.config/alacritty/btop.toml 2>/dev/null || true
