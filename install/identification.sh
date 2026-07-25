#!/bin/bash

# Ensure gum is available
if ! command -v gum >/dev/null 2>&1; then
  _DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
  _ROOT="${PEGASUS_PATH:-$(cd "$_DIR/.." && pwd)}"
  [ -f "$_ROOT/install/terminal/required/app-gum.sh" ] && source "$_ROOT/install/terminal/required/app-gum.sh"
fi
if ! command -v gum >/dev/null 2>&1; then
  echo "Error: 'gum' is required for identification prompt but could not be found."
  exit 1
fi

echo "Enter identification for git and autocomplete..."

SYSTEM_NAME=$(getent passwd "$USER" | cut -d ':' -f 5 | cut -d ',' -f 1)
export PEGASUS_USER_NAME=$(gum input --placeholder "Enter full name" --value "$SYSTEM_NAME" --prompt "Name> ")
export PEGASUS_USER_EMAIL=$(gum input --placeholder "Enter email address" --prompt "Email> ")
export OMAKUB_USER_NAME="$PEGASUS_USER_NAME"
export OMAKUB_USER_EMAIL="$PEGASUS_USER_EMAIL"
