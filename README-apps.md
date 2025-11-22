# App Installation Script

Automated installation of Justin's Omarchy system packages.

## Usage

### On a fresh Omarchy system:

1. Clone your dotfiles:
   ```bash
   git clone https://github.com/justcarlson/omarchy-dotfiles.git ~/dotfiles
   cd ~/dotfiles
   ```

2. Make the script executable and run it:
   ```bash
   chmod +x install-my-apps.sh
   ./install-my-apps.sh
   ```

3. Restore your dotfiles:
   ```bash
   stow .
   ```

## What's Included

The script installs **171 packages** organized into categories:

- **Base System** (10 packages) - Core Arch/Omarchy packages (commented out, likely pre-installed)
- **Apple T2 Mac Support** (7 packages) - Drivers and firmware for T2 MacBooks
- **Omarchy Packages** (4 packages) - Omarchy-specific tools
- **Hyprland & Wayland** (19 packages) - Window manager and Wayland ecosystem
- **UI & Fonts** (17 packages) - Display manager, themes, and fonts
- **Audio & Video** (16 packages) - PipeWire, media players, recording tools
- **Terminals & Shells** (5 packages) - Alacritty, Ghostty, Starship, etc.
- **Development Tools** (18 packages) - Git, Docker, Neovim, Rust, etc.
- **CLI Utilities** (18 packages) - Modern CLI tools (bat, eza, fzf, ripgrep, etc.)
- **Security & Authentication** (7 packages) - 1Password, U2F, firewall
- **Networking & Bluetooth** (7 packages) - WiFi, Bluetooth, file sharing
- **Input Methods** (3 packages) - fcitx5 for multilingual input
- **Productivity Apps** (6 packages) - Obsidian, Typora, LibreOffice, etc.
- **Communication Apps** (3 packages) - Chrome, Signal, LocalSend
- **Creative Apps** (2 packages) - Spotify, Pinta
- **System Utilities** (18 packages) - Nautilus, CUPS, Snapper, etc.
- **Special Packages** (3 packages) - Aether, Impala, Wiremix

## Customization

Edit `install-my-apps.sh` to:
- Comment out categories you don't want
- Remove specific packages from arrays
- Add new packages to existing categories
- Create new categories

Example:
```bash
# Skip creative apps
# install_packages "Creative Apps" "${CREATIVE_PACKAGES[@]}"
```

## Tips

- The script skips failed packages and continues
- Base/T2/Omarchy packages are commented out (likely pre-installed)
- Run with `--noconfirm` flag for unattended installation
- Review the script before running on a new system

## Updating Your Package List

To regenerate after installing new apps:
```bash
yay -Qe | awk '{print $1}' > current-packages.txt
```

Then update the script with any new packages you want to preserve.
