# Spec Delta

## Purpose

On-demand review of a code diff for production-stability risks, using concrete checks that were each validated against real code.

## ADDED Requirements

### Requirement: Invoked only on request
The skill SHALL run only when the user invokes it and SHALL NOT load automatically.

#### Scenario: Normal session
- **WHEN** a session starts without the user invoking `stability-review`
- **THEN** none of its content is in agent context

### Requirement: Reviews a diff against concrete checks
The skill SHALL review the current diff (or a given target) and report each violated check with file and line.

#### Scenario: Missing timeout
- **WHEN** the diff adds an outbound network call without a timeout
- **THEN** the review reports it with location and the check it violates

#### Scenario: Clean diff
- **WHEN** no check is violated
- **THEN** the review says so and reports nothing else

### Requirement: Every check is earned
Each check SHALL trace to a real finding the agent missed without the skill, and SHALL be removed if the agent catches the issue unaided.

#### Scenario: Redundant check
- **WHEN** running the agent without the skill on a diff already catches the issue a check targets
- **THEN** that check is deleted
