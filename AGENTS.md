# Omarchy Dotfiles

Personal dotfiles for Omarchy Linux (Arch + Hyprland). Uses GNU Stow for symlink management.

## Tech Stack

- **OS:** Omarchy Linux (Arch-based) on Apple T2 MacBooks
- **WM:** Hyprland with Hy3 plugin (i3-like tiling)
- **Terminal:** Ghostty
- **Shell:** Bash + Starship prompt
- **Package Manager:** yay (AUR)

## Commands

```bash
# Install everything
./install.sh

# Stow operations
stow omarchy-config           # Create symlinks
stow -D omarchy-config        # Remove symlinks
stow --adopt omarchy-config   # Adopt existing configs
```

## Project Structure

```
├── install.sh              → Main installer (runs Hy3 setup too)
├── omarchy-config/         → Stow package (mirrors ~/)
│   ├── .config/hypr/       → Hyprland + Hy3 config
│   ├── .config/ghostty/    → Terminal config
│   ├── .local/bin/         → Scripts (droid-scripts/, cursor-wayland)
│   └── .bashrc             → Shell config
├── README-apps.md          → Package reference
└── README-keybindings.md   → Keybindings reference
```

## Boundaries

- ✅ **Always:** Place new configs in `omarchy-config/` mirroring `~/` structure
- ✅ **Always:** Update `CONFIGS` array in `install.sh` when adding new config paths
- ⚠️ **Ask first:** Adding new package dependencies to `OPTIONAL_PACKAGES`
- 🚫 **Never:** Run `install.sh` with `sudo` - it doesn't need elevated privileges
- 🚫 **Never:** Edit `~/.local/share/omarchy/` files - override in personal configs

## Patterns

**Adding a new config:**
```bash
# 1. Place file at mirror path
mkdir -p omarchy-config/.config/newapp/
cp ~/.config/newapp/config.toml omarchy-config/.config/newapp/

# 2. Re-stow
stow omarchy-config

# 3. Add to CONFIGS array in install.sh for backup handling
```

**Stow conflicts:** Existing non-symlink configs must be backed up or removed first.

**Symlink editing:** `~/.config/*` edits go directly to repo files (they're symlinks).

## Nested AGENTS.md

- `omarchy-config/.config/hypr/AGENTS.md` - Hyprland/Hy3 specific guidance
