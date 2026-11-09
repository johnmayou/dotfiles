# Dotfiles

My personal dotfiles, managed with [mise](https://mise.jdx.dev).

## New Mac

Clone to `~/Projects/dotfiles` and move aside anything a link would replace.

```sh
mise trust
MISE_ENV=personal mise run stamp   # or MISE_ENV=sps
mise bootstrap --yes
```

Apps installed by hand before bootstrap block their casks. Hand them to brew once: `brew install --cask --adopt <cask>` if the installed version matches the cask, `--force` if it's older. Run it in your own terminal: brew uses sudo to take ownership of the app. A fresh machine doesn't need this.

### SPS machines

- Run mise package commands, including `dotsync` and `dotup`, with `GITHUB_TOKEN=$(gh auth token)` set. switchyard comes from the private `spscommerce/sps` tap, and mise can't read it without auth.
- Create `~/.config/npm/sps.npmrc` and `~/.config/uv/uv.sps.toml` (chmod 600) with JFrog tokens before using npm or uv.

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
