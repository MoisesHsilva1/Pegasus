#!/bin/bash

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$SCRIPT_DIR/ui.sh"

run_doctor() {
  print_banner
  print_section "Pegasus System Diagnostic (Doctor)"

  # 1. OS Check
  if [ -f /etc/os-release ]; then
    source /etc/os-release
    if [ "$ID" = "fedora" ]; then
      step_success "OS: Fedora Linux ($NAME $VERSION_ID)"
    else
      step_error "OS: Non-Fedora distribution detected ($ID)"
    fi
  else
    step_error "OS: /etc/os-release not found"
  fi

  # 2. Package Managers
  if command -v dnf >/dev/null 2>&1; then
    step_success "Package Manager: dnf available"
  else
    step_error "Package Manager: dnf missing"
  fi

  if command -v flatpak >/dev/null 2>&1; then
    if flatpak remotes | grep -q "flathub"; then
      step_success "Flatpak: Flathub remote registered"
    else
      step_warn "Flatpak: Installed but Flathub remote missing"
    fi
  else
    step_error "Flatpak: Not installed"
  fi

  # 3. Docker Service & Permissions
  if command -v docker >/dev/null 2>&1; then
    if systemctl is-active --quiet docker 2>/dev/null; then
      step_success "Docker Service: Active (running)"
    else
      step_warn "Docker Service: Installed but inactive (run 'sudo systemctl start docker')"
    fi

    if groups "$USER" | grep -q "\bdocker\b"; then
      step_success "Docker Group: User '$USER' belongs to docker group"
    else
      step_warn "Docker Group: User '$USER' not in docker group (run 'sudo usermod -aG docker $USER')"
    fi
  else
    step_error "Docker Engine: Not installed"
  fi

  # 4. Core Development Editors
  if command -v nvim >/dev/null 2>&1; then
    step_success "Neovim: $(nvim --version | head -n 1)"
  else
    step_error "Neovim: Not installed"
  fi

  if command -v code >/dev/null 2>&1; then
    step_success "Visual Studio Code: $(code --version | head -n 1 2>/dev/null || echo "Installed")"
  else
    step_warn "Visual Studio Code: Not installed"
  fi

  if command -v mise >/dev/null 2>&1; then
    step_success "Mise Version Manager: $(mise --version 2>/dev/null | head -n 1)"
  else
    step_warn "Mise Version Manager: Not installed"
  fi

  # 5. Installed Target Flatpaks
  print_section "Target Flatpak Applications Status"
  local flatpaks=(
    "md.obsidian.Obsidian:Obsidian"
    "org.signal.Signal:Signal Desktop"
    "com.spotify.Client:Spotify"
    "org.videolan.VLC:VLC Media Player"
    "com.obsproject.Studio:OBS Studio"
    "org.gimp.GIMP:GIMP"
    "io.dbeaver.DBeaverCommunity:DBeaver Community"
    "com.getpostman.Postman:Postman"
    "com.jetbrains.IntelliJ-IDEA-Community:IntelliJ IDEA Community"
  )

  for entry in "${flatpaks[@]}"; do
    local app_id="${entry%%:*}"
    local app_name="${entry##*:}"
    if flatpak list --app | grep -q "$app_id"; then
      step_success "$app_name ($app_id)"
    else
      step_warn "$app_name not installed"
    fi
  done

  echo ""
}

run_doctor
