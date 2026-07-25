#!/bin/bash

# Gum is used for interactive CLI prompts and menus in Pegasus
install_gum() {
  if command -v gum >/dev/null 2>&1; then
    return 0
  fi

  local tmp_dir
  tmp_dir=$(mktemp -d)

  if command -v apt-get >/dev/null 2>&1; then
    local gum_deb="${tmp_dir}/gum.deb"
    local gum_url
    gum_url=$(curl -s "https://api.github.com/repos/charmbracelet/gum/releases/latest" | grep -Po '"browser_download_url": "\K[^"]*amd64\.deb' | head -n 1)
    if [ -z "$gum_url" ]; then
      gum_url="https://github.com/charmbracelet/gum/releases/download/v0.17.0/gum_0.17.0_amd64.deb"
    fi
    curl -sLo "$gum_deb" "$gum_url" 2>/dev/null || true
    if [ -f "$gum_deb" ] && [ $(wc -c <"$gum_deb") -gt 1000 ]; then
      sudo apt-get install -y "$gum_deb" >/dev/null || true
    fi
    if ! command -v gum >/dev/null 2>&1; then
      sudo mkdir -p /etc/apt/keyrings
      curl -fsSL https://repo.charm.sh/apt/gpg.key | sudo gpg --dearmor -o /etc/apt/keyrings/charm.gpg 2>/dev/null || true
      echo "deb [signed-by=/etc/apt/keyrings/charm.gpg] https://repo.charm.sh/apt/ * *" | sudo tee /etc/apt/sources.list.d/charm.list >/dev/null || true
      sudo apt-get update -y >/dev/null 2>&1 || true
      sudo apt-get install -y gum >/dev/null || true
    fi
  elif command -v dnf >/dev/null 2>&1; then
    local gum_rpm="${tmp_dir}/gum.rpm"
    local gum_url
    gum_url=$(curl -s "https://api.github.com/repos/charmbracelet/gum/releases/latest" | grep -Po '"browser_download_url": "\K[^"]*x86_64\.rpm' | head -n 1)
    if [ -z "$gum_url" ]; then
      gum_url="https://github.com/charmbracelet/gum/releases/download/v0.17.0/gum-0.17.0-1.x86_64.rpm"
    fi
    curl -sLo "$gum_rpm" "$gum_url" 2>/dev/null || true
    if [ -f "$gum_rpm" ] && [ $(wc -c <"$gum_rpm") -gt 1000 ]; then
      sudo dnf install -y "$gum_rpm" >/dev/null || true
    fi
    if ! command -v gum >/dev/null 2>&1; then
      if [ ! -f /etc/yum.repos.d/charm.repo ]; then
        echo '[charm]
name=Charm
baseurl=https://repo.charm.sh/yum/
enabled=1
gpgcheck=1
gpgkey=https://repo.charm.sh/yum/gpg.key' | sudo tee /etc/yum.repos.d/charm.repo >/dev/null 2>&1 || true
      fi
      sudo dnf install -y gum >/dev/null || true
    fi
  fi

  rm -rf "$tmp_dir"

  if command -v gum >/dev/null 2>&1; then
    return 0
  else
    return 1
  fi
}

install_gum
