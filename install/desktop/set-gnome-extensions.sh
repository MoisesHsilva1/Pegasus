#!/bin/bash

sudo dnf install -y --skip-unavailable gnome-shell-extension-manager libgtop2-devel clutter >/dev/null 2>&1 || true
pipx install gnome-extensions-cli --system-site-packages >/dev/null 2>&1 || true

# Safely disable Ubuntu extension defaults if present
gnome-extensions disable tiling-assistant@ubuntu.com 2>/dev/null || true
gnome-extensions disable ubuntu-appindicators@ubuntu.com 2>/dev/null || true
gnome-extensions disable ubuntu-dock@ubuntu.com 2>/dev/null || true
gnome-extensions disable ding@rastersoft.com 2>/dev/null || true

# Install GNOME extensions
gext install tactile@lundal.io 2>/dev/null || true
gext install just-perfection-desktop@just-perfection 2>/dev/null || true
gext install blur-my-shell@aunetx 2>/dev/null || true
gext install space-bar@luchrioh 2>/dev/null || true
gext install undecorate@sun.wxg@gmail.com 2>/dev/null || true
gext install tophat@fflewddur.github.io 2>/dev/null || true
gext install AlphabeticalAppGrid@stuarthayhurst 2>/dev/null || true

# Compile gsettings schemas if extension schemas exist
[ -f ~/.local/share/gnome-shell/extensions/tactile@lundal.io/schemas/org.gnome.shell.extensions.tactile.gschema.xml ] && sudo cp ~/.local/share/gnome-shell/extensions/tactile@lundal.io/schemas/org.gnome.shell.extensions.tactile.gschema.xml /usr/share/glib-2.0/schemas/ 2>/dev/null || true
[ -f ~/.local/share/gnome-shell/extensions/just-perfection-desktop\@just-perfection/schemas/org.gnome.shell.extensions.just-perfection.gschema.xml ] && sudo cp ~/.local/share/gnome-shell/extensions/just-perfection-desktop\@just-perfection/schemas/org.gnome.shell.extensions.just-perfection.gschema.xml /usr/share/glib-2.0/schemas/ 2>/dev/null || true
[ -f ~/.local/share/gnome-shell/extensions/blur-my-shell\@aunetx/schemas/org.gnome.shell.extensions.blur-my-shell.gschema.xml ] && sudo cp ~/.local/share/gnome-shell/extensions/blur-my-shell\@aunetx/schemas/org.gnome.shell.extensions.blur-my-shell.gschema.xml /usr/share/glib-2.0/schemas/ 2>/dev/null || true
[ -f ~/.local/share/gnome-shell/extensions/space-bar\@luchrioh/schemas/org.gnome.shell.extensions.space-bar.gschema.xml ] && sudo cp ~/.local/share/gnome-shell/extensions/space-bar\@luchrioh/schemas/org.gnome.shell.extensions.space-bar.gschema.xml /usr/share/glib-2.0/schemas/ 2>/dev/null || true
[ -f ~/.local/share/gnome-shell/extensions/tophat@fflewddur.github.io/schemas/org.gnome.shell.extensions.tophat.gschema.xml ] && sudo cp ~/.local/share/gnome-shell/extensions/tophat@fflewddur.github.io/schemas/org.gnome.shell.extensions.tophat.gschema.xml /usr/share/glib-2.0/schemas/ 2>/dev/null || true
[ -f ~/.local/share/gnome-shell/extensions/AlphabeticalAppGrid\@stuarthayhurst/schemas/org.gnome.shell.extensions.AlphabeticalAppGrid.gschema.xml ] && sudo cp ~/.local/share/gnome-shell/extensions/AlphabeticalAppGrid\@stuarthayhurst/schemas/org.gnome.shell.extensions.AlphabeticalAppGrid.gschema.xml /usr/share/glib-2.0/schemas/ 2>/dev/null || true

