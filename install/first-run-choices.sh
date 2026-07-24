#!/bin/bash

# Only ask for default desktop app choices when running Gnome
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
  OPTIONAL_APPS=("Spotify" "OBS-Studio" "1Password" "Mainline-Kernels")
  DEFAULT_OPTIONAL_APPS='Spotify,OBS-Studio,1Password'
  export PEGASUS_FIRST_RUN_OPTIONAL_APPS=$(gum choose "${OPTIONAL_APPS[@]}" --no-limit --selected $DEFAULT_OPTIONAL_APPS --height 8 --header "Select optional apps" | tr ' ' '-')
  export OMAKUB_FIRST_RUN_OPTIONAL_APPS="$PEGASUS_FIRST_RUN_OPTIONAL_APPS"
fi

AVAILABLE_LANGUAGES=("Ruby on Rails" "Node.js" "Go" "PHP" "Python" "Elixir" "Rust" "Java")
SELECTED_LANGUAGES="Java","Node.js, "Python"
export PEGASUS_FIRST_RUN_LANGUAGES=$(gum choose "${AVAILABLE_LANGUAGES[@]}" --no-limit --selected "$SELECTED_LANGUAGES" --height 10 --header "Select programming languages")
export OMAKUB_FIRST_RUN_LANGUAGES="$PEGASUS_FIRST_RUN_LANGUAGES"

AVAILABLE_DBS=("MySQL" "Redis" "PostgreSQL")
SELECTED_DBS="MySQL","Redis"
export PEGASUS_FIRST_RUN_DBS=$(gum choose "${AVAILABLE_DBS[@]}" --no-limit --selected "$SELECTED_DBS" --height 5 --header "Select databases (runs in Docker)")
export OMAKUB_FIRST_RUN_DBS="$PEGASUS_FIRST_RUN_DBS"
