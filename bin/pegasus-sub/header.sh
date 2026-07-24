#!/bin/bash

PEGASUS_PATH="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_PATH" ] && PEGASUS_PATH="${OMAKUB_PATH:-$HOME/.local/share/omakub}"

source $PEGASUS_PATH/ascii.sh
echo "" # Add spacing
[ -f "$PEGASUS_PATH/version" ] && echo "                                 $(cat $PEGASUS_PATH/version)"
echo "" # Add spacing
