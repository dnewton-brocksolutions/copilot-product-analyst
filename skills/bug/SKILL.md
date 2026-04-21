---
name: bug
description: Create a structured bug work item with reproduction steps, expected vs actual behavior, environment details, and severity. Reads project-config.json to use the correct area path and tags.
argument-hint: "[describe the bug or paste error details]"
---

Create a bug work item following the project's bug format.

## Before Creating

Load `documentation/product-analyst-workflow/project-config.json` to determine:

- **Area Path** — from `workTracking.defaultAreaPath`
- **Application tags** — from `frontend.applications[].name`
- **Environment names** — from `environments[]` or project defaults

## Bug Template

```markdown
# Bug: [Short, Clear Title]

**Work Item Type:** Bug
**Title:** [Application] - [What is wrong] - [Ticket/Source ID if available]
**Severity:** [1-Critical | 2-High | 3-Medium | 4-Low]
**Priority:** [1 | 2 | 3 | 4]
**Area Path:** [from project-config.json workTracking.defaultAreaPath]
**Tags:** [application-name; bug; affected-area]

## Description

[1-2 sentences describing what is broken and the business impact.]

## Steps to Reproduce

1. Navigate to [specific page/feature]
2. [Action taken]
3. [Next action]
4. [Observe: error message, wrong behavior, crash]

## Expected Behavior

[What should happen]

## Actual Behavior

[What actually happens — include error messages verbatim if provided]

## Environment

| Field                   | Value                       |
| ----------------------- | --------------------------- |
| Environment             | [Production / Staging / QA] |
| Application             | [from project config]       |
| Browser / Client        | [if applicable]             |
| User Role / Permissions | [if relevant]               |

## Impact

- **Affected Users:** [Roles or user groups affected]
- **Frequency:** [Always / Intermittent / Rare]
- **Workaround Available:** [Yes — describe / No]

## Additional Context

[Stack traces, screenshots, logs, related tickets — paste here if provided]

## Acceptance Criteria (for fix verification)

- [ ] Steps to reproduce no longer produce the error
- [ ] Expected behavior is confirmed in [environment]
- [ ] Regression test added covering this scenario
```

## Severity Guide

| Severity         | When to Use                                                  |
| ---------------- | ------------------------------------------------------------ |
| **1 - Critical** | System down, data loss, security breach, blocking all users  |
| **2 - High**     | Major feature broken, significant user impact, no workaround |
| **3 - Medium**   | Feature degraded, workaround exists, limited user impact     |
| **4 - Low**      | Minor issue, cosmetic, rarely encountered                    |
