#!/bin/bash

# install-my-apps.sh
# Auto-install Justin's apps via yay
# Run this after setting up a fresh Omarchy system

set -e  # Exit on error

echo "Installing Justin's apps..."

# Color output
GREEN='\033[0;32m'
BLUE='\033[0;34m'
YELLOW='\033[1;33m'
NC='\033[0m' # No Color

# Update system first
echo -e "${BLUE}Updating system...${NC}"
yay -Syu --noconfirm

# Base system packages (likely already installed on Omarchy)
BASE_PACKAGES=(
    base
    base-devel
    linux-firmware
    efibootmgr
    btrfs-progs
    intel-ucode
    inetutils
    man-db
    less
    bash-completion
)

# Apple T2 Mac-specific packages
T2_PACKAGES=(
    apple-bcm-firmware
    apple-t2-audio-config
    linux-t2
    linux-t2-headers
    t2fanrd
    tiny-dfr
    asdcontrol
)

# Omarchy-specific packages
OMARCHY_PACKAGES=(
    omarchy-chromium
    omarchy-keyring
    omarchy-nvim
    omarchy-walker
)

# Hyprland & Wayland ecosystem
HYPRLAND_PACKAGES=(
    hyprland
    hyprland-guiutils
    hypridle
    hyprlock
    hyprpicker
    hyprsunset
    waybar
    swaybg
    swayosd
    wayfreeze
    mako
    grim
    slurp
    satty
    wl-clipboard
    xdg-desktop-portal-hyprland
    xdg-desktop-portal-gtk
    xdg-terminal-exec
    uwsm
)

# Display manager & theming
UI_PACKAGES=(
    sddm
    plymouth
    polkit-gnome
    kvantum-qt5
    qt5-wayland
    gnome-themes-extra
    yaru-icon-theme
    noto-fonts
    noto-fonts-cjk
    noto-fonts-emoji
    noto-fonts-extra
    ttf-cascadia-mono-nerd
    ttf-ia-writer
    ttf-jetbrains-mono-nerd
    woff2-font-awesome
    fontconfig
)

# Audio & video
MEDIA_PACKAGES=(
    pipewire
    pipewire-alsa
    pipewire-jack
    pipewire-pulse
    wireplumber
    gst-plugin-pipewire
    libpulse
    pamixer
    playerctl
    mpv
    gpu-screen-recorder
    kdenlive
    obs-studio
    ffmpegthumbnailer
    imagemagick
    imv
)

# Terminals & shells
TERMINAL_PACKAGES=(
    alacritty
    ghostty
    starship
    zoxide
    fastfetch
)

# Development tools
DEV_PACKAGES=(
    git
    github-cli
    neovim
    mise
    docker
    docker-buildx
    docker-compose
    lazydocker
    lazygit
    rust
    llvm
    clang
    python-poetry-core
    python-gobject
    mariadb-libs
    postgresql-libs
    libyaml
    tree-sitter-cli
    luarocks
)

# CLI utilities
CLI_PACKAGES=(
    bat
    btop
    dust
    eza
    fd
    fzf
    gum
    jq
    ripgrep
    tldr
    plocate
    expac
    unzip
    whois
    xmlstarlet
    yay
    libqalculate
    python-terminaltexteffects
)

# Security & authentication
SECURITY_PACKAGES=(
    1password-beta
    1password-cli
    gnome-keyring
    pam-u2f
    libfido2
    ufw
    ufw-docker
)

# Networking & Bluetooth
NETWORK_PACKAGES=(
    iwd
    wireless-regdb
    nss-mdns
    blueberry
    gvfs-mtp
    gvfs-nfs
    gvfs-smb
)

# Input methods
INPUT_PACKAGES=(
    fcitx5
    fcitx5-gtk
    fcitx5-qt
)

# Desktop apps - Productivity
PRODUCTIVITY_PACKAGES=(
    obsidian
    typora
    libreoffice-fresh
    xournalpp
    evince
    gnome-calculator
)

# Desktop apps - Communication
COMMUNICATION_PACKAGES=(
    google-chrome-beta
    signal-desktop
    localsend
)

# Desktop apps - Media & Creative
CREATIVE_PACKAGES=(
    spotify
    pinta
)

# System utilities
SYSTEM_PACKAGES=(
    gnome-disk-utility
    nautilus
    sushi
    brightnessctl
    power-profiles-daemon
    fwupd
    cups
    cups-browsed
    cups-filters
    cups-pdf
    system-config-printer
    snapper
    limine
    limine-mkinitcpio-hook
    limine-snapper-sync
    tzupdate
    inxi
    stow
)

# Special packages
SPECIAL_PACKAGES=(
    aether
    impala
    wiremix
)

# Function to install packages
install_packages() {
    local category=$1
    shift
    local packages=("$@")
    
    echo -e "\n${BLUE}Installing $category...${NC}"
    for package in "${packages[@]}"; do
        echo -e "${GREEN}  → $package${NC}"
        yay -S --noconfirm "$package" 2>/dev/null || echo -e "${YELLOW}    ⚠ Failed to install $package, continuing...${NC}"
    done
}

# Install in order of importance
echo -e "\n${BLUE}═══════════════════════════════════════${NC}"
echo -e "${BLUE}  Justin's Omarchy System Installation${NC}"
echo -e "${BLUE}═══════════════════════════════════════${NC}\n"

# Uncomment categories you want to install
# Base system (probably already installed)
# install_packages "Base System" "${BASE_PACKAGES[@]}"
# install_packages "Apple T2 Mac Support" "${T2_PACKAGES[@]}"
# install_packages "Omarchy Packages" "${OMARCHY_PACKAGES[@]}"

# Core environment
install_packages "Hyprland & Wayland" "${HYPRLAND_PACKAGES[@]}"
install_packages "UI & Fonts" "${UI_PACKAGES[@]}"
install_packages "Audio & Video" "${MEDIA_PACKAGES[@]}"

# Terminals and dev
install_packages "Terminals & Shells" "${TERMINAL_PACKAGES[@]}"
install_packages "Development Tools" "${DEV_PACKAGES[@]}"
install_packages "CLI Utilities" "${CLI_PACKAGES[@]}"

# Security and networking
install_packages "Security & Authentication" "${SECURITY_PACKAGES[@]}"
install_packages "Network & Bluetooth" "${NETWORK_PACKAGES[@]}"

# Input and productivity
install_packages "Input Methods" "${INPUT_PACKAGES[@]}"
install_packages "Productivity Apps" "${PRODUCTIVITY_PACKAGES[@]}"
install_packages "Communication Apps" "${COMMUNICATION_PACKAGES[@]}"
install_packages "Creative Apps" "${CREATIVE_PACKAGES[@]}"

# System utilities
install_packages "System Utilities" "${SYSTEM_PACKAGES[@]}"
install_packages "Special Packages" "${SPECIAL_PACKAGES[@]}"

echo -e "\n${GREEN}═══════════════════════════════════════${NC}"
echo -e "${GREEN}  Installation complete!${NC}"
echo -e "${GREEN}═══════════════════════════════════════${NC}\n"
echo -e "Next steps:"
echo -e "  1. Restore dotfiles: ${BLUE}cd ~/dotfiles && stow .${NC}"
echo -e "  2. Configure services as needed"
echo -e "  3. Reboot if kernel modules were updated\n"
