# Package Reference

Packages referenced in the dotfiles configuration.

## Optional (Not Pre-installed on Omarchy)

These are offered during `./install.sh`:

| Package | Purpose | Config Reference |
|---------|---------|------------------|
| google-chrome-beta | Web browser | `BROWSER` in uwsm/default |
| tailscale | Mesh VPN | Remote access |
| solaar | Logitech device manager | For MX mice/keyboards |
| tree | Directory tree viewer | CLI |
| bun-bin | JavaScript runtime | CLI |
| claude-code | Claude Code CLI | CLI |
| wev | Wayland event viewer | Debugging keybindings |

## Pre-installed on Omarchy

These are included in Omarchy's base packages and referenced in bindings.conf:

| Package | Purpose | Keybinding |
|---------|---------|------------|
| btop | System monitor | Super+Shift+T |
| lazydocker | Docker TUI | Super+Shift+D |
| obsidian | Note-taking | Super+Shift+O |
| typora | Markdown editor | Super+Shift+W |
| signal-desktop | Encrypted messaging | Super+Shift+G |
| spotify | Music streaming | Super+Shift+M |
| ripgrep | Fast text search | CLI |
| ghostty | Terminal | TERMINAL env |
| 1password-beta | Password manager | Super+Shift+/ |
| nautilus | File manager | Super+Shift+F |

## Installed via curl (automatic)

Factory CLI is installed automatically during `./install.sh`:

| Package | Purpose | Install Command |
|---------|---------|-----------------|
| Factory CLI | Factory AI CLI | `curl -fsSL https://app.factory.ai/cli \| sh` |

## Installed via pipx

These are offered during `./install.sh` after the yay packages. `python-pipx` is auto-installed if needed:

| Package | Purpose | Install Command | Keybinding |
|---------|---------|-----------------|------------|
| pygpt-net | PyGPT AI assistant | `pipx install pygpt-net` | Super+Shift+I |

## Manual Installation (AppImage)

Cursor is installed manually via AppImage (not from AUR):

```bash
# Download from https://www.cursor.com/downloads
# Then install:
chmod +x ~/Downloads/Cursor-*.AppImage
sudo mv ~/Downloads/Cursor-*.AppImage /opt/cursor.AppImage
sudo ln -s /opt/cursor.AppImage /usr/local/bin/cursor

# Extract and install icon + desktop entry:
cd /tmp && /opt/cursor.AppImage --appimage-extract
sudo cp squashfs-root/usr/share/icons/hicolor/256x256/apps/cursor.png /usr/share/icons/hicolor/256x256/apps/
sudo cp squashfs-root/usr/share/icons/hicolor/128x128/apps/cursor.png /usr/share/icons/hicolor/128x128/apps/
sudo cp squashfs-root/usr/share/icons/hicolor/512x512/apps/cursor.png /usr/share/icons/hicolor/512x512/apps/
rm -rf squashfs-root

# Create desktop entry:
cat << 'EOF' | sudo tee /usr/share/applications/cursor.desktop
[Desktop Entry]
Name=Cursor
Comment=AI-powered code editor
Exec=/opt/cursor.AppImage --no-sandbox %F
Icon=cursor
Type=Application
Categories=Development;IDE;TextEditor;
MimeType=text/plain;inode/directory;
StartupNotify=true
StartupWMClass=Cursor
EOF
```

## Manual Installation (yay)

To install any other package individually:
```bash
yay -S <package-name>
```
