# Spec Delta

## ADDED Requirements

### Requirement: Third-party skills load and are reproducible
Each wanted third-party skill SHALL be available in Claude sessions, and its source SHALL be recorded in the repo so bootstrap or plugin sync restores it.

#### Scenario: Skill available
- **WHEN** a Claude session starts
- **THEN** each wanted third-party skill appears in the skills list

#### Scenario: New machine
- **WHEN** bootstrapping a fresh machine
- **THEN** the third-party skills come back without manual installs
