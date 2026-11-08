# Proposal

## Why

The repo was built mostly on the personal Mac. The SPS laptop had drifted: real config files where links belonged, empty repo placeholders that would have overwritten live config, registry tokens inside files the repo links, brew copies of runtimes mise already manages, and apps installed by hand or by the work MDM. Running `mise bootstrap` as-is would have lost config and fought the MDM.

## What Changes

- Merge the SPS machine's live config into the repo before linking; back up and move aside every file a link replaces.
- Split packages into shared (`mise.toml`), `mise.sps.toml`, and `mise.personal.toml`. MDM-owned apps stay out of the SPS lists.
- Remove brew duplicates of mise- and rustup-managed runtimes.
- Link `~/.claude/skills` per entry so Claude's synced org skills and installer-managed skills coexist with repo skills; keep org skill sync on.
- Keep registry tokens in untracked files that only `mise.sps.toml` points to.
- Track the `openspec` CLI as a shared mise tool.

## Capabilities

### New Capabilities
- `machine-bootstrap`: how packages, runtimes, and apps are declared per machine and brought under management.
- `agent-skills`: how skills reach `~/.claude/skills` alongside skills the repo doesn't own.
- `secrets`: where credentials live, and that linked config never holds them.

### Modified Capabilities

## Impact

- `mise.toml`, `mise.sps.toml`, `mise.personal.toml`, `.config/mise/*.toml`, `.config/vscode/*`, `.claude/settings.json`, README.
- Local-only: `~/.config/npm/sps.npmrc`, `~/.config/uv/uv.sps.toml`, `~/.dotfiles-backups/`.
