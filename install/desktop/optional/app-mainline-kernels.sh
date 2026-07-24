#!/bin/bash

# Enable Copr repository for latest upstream mainline Linux kernels on Fedora
sudo dnf copr enable -y @kernel-vanilla/mainline >/dev/null 2>&1 || true
sudo dnf upgrade -y --skip-unavailable kernel kernel-core kernel-modules >/dev/null 2>&1 || true
