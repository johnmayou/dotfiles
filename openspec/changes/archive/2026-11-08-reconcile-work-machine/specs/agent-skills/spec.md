# Spec Delta

## Purpose

Defines the shared agent skill set in `.ai/skills`, how it reaches `~/.claude/skills`, and how it coexists with skills the repo doesn't own.

## ADDED Requirements

### Requirement: Skills linked per entry
`~/.claude/skills` SHALL be a real directory whose repo skill files are individual symlinks into `.ai/skills` (`mode = "symlink-each"`).

#### Scenario: Repo skills linked
- **WHEN** listing symlinks under `~/.claude/skills`
- **THEN** every file in `.ai/skills` has a link, and none is broken

### Requirement: Org skills sync and stay untracked
Claude's org skill sync SHALL stay enabled (no `syncClaudeAiSkills: false`), and synced skills SHALL live only in `~/.claude/skills/synced/`, never in the repo.

#### Scenario: SPS org skills available
- **WHEN** a Claude session starts on the SPS machine
- **THEN** SPS org skills such as `sps-jira-fields` are available, and `git ls-files` lists nothing from `synced/`
