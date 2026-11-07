# Design

## Context

Agents already know stability patterns (timeouts, circuit breakers, bulkheads, steady state). The gap is application, not knowledge. Skills in `.ai/skills` cost context only when invoked; `.ai/AGENTS.md` costs context every session.

## Goals / Non-Goals

**Goals:**
- A review skill whose every check changes agent output on real diffs.
- A repeatable loop from reading a chapter to adding (or not adding) a check.

**Non-Goals:**
- Chapter summaries or book notes as agent context.
- One skill per book.
- Auto-invocation; the skill runs when asked (`disable-model-invocation: true`).

## Decisions

- **Organize by task, not by book.** `stability-review` can take checks from *Release It!* and later books. Alternative (per-book skills) rejected: duplicates overlap, agent must pick a book.
- **Earn each check.** Workflow per chapter: read → audit one real work service against the chapter → findings the agent missed when run without the skill become checks. A check the agent already catches unaided is deleted. A chapter with no real finding yields no rule.
- **Concrete over principle.** "Every outbound call has a timeout and a bounded retry" beats "beware cascading failures".
- **Context belongs in checks.** Team-specific integrations, timeout defaults, and past incidents are the highest-value content.

## Risks / Trade-offs

- [Note-taking feels like progress without changing output] → the "no finding, no rule" gate.
- [Work-specific details in a public dotfiles repo] → keep checks generic in wording; keep sensitive incident details in work-side notes, not this repo.
