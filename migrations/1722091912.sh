#!/bin/bash

PEGASUS_PATH="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_PATH" ] && PEGASUS_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

echo "Running upgrade migration..."

# Set name and class for desktop files
[ -f "$PEGASUS_PATH/applications/About.sh" ] && source "$PEGASUS_PATH/applications/About.sh"
[ -f "$PEGASUS_PATH/applications/Activity.sh" ] && source "$PEGASUS_PATH/applications/Activity.sh"
[ -f "$PEGASUS_PATH/applications/Basecamp.sh" ] && source "$PEGASUS_PATH/applications/Basecamp.sh"
[ -f "$PEGASUS_PATH/applications/HEY.sh" ] && source "$PEGASUS_PATH/applications/HEY.sh"
[ -f "$PEGASUS_PATH/applications/Docker.sh" ] && source "$PEGASUS_PATH/applications/Docker.sh"
[ -f "$PEGASUS_PATH/applications/Neovim.sh" ] && source "$PEGASUS_PATH/applications/Neovim.sh"
[ -f "$PEGASUS_PATH/applications/pegasus.sh" ] && source "$PEGASUS_PATH/applications/pegasus.sh"
[ -f "$PEGASUS_PATH/applications/Theme.sh" ] && source "$PEGASUS_PATH/applications/Theme.sh"
