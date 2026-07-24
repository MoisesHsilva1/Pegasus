#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
export PEGASUS_PATH="${PEGASUS_PATH:-$SCRIPT_DIR}"
source "$SCRIPT_DIR/scripts/ui.sh"

print_banner
print_section "Updating Pegasus & System Packages"

step_info "Pulling latest Pegasus updates from Git..."
if [ -d "$SCRIPT_DIR/.git" ]; then
  cd "$SCRIPT_DIR"
  git pull --rebase >/dev/null 2>&1 || true
  step_success "Pegasus repository updated"
fi

step_info "Updating Fedora system packages (dnf upgrade)..."
sudo dnf upgrade -y >/dev/null
step_success "Fedora packages updated"

step_info "Updating Flatpak applications..."
flatpak update -y >/dev/null 2>&1 || true
step_success "Flatpak applications updated"

echo -e "\n${CLR_GREEN}${CLR_BOLD}[✓] Pegasus update completed successfully!${CLR_RESET}\n"
