# Proposal

## Why

Neovim config at `~/.config/nvim` is a fork of kickstart.nvim. It should come back on a new machine, but copying it into this repo would make merging upstream kickstart changes painful.

## What Changes

- Keep kickstart.nvim as its own git repo.
- Have mise bootstrap clone it to `~/.config/nvim` (via `[bootstrap.repos]` if mise supports it; format unverified).
- Do not link or copy nvim files from this repo. (An earlier repo `nvim/` dir was removed; do not repoint `~/.config/nvim` at it.)

## Capabilities

### New Capabilities

### Modified Capabilities
- `machine-bootstrap`: what `mise bootstrap` provisions on a fresh machine beyond links and packages.

## Impact

- `mise.toml` bootstrap section.
- Existing `~/.config/nvim` has an uncommitted change in `init.lua`; commit or push it to the fork first.
