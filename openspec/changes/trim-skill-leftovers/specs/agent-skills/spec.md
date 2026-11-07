# Spec Delta

## Purpose

Defines the shared agent skill set in `.ai/skills`, linked to `~/.claude/skills`, and which tools and hosts it may reference.

## ADDED Requirements

### Requirement: Skills reference only tools in use
Skills SHALL reference only hosts and agent tools the user uses: GitHub, Claude Code, Plannotator, mise. They SHALL NOT reference Gitea/Forgejo, Hive, Pi, Codex, or mmdot.

#### Scenario: Grep for unused tools
- **WHEN** searching `.ai/skills` for `gitea`, `forgejo`, `hive`, `mmdot`, `codex`, or Pi-specific paths
- **THEN** no matches are found
