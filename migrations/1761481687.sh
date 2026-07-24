#!/bin/bash

# Force upgrade to gum 0.17.0 on Fedora Workstation
cd /tmp
GUM_VERSION="0.17.0"
wget -qO gum.rpm "https://github.com/charmbracelet/gum/releases/download/v${GUM_VERSION}/gum_${GUM_VERSION}_x86_64.rpm" 2>/dev/null || true
sudo dnf install -y ./gum.rpm >/dev/null 2>&1 || true
rm -f gum.rpm
cd - >/dev/null