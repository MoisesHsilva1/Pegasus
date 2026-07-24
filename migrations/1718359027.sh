#!/bin/bash

# Catch 1.0.0 up to 1.1.0

PEGASUS_PATH="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_PATH" ] && PEGASUS_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Running upgrade migration..."

# Change Zellij directory to be realized rather than a symlink
ZELLIJ_THEMES_DIR="$HOME/.config/zellij/themes"
if [ -L $ZELLIJ_THEMES_DIR ]; then
	rm $ZELLIJ_THEMES_DIR
	mkdir -p $ZELLIJ_THEMES_DIR
	for dir in "$PEGASUS_PATH"/themes/*; do
		if [ -d "$dir" ]; then
			zellij_file="$dir/zellij.kdl"
			dir_name=$(basename "$dir")
			dest_file="$ZELLIJ_THEMES_DIR/$dir_name.kdl"
			[ -f "$zellij_file" ] && cp "$zellij_file" "$dest_file" 2>/dev/null || true
		fi
	done
fi

# New neovim settings
mkdir -p ~/.config/nvim/plugin/after
[ -f "$PEGASUS_PATH/configs/neovim/transparency.lua" ] && cp "$PEGASUS_PATH/configs/neovim/transparency.lua" ~/.config/nvim/plugin/after/ 2>/dev/null || true
[ -f ~/.config/nvim/lua/config/lazy.lua ] && sed -i 's/checker = { enabled = true }/checker = { enabled = true, notify = false }/g' ~/.config/nvim/lua/config/lazy.lua 2>/dev/null || true
[ -f "$PEGASUS_PATH/applications/Neovim.sh" ] && source "$PEGASUS_PATH/applications/Neovim.sh"

# New font size setup
[ -f "$PEGASUS_PATH/configs/alacritty/font-size.toml" ] && cp "$PEGASUS_PATH/configs/alacritty/font-size.toml" ~/.config/alacritty/ 2>/dev/null || true
[ -f "$PEGASUS_PATH/themes/tokyo-night/alacritty.toml" ] && cp "$PEGASUS_PATH/themes/tokyo-night/alacritty.toml" ~/.config/alacritty/theme.toml 2>/dev/null || true

# Set new Gnome settings
[ -f "$PEGASUS_PATH/install/desktop/set-gnome-settings.sh" ] && source "$PEGASUS_PATH/install/desktop/set-gnome-settings.sh" 2>/dev/null || true

# Add new desktop applications icons
[ -f "$PEGASUS_PATH/applications/pegasus.sh" ] && source "$PEGASUS_PATH/applications/pegasus.sh"
[ -f "$PEGASUS_PATH/applications/About.sh" ] && source "$PEGASUS_PATH/applications/About.sh"
[ -f "$PEGASUS_PATH/applications/Activity.sh" ] && source "$PEGASUS_PATH/applications/Activity.sh"
[ -f "$PEGASUS_PATH/applications/Docker.sh" ] && source "$PEGASUS_PATH/applications/Docker.sh"

# Set new app grid
[ -f "$PEGASUS_PATH/install/desktop/set-app-grid.sh" ] && source "$PEGASUS_PATH/install/desktop/set-app-grid.sh" 2>/dev/null || true
