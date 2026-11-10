# Agent Instructions

## Working Style

- Default to acting on code and the local environment: edits, tests, local git. Ask only for genuine scope changes or hard-to-reverse decisions.
- Never communicate through external systems unless explicitly asked in the current session. That covers PR and issue comments, review replies, and messages. Prior approval of a similar action does not count.
- End every PR or issue comment, review reply, and message you post with `_Written by Claude_` on its own line, so readers know it didn't come from me directly.
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
- SPS pipelines release from commit messages: `SemanticRelease@1` runs with `failOnNoVersion: true` and the default Conventional Commits preset, so a merge with no releasable commit fails the build and deploys nothing. Start every commit headline with `fix:` or `feat:` (optionally `fix(scope):`, e.g. `fix(DA-2995):`), with `!` or a `BREAKING CHANGE:` footer for a major. `chore:`, `docs:`, `style:`, `refactor:`, `build:`, or a ticket-first headline like `DA-2995(fix):` release nothing; `DA-2995(fix):` doesn't even parse. Use `fix:` for dependency, CVE, and docs-only changes that must ship. Mirror the same prefix in the PR title, since squash merges use it. Check with `git log --format=%s origin/HEAD..HEAD` before pushing. Docs: https://developer.docs.spscommerce.com/platform/building-deploying/azure-pipelines/tasks/artifact-versioning-tasks#semanticrelease
- The diff shows what changed, so a non-trivial commit body covers intent and why this approach: the problem, alternatives rejected, and invariants to preserve. A mechanical change gets one line.
- Never use a repo's `pull_request_template` in repos our team owns: SPSCommerce repos where `corporate-systems`, `data-solutions`, or `entai` has admin (`gh api repos/SPSCommerce/<repo>/teams`). Those templates are the stale org default. Write the body in the fallback shape from `pr-create-auto` instead: the Jira link on the first line, then the prose, then a `## Testing` checklist of every verification, with pre-merge checks ticked once proven and post-merge checks (pipeline, ECR, test and prod deploys) left open. This overrides the skill's "template wins" rule. Other teams' repos still get their template.

## Generated Files

Store generated plans, specs, reviews, and mockups in `.notes/`. Create it if missing.

## Tools

- Runtimes and CLI tools come from mise. Rust comes from rustup, because a mise-managed rust overrides `rust-toolchain.toml`.
- Prefer a repository's justfile, Makefile, or mise tasks over direct commands.
- Prefer `ghissues` over `gh issue list`, and `ghcomments` over raw `gh` for PR feedback.
- When the user asks to see a diff ("show diff"), open it in Plannotator's code review UI instead of printing it in chat.
