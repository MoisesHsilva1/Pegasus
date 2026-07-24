#!/bin/bash

PEGASUS_PATH="${PEGASUS_PATH:-$HOME/.local/share/pegasus}"
[ ! -d "$PEGASUS_PATH" ] && PEGASUS_PATH="$(cd "$(dirname "${BASH_SOURCE[0]}")/.." && pwd)"
source "$PEGASUS_PATH/defaults/bash/functions" 2>/dev/null || true

AVAILABLE_WEB_APPS=("Chat GPT" "Google Photos" "Google Contacts" "Tailscale")
apps=$(gum choose "${AVAILABLE_WEB_APPS[@]}" --no-limit --height 6 --header "Select web apps to uninstall")

if [[ -n "$apps" ]]; then
  IFS=$'\n'
  for app in $apps; do
    case $app in
    "Chat GPT")
      web2app-remove 'Chat GPT' 2>/dev/null || true
      app2folder-remove 'Chat GPT.desktop' WebApps 2>/dev/null || true
      ;;
    "Google Photos")
      web2app-remove 'Google Photos' 2>/dev/null || true
      app2folder-remove 'Google Photos.desktop' WebApps 2>/dev/null || true
      ;;
    "Google Contacts")
      web2app-remove 'Google Contacts' 2>/dev/null || true
      app2folder-remove 'Google Contacts.desktop' WebApps 2>/dev/null || true
      ;;
    "Tailscale")
      web2app-remove 'Tailscale' 2>/dev/null || true
      app2folder-remove 'Tailscale.desktop' WebApps 2>/dev/null || true
      ;;
    esac
  done
fi
