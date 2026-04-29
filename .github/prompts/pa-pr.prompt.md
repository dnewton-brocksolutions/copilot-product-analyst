---
description: Generate a pull request description from staged changes or a description of the work done. Includes summary, type of change, testing notes, and linked work items.
agent: agent
---

Generate a pull request description.

## Before Writing

If the user doesn't provide change details, ask for:

1. A summary of what was changed and why
2. The work item or story this PR addresses
3. Whether tests were added or updated

## PR Description Template

```markdown
## Summary

[2-4 sentences: What was changed and why. Lead with the business value or problem solved.]

## Type of Change

- [ ] Bug fix (non-breaking change that fixes an issue)
- [ ] New feature (non-breaking change that adds functionality)
- [ ] Breaking change (fix or feature that changes existing behavior)
- [ ] Refactor (no behavior change, internal improvement)
- [ ] Documentation update
- [ ] Configuration / dependency update

## Changes Made

- [Specific change 1 — be concrete, e.g. "Added `DateAcknowledged` column to grid component"]
- [Specific change 2]
- [Specific change 3]

## Testing

- [ ] Unit tests added / updated
- [ ] Manual testing completed in [environment]
- [ ] No automated tests required — explain why: [reason]

### Test Scenarios Covered

| Scenario                 | Result |
| ------------------------ | ------ |
| [Happy path description] | Pass   |
| [Edge case description]  | Pass   |
| [Error case description] | Pass   |

## Linked Work Items

- Closes #[work item ID] — [brief title]
- Related: #[work item ID]

## Screenshots / Recordings

[Include if UI changes were made — paste image or link]

## Deployment Notes

[Any special steps, feature flags, environment variables, or DB migrations required]
```

## PR Title Format

`[type]: [Application] - [Short description] ([Work Item ID])`

Examples:

- `feat: Add date acknowledged column to alerts grid (ADO-1234)`
- `fix: Correct null reference on empty queue response (INC0001234)`
- `chore: Upgrade Angular from 17 to 18`
