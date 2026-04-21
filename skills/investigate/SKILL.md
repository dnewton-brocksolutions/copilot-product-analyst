---
name: investigate
description: Research and analyze a bug, support ticket, or feature request. Examines the codebase to identify root causes, affected components, and implementation options before writing any code or work items.
argument-hint: "[ticket ID, error message, or description of the issue to investigate]"
---

Investigate a request, bug, or feature — analyze the codebase and produce a findings report.

## Investigation Steps

### 1. Clarify the Problem

If the request is vague, ask:

- What behavior is observed vs expected?
- When did this start? Was there a recent release or change?
- Which users or environments are affected?
- Is there an error message, stack trace, or log snippet?

### 2. Understand the Domain

Read `documentation/business-analyst-workflow/project-config.json` to identify:

- Which application or service is involved
- Relevant tech stack (framework, ORM, API protocol)
- Team ownership or responsible area

### 3. Search the Codebase

Based on the symptoms, search for:

- The specific feature, component, or screen mentioned
- Error message strings or exception types
- Relevant API endpoints or service methods
- Database tables or entities involved
- Configuration keys or environment variables

Document **exactly which files and line numbers** you examined.

### 4. Identify Root Cause

Determine:

- What is the most likely cause?
- Is this a regression (recent change broke it) or a pre-existing gap?
- Are there multiple contributing factors?
- What assumptions in the code might be invalid?

### 5. Assess Impact

- Which other components depend on the affected code?
- Could a fix break other functionality?
- Are there related bugs or known issues?

### 6. Identify Solutions

For each viable solution, describe:

- **Approach**: What would be changed
- **Risk**: Low / Medium / High — why
- **Effort**: Rough relative effort (small, medium, large)
- **Recommendation**: Which approach and why

## Output: Investigation Report

```markdown
# Investigation Report: [Brief Title]

**Investigated:** [Date]
**Source:** [Ticket ID / Description]
**Status:** [Root Cause Found | Inconclusive | Needs Further Info]

## Problem Statement

[1-2 sentences: what was reported]

## Findings

### Root Cause

[Describe what is causing the issue, with specific file/line references]

### Evidence

- `[file path]` line X — [what you found and why it matters]
- `[file path]` line Y — [related code]

### Impact Assessment

[Which users, systems, or flows are affected]

## Proposed Solutions

### Option 1: [Name]

- **Approach:** [What changes]
- **Risk:** Low / Medium / High — [rationale]
- **Effort:** Small / Medium / Large
- **Recommendation:** ✅ Recommended — [why]

### Option 2: [Name]

- **Approach:** [What changes]
- **Risk:** [rationale]
- **Effort:** [size]

## Recommended Next Step

[What to do: create a bug, spike task, or user story — with key information pre-filled]
```
