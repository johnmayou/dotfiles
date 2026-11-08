# Tasks

## 1. Decide

- [ ] 1.1 Ask the user whether `microsoft-foundry` is still wanted. If not, remove it and stop.
- [ ] 1.2 Check whether `microsoft/azure-skills` is available as a Claude plugin marketplace. Verify: marketplace repo has a plugin manifest, or doesn't.

## 2. Wire it

- [ ] 2.1 Plugin route: add marketplace and plugin to `.claude/settings.json`. Link route: add a `symlink-each` entry from `~/.agents/skills` into `~/.claude/skills` and track the lock file. Verify: skill shows in a new session.
