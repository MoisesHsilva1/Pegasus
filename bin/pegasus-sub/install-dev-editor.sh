#!/bin/bash

PEGASUS_PATH="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_PATH" ] && PEGASUS_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

CHOICES=(
  "Cursor            AI Code Editor"
  "Doom Emacs        Emacs framework with curated list of packages"
  "RubyMine          IntelliJ's commercial Ruby editor"
  "Windsurf          Another AI Code Editor"
  "Zed               Fast all-purpose editor"
  "<< Back           "
)

CHOICE=$(gum choose "${CHOICES[@]}" --height 8 --header "Install editor")

if [[ "$CHOICE" == "<< Back"* ]] || [[ -z "$CHOICE" ]]; then
  echo ""
else
  INSTALLER=$(echo "$CHOICE" | awk -F ' {2,}' '{print $1}' | tr '[:upper:]' '[:lower:]' | sed 's/ /-/g')
  INSTALLER_FILE="$PEGASUS_PATH/install/desktop/optional/app-$INSTALLER.sh"

  [ -f "$INSTALLER_FILE" ] && source "$INSTALLER_FILE" && gum spin --spinner globe --title "Install completed!" -- sleep 3
fi

clear
source "$PEGASUS_PATH/bin/pegasus-sub/header.sh"
source "$PEGASUS_PATH/bin/pegasus-sub/install.sh"
