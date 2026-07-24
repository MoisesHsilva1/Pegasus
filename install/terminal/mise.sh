#!/bin/bash

# Install mise for managing multiple versions of languages. See https://mise.jdx.dev/
sudo dnf config-manager --add-repo https://mise.jdx.dev/rpm/mise.repo 2>/dev/null || true
sudo dnf install -y mise
