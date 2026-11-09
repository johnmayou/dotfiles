# Spec Delta

## ADDED Requirements

### Requirement: One install per declared tool
Each tool declared in the repo SHALL resolve on PATH to the copy its declaring manager installed. No other copy of the tool SHALL exist from `cargo install`, a standalone installer, or another package manager.

#### Scenario: Brew-declared tool
- **WHEN** running `which -a tree-sitter` in a login shell
- **THEN** only `/opt/homebrew/bin/tree-sitter` is listed

#### Scenario: mise-declared cargo tool
- **WHEN** running `cargo install --list`
- **THEN** no tool declared as `cargo:<name>` in `.config/mise/*.toml` is listed

### Requirement: Rustup from Homebrew
The only rustup SHALL be the `brew:rustup` package declared in `mise.toml`, linked into `/opt/homebrew/bin`. Toolchains SHALL stay in `~/.rustup`. Neither mise nor a standalone installer SHALL provide `rustup` or its `cargo`/`rustc` proxies.

#### Scenario: rustup on PATH
- **WHEN** running `which -a rustup cargo rustc` in a login shell
- **THEN** each resolves only under `/opt/homebrew/bin`

#### Scenario: Toolchain pins still apply
- **WHEN** running `rustc --version` in a directory with a `rust-toolchain.toml`
- **THEN** the pinned toolchain runs

### Requirement: No undeclared mise installs
Every tool mise has installed SHALL be declared by a tracked mise config, so `mise prune` removes nothing.

#### Scenario: Prune is a no-op
- **WHEN** running `mise prune --dry-run`
- **THEN** no tool is reported as prunable
