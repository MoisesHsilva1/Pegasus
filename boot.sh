#!/bin/bash

set -e

ascii_art='________                  __        ___.
\_____  \   _____ _____  |  | ____ _\_ |__
 /   |   \ /     \\__   \ |  |/ /  |  \ __ \
/    |    \  Y Y  \/ __ \|    <|  |  / \_\ \
\_______  /__|_|  (____  /__|_ \____/|___  /
        \/      \/     \/     \/         \/
'

echo -e "$ascii_art"
echo "=> Pegasus Fedora is for fresh Fedora Workstation installations only!"
echo -e "\nBegin installation (or abort with ctrl+c)..."

sudo dnf check-update >/dev/null || true
sudo dnf install -y git >/dev/null

echo "Cloning Pegasus Fedora..."
rm -rf ~/.local/share/pegasus ~/.local/share/omakub
git clone https://github.com/MoisesHsilva1/Pegasus.git ~/.local/share/pegasus >/dev/null
ln -sf ~/.local/share/pegasus ~/.local/share/omakub
if [[ $PEGASUS_REF != "master" && -n "$PEGASUS_REF" ]]; then
	cd ~/.local/share/pegasus
	git fetch origin "${PEGASUS_REF:-stable}" && git checkout "${PEGASUS_REF:-stable}"
	cd -
fi

echo "Installation starting..."
source ~/.local/share/pegasus/install.sh
