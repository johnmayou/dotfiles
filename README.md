# Dotfiles

My personal dotfiles, managed with [mise](https://mise.jdx.dev).

## New Mac

Clone to `~/Projects/dotfiles` and move aside anything a link would replace.

```sh
mise trust
MISE_ENV=personal mise run stamp   # or MISE_ENV=sps
mise bootstrap --yes
```

## Daily use

- `dotsync`: pull and apply everything
- `dotup`: upgrade packages and tools
- `mise bootstrap plan`: preview changes

## Where things go

- Links, shared apps, macOS preferences: `mise.toml`
- Per-machine apps: `mise.personal.toml`, `mise.sps.toml`
- Tools and runtimes: `.config/mise/`
- Skills: `.ai/skills/`
- Agent rules: `.ai/AGENTS.md`
- Registry tokens: never in the repo. On SPS machines, `~/.config/npm/sps.npmrc` and `~/.config/uv/uv.sps.toml` (untracked, chmod 600), wired up in `mise.sps.toml`

Rust stays on rustup, because mise overrides `rust-toolchain.toml` pins.
