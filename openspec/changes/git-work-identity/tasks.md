# Tasks

## 1. Identity

- [ ] 1.1 Create untracked `~/.gitconfig.local` with the `includeIf hasconfig:remote` block and work `user.email` (ask user for the values). Verify: file exists outside the repo.
- [ ] 1.2 Add `[include] path = ~/.gitconfig.local` to `git/.gitconfig`. Verify: both scenarios in the spec delta print the expected email.
- [ ] 1.3 Note `~/.gitconfig.local` under "SPS machines" in README, without naming the org.
