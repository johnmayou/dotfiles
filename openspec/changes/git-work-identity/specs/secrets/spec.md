# Spec Delta

## ADDED Requirements

### Requirement: Work git identity outside the repo
Commits in work repos SHALL use the work email. The email and the rule that matches work remotes SHALL live only in untracked `~/.gitconfig.local`; tracked files SHALL contain neither.

#### Scenario: Commit in a work repo
- **WHEN** running `git config user.email` inside a repo with a work-org remote
- **THEN** it prints the work email from `~/.gitconfig.local`

#### Scenario: Commit in a personal repo
- **WHEN** running `git config user.email` inside this dotfiles repo
- **THEN** it prints the personal email
