#!/bin/bash

PEGASUS_DIR="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_DIR" ] && PEGASUS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Run desktop installers
for installer in "$PEGASUS_DIR"/install/desktop/*.sh; do
  [ -f "$installer" ] && source "$installer"
done

# Reboot to pick up changes
gum confirm "Ready to reboot for all settings to take effect?" && sudo reboot || true
