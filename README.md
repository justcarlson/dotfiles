# Omarchy Dotfiles

Justin's dotfiles and configuration for Omarchy Linux (Arch-based with Hyprland).

<details>
<summary><strong>Prerequisites (1Password SSH)</strong></summary>

This repo requires SSH authentication. Configure 1Password SSH agent first:

1. Open 1Password > Settings > Developer
2. Enable "Use the SSH agent"
3. Add your GitHub SSH key to 1Password
4. Create/update `~/.ssh/config`:
   ```
   Host github.com
     IdentityAgent ~/.1password/agent.sock
   ```

</details>

## Quick Start

```bash
git clone git@github.com:justcarlson/dotfiles.git ~/.dotfiles
cd ~/.dotfiles
./install.sh
```

The installer backs up existing configs, creates symlinks via GNU Stow, and offers optional packages.

**CLI Options:**
```bash
./install.sh --check          # Dry run - preview changes
./install.sh --skip-packages  # Skip optional package selection
./install.sh --skip-secrets   # Skip API key configuration
```

> **Note:** Do NOT use `sudo` - the script doesn't need it.

<details>
<summary><strong>Resolving Stow Conflicts</strong></summary>

If the install script fails with "cannot stow" errors, you have existing configs that need to be moved first:

**Option 1: Manual backup** (recommended for clean install)
```bash
mkdir -p ~/omarchy-backup-manual
mv ~/.config/hypr ~/omarchy-backup-manual/
mv ~/.config/waybar ~/omarchy-backup-manual/
mv ~/.config/walker ~/omarchy-backup-manual/
mv ~/.config/ghostty ~/omarchy-backup-manual/
mv ~/.config/uwsm ~/omarchy-backup-manual/
mv ~/.config/starship.toml ~/omarchy-backup-manual/
mv ~/.bashrc ~/omarchy-backup-manual/
mv ~/.XCompose ~/omarchy-backup-manual/

./install.sh
```

**Option 2: Adopt existing configs** (merges your current configs into the repo)
```bash
cd ~/.dotfiles
stow --adopt omarchy-config
```

</details>

<details>
<summary><strong>Troubleshooting</strong></summary>

**"Permission denied" when running scripts:**
```bash
chmod +x install.sh
```

**"command not found" with sudo:**
Don't use sudo. Run scripts as your regular user.

**Stow conflicts:**
See "Resolving Stow Conflicts" section above.

**Installation failed mid-way:**
The installer automatically rolls back if stow fails. Your original configs are preserved in `~/omarchy-backup-*/`. To manually restore:
```bash
cd ~/.dotfiles
stow -D omarchy-config
cp -r ~/omarchy-backup-TIMESTAMP/.config/hypr ~/.config/
```

</details>

## What's Included

| Path | Description |
|------|-------------|
| `omarchy-config/` | Dotfiles (Hyprland, Waybar, Ghostty, Walker, etc.) |
| `lib/` | Modular libraries (tui.sh, secrets.sh, packages.sh) |
| `install.sh` | Main installer |

**Configured apps:** Hyprland, Waybar, Walker, Ghostty, uwsm, Starship, Typora themes

## Customization

After installation, edit:
- `~/.config/hypr/bindings.conf` - Keybindings
- `~/.config/hypr/autostart-claude.conf` - Claude Code workspaces
- `~/.secrets` - API keys for MCP integrations

## Updating

Since Stow creates symlinks, edits in `~/.config/` automatically update the repo.

```bash
cd ~/.dotfiles && git pull   # Pull latest (changes apply immediately)
```

<details>
<summary><strong>Git Workflow (PRs & Branches)</strong></summary>

1. Create a feature branch:
   ```bash
   cd ~/.dotfiles
   git checkout main && git pull
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
   git checkout main && git pull
   git branch -d feature/description
   ```

</details>

<details>
<summary><strong>Version Tags & Rollback</strong></summary>

**Roll back to a previous version:**
```bash
cd ~/.dotfiles
git checkout v2.0.0
stow -R omarchy-config
```

**Return to latest:**
```bash
cd ~/.dotfiles
git checkout main && git pull
stow -R omarchy-config
```

**Available versions:**
- **v2.0.0** - Modular install with TUI, secrets, and package registry
- **v1.0.0** - First stable release with Hyprland, Hy3, and core configs

</details>

<details>
<summary><strong>Uninstalling</strong></summary>

To remove the symlinks:
```bash
cd ~/.dotfiles
stow -D omarchy-config
```

Your backup configs will still be in `~/omarchy-backup-*/` if you need them.

</details>

## Documentation

- **[Keybindings](README-keybindings.md)** - Keyboard shortcuts and aliases
- **[Packages](README-apps.md)** - Optional and pre-installed packages
