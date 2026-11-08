# Proposal

## Why

Plannotator is installed twice. mise installs it from `github:backnotprop/plannotator` (0.28.51), and the upstream install script put another copy in `~/.local/bin/plannotator` (0.28.54), which comes first on PATH. So the mise-tracked version never runs. The install script also writes its stock skills into `~/.claude/skills` and `~/.agents/skills`, outside the repo.

## What Changes

- Keep one binary: the mise-managed one. Remove `~/.local/bin/plannotator`.
- Decide where the stock skills (`plannotator`, `plannotator-annotate`, `plannotator-inbox`, `plannotator-review`) come from without the install script: vendor them into `.ai/skills`, or let the plugin provide them if it does. The repo's adapted `plannotator-last` stays.
- Remove the install script's copies in `~/.agents/skills`.

## Capabilities

### New Capabilities

### Modified Capabilities
- `agent-skills`: plannotator's skills come from the repo or the plugin, not the install script.

## Impact

- `.ai/skills/` (if vendored), `~/.local/bin/plannotator`, `~/.claude/skills/plannotator*`, `~/.agents/skills/plannotator*`.
