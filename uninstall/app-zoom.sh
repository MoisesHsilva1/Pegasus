#!/bin/bash
sudo dnf remove -y zoom >/dev/null 2>&1 || true
flatpak uninstall -y us.zoom.Zoom >/dev/null 2>&1 || true
