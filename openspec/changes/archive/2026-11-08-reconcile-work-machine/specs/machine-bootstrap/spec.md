# Spec Delta

## Purpose

Defines what `mise bootstrap` provisions on each machine: links, packages, runtimes, and apps, and how existing installs come under management.

## ADDED Requirements

### Requirement: Packages declared per machine
Packages needed on every machine SHALL be declared in `mise.toml`. Packages for one machine SHALL be declared in `mise.<env>.toml`, loaded via the `MISE_ENV` that `mise run stamp` pins in `~/.config/mise/miserc.toml`.

#### Scenario: Status on a stamped machine
- **WHEN** `GITHUB_TOKEN=$(gh auth token) mise bootstrap packages status` runs
- **THEN** every declared package shows installed

### Requirement: MDM-managed apps not declared for SPS
Apps that the work MDM installs and updates on the SPS machine SHALL NOT be declared in `mise.toml` or `mise.sps.toml`.

#### Scenario: MDM app on the SPS machine
- **WHEN** an app in `/Applications` is root-owned with an MDM install receipt in `pkgutil --pkgs`
- **THEN** it is absent from the shared and SPS package lists

### Requirement: Runtimes from mise or rustup only
Language runtimes and their package managers SHALL come from mise, except Rust, which SHALL come from rustup. Homebrew SHALL NOT install them on request; a runtime brew pulls in as another formula's dependency is allowed.

#### Scenario: No brew runtime duplicates
- **WHEN** running `brew leaves --installed-on-request`
- **THEN** none of go, node, python, uv, zig, ruby, rust, pyenv, fnm, or pipx is listed

### Requirement: Existing apps brought under brew once
An app installed before bootstrap SHALL be handed to Homebrew once: `brew install --cask --adopt` when its version matches the cask, `--force` when older.

#### Scenario: Hand-installed app at cask version
- **WHEN** `/Applications/<App>.app` exists at the cask's version and brew doesn't own it
- **THEN** `brew install --cask --adopt <cask>` records it without replacing it

### Requirement: Live config merged before linking
Before a link replaces an existing file, the file's content SHALL be merged into the repo and the file backed up and moved aside.

#### Scenario: Link target already exists
- **WHEN** `mise bootstrap dotfiles status` reports `exists but is not a symlink`
- **THEN** the file is merged into its repo source, moved to `~/.dotfiles-backups/`, and only then linked
