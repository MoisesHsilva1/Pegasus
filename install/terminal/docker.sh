#!/bin/bash

# Add the official Docker repo for Fedora
if [ ! -f /etc/yum.repos.d/docker-ce.repo ]; then
    sudo dnf config-manager --add-repo https://download.docker.com/linux/fedora/docker-ce.repo
fi

# Install Docker engine and standard plugins
sudo dnf install -y docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Enable and start Docker service
sudo systemctl enable --now docker

# Give this user privileged Docker access
sudo usermod -aG docker ${USER}

# Limit log size to avoid running out of disk
sudo mkdir -p /etc/docker
echo '{"log-driver":"json-file","log-opts":{"max-size":"10m","max-file":"5"}}' | sudo tee /etc/docker/daemon.json
