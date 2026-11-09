# Design

## Context

The personal Mac is now in the declared state (`mise bootstrap plan`: 48 unchanged, nothing to do), but some tools still have extra copies, and those decide which binary actually runs:

- PATH order puts mise's `cargo:` install directories first, then `~/.local/share/mise/shims`, then `~/.cargo/bin`, then `/opt/homebrew/bin`.
- `~/.local/share/mise/installs/rust/stable` is a symlink to `~/.cargo/bin`, a leftover install that no config declares. mise therefore shims every binary in `~/.cargo/bin` (rustup, cargo, rustc, rustlings), and those shims fall through to `~/.cargo/bin`.
- `~/.cargo/bin` holds a standalone rustup with its proxies, plus `cargo install` copies of cargo-insta, cargo-nextest, cargo-semver-checks, just-lsp, mdbook, mdbook-toc, and rustlings.
- `brew:rustup` is keg-only. mise reported it as "needs repair" (no linked-keg record) until `mise bootstrap packages apply brew:rustup` linked it. Linking puts only `rustup` itself in `/opt/homebrew/bin`. The `cargo`/`rustc` proxies stay in the keg and come from `/opt/homebrew/opt/rustup/bin`, which `zsh/.zshrc` puts ahead of `~/.cargo/bin`.

## Decisions

- **Homebrew's rustup, not the standalone one.** Both machines already declare `brew:rustup` in `mise.toml`, and `dotup` keeps it upgraded. The standalone install updates itself separately and duplicates it. Both use `~/.rustup`, so the toolchains stay.
- **Remove the mise rust install by hand.** `mise uninstall rust` and `mise prune` act through the rust backend, and with the install pointing at `~/.cargo/bin` it's unclear what they would delete. Removing the `installs/rust` symlink and reshimming touches only mise's own state. During the sync, `mise prune` was skipped for this reason, and only `cargo:tree-sitter-cli` was uninstalled.
- **Delete binaries individually, keep `~/.cargo`.** `~/.cargo/bin` stays on PATH for future `cargo install` output, and `~/.cargo/registry` is shared cache. `rustup self uninstall` is rejected because it deletes `~/.rustup` toolchains as well.
- **Drop pipx copies; use `uv tool` only for undeclared tools.** `machine-bootstrap` already bans pipx. mise declares `poetry`, `prek`, and `pipx:pytest`, so the pipx and `uv tool` copies of those are just removed. pynvim, which neovim's python provider needs and nothing declares, moves to `uv tool`.
- **Adopting a cask needs the user's terminal.** `brew install --cask --adopt` runs `sudo chgrp`/`chmod` on the app, and an agent can't enter the password; a failed adopt rolls back and leaves the app intact. Running the adopt while the app is open gives `Operation not permitted` on caches it holds (VS Code's `node-compile-cache`). Brew still recorded the cask, and the signature verified.

## Risks / Trade-offs

- [Removing the standalone proxies leaves `cargo` unresolved until brew's are linked] → `brew:rustup` is already linked; check `which cargo` right after.
- [Something hard-codes `~/.cargo/bin/cargo`] → rust-analyzer and editors resolve through PATH; check that neovim and VS Code rust-analyzer still start.
- [Uninstalling Homebrew zig or ruby breaks a project not using mise] → mise declares both (`zig 0.15` personal, `ruby 3.4` shared); `brew uses --installed` shows no dependents.
- [CleanShot 5 license] → the sync force-upgraded CleanShot from 4.8.8 to 5.0.2. A 4.8.8 copy was saved to the session scratchpad, which is temporary; confirm the license promptly.
