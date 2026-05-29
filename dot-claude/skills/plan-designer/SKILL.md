---
name: plan-designer
description: >-
  Design a task implementation plan from a Jira ticket or GitHub issue. Pulls
  the ticket/issue details (Atlassian MCP for Jira, gh CLI for GitHub), analyzes
  the codebase, agrees on an approach with the user, then writes a structured
  implementation plan (including test coverage and a final test run) to
  .claude/plans/<IDENTIFIER>/. Use when the user wants to plan, scope, or design
  an implementation for a ticket/issue (e.g. "/plan-designer LPP-123",
  "plan out issue 456", "design an implementation plan for this branch").
---

# Plan Designer

Turn a tracker item into an agreed, test-aware implementation plan stored in the
repo. The flow is deliberately **collaborative** — do not skip ahead to writing
the plan before the approach is agreed.

## 0. Resolve the identifier

Determine what to plan for, in this order:

1. **Explicit argument** the user passed (e.g. `LPP-123`, `PROJ-7`, `456`, `#456`).
2. **Branch fallback** — if no argument, read the current branch
   (`git rev-parse --abbrev-ref HEAD`) and extract a Jira-style tag
   (`[A-Za-z]+-[0-9]+`) from it.
3. If neither yields an identifier, ask the user which ticket/issue to plan.

**Classify the identifier by pattern:**

| Pattern | Source |
| --- | --- |
| `LETTERS-DIGITS` (e.g. `LPP-123`, `PROJ-7`) | **Jira** → Atlassian MCP |
| bare digits, optionally `#`-prefixed (e.g. `456`, `#456`) | **GitHub** → `gh` CLI |

Normalize the identifier (uppercase Jira tags; strip a leading `#` from GitHub
numbers). The normalized identifier is used for the plan directory name later.

## 1. Fetch details (and, for Jira, move to In Progress)

### Jira (Atlassian MCP)

1. Get the cloud id via `getAccessibleAtlassianResources` (cache/reuse it).
2. Fetch the issue with `getJiraIssue` (summary, description, acceptance
   criteria, comments, linked issues, labels).
3. **Move to "In Progress":** call `getTransitionsForJiraIssue`, find the
   transition whose target status is `In Progress`. If the issue is not already
   in that status, apply it with `transitionJiraIssue`. If no such transition is
   available, note it and continue (do not block planning).

### GitHub (`gh` CLI)

1. Fetch the issue:
   `gh issue view <number> --json number,title,body,labels,assignees,comments,url`
2. **Do not** change the issue's status, labels, or assignment — GitHub issues
   are read-only context for this skill.

If the fetch fails (auth, missing MCP, unknown id), report the exact error and
stop — do not guess at ticket contents.

## 2. Understand the work

- Read the ticket/issue fully, including acceptance criteria and comments.
- Analyze the codebase to ground the request in real files: locate the modules,
  patterns, and tests the change will touch. Use search/Explore liberally.
- Form a concrete mental model of the change and where it lands.

## 3. Align on approach (do not skip)

Surface clarifying and architectural questions **before** writing the plan. Use
the `AskUserQuestion` tool for crisp, decision-shaping choices (data model,
boundaries, edge cases, scope cuts, trade-offs). Iterate until the user and you
agree on the approach. If there are genuinely no open questions, briefly state
the approach and confirm it before proceeding.

## 4. Determine the test command

The plan must conclude with a full test run. Resolve the command in this order:

1. Read the project's `CLAUDE.md` (repo root, then `.claude/CLAUDE.md`) for the
   documented test command(s) — prefer one that runs unit + integration + e2e.
2. Fall back to `npm test` if `CLAUDE.md` documents nothing.

Record the resolved command in the plan so the final step is unambiguous.

## 5. Write the plan

Create `.claude/plans/<IDENTIFIER>/plan.md` (project-local `.claude`, not the
global one). Use the normalized identifier as the subdirectory:
- Jira → the tag, e.g. `.claude/plans/LPP-123/plan.md`
- GitHub → `issue-<number>`, e.g. `.claude/plans/issue-456/plan.md`

Use this structure:

```markdown
# <IDENTIFIER>: <title>

> Source: <Jira/GitHub link> · Status: In Progress
> Test command: <resolved command>

## Summary
What the ticket asks for, in your own words.

## Context & affected areas
Key files/modules/patterns this change touches (with paths).

## Agreed approach
The approach settled on in step 3, including decisions made and alternatives
rejected (and why).

## Implementation steps
Ordered, concrete steps. Each step names the files involved and the change.

## Test plan
- **Unit tests:** what to add/extend, where.
- **e2e tests:** what to add/extend, where.
- (Integration tests if applicable.)

## Verification
Conclude by running the full suite: `<resolved command>`
(unit + integration + e2e). The task is not done until this passes.

## Open questions / risks
Anything still uncertain.
```

The plan **must** explicitly include unit test coverage, e2e test coverage, and
a concluding full test run using the resolved command.

## 6. Await feedback

After writing the plan, summarize it briefly, give the file path, and **stop** —
wait for the user's feedback before implementing anything. This skill produces a
plan; it does not execute it.
