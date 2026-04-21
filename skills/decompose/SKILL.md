---
name: decompose
description: Decompose a user story into granular implementation tasks using the Objective+Requirements breakdown pattern. Reads an existing story file and produces individual task work items. Always creates a separate estimates file.
argument-hint: "[path to story file or brief description of the story]"
---

Break a user story into implementation tasks.

## Before Decomposing

1. **Read the story file** — load the specified story or search `documentation/work-items/` for the relevant user story markdown file
2. **Read project config** — load `documentation/product-analyst-workflow/project-config.json` for tech stack, estimation units, and standards

## Task Template (per task)

```markdown
# Task: [Short Action Title]

**Type:** Task
**Parent Story:** [Story title]
**Story Points:** [number from project config estimation scale]

## Objective

[1 sentence: What specific deliverable does this task produce?]

## Requirements

- [ ] [Concrete, testable requirement]
- [ ] [Concrete, testable requirement]
- [ ] [Concrete, testable requirement]

## Technical Details

[Framework/component/pattern to use. Reference project-config.json tech stack.]

## Acceptance Criteria

- [ ] [Testable outcome matching a requirement]
- [ ] [Testable outcome matching a requirement]

## Definition of Done

- [ ] Code complete and peer reviewed
- [ ] Unit tests written and passing
- [ ] Acceptance criteria verified
```

## Task Categories to Generate

Based on the story content, create tasks from these categories as applicable:

| Category          | Focus                                                            |
| ----------------- | ---------------------------------------------------------------- |
| **Backend**       | API endpoints, business logic, data models, validation, services |
| **Frontend**      | Components, state management, user interactions, routing         |
| **Data/DB**       | Schema changes, migrations, stored procedures                    |
| **Integration**   | Service wiring, API contracts, error handling                    |
| **Testing**       | Unit tests, integration tests, E2E scenarios                     |
| **Documentation** | API docs, changelog, runbook updates                             |

## Decomposition Rules

1. **One clear deliverable per task** — don't bundle unrelated work
2. **Story points from project config** — use the estimation scale defined in `estimation.units`
3. **Reference the parent story** — every task links to the parent story title
4. **No hour estimates in tasks** — create a separate `ESTIMATES-[title].md` file
5. **Concrete requirements** — each requirement must be testable by QA

## Output Structure

Create individual task markdown files in `documentation/work-items/tasks/`:

- `TASK-[title]-backend.md`
- `TASK-[title]-frontend.md`
- `TASK-[title]-testing.md`
- _(etc. as applicable)_
- `ESTIMATES-[title]-tasks.md` — hour breakdown summary (SEPARATE FILE)
