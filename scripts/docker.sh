#!/bin/bash

_SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PEGASUS_DIR="${PEGASUS_DIR:-$(cd "$_SCRIPT_DIR/.." && pwd)}"
source "$PEGASUS_DIR/scripts/ui.sh"

setup_docker() {
  print_section "Configuring Docker Engine & Permissions"

  step_info "Configuring Docker CE Fedora YUM repository..."
  if [ ! -f /etc/yum.repos.d/docker-ce.repo ]; then
    sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo >/dev/null 2>&1 || true
  fi

  step_info "Installing Docker Engine and Compose plugins..."
  sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin >/dev/null
  step_success "Docker Engine installed"

  step_info "Enabling Docker service (systemctl enable --now docker)..."
  sudo systemctl enable --now docker >/dev/null 2>&1 || true
  step_success "Docker service enabled"

  step_info "Adding user '$USER' to docker group..."
  sudo usermod -aG docker "$USER" 2>/dev/null || true
  step_success "User permissions granted"

  step_info "Setting Docker log size limits..."
  sudo mkdir -p /etc/docker
  echo '{"log-driver":"json-file","log-opts":{"max-size":"10m","max-file":"5"}}' | sudo tee /etc/docker/daemon.json >/dev/null
  step_success "Docker daemon configured"
}

setup_docker
