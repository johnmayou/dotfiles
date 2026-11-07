# Proposal

## Why

Reading engineering books (starting with *Release It!*) should make agents better at reviewing real work code. Summaries of a book add nothing because the model already knows the material; what it lacks is applying it unprompted to this codebase and this team's failure history.

## What Changes

- Keep personal reading notes outside the skills tree (Obsidian), never loaded into agent context.
- Add a task-shaped review skill, `stability-review`, run on a diff on request. Books feed it; it is not one skill per book.
- Each rule in the skill is a concrete, checkable item (e.g. "every outbound HTTP call sets a timeout"), sourced from a finding in real code.
- Nothing from this goes into `.ai/AGENTS.md`, which loads every session.

## Capabilities

### New Capabilities
- `stability-review`: on-demand review of a diff for production-stability risks, using checks distilled from reading plus real findings.

### Modified Capabilities

## Impact

- New `.ai/skills/stability-review/` (linked to `~/.claude/skills` via existing mise dotfile entry).
- No change to always-loaded instructions.
