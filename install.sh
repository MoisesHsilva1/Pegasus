#!/bin/bash

# Pegasus Installer Entry Point
set -e

# Determine main root directory of Pegasus
PEGASUS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export PEGASUS_PATH="${PEGASUS_PATH:-$PEGASUS_DIR}"
export OMAKUB_PATH="$PEGASUS_PATH"

# Auto-apply execution permissions to scripts
chmod +x "$PEGASUS_DIR/install.sh" "$PEGASUS_DIR/boot.sh" "$PEGASUS_DIR/update.sh" "$PEGASUS_DIR/uninstall.sh" "$PEGASUS_DIR/bin/pegasus" "$PEGASUS_DIR/scripts"/*.sh 2>/dev/null || true

# Load UI Formatting & Banners
source "$PEGASUS_DIR/scripts/ui.sh"
print_banner

# Error trap handler
trap 'print_box_error "Pegasus installation failed! You can retry by running: ./install.sh"' ERR

# 1. System Requirements & Non-Root Guard
source "$PEGASUS_DIR/scripts/requirements.sh"

# 2. Interactive First Run Choices
print_section "Interactive Choices & Identification"
step_info "Get ready to make a few choices..."
source "$PEGASUS_PATH/install/terminal/required/app-gum.sh" >/dev/null 2>&1 || true
source "$PEGASUS_PATH/install/first-run-choices.sh"
source "$PEGASUS_PATH/install/identification.sh"

# 3. Development Libraries, CLI Packages & Runtimes
source "$PEGASUS_DIR/scripts/packages.sh"

# 4. Docker Engine & Permissions
source "$PEGASUS_DIR/scripts/docker.sh"

# 5. Selected Language Runtimes & Database Storage Containers
print_section "Configuring Selected Language Runtimes & Databases"
[ -f "$PEGASUS_PATH/install/terminal/select-dev-language.sh" ] && source "$PEGASUS_PATH/install/terminal/select-dev-language.sh"
[ -f "$PEGASUS_PATH/install/terminal/select-dev-storage.sh" ] && source "$PEGASUS_PATH/install/terminal/select-dev-storage.sh"
[ -f "$PEGASUS_PATH/install/terminal/set-git.sh" ] && source "$PEGASUS_PATH/install/terminal/set-git.sh"

# 6. Desktop Software & GNOME Tweaks (GNOME Only)
if [[ "${XDG_CURRENT_DESKTOP:-}" == *"GNOME"* ]]; then
  # Disable idle sleep during setup
  gsettings set org.gnome.desktop.screensaver lock-enabled false 2>/dev/null || true
  gsettings set org.gnome.desktop.session idle-delay 0 2>/dev/null || true

  # Desktop Applications & Flatpaks
  source "$PEGASUS_DIR/scripts/applications.sh"

  # Optional Apps Selected by User
  if [[ -v OMAKUB_FIRST_RUN_OPTIONAL_APPS && -n "$OMAKUB_FIRST_RUN_OPTIONAL_APPS" ]]; then
    for app in $OMAKUB_FIRST_RUN_OPTIONAL_APPS; do
      [ -f "$PEGASUS_PATH/install/desktop/optional/app-${app,,}.sh" ] && source "$PEGASUS_PATH/install/desktop/optional/app-${app,,}.sh"
    done
  fi

  # GNOME Tweaks, Extensions & Themes
  source "$PEGASUS_DIR/scripts/gnome.sh"

  # Revert idle sleep
  gsettings set org.gnome.desktop.screensaver lock-enabled true 2>/dev/null || true
  gsettings set org.gnome.desktop.session idle-delay 300 2>/dev/null || true
fi

# Print Completion Summary
print_summary
