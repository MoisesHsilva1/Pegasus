#!/bin/bash

# Load UI helpers if not loaded
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/ui.sh"

check_system_requirements() {
  print_section "System Validation Checks"

  # 1. Non-root guard
  if [ "$EUID" -eq 0 ]; then
    print_box_error "Do not run install.sh with sudo!"
    echo "Pegasus must be executed as a standard user."
    echo "The installer will request your sudo password when necessary for system operations."
    exit 1
  fi
  step_success "Running as standard user ($USER)"

  # 2. OS distribution check
  if [ ! -f /etc/os-release ]; then
    step_error "Unable to determine OS (/etc/os-release not found)"
    exit 1
  fi

  source /etc/os-release
  if [ "$ID" != "fedora" ]; then
    step_error "Unsupported OS: $ID ($NAME)"
    echo "Pegasus is designed exclusively for Fedora Linux Workstation."
    exit 1
  fi
  step_success "Fedora Linux detected ($NAME $VERSION_ID)"

  # 3. Architecture check
  ARCH="$(uname -m)"
  if [ "$ARCH" != "x86_64" ]; then
    step_error "Unsupported architecture: $ARCH (Requires x86_64)"
    exit 1
  fi
  step_success "Supported architecture: $ARCH"

  # 4. Internet connection check
  step_info "Checking network connectivity..."
  if ! curl -s --connect-timeout 5 https://fedoraproject.org >/dev/null && ! curl -s --connect-timeout 5 https://github.com >/dev/null; then
    step_error "No active internet connection detected"
    echo "An active internet connection is required to download packages and repositories."
    exit 1
  fi
  step_success "Internet connection verified"

  # 5. Base tools check
  step_info "Verifying base tools..."
  sudo dnf install -y git curl wget unzip jq flatpak dnf-plugins-core >/dev/null 2>&1 || true
  step_success "Base system requirements met"
}

check_system_requirements
