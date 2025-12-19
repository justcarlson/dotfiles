# Agent Instructions

## Issue Tracking with bd (beads)

**IMPORTANT**: This project uses **bd (beads)** for ALL issue tracking. Do NOT use markdown TODOs, task lists, or other tracking methods.

### Quick Start

```bash
bd ready --json                    # Check for ready work
bd create "Title" -t task -p 2 --json   # Create issue
bd update <id> --status in_progress --json  # Claim work
bd close <id> --reason "Done" --json    # Complete work
bd sync                            # Sync with git
```

### Issue Types

- `bug` - Something broken
- `feature` - New functionality
- `task` - Work item (tests, docs, refactoring)
- `epic` - Large feature with subtasks
- `chore` - Maintenance (dependencies, tooling)

### Priorities

- `0` - Critical (security, data loss, broken builds)
- `1` - High (major features, important bugs)
- `2` - Medium (default, nice-to-have)
- `3` - Low (polish, optimization)
- `4` - Backlog (future ideas)

### Workflow for AI Agents

1. **Check ready work**: `bd ready` shows unblocked issues
2. **Claim your task**: `bd update <id> --status in_progress`
3. **Work on it**: Implement, test, document
4. **Discover new work?** Create linked issue:
   - `bd create "Found bug" -p 1 --deps discovered-from:<parent-id>`
5. **Complete**: `bd close <id> --reason "Done"`
6. **Commit together**: Always commit `.beads/issues.jsonl` with code changes

### Writing Self-Contained Issues

Issues must be fully self-contained - readable without any external context.

**Required elements:**
- **Summary**: What and why in 1-2 sentences
- **Files to modify**: Exact paths
- **Implementation steps**: Numbered, specific actions

**Bad example:**
```
Implement the refactoring from the plan
```

**Good example:**
```
Add timeout parameter to fetchUser() in src/api/users.ts

1. Add optional timeout param (default 5000ms)
2. Pass to underlying fetch() call
3. Update tests in src/api/users.test.ts
```

### Dependencies: Think "Needs", Not "Before"

`bd dep add X Y` = "X needs Y" = Y blocks X

**TRAP**: Temporal words ("Phase 1", "before", "first") invert your thinking!
```
WRONG: "Phase 1 before Phase 2" → bd dep add phase1 phase2
RIGHT: "Phase 2 needs Phase 1" → bd dep add phase2 phase1
```

### Important Rules

- ✅ Use bd for ALL task tracking
- ✅ Always use `--json` flag for programmatic use
- ✅ Link discovered work with `discovered-from` dependencies
- ✅ Check `bd ready` before asking "what should I work on?"
- ❌ Do NOT create markdown TODO lists
- ❌ Do NOT duplicate tracking systems

## Landing the Plane (Session Completion)

**When ending a work session**, you MUST complete ALL steps below. Work is NOT complete until `git push` succeeds.

**MANDATORY WORKFLOW:**

1. **File issues for remaining work** - Create issues for anything that needs follow-up
2. **Run quality gates** (if code changed) - Tests, linters, builds
3. **Update issue status** - Close finished work, update in-progress items
4. **PUSH TO REMOTE** - This is MANDATORY:
   ```bash
   git pull --rebase
   bd sync
   git push
   git status  # MUST show "up to date with origin"
   ```
5. **Clean up** - Clear stashes, prune remote branches
6. **Verify** - All changes committed AND pushed
7. **Hand off** - Provide context for next session

**CRITICAL RULES:**
- Work is NOT complete until `git push` succeeds
- NEVER stop before pushing - that leaves work stranded locally
- NEVER say "ready to push when you are" - YOU must push
- If push fails, resolve and retry until it succeeds

