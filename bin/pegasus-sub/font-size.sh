#!/bin/bash

PEGASUS_PATH="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_PATH" ] && PEGASUS_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

choice=$(gum choose {7..14} "<< Back" --height 11 --header "Choose your terminal font size")

if [[ $choice =~ ^[0-9]+$ ]]; then
	[ -f ~/.config/alacritty/font-size.toml ] && sed -i "s/^size = .*$/size = $choice/g" ~/.config/alacritty/font-size.toml 2>/dev/null || true
	source "$PEGASUS_PATH/bin/pegasus-sub/font-size.sh"
else
	source "$PEGASUS_PATH/bin/pegasus-sub/font.sh"
fi
