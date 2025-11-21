#!/bin/bash

# Omarchy Dotfiles Installation Script
# This script installs GNU Stow (if needed), backs up existing configs, and stows your Omarchy configuration

set -e  # Exit on any error

echo "======================================"
echo "  Omarchy Dotfiles Installation"
echo "======================================"
echo ""

# Check if stow is installed
if ! command -v stow &> /dev/null; then
    echo "📦 GNU Stow not found. Installing..."
    if command -v yay &> /dev/null; then
        yay -S --noconfirm stow
        echo "✅ Stow installed successfully"
    else
        echo "❌ Error: yay package manager not found"
        echo "Please install stow manually: yay -S stow"
        exit 1
    fi
else
    echo "✅ GNU Stow is already installed"
fi

echo ""

# Define configs that will be managed
CONFIGS=(
    ".config/hypr"
    ".config/waybar"
    ".config/walker"
    ".config/ghostty"
    ".config/uwsm"
    ".config/starship.toml"
    ".bashrc"
    ".XCompose"
)

# Check if any configs exist and need backing up
BACKUP_NEEDED=false
for config in "${CONFIGS[@]}"; do
    if [ -e "$HOME/$config" ] && [ ! -L "$HOME/$config" ]; then
        BACKUP_NEEDED=true
        break
    fi
done

# Backup existing configs if needed
if [ "$BACKUP_NEEDED" = true ]; then
    BACKUP_DIR="$HOME/omarchy-backup-$(date +%Y%m%d-%H%M%S)"
    echo "📦 Backing up existing configs to: $BACKUP_DIR"
    mkdir -p "$BACKUP_DIR"
    
    for config in "${CONFIGS[@]}"; do
        if [ -e "$HOME/$config" ] && [ ! -L "$HOME/$config" ]; then
            # Create parent directory structure in backup
            parent_dir=$(dirname "$config")
            mkdir -p "$BACKUP_DIR/$parent_dir"
            
            # Move the file/directory to backup
            mv "$HOME/$config" "$BACKUP_DIR/$config"
            echo "  ✓ Backed up: $config"
        fi
    done
    
    echo ""
    echo "✅ Backup complete: $BACKUP_DIR"
    echo ""
fi

echo "🔗 Creating symlinks for Omarchy configs..."
echo ""

# Stow the configuration
if stow omarchy-config; then
    echo ""
    echo "======================================"
    echo "  ✅ Installation Complete!"
    echo "======================================"
    echo ""
    echo "Your Omarchy dotfiles have been installed."
    echo ""
    echo "Configured:"
    echo "  • Hyprland (window manager)"
    echo "  • Waybar (top bar)"
    echo "  • Walker (launcher)"
    echo "  • Ghostty (terminal)"
    echo "  • uwsm (session manager)"
    echo "  • Starship (shell prompt)"
    echo "  • .bashrc and .XCompose"
    echo ""
    if [ "$BACKUP_NEEDED" = true ]; then
        echo "📦 Your original configs were backed up to:"
        echo "   $BACKUP_DIR"
        echo ""
    fi
    echo "⚠️  You may need to restart Hyprland or reboot for all changes to take effect."
    echo ""
else
    echo ""
    echo "❌ Installation failed"
    echo ""
    echo "Please check the error messages above."
    echo ""
    if [ "$BACKUP_NEEDED" = true ]; then
        echo "Your original configs are backed up in: $BACKUP_DIR"
        echo ""
    fi
    exit 1
fi
