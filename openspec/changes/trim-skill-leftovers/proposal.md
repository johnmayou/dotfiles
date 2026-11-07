# Proposal

## Why

Skills adapted from hay-kot/dotfiles still reference tools this user doesn't use (Gitea/Forgejo, Pi, Codex). Dead branches cost context and can mislead agents.

## What Changes

- Remove Gitea/Forgejo mentions from `pr-create-auto`, `diff-review`, `init-simplified-english-contrib`.
- Remove Pi/Codex code paths from `plannotator-last`'s script.
- Keep GitHub and Claude Code paths only.

## Capabilities

### New Capabilities
- `agent-skills`: the shared skill set linked to `~/.claude/skills`, and what it may reference.

### Modified Capabilities

## Impact

- `.ai/skills/{pr-create-auto,diff-review,init-simplified-english-contrib,plannotator-last}`.
