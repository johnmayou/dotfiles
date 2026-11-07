# Tasks

## 1. Prep

- [ ] 1.1 Commit the pending `init.lua` change in `~/.config/nvim` and push to the fork (ask user first). Verify: `git -C ~/.config/nvim status` clean, remote has it.
- [ ] 1.2 Confirm mise's `[bootstrap.repos]` format from mise docs. Verify: `mise bootstrap plan` accepts the entry.

## 2. Wire it

- [ ] 2.1 Add the repo entry to `mise.toml`. Verify: `mise bootstrap plan` shows no action on this Mac (already exists).
- [ ] 2.2 If mise lacks repo support, add a small idempotent clone task instead. Verify: task is a no-op when the dir exists.
