# Proposal

## Why

The `skills` CLI installed `microsoft-foundry` (from `microsoft/azure-skills`) into `~/.agents/skills`, tracked by `~/.agents/.skill-lock.json`. Claude Code doesn't read `~/.agents/skills`, so the skill never loads. Third-party skills need a defined path into Claude and a reproducible source.

## What Changes

- Pick one route for third-party skills: install them as Claude plugins, or link `~/.agents/skills` entries into `~/.claude/skills`.
- Record the source so a new machine gets them back (a plugin entry in `.claude/settings.json`, or the lock file).
- Decide whether `microsoft-foundry` is still wanted; remove it if not.

## Capabilities

### New Capabilities

### Modified Capabilities
- `agent-skills`: third-party skills load in Claude and are reproducible.

## Impact

- `.claude/settings.json` or `mise.toml` `[dotfiles]`, `~/.agents/`.
