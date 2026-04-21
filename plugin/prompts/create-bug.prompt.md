---
agent: business-analyst
description: "Create an ADO bug work item with description, repro steps, and suggested fix"
---

Create a bug work item that matches the **ADO bug format** exactly.

## ADO Bug Fields (Three Fields Only)

ADO bugs have exactly three fields. Output ONLY these — no extra sections:

1. **Description** – High-level summary of what is broken
2. **Repro Steps** – Numbered, iterative, repeatable steps to reproduce the bug
3. **Fix** – Suggested or possible fix (can be a hypothesis if root cause is unknown)

---

## Output Format

Create a single file `BUG-[brief-title].md` in `documentation/work-items/`:

```markdown
# Bug: [Title]

**Work Item Type:** Bug

## Description

[High-level description of what is broken and what the observable symptom is]

## Repro Steps

1. [Starting state or precondition]
2. [Action]
3. [Action]
4. [Observed result]

**Expected:** [What should happen]
**Actual:** [What actually happens]

## Fix

[Suggested or possible fix. If root cause is unknown, describe the likely area to investigate and a hypothesis for the fix.]
```

---

## CRITICAL: Repro Steps Requirement

Repro steps must be **specific, numbered, and independently repeatable** by a developer who was not present when the bug was discovered.

**If the user has not provided adequate repro steps, you MUST ask before creating the file.** Do not guess or invent steps.

A good repro step set:

- Starts with a concrete initial state (logged in as X, on screen Y, with data Z)
- Uses numbered steps — each step is a single action
- Has a clear observed result at the end
- Can be followed by someone else and produce the same outcome

**Ask the user for clarification if any of the following are missing:**

- What screen or feature they were on
- What specific action triggered the bug
- What data or state was present at the time
- What the exact observed behavior was vs. what was expected

---

## Before Creating the File

1. **Confirm repro steps are adequate** — if not, ask the user before proceeding
2. Read project context if needed: `documentation/business-analyst-workflow/project-config.json`
