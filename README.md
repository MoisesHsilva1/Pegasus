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

---

# Requirements

## Supported System

Currently supported:
- **Fedora Workstation** (Fedora 40 / 41+)
- **GNOME Desktop** (Wayland session)
- Active **Internet connection**
- User account with **sudo privileges**

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

# Installation

To install Pegasus on Fedora Workstation, open a terminal and run:

```bash
git clone https://github.com/MoisesHsilva1/Pegasus.git ~/.local/share/pegasus
cd ~/.local/share/pegasus
source install.sh
```

Or run the one-line bootstrapper:

```bash
source <(curl -sSL https://raw.githubusercontent.com/MoisesHsilva1/Pegasus/main/boot.sh)
```

---

# After Installation

1. **Reboot Recommendation:** Reboot your computer after installation completes to ensure all system group permissions (`docker` group), udev rules, and GNOME Shell extension schemas take full effect.
2. **Verify Runtimes & Tools:** Test your installed development tools in a terminal window:

```bash
nvim --version
code --version
docker --version
java --version
node --version
```

3. **CLI Management:** Access the Pegasus management menu at any time by running:

```bash
pegasus
```

---

# Architecture

- **`boot.sh` / `install.sh`:** Bootstrap entry points that execute system version verification, user prompts via `gum`, and trigger installation modules.
- **`install/terminal.sh` & `install/desktop.sh`:** Modular installer scripts split into CLI development tools, system libraries, fonts, Flatpaks, and desktop applications.
- **`defaults/bash/functions`:** Package abstraction layer containing `install_package`, `install_flatpak`, and `install_rpm` functions.
- **`themes/`:** Centralized theme management coordinating background wallpapers, terminal color schemes, VS Code extensions, and GNOME accents.

---

# Fedora Compatibility

Pegasus replaces legacy Ubuntu installation scripts with Fedora-native tooling:
- Uses **`dnf`** instead of `apt` / `apt-get`.
- Uses official **RPM repositories** (Microsoft VS Code, Docker CE, Mise) instead of PPAs.
- Uses **Flathub Flatpaks** for desktop applications instead of `.deb` package downloads.
- Enables systemd services (`systemctl enable --now docker`) natively.

---

# Troubleshooting

- **Docker Permission Denied:** If running `docker` commands without `sudo` returns a permission error, ensure your user is added to the `docker` group (`sudo usermod -aG docker $USER`) and reboot your system.
- **Flatpak Installation Errors:** Ensure the Flathub repository is enabled (`flatpak remote-add --if-not-exists flathub https://dl.flathub.org/repo/flathub.flatpakrepo`) and update Flatpak metadata (`flatpak update`).
- **GNOME Extensions Not Appearing:** If extensions fail to load immediately, log out and log back in, or run `sudo glib-compile-schemas /usr/share/glib-2.0/schemas/` to compile missing schema overrides.
- **Missing Build Headers:** If compiling native gems or C modules fails, verify development libraries are installed (`sudo dnf install -y @development-tools openssl-devel readline-devel zlib-devel`).

---

# Development

Contributors can customize and extend Pegasus:
- **Adding Applications:** Create a new installer script under `install/desktop/app-<name>.sh` using `install_package`, `install_flatpak`, or `install_rpm`.
- **Modifying Themes:** Add or adjust theme assets within `themes/<theme-name>/` and update theme switching logic in `themes/set-gnome-theme.sh`.
- **Improving Fedora Compatibility:** Audit and submit PRs ensuring all package references map directly to Fedora DNF repositories or Flathub.

---

## Credits & Attribution

Pegasus builds upon the original architecture and design created by Basecamp for [Omakub](https://omakub.org).

## License

Pegasus is released under the [MIT License](https://opensource.org/licenses/MIT).
