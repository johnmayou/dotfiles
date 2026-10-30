---
name: doc-review
description: >
  Open a plan, research, or design doc in Plannotator's browser UI for human
  review and act on the returned annotations. Use when the user says "review the
  plan", "open the doc in plannotator", "let me annotate the research", "review
  the latest doc", or returns to a session to gate work the agent produced.
allowed-tools: "Bash(plannotator:*),Bash(ls:*),Bash(find:*),Bash(stat:*),Read"
disable-model-invocation: true
---

# Doc Review

Open a markdown document in Plannotator with `--gate`, then act on the user's
annotations in the same conversation. The `--gate` flag blocks until the user
approves or denies, and returns their feedback as command output.

## Argument handling

`$ARGUMENTS` controls which doc opens:

| Argument      | Behavior                                                                    |
| ------------- | --------------------------------------------------------------------------- |
| _empty_       | Newest `.md` under `.notes/`                                                |
| `specs`       | Newest `.md` in `.notes/specs/`                                             |
| `reviews`     | Newest `.md` in `.notes/reviews/`                                           |
| any path      | That file directly (relative to cwd or absolute)                            |
| any URL       | That URL (Plannotator handles `https://` natively)                          |

To find the newest file, use `find` with `stat` and pick the highest mtime.

If no candidate file is found, tell the user which directory was empty and stop.
Don't guess a path.

## Run

```bash
plannotator annotate <resolved-path-or-url> --gate
```

Don't ask the user to copy the command into a terminal — run it yourself.

## After plannotator returns

- **Annotations returned** — address each one in the same conversation. If the
  document needs edits, edit the file, summarize what changed, and offer to
  re-gate.
- **Approval / LGTM** — acknowledge briefly and continue with whatever the doc
  was setting up (implementation, next research question, etc.).
- **Denied with no actionable feedback** — ask the user what they'd like
  changed before re-gating.
- **Session closed without feedback** — say so in one sentence and continue.

## Notes

- `--gate` is the right mode for this skill; it's the synchronous review primitive.
- Plannotator returns its result on the same CLI invocation, so the agent sees
  the annotations in the next tool turn — no polling, no separate hook.
