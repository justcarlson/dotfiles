# Hyprland Configuration

## Autostart Commands

Hyprland's `exec-once` does not use a shell to parse commands. Arguments are passed literally, which breaks commands with flags like `droid -m model-name`.

### Adding commands with arguments

**Wrong** - arguments get mangled:
```
exec-once = uwsm-app -- xdg-terminal-exec -e bash -c 'droid -m claude-opus-4-5-20251101'
```

**Correct** - use a wrapper script:
```
exec-once = uwsm-app -- xdg-terminal-exec -e ~/.local/bin/droid-scripts/droid-opus
```

### Creating wrapper scripts

1. Add script to `omarchy-config/.local/bin/droid-scripts/`
2. Make it executable: `chmod +x script-name`
3. Run `stow omarchy-config` to symlink
4. Reference full path in autostart.conf: `~/.local/bin/droid-scripts/script-name`

### Command patterns

- GUI apps: `exec-once = uwsm-app -- app-name`
- Terminal apps: `exec-once = uwsm-app -- xdg-terminal-exec -e command`
- Silent/workspace: `exec-once = [workspace 1 silent] app-name`

## Factory CLI (droid) Reference

Run `droid --help` and `droid exec --help` to verify available flags.

### Interactive mode (`droid`)

Only these options exist:
- `droid` - start interactive mode
- `droid "prompt"` - start with initial context
- `droid --resume [sessionId]` - resume session
- `-v, --version` / `-h, --help`

**No `-m` or `--model` flag** - model selection is NOT available in interactive mode.

### Exec mode (`droid exec`)

Supports full options including:
- `-m, --model <id>` - select model
- `--auto <level>` - autonomy level (low/medium/high)
- `--skip-permissions-unsafe` - bypass permission checks
- `-s, --session-id <id>` - continue existing session

### Common mistakes

```conf
# WRONG - --use-spec doesn't exist, -m not valid for interactive
bindd = SUPER SHIFT ALT, A, Factory CLI, exec, $terminal -e droid --use-spec -m claude-opus

# CORRECT - plain droid for interactive mode
bindd = SUPER SHIFT ALT, A, Factory CLI, exec, $terminal -e droid
```
