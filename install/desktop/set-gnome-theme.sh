#!/bin/bash

PEGASUS_DIR="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_DIR" ] && PEGASUS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

[ -f "$PEGASUS_DIR/themes/tokyo-night/gnome.sh" ] && source "$PEGASUS_DIR/themes/tokyo-night/gnome.sh" 2>/dev/null || true
[ -f "$PEGASUS_DIR/themes/tokyo-night/tophat.sh" ] && source "$PEGASUS_DIR/themes/tokyo-night/tophat.sh" 2>/dev/null || true
