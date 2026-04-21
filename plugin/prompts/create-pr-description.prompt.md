---
agent: business-analyst
description: "Generate a PR description from completed code changes"
---

Generate a clear, structured pull request description from the changes made in this session or the provided context.

## Output

Create a single file `PR-[brief-title].md` in `documentation/work-items/`.

---

## PR Description Structure

````markdown
## [Feature/Fix Title] — Change Breakdown

### Background

[1-2 sentences: What problem existed and why this change was needed]

---

### [Change Area 1] — [Brief label]

**File(s):** `path/to/file`

[What was wrong and why. Then explain the fix with enough detail for a reviewer to understand the decision.]

```code
// Key code snippet if helpful
```
````

---

### [Change Area 2] — [Brief label]

**File(s):** `path/to/file`

[Repeat pattern]

---

### Summary of Files Changed

| File           | Type                     | Change               |
| -------------- | ------------------------ | -------------------- |
| `path/to/file` | Modified / New / Deleted | One-line description |

```

---

## Guidelines

- **Background:** One paragraph max. Focus on the problem, not the solution.
- **Change sections:** One section per logical change area (not one per file). Group related file changes together.
- **Code snippets:** Include only when they meaningfully illustrate the fix. Keep them short.
- **Summary table:** Every changed file gets a row — use relative paths from the service root.
- **Tone:** Direct and technical. Written for a developer reviewer, not a manager.
- **No Definition of Done, acceptance criteria, or estimate sections** — this is a PR description, not a work item.

## ADO Formatting Rules

> **Code blocks must be flush against the left margin.** ADO does not render code blocks that are indented inside list items. Always break a code block out of any list nesting, even if it interrupts the list flow.
```
