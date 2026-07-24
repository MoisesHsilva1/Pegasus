#!/bin/bash

PEGASUS_DIR="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_DIR" ] && PEGASUS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

[ -f "$PEGASUS_DIR/configs/xcompose" ] && envsubst < "$PEGASUS_DIR/configs/xcompose" > ~/.XCompose 2>/dev/null || true
ibus restart 2>/dev/null || true
gsettings set org.gnome.desktop.input-sources xkb-options "['compose:caps']" 2>/dev/null || true
