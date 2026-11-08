# Tasks

## 1. Binary

- [ ] 1.1 Remove `~/.local/bin/plannotator` (move to Trash). Verify: `command -v plannotator` resolves under mise installs.

## 2. Skills

- [ ] 2.1 Check whether the plannotator plugin ships the stock skills. Verify: plugin cache has a `skills/` dir with them, or doesn't.
- [ ] 2.2 If not, vendor the stock skills into `.ai/skills` and trim them per `trim-skill-leftovers` rules (ask user first). Verify: `mise bootstrap dotfiles status` up to date.
- [ ] 2.3 Remove installer copies from `~/.claude/skills` and `~/.agents/skills`. Verify: spec delta scenarios pass.
