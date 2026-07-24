#!/bin/bash

PEGASUS_PATH="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_PATH" ] && PEGASUS_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

[ -f "$PEGASUS_PATH/install/desktop/app-wl-clipboard.sh" ] && source "$PEGASUS_PATH/install/desktop/app-wl-clipboard.sh"
