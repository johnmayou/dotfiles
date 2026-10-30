# Agent Instructions

## Working Style

- Default to acting on code and the local environment: edits, tests, local git. Ask only for genuine scope changes or hard-to-reverse decisions.
- Never communicate through external systems unless explicitly asked in the current session. That covers PR and issue comments, review replies, and messages. Prior approval of a similar action does not count.
- Be direct. Evaluate suggestions on merit, not agreeableness.
- After completing work, state what changed, not anticipated benefits.
- Run formatters, linters, and tests after implementing.

## Project Notes

Before working in a repository, read `~/Projects/dotfiles/.ai/projects/<repo-name>.md` if it exists. Save project-specific instructions there.

## Architecture

- Prefer deleting obsolete code over keeping deprecation shims, versioned names, or "removed" comments, unless a public contract or the task requires compatibility.
- Add migration code only when persisted data, an existing contract, or the task requires it.

## Code Comments

Default to self-documenting code. A comment earns its place only when it carries information the code can't:

1. **Why**: non-obvious constraints, workarounds, and invariants.
2. **API docs**: follow the project's convention for anything consumed outside the codebase.
3. **Surprises**: code that looks wrong but is correct on purpose.

Never narrate the code, talk to the reviewer, or record what was removed. Git history has that.

## Git

- Do not include Claude attribution or co-author lines in commits or PRs.
- A clean Plannotator review means commit without asking. Pushing still needs an explicit request.
- Never bypass commit signing or hooks. Fix the underlying issue.
- Never @-mention users unless explicitly asked.
- The diff shows what changed, so a non-trivial commit body covers intent and why this approach: the problem, alternatives rejected, and invariants to preserve. A mechanical change gets one line.

## Generated Files

Store generated plans, specs, reviews, and mockups in `.notes/`. Create it if missing and add it to `.git/info/exclude`.

## Tools

- Runtimes and CLI tools come from mise. Rust comes from rustup, because a mise-managed rust overrides `rust-toolchain.toml`.
- Prefer a repository's justfile, Makefile, or mise tasks over direct commands.
