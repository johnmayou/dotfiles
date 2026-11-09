# Proposal

## Why

The work machine reconcile (`2026-11-08-reconcile-work-machine`) moved packages between lists, switched `~/.claude/skills` to `symlink-each`, and added tools. The personal Mac then pulled those changes. Applying them converged the declared state, so `mise bootstrap plan` is clean. That pass also showed that the personal Mac still has more than one copy of several tools, and the extra copies come first on PATH or wait to break something later:

- Three rustups: a standalone `~/.cargo/bin/rustup` (1.29.2), which runs first; Homebrew's declared one (1.29.3); and a mise `rust@stable` install that symlinks to `~/.cargo/bin`. mise generates shims for every binary in that directory, and `mise prune` lists `rust@stable` as prunable.
- `cargo install` copies in `~/.cargo/bin` of tools that mise declares as `cargo:` tools. A `tree-sitter` copy there ran instead of Homebrew's until it was removed by hand.
- Runtimes that Homebrew installed on request, against `machine-bootstrap`: fnm, pipx, pyenv, ruby, and zig.

The project context still says to avoid `dotsync` on the personal Mac because hand-installed apps show up as cask installs. That stopped being true once every app was adopted.

## What Changes

- Record the personal-Mac sync done on 2026-11-08: pulled the changes, applied the per-entry skills links, installed the new mise tools and brew packages, adopted or force-installed every hand-installed app, and relinked keg-only rustup.
- Keep one rustup, Homebrew's: remove the standalone install's binaries and the mise `rust@stable` symlink install, and keep `~/.rustup` toolchains.
- Remove `cargo install` copies of tools mise declares; decide whether `rustlings` gets declared or removed.
- Uninstall Homebrew runtimes installed on request. Move pipx-installed tools to `uv tool` first.
- Drop the "avoid `dotsync` on the personal Mac" note from `openspec/config.yaml`. Make the README's adopt/force note apply to both machines, and say that adopting needs an interactive terminal for sudo.

## Capabilities

### New Capabilities

### Modified Capabilities
- `machine-bootstrap`: each tool has one install on PATH, from the manager that declares it; rustup comes from Homebrew; mise has no installs that no config declares.

## Impact

- `openspec/config.yaml`, `README.md`, possibly `.config/mise/mise.personal.toml` (rustlings).
- Personal Mac only: `~/.cargo/bin`, `~/.local/share/mise/installs/rust`, Homebrew formulae fnm/pipx/pyenv/ruby/zig, pipx venvs under `~/.local/pipx`.
