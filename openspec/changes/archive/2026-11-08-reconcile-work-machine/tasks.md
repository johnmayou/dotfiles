# Tasks

## 1. Config

- [x] 1.1 Back up every link target. Verify: tarball in `~/.dotfiles-backups/`.
- [x] 1.2 Merge live VS Code, Claude, mise, and glow config into the repo; split work-only VS Code extensions. Verify: JSONC parses; no credentials in diff.
- [x] 1.3 Switch `~/.claude/skills` to `symlink-each` and drop `syncClaudeAiSkills: false`.
- [x] 1.4 Move npm and uv tokens to untracked files pointed to from `mise.sps.toml`. Verify: `npm whoami` against the work registry succeeds.

## 2. Packages

- [x] 2.1 Sort brew installs into shared, SPS, and personal lists; move MDM-owned casks to personal.
- [x] 2.2 Remove brew runtime duplicates and one-off formulae; Rust from rustup, Ruby from mise.
- [x] 2.3 Adopt or force-install hand-installed apps. Verify: `mise bootstrap packages status` shows all installed.

## 3. Link

- [x] 3.1 Stamp `sps`, move aside conflicting files, apply links. Verify: `mise bootstrap dotfiles status` shows 23 entries up to date.
- [x] 3.2 Document SPS bootstrap steps in README.