sudo glib-compile-schemas /usr/share/glib-2.0/schemas/ 2>/dev/null || true

# Configure Tactile
gsettings set org.gnome.shell.extensions.tactile col-0 1 2>/dev/null || true
gsettings set org.gnome.shell.extensions.tactile col-1 2 2>/dev/null || true
gsettings set org.gnome.shell.extensions.tactile col-2 1 2>/dev/null || true
gsettings set org.gnome.shell.extensions.tactile col-3 0 2>/dev/null || true
gsettings set org.gnome.shell.extensions.tactile row-0 1 2>/dev/null || true
gsettings set org.gnome.shell.extensions.tactile row-1 1 2>/dev/null || true
gsettings set org.gnome.shell.extensions.tactile gap-size 32 2>/dev/null || true

# Configure Just Perfection
gsettings set org.gnome.shell.extensions.just-perfection animation 2 2>/dev/null || true
gsettings set org.gnome.shell.extensions.just-perfection dash-app-running true 2>/dev/null || true
gsettings set org.gnome.shell.extensions.just-perfection workspace true 2>/dev/null || true
gsettings set org.gnome.shell.extensions.just-perfection workspace-popup false 2>/dev/null || true

# Configure Blur My Shell
gsettings set org.gnome.shell.extensions.blur-my-shell.appfolder blur false 2>/dev/null || true
gsettings set org.gnome.shell.extensions.blur-my-shell.lockscreen blur false 2>/dev/null || true
gsettings set org.gnome.shell.extensions.blur-my-shell.screenshot blur false 2>/dev/null || true
gsettings set org.gnome.shell.extensions.blur-my-shell.window-list blur false 2>/dev/null || true
gsettings set org.gnome.shell.extensions.blur-my-shell.panel blur false 2>/dev/null || true
gsettings set org.gnome.shell.extensions.blur-my-shell.overview blur true 2>/dev/null || true
gsettings set org.gnome.shell.extensions.blur-my-shell.overview pipeline 'pipeline_default' 2>/dev/null || true
gsettings set org.gnome.shell.extensions.blur-my-shell.dash-to-dock blur true 2>/dev/null || true
gsettings set org.gnome.shell.extensions.blur-my-shell.dash-to-dock brightness 0.6 2>/dev/null || true
gsettings set org.gnome.shell.extensions.blur-my-shell.dash-to-dock sigma 30 2>/dev/null || true
gsettings set org.gnome.shell.extensions.blur-my-shell.dash-to-dock static-blur true 2>/dev/null || true
gsettings set org.gnome.shell.extensions.blur-my-shell.dash-to-dock style-dash-to-dock 0 2>/dev/null || true

# Configure Space Bar
gsettings set org.gnome.shell.extensions.space-bar.behavior smart-workspace-names false 2>/dev/null || true
gsettings set org.gnome.shell.extensions.space-bar.shortcuts enable-activate-workspace-shortcuts false 2>/dev/null || true
gsettings set org.gnome.shell.extensions.space-bar.shortcuts enable-move-to-workspace-shortcuts true 2>/dev/null || true
gsettings set org.gnome.shell.extensions.space-bar.shortcuts open-menu "@as []" 2>/dev/null || true

# Configure TopHat
gsettings set org.gnome.shell.extensions.tophat show-icons false 2>/dev/null || true
gsettings set org.gnome.shell.extensions.tophat show-cpu false 2>/dev/null || true
gsettings set org.gnome.shell.extensions.tophat show-disk false 2>/dev/null || true
gsettings set org.gnome.shell.extensions.tophat show-mem false 2>/dev/null || true
gsettings set org.gnome.shell.extensions.tophat show-fs false 2>/dev/null || true
gsettings set org.gnome.shell.extensions.tophat network-usage-unit bits 2>/dev/null || true

# Configure AlphabeticalAppGrid
gsettings set org.gnome.shell.extensions.alphabetical-app-grid folder-order-position 'end' 2>/dev/null || true
