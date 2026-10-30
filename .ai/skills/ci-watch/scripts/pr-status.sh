#!/usr/bin/env bash
# pr-status.sh — Report PR status as JSON for ci-watch skill
#
# Usage: pr-status.sh [PR_NUMBER]
#   PR_NUMBER  optional; defaults to current branch's open PR
#
# Output: JSON matching the ci-watch schema

set -euo pipefail

# ---------------------------------------------------------------------------
# Helpers
# ---------------------------------------------------------------------------

die() { echo "pr-status.sh error: $*" >&2; exit 1; }

# Emit a "no PR found" JSON and exit cleanly
no_pr_json() {
  local forge="$1"
  printf '{"forge":"%s","pr_number":0,"pr_title":"","pr_state":"no_pr","ci_status":"unknown","failing_checks":[],"review_comments":[],"action_needed":"none"}\n' "$forge"
  exit 0
}

FORGE="github"

# ---------------------------------------------------------------------------
# Determine PR number
# ---------------------------------------------------------------------------

PR_NUMBER="${1:-}"

if [[ -z "$PR_NUMBER" ]]; then
  PR_NUMBER=$(gh pr view --json number --jq '.number' 2>/dev/null) || no_pr_json "github"
fi

[[ -z "$PR_NUMBER" ]] && no_pr_json "github"

# PR metadata (include HEAD SHA so we can scope CI checks to the current commit)
PR_JSON=$(gh pr view "$PR_NUMBER" \
  --json number,title,headRefName,headRefOid,state \
  2>/dev/null) || no_pr_json "github"

PR_TITLE=$(echo "$PR_JSON" | jq -r '.title // ""')
PR_STATE=$(echo "$PR_JSON" | jq -r '.state // "unknown"' | tr '[:upper:]' '[:lower:]')
HEAD_REF=$(echo "$PR_JSON" | jq -r '.headRefName // ""')
HEAD_SHA=$(echo "$PR_JSON" | jq -r '.headRefOid // ""')

# Map GitHub states to our schema (MERGED → merged, OPEN → open, CLOSED → closed)
case "$PR_STATE" in
  merged) PR_STATE="merged" ;;
  closed) PR_STATE="closed" ;;
  *)      PR_STATE="open" ;;
esac

# CI status from workflow runs scoped to HEAD commit.
# statusCheckRollup is NOT used: it aggregates the latest check per name across
# ALL commits on the branch, so after a push it mixes old failures with new
# queued runs and cannot be trusted to reflect the current commit's state.
CI_STATUS="unknown"
FAILING_CHECKS_JSON="[]"

