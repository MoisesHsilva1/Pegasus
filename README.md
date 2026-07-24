# Pegasus

Pegasus is a customized Fedora developer environment setup inspired by Omakub.

The goal of Pegasus is to transform a fresh Fedora Workstation installation into a complete development environment with configured tools, applications, themes and GNOME customization.

## Requirements

- Fedora Workstation 40+
- GNOME Desktop (Wayland)
- Internet connection
- User with sudo privileges

## Installation

Clone the repository:

```bash
git clone https://github.com/MoisesHsilva1/Pegasus.git
cd Pegasus
```

Run the installer:

```bash
bash install.sh
```

Do not run the installer using `sudo`. Pegasus will request administrator permissions when necessary.

## Commands

Open Pegasus menu:

```bash
pegasus
```

System diagnostics:

```bash
pegasus doctor
```

Update Pegasus:

```bash
./update.sh
```

Remove Pegasus:

```bash
./uninstall.sh
```

## Credits

Pegasus is inspired by the Omakub project:

https://omakub.org
