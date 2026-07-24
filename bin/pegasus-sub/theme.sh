#!/bin/bash

PEGASUS_PATH="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_PATH" ] && PEGASUS_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

CURRENT_THEME_FILE="$HOME/.config/pegasus/current_theme"

get_current_theme() {
  if [ -f "$CURRENT_THEME_FILE" ]; then
    cat "$CURRENT_THEME_FILE"
  else
    echo "tokyo-night"
  fi
}

get_available_themes() {
  local themes=()
  for dir in "$PEGASUS_PATH"/themes/*; do
    if [ -d "$dir" ]; then
      themes+=("$(basename "$dir")")
    fi
  done
  echo "${themes[@]}"
}

format_title() {
  local slug="$1"
  echo "$slug" | tr '-' ' ' | sed -e 's/\b\(.\)/\u\1/g'
}

slugify() {
  echo "$1" | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g'
}

apply_component() {
  local name="$1"
  local cmd="$2"
  eval "$cmd" >/dev/null 2>&1
  local status=$?
  if [ $status -ne 0 ]; then
    echo "[!] Warning: Theme component '$name' encountered an issue, continuing..." >&2
  fi
  return 0
}

apply_theme() {
  local THEME="$1"
  THEME=$(slugify "$THEME")

  if [ ! -d "$PEGASUS_PATH/themes/$THEME" ]; then
    echo "Error: Theme '$THEME' not found in $PEGASUS_PATH/themes/" >&2
    return 1
  fi

  echo "[•] Applying Pegasus theme profile: $THEME..."

  # Save active theme state
  mkdir -p "$HOME/.config/pegasus"
  echo "$THEME" > "$CURRENT_THEME_FILE"

  # 1. Alacritty
  if [ -d "$HOME/.config/alacritty" ]; then
    apply_component "Alacritty" "[ -f '$PEGASUS_PATH/themes/$THEME/alacritty.toml' ] && cp '$PEGASUS_PATH/themes/$THEME/alacritty.toml' ~/.config/alacritty/theme.toml"
  fi

  # 2. Zellij
  if [ -d "$HOME/.config/zellij" ]; then
    mkdir -p ~/.config/zellij/themes
    apply_component "Zellij" "[ -f '$PEGASUS_PATH/themes/$THEME/zellij.kdl' ] && cp '$PEGASUS_PATH/themes/$THEME/zellij.kdl' ~/.config/zellij/themes/$THEME.kdl && [ -f ~/.config/zellij/config.kdl ] && sed -i 's/theme \".*\"/theme \"$THEME\"/g' ~/.config/zellij/config.kdl"
  fi

  # 3. Neovim
  if [ -d "$HOME/.config/nvim" ]; then
    apply_component "Neovim" "[ -f '$PEGASUS_PATH/themes/$THEME/neovim.lua' ] && cp '$PEGASUS_PATH/themes/$THEME/neovim.lua' ~/.config/nvim/lua/plugins/theme.lua"
  fi

  # 4. btop
  if [ -d "$HOME/.config/btop" ]; then
    apply_component "btop" "[ -f '$PEGASUS_PATH/themes/$THEME/btop.theme' ] && cp '$PEGASUS_PATH/themes/$THEME/btop.theme' ~/.config/btop/themes/$THEME.theme && [ -f ~/.config/btop/btop.conf ] && sed -i 's/color_theme = \".*\"/color_theme = \"$THEME\"/g' ~/.config/btop/btop.conf"
  fi

  # 5. GNOME Desktop & Wallpaper & Accent Colors
  if [ -f "$PEGASUS_PATH/themes/$THEME/gnome.sh" ]; then
    apply_component "GNOME Settings" "source '$PEGASUS_PATH/themes/$THEME/gnome.sh'"
  fi

  if [ -f "$PEGASUS_PATH/themes/$THEME/tophat.sh" ]; then
    apply_component "TopHat Extension" "source '$PEGASUS_PATH/themes/$THEME/tophat.sh'"
  fi

  # 6. Visual Studio Code
  if [ -f "$PEGASUS_PATH/themes/$THEME/vscode.sh" ]; then
    apply_component "VS Code Theme" "source '$PEGASUS_PATH/themes/$THEME/vscode.sh'"
  fi

  echo "[✓] Pegasus theme '$THEME' applied successfully!"
  return 0
}

# CLI Argument Router
case "${1:-}" in
  "list")
    echo "Available Pegasus Themes:"
    for t in $(get_available_themes); do
      echo " - $(format_title "$t") ($t)"
    done
    exit 0
    ;;
  "current")
    echo "Current Active Theme: $(get_current_theme)"
    exit 0
    ;;
  "apply")
    if [ -z "${2:-}" ]; then
      echo "Usage: pegasus theme apply <theme-name>" >&2
      exit 1
    fi
    apply_theme "$2"
    exit 0
    ;;
esac

# Interactive Gum Menu Mode
THEME_SLUGS=($(get_available_themes))
THEME_TITLES=()
for slug in "${THEME_SLUGS[@]}"; do
  THEME_TITLES+=("$(format_title "$slug")")
done

SELECTED_TITLE=$(gum choose "${THEME_TITLES[@]}" "<< Back" --header "Choose your Pegasus theme" --height 14)

if [ -n "$SELECTED_TITLE" ] && [ "$SELECTED_TITLE" != "<< Back" ]; then
  SELECTED_SLUG=$(slugify "$SELECTED_TITLE")
  apply_theme "$SELECTED_SLUG"
fi

if [ -n "$PEGASUS_CLI_MENU" ]; then
  source "$PEGASUS_PATH/bin/pegasus-sub/menu.sh"
fi
