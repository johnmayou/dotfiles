# Tasks

## 1. Reading loop

- [ ] 1.1 Read a *Release It!* chapter; keep notes in Obsidian, not this repo. Verify: no new files under `.ai/` from notes.
- [ ] 1.2 Audit one real work service against that chapter; list findings. Verify: written findings list exists.
- [ ] 1.3 Run an agent review without any skill on the relevant diff/code; mark which findings it missed. Verify: missed-findings list.

## 2. Skill

- [ ] 2.1 Create `.ai/skills/stability-review/SKILL.md` with `disable-model-invocation: true` and only the missed findings as concrete checks. Verify: skill appears in `~/.claude/skills` and does not auto-trigger.
- [ ] 2.2 Run the skill on the same diff; confirm it reports the previously missed findings. Verify: review output lists them.
- [ ] 2.3 Repeat 1.1–2.2 per chapter; delete checks the agent catches unaided.
