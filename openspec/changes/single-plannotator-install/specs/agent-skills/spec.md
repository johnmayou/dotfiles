# Spec Delta

## ADDED Requirements

### Requirement: One plannotator install
The `plannotator` binary on PATH SHALL be the mise-managed one, and plannotator skills SHALL come from `.ai/skills` or the plannotator plugin, not from its install script.

#### Scenario: Binary on PATH
- **WHEN** running `command -v plannotator` in a login shell
- **THEN** the path is under `~/.local/share/mise/installs/`

#### Scenario: Skills present without the installer
- **WHEN** listing `~/.claude/skills`
- **THEN** each plannotator skill is a symlink into `.ai/skills` or absent because the plugin provides it
