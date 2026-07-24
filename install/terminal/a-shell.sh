#!/bin/bash

PEGASUS_DIR="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_DIR" ] && PEGASUS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

# Configure the bash shell using Pegasus defaults
[ -f ~/.bashrc ] && mv ~/.bashrc ~/.bashrc.bak 2>/dev/null || true
cp "$PEGASUS_DIR/configs/bashrc" ~/.bashrc

# Load the PATH for use later in the installers
source "$PEGASUS_DIR/defaults/bash/shell"

[ -f ~/.inputrc ] && mv ~/.inputrc ~/.inputrc.bak 2>/dev/null || true
# Configure the inputrc using Pegasus defaults
cp "$PEGASUS_DIR/configs/inputrc" ~/.inputrc
