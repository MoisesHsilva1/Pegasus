#!/bin/bash

PEGASUS_PATH="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_PATH" ] && PEGASUS_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Turn off animated scrolling
[ -f "$PEGASUS_PATH/configs/neovim/snacks-animated-scrolling-off.lua" ] && [ -d ~/.config/nvim/lua/plugins ] && cp "$PEGASUS_PATH/configs/neovim/snacks-animated-scrolling-off.lua" ~/.config/nvim/lua/plugins/ 2>/dev/null || true
