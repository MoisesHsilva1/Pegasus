#!/bin/bash

_SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PEGASUS_DIR="${PEGASUS_DIR:-$(cd "$_SCRIPT_DIR/.." && pwd)}"
source "$PEGASUS_DIR/scripts/ui.sh"

setup_gnome() {
  print_section "Configuring GNOME Desktop Environment & Extensions"

  # System Utilities & GNOME Tools
  step_info "Installing GNOME Tweaks, Extension Manager & wl-clipboard..."
  sudo dnf install -y --skip-unavailable --skip-broken gnome-tweaks gnome-shell-extension-manager wl-clipboard libgtop2-devel clutter >/dev/null 2>&1 || true
  pipx install gnome-extensions-cli --system-site-packages >/dev/null 2>&1 || true
  step_success "GNOME system tools installed"

  step_info "Generating desktop launchers (Pegasus, Docker & Neovim)..."
  mkdir -p ~/.local/share/applications
  [ -f "$PEGASUS_DIR/applications/pegasus.sh" ] && source "$PEGASUS_DIR/applications/pegasus.sh"
  [ -f "$PEGASUS_DIR/applications/Docker.sh" ] && source "$PEGASUS_DIR/applications/Docker.sh"
  [ -f "$PEGASUS_DIR/applications/Neovim.sh" ] && source "$PEGASUS_DIR/applications/Neovim.sh"
  step_success "Desktop launchers generated"

  # GNOME Extensions
  step_info "Installing GNOME Shell extensions..."
  gext install tactile@lundal.io >/dev/null 2>&1 || true
  gext install just-perfection-desktop@just-perfection >/dev/null 2>&1 || true
  gext install blur-my-shell@aunetx >/dev/null 2>&1 || true
  gext install space-bar@luchrioh >/dev/null 2>&1 || true
  gext install undecorate@sun.wxg@gmail.com >/dev/null 2>&1 || true
  gext install tophat@fflewddur.github.io >/dev/null 2>&1 || true
  gext install AlphabeticalAppGrid@stuarthayhurst >/dev/null 2>&1 || true
  step_success "GNOME Shell extensions installed"

  # Apply GNOME Hotkeys & Settings
  step_info "Configuring GNOME keybindings and interface preferences..."
  [ -f "$PEGASUS_DIR/install/desktop/set-gnome-hotkeys.sh" ] && source "$PEGASUS_DIR/install/desktop/set-gnome-hotkeys.sh" >/dev/null 2>&1 || true
  [ -f "$PEGASUS_DIR/install/desktop/set-gnome-settings.sh" ] && source "$PEGASUS_DIR/install/desktop/set-gnome-settings.sh" >/dev/null 2>&1 || true
  [ -f "$PEGASUS_DIR/install/desktop/set-app-grid.sh" ] && source "$PEGASUS_DIR/install/desktop/set-app-grid.sh" >/dev/null 2>&1 || true
  [ -f "$PEGASUS_DIR/install/desktop/set-dock.sh" ] && source "$PEGASUS_DIR/install/desktop/set-dock.sh" >/dev/null 2>&1 || true
  step_success "GNOME preferences & dock launchers configured"

  # Themes
  step_info "Applying default Tokyo Night theme suite..."
  export PEGASUS_THEME_COLOR="blue"
  export PEGASUS_THEME_BACKGROUND="tokyo-night/background.jpg"
  [ -f "$PEGASUS_DIR/themes/set-gnome-theme.sh" ] && source "$PEGASUS_DIR/themes/set-gnome-theme.sh" >/dev/null 2>&1 || true
  step_success "Theme suite applied"
}

setup_gnome
