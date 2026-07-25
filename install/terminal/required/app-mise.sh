#!/bin/bash
set -euo pipefail

# Ensure PATH contains common binary directories for mise
export PATH="$HOME/.local/bin:$HOME/.local/share/mise/bin:/usr/local/bin:$PATH"

install_mise() {
  if command -v mise >/dev/null 2>&1; then
    eval "$(mise activate bash 2>/dev/null)" || true
    return 0
  fi

  echo "Installing Mise version manager..."

  if command -v apt-get >/dev/null 2>&1; then
    sudo apt-get update -y >/dev/null 2>&1 || true
    sudo apt-get install -y gpg wget curl >/dev/null 2>&1 || true
    sudo install -dm 755 /etc/apt/keyrings 2>/dev/null || true
    wget -qO - https://mise.jdx.dev/gpg-key.pub | gpg --dearmor | sudo tee /etc/apt/keyrings/mise-archive-keyring.gpg >/dev/null 2>&1 || true
    echo "deb [signed-by=/etc/apt/keyrings/mise-archive-keyring.gpg arch=$(dpkg --print-architecture 2>/dev/null || echo amd64)] https://mise.jdx.dev/deb stable main" | sudo tee /etc/apt/sources.list.d/mise.list >/dev/null 2>&1 || true
    sudo apt-get update -y >/dev/null 2>&1 || true
    sudo apt-get install -y mise >/dev/null 2>&1 || true
  elif command -v dnf >/dev/null 2>&1; then
    if [ ! -f /etc/yum.repos.d/mise.repo ]; then
      sudo dnf config-manager --add-repo https://mise.jdx.dev/rpm/mise.repo >/dev/null 2>&1 || true
    fi
    sudo dnf install -y mise >/dev/null 2>&1 || true
  fi

  if ! command -v mise >/dev/null 2>&1; then
    # Universal standalone installer script
    curl -fsSL https://mise.run | sh >/dev/null 2>&1 || true
  fi

  export PATH="$HOME/.local/bin:$HOME/.local/share/mise/bin:/usr/local/bin:$PATH"

  if command -v mise >/dev/null 2>&1; then
    eval "$(mise activate bash 2>/dev/null)" || true
    return 0
  else
    return 1
  fi
}

install_mise
