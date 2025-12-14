# Omarchy Dotfiles

Personal dotfiles for Omarchy Linux (Arch + Hyprland). Uses GNU Stow for symlink management.

## Quick Commands

```bash
# Install everything (interactive)
./install.sh

# Install with options
./install.sh --check          # Dry run - preview changes
./install.sh --skip-packages  # Skip optional package selection
./install.sh --skip-secrets   # Skip API key configuration

# Stow operations
stow omarchy-config           # Create symlinks
stow -D omarchy-config        # Remove symlinks
stow --adopt omarchy-config   # Adopt existing files into repo

# Reload Hyprland config after changes
hyprctl reload
```

## Project Structure

```
.
├── install.sh              # Main installer (orchestrator, ~200 lines)
├── lib/                    # Modular libraries
│   ├── tui.sh              # Gum wrappers for styled UI
│   ├── secrets.sh          # ~/.secrets management
│   └── packages.sh         # Package registry & installer
├── omarchy-config/         # Stow package (mirrors ~/)
│   ├── .config/hypr/       # Hyprland + Hy3 tiling config
│   ├── .config/ghostty/    # Terminal config
│   ├── .config/waybar/     # Status bar
│   ├── .local/bin/         # Custom scripts
│   └── .bashrc             # Shell config
├── README-apps.md          # Package reference (what's installed)
└── README-keybindings.md   # Keybindings reference
```

## Key Files

- `lib/packages.sh` - `PACKAGE_REGISTRY` array (single source of truth for packages)
- `install.sh` - `CONFIGS` array for stow paths
- `lib/secrets.sh` - Secrets management (`~/.secrets`)
- `lib/tui.sh` - Gum-based UI helpers
- `omarchy-config/.config/hypr/bindings.conf` - Keybindings
- `omarchy-config/.config/hypr/autostart.conf` - Startup apps

## Code Patterns

**Adding a new package:**
```bash
# Add to PACKAGE_REGISTRY in lib/packages.sh:
# Format: "name|category|description|config_files|autostart_entry|post_install"
"newpkg|Category|Description|none|exec-once = newpkg|none"

# That's it! The install script handles the rest.
```

**Adding a new config:**
```bash
# 1. Mirror the ~ path structure
mkdir -p omarchy-config/.config/newapp/
cp ~/.config/newapp/config.toml omarchy-config/.config/newapp/

# 2. Add to CONFIGS array in install.sh
# 3. Re-stow: stow omarchy-config
```

**Adding a secret:**
```bash
# Secrets go in ~/.secrets (created by install.sh or manually)
echo 'export NEW_API_KEY="xxx"' >> ~/.secrets
chmod 600 ~/.secrets

# Reference via environment variable in configs
```

**Adding a keybinding:**
```bash
# In bindings.conf, format:
bindd = SUPER SHIFT, KEY, Description, exec, command

# For optional apps, use guards:
bindd = SUPER SHIFT, KEY, Description, exec, command -v app &>/dev/null && uwsm-app -- app || notify-send "app not installed" "Install with: yay -S app"
```

## Git Workflow

### Making Changes

1. Create a feature branch:
   ```bash
   git checkout main
   git pull
   git checkout -b feature/description
   ```

2. Make changes and commit:
   ```bash
   git add -A
   git commit -m "feat: description"
   ```

3. Push and create PR:
   ```bash
   git push -u origin feature/description
   gh pr create --fill
   ```

4. After PR merge, clean up:
   ```bash
   git checkout main
   git pull
   git branch -d feature/description
   ```

### Creating a Stable Version

After significant changes are tested and stable:
```bash
git tag -a v1.1.0 -m "Description of changes"
git push origin v1.1.0
```

### Rolling Back to a Stable Version

If something breaks after an update:
```bash
git checkout v1.0.0
stow -R omarchy-config
```

To return to latest:
```bash
git checkout main
stow -R omarchy-config
```

**Commit format:** Use conventional commits (`feat:`, `fix:`, `docs:`)

## Boundaries

**Always:**
- Place configs in `omarchy-config/` mirroring `~/` structure
- Add packages to `PACKAGE_REGISTRY` in `lib/packages.sh`
- Store secrets in `~/.secrets`, never in tracked files
- Test keybindings with `hyprctl reload` before committing

**Ask first:**
- Adding new package dependencies
- Modifying core install.sh logic

**Never:**
- Run `install.sh` with sudo
- Edit files in `~/.local/share/omarchy/` (override in personal configs instead)
- Commit API keys or credentials to git

## Nested Guidance

- `omarchy-config/.config/hypr/AGENTS.md` - Hyprland/Hy3 specific patterns
