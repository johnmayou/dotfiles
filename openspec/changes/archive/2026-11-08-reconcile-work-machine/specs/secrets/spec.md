# Spec Delta

## Purpose

Defines where credentials live so linked config never holds them.

## ADDED Requirements

### Requirement: No credentials in tracked files
Tracked files SHALL NOT contain credentials, including files linked into the home directory.

#### Scenario: Scan the repo
- **WHEN** searching tracked files for auth tokens or credentials embedded in URLs
- **THEN** none are found

### Requirement: Work registry tokens in untracked files
On the SPS machine, npm and uv registry tokens SHALL live in `~/.config/npm/sps.npmrc` and `~/.config/uv/uv.sps.toml` (chmod 600, untracked), reached through `NPM_CONFIG_GLOBALCONFIG` and `UV_CONFIG_FILE` set in `mise.sps.toml`.

#### Scenario: Authenticated npm with shared config linked
- **WHEN** `~/.npmrc` links to the repo's token-free `.npmrc` and `npm whoami` runs against the work registry
- **THEN** it authenticates, and `min-release-age` from the shared file still applies
