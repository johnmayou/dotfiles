# Tasks

## 1. Sync (done 2026-11-08)

- [x] 1.1 Pull work-machine changes and apply links; `~/.claude/skills` becomes per-file links before Claude restarts. Verify: `mise dot status` shows 23 entries up to date.
- [x] 1.2 Install new mise tools (duckdb, java 27, local-review) and brew packages (jq, mkcert, pv, tree-sitter-cli, postman-cli). Verify: `mise ls --missing` empty.
- [x] 1.3 Relink keg-only rustup with `mise bootstrap packages apply brew:rustup`. Verify: status no longer says `needs repair`.
- [x] 1.4 Adopt matching hand-installed apps (Claude, Ghostty, VS Code); force older ones (cmux, Obsidian, Chrome, Zoom, Google Drive, NordPass, NordVPN, CleanShot, Docker, GeForce NOW). Verify: `mise bootstrap plan` reports 0 create, 0 update.
- [x] 1.5 Remove mise `cargo:tree-sitter-cli` and the `cargo install` copy. Verify: `which -a tree-sitter` lists only `/opt/homebrew/bin`.

## 2. Rust

- [x] 2.1 Remove the mise `rust@stable` symlink install by hand and run `mise reshim`. Verify: `mise prune --dry-run` lists nothing, and no rustup/cargo/rustc shims remain.
- [x] 2.2 Delete the standalone rustup and its proxies from `~/.cargo/bin` (move to Trash), keeping `~/.rustup`. Verify: `which -a rustup cargo rustc` lists only `/opt/homebrew/bin`; `rustc --version` honors a `rust-toolchain.toml`.
- [x] 2.3 `cargo uninstall` the copies of mise-declared cargo tools. Verify: `cargo install --list` lists none of them.
- [x] 2.4 Ask the user whether `rustlings` is kept (declare `cargo:rustlings` in `.config/mise/mise.personal.toml`) or removed; user chose remove. Verify: `cargo install --list` is empty.
- [x] 2.5 Confirm rust-analyzer still starts in neovim and VS Code.

## 3. Runtimes

- [x] 3.1 Remove pipx tools. poetry, pytest, and prek are mise-declared (drop the pipx and `uv tool` copies); pynvim, which nothing declares, moves to `uv tool`. Verify: each of poetry/pytest/prek resolves only to mise, `pynvim-python` to a uv tool, and neovim's `has("python3")` is 1.
- [x] 3.2 `brew uninstall` fnm, pipx, pyenv, ruby, and zig. Verify: `brew leaves --installed-on-request` lists none of the runtimes `machine-bootstrap` bans.

## 4. Docs

- [x] 4.1 Remove the "avoid `mise run sync`/`dotsync` on the personal Mac" line from `openspec/config.yaml`. Verify: `dotsync` runs to completion with no cask installs.
- [x] 4.2 Move the README adopt/force bullet out of "SPS machines" and note that it needs an interactive terminal for sudo. Verify: README renders and the commands match `machine-bootstrap`.
- [ ] 4.3 Confirm the CleanShot 5 license; otherwise restore 4.8.8 from the backup. Verify: CleanShot opens licensed.

## Workflow follow-up

- Archive after review; the deltas add to `openspec/specs/machine-bootstrap/spec.md`.
