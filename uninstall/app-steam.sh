#!/bin/bash
sudo dnf remove -y steam >/dev/null 2>&1 || true
flatpak uninstall -y com.valvesoftware.Steam >/dev/null 2>&1 || true
