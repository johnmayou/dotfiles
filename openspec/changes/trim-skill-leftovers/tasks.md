# Tasks

## 1. Trim

- [ ] 1.1 Remove Gitea/Forgejo text from `pr-create-auto`, `diff-review`, `init-simplified-english-contrib`. Verify: `grep -rni 'gitea\|forgejo' .ai/skills` empty.
- [ ] 1.2 Remove Pi/Codex branches from `plannotator-last` script. Verify: `grep -rni 'codex\|\bpi\b' .ai/skills/plannotator-last` empty; script still runs for Claude Code.
- [ ] 1.3 Diff review with user before commit.
