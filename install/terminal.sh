#!/bin/bash

# Needed for all installers
sudo dnf check-update >/dev/null 2>&1 || true
sudo dnf upgrade -y --skip-unavailable >/dev/null 2>&1 || true
sudo dnf install -y --skip-unavailable curl git unzip >/dev/null 2>&1 || true

PEGASUS_DIR="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_DIR" ] && PEGASUS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Run terminal installers
for installer in "$PEGASUS_DIR"/install/terminal/*.sh; do
  [ -f "$installer" ] && source "$installer"
done