if [[ -n "$HEAD_SHA" && -n "$HEAD_REF" ]]; then
  RUNS_JSON=$({ gh run list \
    --branch "$HEAD_REF" \
    --limit 50 \
    --json headSha,status,conclusion,name,url \
    2>/dev/null || true; } \
    | jq --arg sha "$HEAD_SHA" '[.[] | select(.headSha == $sha)]' \
    2>/dev/null || echo "[]")

  RUN_COUNT=$(echo "$RUNS_JSON" | jq 'length' 2>/dev/null || echo 0)

  if [[ "$RUN_COUNT" -gt 0 ]]; then
    HAS_FAILURE=$(echo "$RUNS_JSON" | jq '
      any(.status == "completed" and (
        .conclusion == "failure" or .conclusion == "timed_out" or
        .conclusion == "cancelled" or .conclusion == "action_required" or
        .conclusion == "startup_failure"
      ))
    ' 2>/dev/null || echo "false")
    HAS_PENDING=$(echo "$RUNS_JSON" | jq 'any(.status != "completed")' 2>/dev/null || echo "false")

    if [[ "$HAS_FAILURE" == "true" ]]; then
      CI_STATUS="fail"
    elif [[ "$HAS_PENDING" == "true" ]]; then
      CI_STATUS="pending"
    else
      CI_STATUS="pass"
    fi
  fi
fi

# Failing checks with job-level detail via gh pr checks (only fetched on failure)
if [[ "$CI_STATUS" == "fail" ]]; then
  # gh pr checks outputs TSV: name \t state \t elapsed \t link
  FAILING_CHECKS_JSON=$({ gh pr checks "$PR_NUMBER" 2>/dev/null || true; } \
    | awk -F'\t' '$2 ~ /^(fail|error|FAIL|ERROR)/' \
    | jq -Rn '
        [inputs | split("\t") | select(length >= 4) | {"name": .[0], "url": .[3]}]
      ' 2>/dev/null || echo "[]")
fi

# Review comments (inline, unresolved threads only).
# Use GraphQL because the REST /pulls/{n}/comments endpoint has no concept of
# resolved threads — it returns every inline comment forever, even after the
# author or maintainer marks the conversation resolved. That makes the loop
# spin on stale comments. reviewThreads.isResolved is the authoritative bit.
OWNER_REPO=$(gh repo view --json nameWithOwner --jq '.nameWithOwner' 2>/dev/null || echo "")
REVIEW_COMMENTS_JSON="[]"

if [[ -n "$OWNER_REPO" ]]; then
  OWNER="${OWNER_REPO%%/*}"
  REPO="${OWNER_REPO##*/}"

  REVIEW_COMMENTS_JSON=$(gh api graphql \
    -f query='query($owner:String!,$repo:String!,$number:Int!){repository(owner:$owner,name:$repo){pullRequest(number:$number){reviewThreads(first:100){nodes{isResolved,comments(first:1){nodes{path,line,originalLine,body,author{login}}}}}}}}' \
    -F owner="$OWNER" -F repo="$REPO" -F number="$PR_NUMBER" 2>/dev/null \
    | jq '[.data.repository.pullRequest.reviewThreads.nodes[]
            | select(.isResolved == false)
            | .comments.nodes[0]
            | {file: .path, line: (.line // .originalLine // 0), body: .body, author: .author.login}]' \
    2>/dev/null || echo "[]")

  # Top-level reviews — check for CHANGES_REQUESTED
  CHANGES_REQUESTED=$(gh api "repos/${OWNER_REPO}/pulls/${PR_NUMBER}/reviews" \
    --paginate 2>/dev/null \
    | jq '[.[] | select(.state == "CHANGES_REQUESTED") | {file: "", line: 0, body: .body, author: .user.login}]' \
    2>/dev/null || echo "[]")

  # Merge inline comments + CHANGES_REQUESTED reviews into one list
  REVIEW_COMMENTS_JSON=$(jq -n \
    --argjson inline "$REVIEW_COMMENTS_JSON" \
    --argjson reviews "$CHANGES_REQUESTED" \
    '$inline + $reviews')
fi

# ---------------------------------------------------------------------------
# action_needed logic
# ---------------------------------------------------------------------------

HAS_FAILING=$(echo "$FAILING_CHECKS_JSON" | jq 'length > 0' 2>/dev/null || echo "false")
HAS_COMMENTS=$(echo "$REVIEW_COMMENTS_JSON" | jq 'length > 0' 2>/dev/null || echo "false")

if [[ "$CI_STATUS" == "fail" ]] || [[ "$HAS_FAILING" == "true" ]]; then
  ACTION_NEEDED="ci"
elif [[ "$HAS_COMMENTS" == "true" ]]; then
  ACTION_NEEDED="comments"
elif [[ "$CI_STATUS" == "pending" || "$CI_STATUS" == "unknown" ]]; then
  ACTION_NEEDED="wait"
else
  ACTION_NEEDED="none"
fi

# ---------------------------------------------------------------------------
# Emit JSON
# ---------------------------------------------------------------------------

jq -n \
  --arg forge "$FORGE" \
  --argjson pr_number "$PR_NUMBER" \
  --arg pr_title "$PR_TITLE" \
  --arg pr_state "$PR_STATE" \
  --arg ci_status "$CI_STATUS" \
  --argjson failing_checks "$FAILING_CHECKS_JSON" \
  --argjson review_comments "$REVIEW_COMMENTS_JSON" \
  --arg action_needed "$ACTION_NEEDED" \
  '{
    forge: $forge,
    pr_number: $pr_number,
    pr_title: $pr_title,
    pr_state: $pr_state,
    ci_status: $ci_status,
    failing_checks: $failing_checks,
    review_comments: $review_comments,
    action_needed: $action_needed
  }'
