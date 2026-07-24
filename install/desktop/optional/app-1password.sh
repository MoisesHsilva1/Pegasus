#!/bin/bash

if [ ! -f /etc/yum.repos.d/1password.repo ]; then
  sudo rpm --import https://downloads.1password.com/linux/keys/1password.asc 2>/dev/null || true
  sudo sh -c 'echo -e "[1password]\nname=1Password Pages\nbaseurl=https://downloads.1password.com/linux/tar/stable/x86_64\nenabled=1\ngpgcheck=1\ngpgkey=https://downloads.1password.com/linux/keys/1password.asc" > /etc/yum.repos.d/1password.repo'
fi

sudo dnf install -y --skip-unavailable 1password 1password-cli >/dev/null 2>&1 || true