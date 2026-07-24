#!/bin/bash

gsettings set org.gnome.desktop.default-applications.terminal exec 'alacritty' 2>/dev/null || true
gsettings set org.gnome.desktop.default-applications.terminal exec-arg '-e' 2>/dev/null || true