#!/bin/bash

PEGASUS_DIR="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_DIR" ] && PEGASUS_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")/../.." && pwd)"

cd /tmp
wget -O zellij.tar.gz "https://github.com/zellij-org/zellij/releases/latest/download/zellij-x86_64-unknown-linux-musl.tar.gz" 2>/dev/null || true
tar -xf zellij.tar.gz zellij 2>/dev/null || true
sudo install zellij /usr/local/bin 2>/dev/null || true
rm -f zellij.tar.gz zellij
cd - >/dev/null

mkdir -p ~/.config/zellij/themes
[ -f "$PEGASUS_DIR/configs/zellij.kdl" ] && [ ! -f "$HOME/.config/zellij/config.kdl" ] && cp "$PEGASUS_DIR/configs/zellij.kdl" ~/.config/zellij/config.kdl 2>/dev/null || true
[ -f "$PEGASUS_DIR/themes/tokyo-night/zellij.kdl" ] && cp "$PEGASUS_DIR/themes/tokyo-night/zellij.kdl" ~/.config/zellij/themes/tokyo-night.kdl 2>/dev/null || true
