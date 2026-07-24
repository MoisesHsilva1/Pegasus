#!/bin/bash

PEGASUS_PATH="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_PATH" ] && PEGASUS_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

xdg-open "https://github.com/MoisesHsilva1/Pegasus" &>/dev/null || true
if [ -n "$PEGASUS_CLI_MENU" ]; then
  source "$PEGASUS_PATH/bin/pegasus-sub/menu.sh"
fi
