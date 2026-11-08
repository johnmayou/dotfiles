# Proposal

## Why

`git/.gitconfig` is linked on both machines and sets the personal email, so commits in work repos on the work laptop are authored with it. This repo is public, so neither the work email nor the work GitHub org can go in it.

## What Changes

- Add `[include] path = ~/.gitconfig.local` to `git/.gitconfig`. Git ignores the include when the file is absent, so the personal machine is unaffected.
- On the SPS machine, untracked `~/.gitconfig.local` holds an `includeIf "hasconfig:remote.*.url:..."` block matching the work GitHub org, which sets the work `user.email`.
- README notes creating `~/.gitconfig.local` on SPS machines, without naming the org.

## Capabilities

### New Capabilities

### Modified Capabilities
- `secrets`: extend "no work details in the public repo" to the work git identity.

## Impact

- `git/.gitconfig`, README. Local-only: `~/.gitconfig.local`.
