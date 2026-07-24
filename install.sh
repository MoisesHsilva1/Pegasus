#!/bin/bash

# Exit immediately if a command exits with a non-zero status
set -e

# Determine directory of script
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PEGASUS_PATH="${PEGASUS_PATH:-$SCRIPT_DIR}"
export PEGASUS_PATH
export OMAKUB_PATH="$PEGASUS_PATH"

# Give people a chance to retry running the installation
trap 'echo "Pegasus Fedora installation failed! You can retry by running: source ~/.local/share/pegasus/install.sh"' ERR

# Check the distribution name and version and abort if incompatible
source $PEGASUS_PATH/install/check-version.sh

# Ask for app choices
echo "Get ready to make a few choices..."
source $PEGASUS_PATH/install/terminal/required/app-gum.sh >/dev/null
source $PEGASUS_PATH/install/first-run-choices.sh
source $PEGASUS_PATH/install/identification.sh

# Desktop software and tweaks will only be installed if we're running Gnome
if [[ "$XDG_CURRENT_DESKTOP" == *"GNOME"* ]]; then
  # Ensure computer doesn't go to sleep or lock while installing
  gsettings set org.gnome.desktop.screensaver lock-enabled false 2>/dev/null || true
  gsettings set org.gnome.desktop.session idle-delay 0 2>/dev/null || true

  echo "Installing terminal and desktop tools..."

  # Install terminal tools
  source $PEGASUS_PATH/install/terminal.sh

  # Install desktop tools and tweaks
  source $PEGASUS_PATH/install/desktop.sh

  # Revert to normal idle and lock settings
  gsettings set org.gnome.desktop.screensaver lock-enabled true 2>/dev/null || true
  gsettings set org.gnome.desktop.session idle-delay 300 2>/dev/null || true
else
  echo "Only installing terminal tools..."
  source $PEGASUS_PATH/install/terminal.sh
fi
