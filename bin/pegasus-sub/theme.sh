#!/bin/bash

PEGASUS_PATH="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_PATH" ] && PEGASUS_PATH="${OMAKUB_PATH:-$HOME/.local/share/omakub}"

THEME_NAMES=("Tokyo Night" "Catppuccin" "Nord" "Everforest" "Gruvbox" "Kanagawa" "Ristretto" "Rose Pine" "Matte Black" "Osaka Jade")
THEME=$(gum choose "${THEME_NAMES[@]}" "<< Back" --header "Choose your Pegasus theme" --height 12 | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')

if [ -n "$THEME" ] && [ "$THEME" != "<<-back" ]; then
  [ -f "$PEGASUS_PATH/themes/$THEME/alacritty.toml" ] && [ -d "$HOME/.config/alacritty" ] && cp $PEGASUS_PATH/themes/$THEME/alacritty.toml ~/.config/alacritty/theme.toml 2>/dev/null || true
  if [ -d "$HOME/.config/zellij" ]; then
    mkdir -p ~/.config/zellij/themes
    cp $PEGASUS_PATH/themes/$THEME/zellij.kdl ~/.config/zellij/themes/$THEME.kdl 2>/dev/null || true
    sed -i "s/theme \".*\"/theme \"$THEME\"/g" ~/.config/zellij/config.kdl 2>/dev/null || true
  fi
  if [ -d "$HOME/.config/nvim" ]; then
    cp $PEGASUS_PATH/themes/$THEME/neovim.lua ~/.config/nvim/lua/plugins/theme.lua 2>/dev/null || true
  fi

  if [ -f "$PEGASUS_PATH/themes/$THEME/btop.theme" ] && [ -d "$HOME/.config/btop" ]; then
    cp $PEGASUS_PATH/themes/$THEME/btop.theme ~/.config/btop/themes/$THEME.theme 2>/dev/null || true
    sed -i "s/color_theme = \".*\"/color_theme = \"$THEME\"/g" ~/.config/btop/btop.conf 2>/dev/null || true
  fi

  [ -f "$PEGASUS_PATH/themes/$THEME/gnome.sh" ] && source $PEGASUS_PATH/themes/$THEME/gnome.sh 2>/dev/null || true
  [ -f "$PEGASUS_PATH/themes/$THEME/tophat.sh" ] && source $PEGASUS_PATH/themes/$THEME/tophat.sh 2>/dev/null || true
  [ -f "$PEGASUS_PATH/themes/$THEME/vscode.sh" ] && source $PEGASUS_PATH/themes/$THEME/vscode.sh 2>/dev/null || true
fi

if [ -n "$PEGASUS_CLI_MENU" ]; then
  source "$PEGASUS_PATH/bin/pegasus-sub/menu.sh"
fi
