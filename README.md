# Omarchy Dotfiles

Justin's dotfiles and configuration for Omarchy Linux (Arch-based with Hyprland).

## Prerequisites

This repo requires SSH authentication. Configure 1Password SSH agent first:

1. Open 1Password > Settings > Developer
2. Enable "Use the SSH agent"
3. Add your GitHub SSH key to 1Password
4. Create/update `~/.ssh/config`:
   ```
   Host github.com
     IdentityAgent ~/.1password/agent.sock
   ```

## Quick Start

### Fresh Omarchy Installation

1. **Clone this repository:**
   ```bash
   git clone git@github.com:justcarlson/dotfiles.git ~/dotfiles
   ```

2. **Run the installer:**
   ```bash
   cd ~/dotfiles
   chmod +x install.sh
   ./install.sh
   ```

   The script will:
   - Back up existing configs to `~/omarchy-backup-TIMESTAMP/`
   - Install GNU Stow if needed
   - Create symlinks to your dotfiles
   - Offer to install Hy3 plugin and Claude Code
   - Offer to install optional packages (file managers, monitors, etc.)
   - Configure API keys for MCP integrations

   **Important:** Do NOT use `sudo` - the script doesn't need it.

   **CLI Options:**
   ```bash
   ./install.sh --check          # Dry run - preview changes without applying
   ./install.sh --skip-packages  # Skip optional package selection
   ./install.sh --skip-secrets   # Skip API key configuration
   ./install.sh --help           # Show all options
   ```

### If You Get Conflicts

If the install script fails with "cannot stow" errors, you have existing configs that need to be moved first:

**Option 1: Manual backup** (recommended for clean install)
```bash
# Backup your current configs
mkdir -p ~/omarchy-backup-manual
mv ~/.config/hypr ~/omarchy-backup-manual/
mv ~/.config/waybar ~/omarchy-backup-manual/
mv ~/.config/walker ~/omarchy-backup-manual/
mv ~/.config/ghostty ~/omarchy-backup-manual/
mv ~/.config/uwsm ~/omarchy-backup-manual/
mv ~/.config/starship.toml ~/omarchy-backup-manual/
mv ~/.bashrc ~/omarchy-backup-manual/
mv ~/.XCompose ~/omarchy-backup-manual/

# Run the install script
./install.sh
```

**Option 2: Adopt existing configs** (merges your current configs into the repo)
```bash
cd ~/dotfiles
stow --adopt omarchy-config
```

## What's Included

- **`omarchy-config/`** - Dotfiles for Hyprland, Waybar, Ghostty, Walker, uwsm, etc.
- **`install.sh`** - Main installer with backup, stow, and interactive setup
- **`lib/`** - Modular libraries:
  - `tui.sh` - Gum-based UI helpers with fallback to basic prompts
  - `secrets.sh` - `~/.secrets` file management for API keys
  - `packages.sh` - Package registry (single source of truth)
- **`README-apps.md`** - Reference list of packages

### Configured Applications

- **Hyprland** - Window manager
- **Waybar** - Top bar
- **Walker** - Launcher
- **Ghostty** - Terminal
- **uwsm** - Session manager
- **Starship** - Shell prompt
- **Typora** - Markdown editor themes
- **.bashrc and .XCompose** - Shell and input configs

### Customization

After installation, edit these files to customize:
- **`~/.config/hypr/autostart-claude.conf`** - Claude Code workspace sessions
- **`~/.config/hypr/bindings.conf`** - App launch keybindings
- **`~/.secrets`** - API keys for MCP integrations (created by installer)

## Documentation

- **[Package Reference](README-apps.md)** - List of optional and pre-installed packages
- All configs are managed with [GNU Stow](https://www.gnu.org/software/stow/)

## Updating Configs

Since Stow creates symlinks, editing files in `~/.config/` automatically updates the files in `~/dotfiles/`.

### Making Changes via PR Workflow

1. Create a feature branch:
   ```bash
   cd ~/dotfiles
   git checkout main
   git pull
   git checkout -b feature/description
   ```

2. Make your config changes (they're symlinked, so edit directly in `~/.config/`)

3. Commit and push:
   ```bash
   git add -A
   git commit -m "feat: description"
   git push -u origin feature/description
   gh pr create --fill
   ```

4. After PR merge, clean up:
   ```bash
   git checkout main
   git pull
   git branch -d feature/description
   ```

### Pull latest configs from the repo:
```bash
cd ~/dotfiles
git pull
```

Changes are immediately active since the files are symlinked.

## Version Tags & Rollback

### Checking Out a Specific Version

If you need to roll back to a previous stable release:
```bash
cd ~/dotfiles
git checkout v1.0.0
stow -R omarchy-config
```

This restores all configs to the state they were in at that version.

### Returning to Latest

To go back to the latest version:
```bash
cd ~/dotfiles
git checkout main
git pull
stow -R omarchy-config
```

### Available Versions

- **v1.0.0** - First stable release with Hyprland, Hy3, and core configs

## Uninstalling

To remove the symlinks and restore your configs to regular files:
```bash
cd ~/dotfiles
stow -D omarchy-config
```

Your backup configs will still be in `~/omarchy-backup-*/` if you need them.

## Notes

- **Never run install scripts with `sudo`** - they don't need it
- Uses GNU Stow for symlink management
- Designed for Omarchy Linux (Arch-based, Hyprland WM)
- Optimized for Apple T2 MacBooks

## Troubleshooting

**"Permission denied" when running scripts:**
```bash
chmod +x install.sh
```

**"command not found" with sudo:**
Don't use sudo. Run scripts as your regular user.

**Stow conflicts:**
See "If You Get Conflicts" section above.

**Installation failed mid-way:**
The installer automatically rolls back if stow fails. Your original configs are preserved in `~/omarchy-backup-*/`. To manually restore:
```bash
# Remove partial symlinks
cd ~/dotfiles
stow -D omarchy-config

# Restore from backup
cp -r ~/omarchy-backup-TIMESTAMP/.config/hypr ~/.config/
```

**Preview changes before installing:**
```bash
./install.sh --check
```
