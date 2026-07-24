#!/bin/bash
sudo dnf remove -y 1password 1password-cli >/dev/null 2>&1 || true
sudo rm -f /etc/yum.repos.d/1password.repo
