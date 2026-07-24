#!/bin/bash

# Typora is a markdown editor and reader. See https://typora.io/
flatpak install -y flathub io.typora.Typora

# Add iA Typora theme
mkdir -p ~/.config/Typora/themes
cp ~/.local/share/omakub/configs/typora/ia_typora.css ~/.config/Typora/themes/
cp ~/.local/share/omakub/configs/typora/ia_typora_night.css ~/.config/Typora/themes/
