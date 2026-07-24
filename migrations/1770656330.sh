#!/bin/bash

# Ensure Spotify Flatpak repo is configured if Spotify is installed
if flatpak list | grep -i spotify >/dev/null 2>&1; then
  flatpak update -y com.spotify.Client >/dev/null 2>&1 || true
fi