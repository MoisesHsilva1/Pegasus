#!/bin/bash

PEGASUS_PATH="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_PATH" ] && PEGASUS_PATH="${OMAKUB_PATH:-$HOME/.local/share/omakub}"

if [ $# -eq 0 ]; then
	SUB=$(gum choose "Theme" "Font" "Update" "Install" "Uninstall" "Manual" "Quit" --height 10 --header "" | tr '[:upper:]' '[:lower:]')
else
	SUB=$1
fi

if [ -n "$SUB" ] && [ "$SUB" != "quit" ]; then
  if [ -f "$PEGASUS_PATH/bin/pegasus-sub/$SUB.sh" ]; then
    source "$PEGASUS_PATH/bin/pegasus-sub/$SUB.sh"
  elif [ -f "$PEGASUS_PATH/bin/omakub-sub/$SUB.sh" ]; then
    source "$PEGASUS_PATH/bin/omakub-sub/$SUB.sh"
  fi
fi
