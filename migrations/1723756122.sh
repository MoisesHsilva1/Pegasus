#!/bin/bash

PEGASUS_PATH="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_PATH" ] && PEGASUS_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"

# Install Tophat libraries on Fedora
sudo dnf install -y --skip-unavailable libgtop2-devel clutter >/dev/null 2>&1 || true

# Install TopHat
gext install tophat@fflewddur.github.io >/dev/null 2>&1 || true

if [ -f ~/.local/share/gnome-shell/extensions/tophat@fflewddur.github.io/schemas/org.gnome.shell.extensions.tophat.gschema.xml ]; then
  sudo cp ~/.local/share/gnome-shell/extensions/tophat@fflewddur.github.io/schemas/org.gnome.shell.extensions.tophat.gschema.xml /usr/share/glib-2.0/schemas/ 2>/dev/null || true
  sudo glib-compile-schemas /usr/share/glib-2.0/schemas/ 2>/dev/null || true
fi

# Configure TopHat
gsettings set org.gnome.shell.extensions.tophat show-icons false 2>/dev/null || true
gsettings set org.gnome.shell.extensions.tophat show-cpu false 2>/dev/null || true
gsettings set org.gnome.shell.extensions.tophat show-disk false 2>/dev/null || true
gsettings set org.gnome.shell.extensions.tophat show-mem false 2>/dev/null || true
gsettings set org.gnome.shell.extensions.tophat network-usage-unit bits 2>/dev/null || true
