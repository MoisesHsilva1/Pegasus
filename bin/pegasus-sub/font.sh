#!/bin/bash

PEGASUS_PATH="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_PATH" ] && PEGASUS_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

set_font() {
	local font_name=$1
	local url=$2
	local file_type=$3
	local file_name="${font_name/ Nerd Font/}"

	if ! $(fc-list | grep -i "$font_name" >/dev/null); then
		cd /tmp
		wget -O "$file_name.zip" "$url"
		unzip -qo "$file_name.zip" -d "$file_name"
		mkdir -p ~/.local/share/fonts
		cp "$file_name"/*."$file_type" ~/.local/share/fonts 2>/dev/null || true
		rm -rf "$file_name.zip" "$file_name"
		fc-cache >/dev/null 2>&1 || true
		cd - >/dev/null
		clear
		source "$PEGASUS_PATH/ascii.sh"
	fi

	gsettings set org.gnome.desktop.interface monospace-font-name "$font_name 10" 2>/dev/null || true
	[ -f "$PEGASUS_PATH/configs/alacritty/fonts/$file_name.toml" ] && cp "$PEGASUS_PATH/configs/alacritty/fonts/$file_name.toml" ~/.config/alacritty/font.toml 2>/dev/null || true
	[ -f ~/.config/Code/User/settings.json ] && sed -i "s/\"editor.fontFamily\": \".*\"/\"editor.fontFamily\": \"$font_name\"/g" ~/.config/Code/User/settings.json 2>/dev/null || true
}

if [ "$#" -gt 1 ]; then
	choice=${!#}
else
	choice=$(gum choose "Cascadia Mono" "Fira Mono" "JetBrains Mono" "Meslo" "> Change size" "<< Back" --height 8 --header "Choose your programming font")
fi

case $choice in
"Cascadia Mono")
	set_font "CaskaydiaMono Nerd Font" "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/CascadiaMono.zip" "ttf"
	;;
"Fira Mono")
	set_font "FiraMono Nerd Font" "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/FiraMono.zip" "otf"
	;;
"JetBrains Mono")
	set_font "JetBrainsMono Nerd Font" "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/JetBrainsMono.zip" "ttf"
	;;
"Meslo")
	set_font "MesloLGS Nerd Font" "https://github.com/ryanoasis/nerd-fonts/releases/latest/download/Meslo.zip" "ttf"
	;;
"> Change size")
	source "$PEGASUS_PATH/bin/pegasus-sub/font-size.sh"
	exit 0
	;;
esac

if [ -n "$PEGASUS_CLI_MENU" ]; then
  source "$PEGASUS_PATH/bin/pegasus-sub/menu.sh"
fi
