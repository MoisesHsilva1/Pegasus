#!/bin/bash

PEGASUS_DIR="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_DIR" ] && PEGASUS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

APPS="${PEGASUS_FIRST_RUN_OPTIONAL_APPS:-$OMAKUB_FIRST_RUN_OPTIONAL_APPS}"

if [[ -n "$APPS" ]]; then
	for app in $APPS; do
		[ -f "$PEGASUS_DIR/install/desktop/optional/app-${app,,}.sh" ] && source "$PEGASUS_DIR/install/desktop/optional/app-${app,,}.sh"
	done
fi
