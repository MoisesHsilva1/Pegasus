#!/bin/bash

PEGASUS_PATH="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_PATH" ] && PEGASUS_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

[ -f "$PEGASUS_PATH/install/desktop/set-alacritty-default.sh" ] && source "$PEGASUS_PATH/install/desktop/set-alacritty-default.sh"
nautilus -q 2>/dev/null || true
