#!/bin/bash

sudo dnf install -y flatpak gnome-software
sudo flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo
