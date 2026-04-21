---
agent: business-analyst
description: "Create a user story with business context, acceptance criteria, and task breakdown"
---

Create a user story following the **Two-Document Pattern**:

## CRITICAL: Two-Document Pattern (REQUIRED)

**Always create THREE separate files:**

1. **Main Story** (`USER-STORY-[brief-title].md`) - Business-focused, ~25 lines max
2. **Technical Spec** (`TECHNICAL-[brief-title].md`) - Implementation details, ~70 lines
3. **Estimates** (`ESTIMATES-[brief-title].md`) - Hour breakdown, ~40 lines

**Reference templates:** `documentation/business-analyst-workflow/work-item-templates/`

---

## File 1: Main Story (Business-Focused)

Keep this **concise** (~25 lines). Include ONLY:

## Story Naming Convention (REQUIRED)

- **Title format:** `Application - Action-Oriented Title - Source`
- **Allowed Application values:** See `frontend.applications[].name` in `documentation/business-analyst-workflow/project-config.json`
- **Source examples:** Ticket/incident/work item ID from your work tracking system (e.g., `INC0001234`, `ADO12345`)
- **Example:** `[Application Name] - Add Date Acknowledged Column - [Source ID]`

```markdown
# User Story: [Title]

**Work Item Type:** User Story  
**Title:** [Application from project config] - [Action-Oriented Title] - [Source]

## Business Context

[1-2 sentences: Why is this needed? What problem does it solve?]

## Description

[2-3 sentences: User flow, current vs desired state]

## Acceptance Criteria

- Given [condition], When [action], Then [outcome]
- Given [condition], When [action], Then [outcome]
- [3-6 criteria max]

---

**See companion files:**

- `TECHNICAL-[brief-title].md` (requirements, tasks, DoD)
- `ESTIMATES-[brief-title].md` (effort breakdown)
```

---

## File 2: Technical Specification

Include implementation details:

- Business Requirements (UI, Backend, Business Rules)
- Suggested Task Breakdown (Backend, Frontend, Testing)
- Dependencies & Constraints
- Out of Scope
- Definition of Done
- Non-Functional Requirements
- Meta (Priority, Tags, Area Path)

---

## File 3: Estimates (Separate from Tasks)

**NEVER put hour estimates in task documents.** Create separate estimates file with:

- Summary table by component
- Task breakdown with hours
- Risks and assumptions

---

## ADO Formatting Rules

> **Code blocks must be flush against the left margin.** ADO does not render code blocks that are indented inside list items. Always break a code block out of any list nesting, even if it interrupts the list flow.

---

## Before Creating Files

1. **Read project context**: Load `documentation/business-analyst-workflow/project-config.json`
2. **Check templates**: Reference `documentation/business-analyst-workflow/work-item-templates/`
3. **Review example**: See `BEFORE-AFTER-EXAMPLE.md` for correct format

**Output**: Three separate markdown files in `documentation/work-items/`
