#!/bin/bash

# ANSI Color Definitions
CLR_RESET='\033[0m'
CLR_BOLD='\033[1m'
CLR_RED='\033[38;5;196m'
CLR_GREEN='\033[38;5;46m'
CLR_YELLOW='\033[38;5;226m'
CLR_BLUE='\033[38;5;39m'
CLR_MAGENTA='\033[38;5;201m'
CLR_CYAN='\033[38;5;51m'
CLR_GRAY='\033[38;5;244m'

print_banner() {
  clear
  echo -e "${CLR_CYAN}${CLR_BOLD}"
  echo "╭────────────────────────────────────────────────────────────╮"
  echo "│                                                            │"
  echo "│                  PEGASUS LINUX SETUP                       │"
  echo "│              Fedora Developer Environment                  │"
  echo "│                                                            │"
  echo "╰────────────────────────────────────────────────────────────╯"
  echo -e "${CLR_RESET}"
}

print_section() {
  local title="$1"
  echo -e "\n${CLR_BLUE}${CLR_BOLD}─── $title ───${CLR_RESET}\n"
}

step_info() {
  echo -e "${CLR_CYAN}[•]${CLR_RESET} $1"
}

step_success() {
  echo -e "${CLR_GREEN}[✓]${CLR_RESET} $1"
}

step_warn() {
  echo -e "${CLR_YELLOW}[!]${CLR_RESET} $1"
}

step_error() {
  echo -e "${CLR_RED}[✗]${CLR_RESET} $1"
}

print_box_error() {
  local msg="$1"
  echo -e "\n${CLR_RED}${CLR_BOLD}┌────────────────────────────────────────────────────────────┐"
  echo -e "│ ERROR: $msg"
  echo -e "└────────────────────────────────────────────────────────────┘${CLR_RESET}\n"
}

print_box_warn() {
  local msg="$1"
  echo -e "\n${CLR_YELLOW}${CLR_BOLD}┌────────────────────────────────────────────────────────────┐"
  echo -e "│ WARNING: $msg"
  echo -e "└────────────────────────────────────────────────────────────┘${CLR_RESET}\n"
}

print_summary() {
  echo -e "\n${CLR_GREEN}${CLR_BOLD}"
  echo "╭────────────────────────────────────────────────────────────╮"
  echo "│               PEGASUS SETUP COMPLETE                       │"
  echo "│                                                            │"
  echo "│  Restart your terminal or reboot your system to apply     │"
  echo "│  all changes and user group permissions.                   │"
  echo "│                                                            │"
  echo "│  Type 'pegasus' in your terminal at any time for settings. │"
  echo "╰────────────────────────────────────────────────────────────╯"
  echo -e "${CLR_RESET}\n"
}
