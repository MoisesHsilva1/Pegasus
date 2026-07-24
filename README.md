# Pegasus Linux Setup

## Fedora Developer Environment

Pegasus is a customized Linux environment setup project inspired by Omakub.

The goal of Pegasus is to provide a complete Fedora workstation configuration focused on developers, combining:

- Development tools
- Terminal customization
- GNOME personalization
- Productivity applications
- Developer workflow optimization

Pegasus transforms a fresh Fedora installation into a ready-to-use development environment.

---

# Features

Pegasus provides:

- Customized GNOME desktop environment (Wayland session)
- Developer-focused applications (VS Code, Neovim/LazyVim, Docker, DBeaver, Postman, IntelliJ)
- Terminal improvements & shell configurations
- Development tools & polyglot language runtimes via `mise`
- Productivity & media workflow setup (Obsidian, LibreOffice, OBS Studio, Spotify, VLC, GIMP, Signal)
- Visual customization (10 coordinated theme suites, backgrounds, fonts, and GNOME extensions)
- Professional CLI experience with step indicators (`[✓]`), pre-flight checks, and diagnostics.

---

# Requirements

## Supported System

Currently supported:
- **Fedora Workstation** (Fedora 40 / 41+)
- **GNOME Desktop** (Wayland session)
- Active **Internet connection**
- User account with **sudo privileges**

---

# Management Commands

Pegasus provides intuitive CLI management tools:

| Command | Description |
|---------|-------------|
| `./install.sh` | Runs the full Pegasus Fedora environment installer |
| `./update.sh` | Updates Pegasus repository, DNF system packages, and Flatpaks |
| `./uninstall.sh` | Interactively uninstalls Pegasus launchers, binaries, and configurations |
| `pegasus doctor` | Runs system diagnostics and health checks on installed packages and services |
| `pegasus` | Opens the interactive settings menu (themes, fonts, apps) |

---

# Installation

To install Pegasus on Fedora Workstation, open a terminal and run:

```bash
git clone https://github.com/MoisesHsilva1/Pegasus.git
cd Pegasus
./install.sh
```

Or run directly via `bash`:

```bash
bash install.sh
```

Or run the one-line bootstrapper:

```bash
source <(curl -sSL https://raw.githubusercontent.com/MoisesHsilva1/Pegasus/main/boot.sh)
```

> [!NOTE]
> Do not execute `./install.sh` with `sudo`. The installer will prompt for your `sudo` password when required.

---

# Supported Applications

## Development
- **Neovim** (Configured with LazyVim starter)
- **Visual Studio Code** (Installed via official Microsoft YUM repo)
- **DBeaver Community** (Installed via Flathub)
- **Postman** (Installed via Flathub)
- **IntelliJ IDEA Community** (Installed via Flathub)
- **Docker Engine** (Installed via official Docker CE Fedora repo)

## Productivity
- **Obsidian** (Installed via Flathub)
- **LibreOffice** (Installed via official Fedora repo)

## Media
- **OBS Studio** (Installed via Flathub)
- **Spotify** (Installed via Flathub)
- **VLC Media Player** (Installed via Flathub)

## Graphics
- **GIMP** (Installed via Flathub)

## Communication
- **Signal Desktop** (Installed via Flathub)

## GNOME/System
- **GNOME Tweaks** (Installed via official Fedora repo)
- **GNOME Shell Extension Manager** (Installed via official Fedora repo)
- **wl-clipboard** (Installed via official Fedora repo)

---

# After Installation

1. **Reboot Recommendation:** Reboot your computer after installation completes to ensure all system group permissions (`docker` group), udev rules, and GNOME Shell extension schemas take full effect.
2. **Verify Runtimes & Health:** Run the diagnostic health check tool:

```bash
pegasus doctor
```

---

# Architecture

```
Pegasus/
├── install.sh             # Primary entry point orchestrator
├── boot.sh                # Web bootstrapper (curl/wget execution)
├── update.sh              # Update script for Pegasus & system packages
├── uninstall.sh           # Uninstaller orchestrator
├── README.md              # Project documentation
│
├── bin/
│   ├── pegasus            # Primary CLI binary launcher
│   └── pegasus-sub/       # Sub-commands (theme, font, doctor, etc.)
│
├── scripts/
│   ├── ui.sh              # Terminal formatting, colors, boxes & indicators
│   ├── requirements.sh    # Pre-check system (OS check, internet, dependencies)
│   ├── packages.sh        # DNF base libraries & CLI tools installer
│   ├── applications.sh    # GUI desktop applications & Flathub installer
│   ├── gnome.sh           # GNOME settings, extensions, themes & dock setup
│   ├── docker.sh          # Docker engine setup, service enablement & permissions
│   └── doctor.sh          # Diagnostic tool for system health check
```

---

# Troubleshooting

- **Permission Denied (`./install.sh`):** Execute `bash install.sh` or run `chmod +x install.sh boot.sh` beforehand.
- **Docker Permission Denied:** If running `docker` commands without `sudo` returns a permission error, ensure your user is added to the `docker` group (`sudo usermod -aG docker $USER`) and reboot your system.
- **Flatpak Installation Errors:** Ensure the Flathub repository is enabled (`flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo`) and update Flatpak metadata (`flatpak update`).
- **GNOME Extensions Not Appearing:** Log out and log back in, or run `sudo glib-compile-schemas /usr/share/glib-2.0/schemas/`.

---

# Development

Contributors can customize and extend Pegasus:
- **Adding Applications:** Create a new installer script under `install/desktop/app-<name>.sh` or add Flathub entries to `scripts/applications.sh`.
- **Modifying Themes:** Add or adjust theme assets within `themes/<theme-name>/` and update theme switching logic in `themes/set-gnome-theme.sh`.

---

## Credits & Attribution

Pegasus builds upon the original architecture and design created by Basecamp for [Omakub](https://omakub.org).

## License

Pegasus is released under the [MIT License](https://opensource.org/licenses/MIT).
