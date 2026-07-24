#!/bin/bash

if [ ! -f /etc/yum.repos.d/brave-browser.repo ]; then
  sudo dnf config-manager --add-repo https://brave-browser-rpm-release.s3.brave.com/brave-browser.repo 2>/dev/null || true
  sudo rpm --import https://brave-browser-rpm-release.s3.brave.com/brave-core.asc
fi

sudo dnf install -y brave-browser
