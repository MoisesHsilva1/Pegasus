#!/bin/bash

sudo dnf remove -y VirtualBox VirtualBox-qt virtualbox-guest-additions >/dev/null 2>&1 || true
sudo dnf autoremove -y >/dev/null 2>&1 || true
rm -rf ~/.config/VirtualBox
