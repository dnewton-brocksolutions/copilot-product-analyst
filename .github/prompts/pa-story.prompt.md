---
description: Create a user story using the Three-File Pattern — a business-focused main story, a technical specification, and a separate estimates file. Always reads project-config.json first to use the correct application names and tech stack.
agent: agent
---

Create a user story following the **Three-File Pattern**.

## CRITICAL: Three-File Pattern (REQUIRED)

**Always create THREE separate files:**

1. **Main Story** (`USER-STORY-[brief-title].md`) - Business-focused, ~25 lines max
2. **Technical Spec** (`TECHNICAL-[brief-title].md`) - Implementation details, ~70 lines
3. **Estimates** (`ESTIMATES-[brief-title].md`) - Hour breakdown, ~40 lines

**Reference templates:** `documentation/product-analyst-workflow/work-item-templates/`

## Story Naming Convention (REQUIRED)

- **Title format:** `Application - Action-Oriented Title - Source`
- **Allowed Application values:** See `frontend.applications[].name` in `documentation/product-analyst-workflow/project-config.json`
- **Source:** Ticket/incident/work item ID from your work tracking system (e.g., `INC0001234`, `ADO12345`)
- **Example:** `[Application Name] - Add Date Acknowledged Column - [Source ID]`

## File 1: Main Story (Business-Focused, ~25 lines)

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

- `TECHNICAL-[brief-title].md` (requirements, tasks)
- `ESTIMATES-[brief-title].md` (effort breakdown)
```

## File 2: Technical Specification (~70 lines)

Include:

- Business Requirements (UI, Backend, Business Rules)
- Suggested Task Breakdown (Backend, Frontend, Testing)
- Dependencies & Constraints
- Out of Scope
- Non-Functional Requirements
- Meta (Priority, Tags, Area Path from project config)

## File 3: Estimates (Separate, ~40 lines)

**NEVER put hour estimates in task documents.** Create a separate estimates file with:

- Summary table by component
- Task breakdown with hours
- Risks and assumptions

## Before Creating Files

1. **Read project context**: Load `documentation/product-analyst-workflow/project-config.json`
2. **Check templates**: Reference `documentation/product-analyst-workflow/work-item-templates/`

**Output**: Three separate markdown files in `documentation/work-items/`
