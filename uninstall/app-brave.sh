#!/bin/bash
sudo dnf remove -y brave-browser >/dev/null 2>&1 || true
sudo rm -f /etc/yum.repos.d/brave-browser.repo
