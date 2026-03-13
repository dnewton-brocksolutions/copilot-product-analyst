---
agent: business-analyst
description: "Break down a user story into specific frontend and backend tasks with estimates"
---

Take an existing user story and decompose it into frontend and backend tasks using the simplified task structure.

## CRITICAL: Objective + Requirements Pattern

**Reference:** `documentation/business-analyst-workflow/guides/TASK-DECOMPOSITION-GUIDE.md`

### Task Structure (Required for All Tasks)

Each task must have two sections:

1. **Objective** - One sentence: what this accomplishes and why
2. **Requirements** - Bulleted list of what needs to happen (not HOW)

### Standard Decomposition Order

Create tasks in this sequence:

1. **Backend Task** - Business logic, API, database (use `backend-task-simple.md`)
2. **Frontend Task** - UI, user workflows (use `frontend-task-simple.md`)
3. **Estimates File** - Separate file with hour breakdowns

---

## Before Creating Tasks

1. **Load project context**: `documentation/business-analyst-workflow/project-config.json`
2. **CRITICAL: Investigate database** (for backend tasks):
   - Use MCP tools to find actual table names
   - Use MCP tools to find stored procedures with similar logic
   - Use findings to write informed requirements
   - **DO NOT** create "Investigation Needed" sections in tasks
3. **Reference templates**: `documentation/business-analyst-workflow/work-item-templates/`

---

## Task 1: Backend Implementation

**Use template:** `backend-task-simple.md`

**File:** `TASK-1-backend-[brief-description].md`

```markdown
**Work Item Type:** Task
**Title:** [Feature] - Backend Implementation
**Parent:** [Link to user story]

### Objective

[One sentence: What business logic/data processing this delivers]

### Requirements

- **Business Logic:** [What business rules to implement]
- **Data Storage:** [What data to store/update/retrieve]
- **API Endpoints:** [What gRPC endpoints needed]
- **Validation:** [What validation rules]
- **Error Scenarios:** [What errors to handle]

> **Note:** See `ESTIMATES-[feature].md` for effort estimates
```

---

## Task 2: Frontend Implementation

**Use template:** `frontend-task-simple.md`

**File:** `TASK-2-frontend-[brief-description].md`

```markdown
**Work Item Type:** Task
**Title:** [Feature] - Frontend Implementation
**Parent:** [Link to user story]

### Objective

[One sentence: What UI/functionality this delivers to users]

### Requirements

- **User Interface:** [What users see and interact with]
- **Data Display:** [What data to show]
- **User Interactions:** [What actions users perform]
- **Validation:** [Input validation rules]
- **Error Handling:** [How to communicate errors]

> **Note:** This task requires UI design/mockup. Create wireframes before implementation.

## UI Design Considerations

**Mockup should show:**

- [Key UI element placement and layout]
- [Label text and styling details]
- [Consistency with existing UI patterns]
- [Required field indicators, if applicable]
- [Error message placement and styling]
- [How data displays in different states (loading, success, error, read-only)]

> **Note:** See `ESTIMATES-[feature].md` for effort estimates
```

---

## Estimates File (SEPARATE - REQUIRED)

**File:** `ESTIMATES-[feature].md`

```markdown
# Effort Estimates: [Feature Name]

**Related Work Item:** [User Story filename]
**Date:** YYYY-MM-DD

## Summary

| Component | Estimated Hours |
| --------- | --------------- |
| Backend   | X hours         |
| Frontend  | Y hours         |
| Testing   | Z hours         |
| **Total** | **XX hours**    |

## Backend Breakdown

| Phase                  | Hours | Notes                   |
| ---------------------- | ----- | ----------------------- |
| Proto definition       | X     | [assumptions]           |
| Business logic         | X     | [complexity factors]    |
| Database changes       | X     | [migration approach]    |
| Unit/integration tests | X     | [coverage expectations] |

## Frontend Breakdown

| Phase            | Hours | Notes               |
| ---------------- | ----- | ------------------- |
| UI mockup        | X     | [design complexity] |
| Component build  | X     | [reuse vs new]      |
| State management | X     | [Redux complexity]  |
| API integration  | X     | [error handling]    |
| Unit/E2E tests   | X     | [test coverage]     |

## Testing Notes

- Testing is included in Definition of Done for each task
- Backend tasks include unit and integration tests
- Frontend tasks include component and E2E tests
- No separate testing task needed

## Assumptions & Risks

- [Key assumption that affects estimates]
- [Risk that could increase hours]
- [Areas of uncertainty]

## Revision History

| Date       | Change           | New Total |
| ---------- | ---------------- | --------- |
| YYYY-MM-DD | Initial estimate | XX hours  |
```

---

## Decompose Checklist

Before finalizing, verify:

- [ ] Backend task uses Objective + Requirements structure
- [ ] Frontend task uses Objective + Requirements structure
- [ ] Frontend task includes UI mockup note
- [ ] Requirements describe WHAT (not HOW)
- [ ] Separate ESTIMATES file created (NOT in tasks)
- [ ] Backend task listed first (provides API for frontend)
- [ ] Frontend task depends on backend completion
- [ ] No hour estimates in task documents
- [ ] Database investigation done if needed (MCP tools)

---

## Output

Create these files in `documentation/work-items/`:

1. `TASK-1-backend-[feature].md`
2. `TASK-2-frontend-[feature].md`
3. `ESTIMATES-[feature].md`
