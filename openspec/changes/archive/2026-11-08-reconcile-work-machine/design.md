# Design

## Context

`mise bootstrap` links whole files and installs declared packages. It refuses to replace an existing real file and can't install a cask over an app it didn't install. VS Code settings have no include mechanism, and Claude writes synced org skills into `~/.claude/skills/synced/`.

## Decisions

- **Merge before link.** Each live file was classified: empty repo placeholder → take live; both differ → union by hand; holds credentials → keep out. Alternative (link first, fix later) rejected: links would overwrite live config.
- **VS Code settings as a union.** No key had conflicting values; work-only keys are inert where their extension is absent. Work-only extensions live in `extensions.sps.txt` with a `vscode-extensions-sps` task.
- **`symlink-each` for `~/.claude/skills`.** A whole-directory link would make Claude and the plannotator installer write into the repo, and would hide `synced/`.
- **The work MDM owns its apps.** Apps it installs are root-owned with MDM receipts on the SPS Mac. Declaring them as casks there would fight MDM updates, so shared casks the MDM also installs are personal-only.
- **Tokens via env-pointed files.** `NPM_CONFIG_GLOBALCONFIG` and `UV_CONFIG_FILE` in `mise.sps.toml` point at untracked chmod-600 files. Alternative (`${VAR}` in tracked config) rejected: npm errors on unset vars on the personal Mac. Trade-off: `UV_CONFIG_FILE` replaces the shared `uv.toml`, so its `exclude-newer` doesn't apply at work.
- **Adopt or force once.** Hand-installed apps matching the cask version use `brew install --cask --adopt`; older ones use `--force`. Not part of bootstrap: once brew owns an app, `dotsync`/`dotup` maintain it.

## Risks / Trade-offs

- [Apps write to linked settings] → changes show as repo diffs; commit or revert them.
- [Private tap needs auth] → mise package commands run with `GITHUB_TOKEN=$(gh auth token)`.
