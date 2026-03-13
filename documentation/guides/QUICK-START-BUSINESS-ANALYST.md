# Quick Start Guide: Business Analyst Work Item Generation

**One-page reference for creating consistent, complete work items**

## � User Stories Now Use Two-Document Pattern

User stories are now **concise and business-focused** while maintaining comprehensive technical details:

✅ **Main Story Document:** Business Context + Description + Acceptance Criteria (5-10 lines)  
✅ **Technical Specification:** Requirements + Task Breakdown + DoD + Meta (separate file)  
✅ **Estimates (Optional):** Effort breakdown (separate file)

**Why?** Reduces cognitive load, stays scannable, mirrors the established estimates-separation pattern.

**📖 See:** [TWO-DOCUMENT-PATTERN.md](../TWO-DOCUMENT-PATTERN.md) for complete guide

### Quick Example

**Main Story (CS001685-furnace-load-mobile.md):**

```markdown
## Business Context

Operators currently switch between systems to match coils to furnace positions, causing delays.

## Description

Screen shows all 12 furnace positions with coils already loaded. Operator can select next position
and confirm coil placement.

## Acceptance Criteria

- Given operator at furnace, When they scan coil, Then screen shows all 12 positions
```

**Technical Details (TECHNICAL-CS001685-furnace-load-mobile.md):**

```markdown
## Business Requirements

- Application: ProcessingMes (mobile)
- API: FurnacePositionService.GetFurnacePositions (gRPC)
- Validation: Verify coil belongs to correct rack

## Task Breakdown

- Backend: Create FurnacePositionDTO + gRPC endpoint
- Frontend: Create FurnacePositionGrid component + coil scan handler

## Definition of Done

- Code merged; CI green
- ≥ 80% unit test coverage
- gRPC contracts (.proto) updated
```

## �🚀 Quick Workflow

```
1. Stakeholder describes feature
2. Use this guide to clarify requirements
3. Generate User Story + Tasks using templates
4. Review with team
5. Enter into ADO
```

## 📋 Standard Task Breakdown (Always Follow This Order)

Every User Story decomposes into these tasks:

| #   | Task Type                   | Template                  | Estimate | When to Skip                   |
| --- | --------------------------- | ------------------------- | -------- | ------------------------------ |
| 1   | **Investigation Spike**     | `spike-task-template.md`  | 2-4 hrs  | Skip if no unknowns            |
| 2   | **Backend Implementation**  | `backend-task-simple.md`  | 6-12 hrs | Never skip (if backend needed) |
| 3   | **Frontend Implementation** | `frontend-task-simple.md` | 8-16 hrs | Never skip (if UI needed)      |
| 4   | Other (docs, deployment)    | `task-template.md`        | Varies   | As needed                      |

**Total typical estimate:** 14-28 hours per story (without spike)

**Note:** Testing is included in Definition of Done for each task. Backend and frontend tasks include unit, integration, and E2E tests.

### ⏱️ Task Format: Objective + Requirements + Technical Context

**Best Practice:** Keep tasks concise and scannable with only essential sections:

1. **Objective** - One clear sentence: what this task accomplishes and why
2. **Requirements** - What needs to be built (bullet points)
3. **Technical Context** - Where to start (application, service, tables, similar features)
4. **Estimates Reference** - Link to separate `ESTIMATES-[feature].md` file

**What NOT to include in tasks:**

- ❌ Acceptance Criteria (lives in User Story)
- ❌ Definition of Done (standard DoD applies)
- ❌ Hour estimates (lives in separate ESTIMATES file)
- ❌ Detailed implementation steps (let developers decide how)
- ❌ Meta fields (ADO handles this)

**Benefits:**

- Tasks remain clear and concise (easier to read/understand)
- No duplication between Story and Task acceptance criteria
- Technical Context gives developers a starting point
- Estimates can be reviewed and adjusted without modifying requirements
- Reduce cognitive load when reviewing task scope

**How to structure:**

- Create `ESTIMATES-[feature-name].md` in `work-items/`
- Include phase breakdowns, risk adjustments, and team recommendations
- Reference estimates file in story's summary table (not detailed in task)
- Use estimates during sprint planning, not during task specification

**Example:**

```
✅ Task says: "Implement gRPC endpoint to return acknowledged_at field"
✅ Technical Context: "Service: CoilProcessingService, Table: M_Coil, Similar: GetCoilDetails endpoint"
❌ Task does NOT say: "This will take 2.5 hours: 30 min proto update, 1 hour mapping, 45 min testing, 15 min review"
✅ Estimates file says: Detailed breakdown with confidence level and assumptions
```

### 🎨 Frontend Tasks Require UI Mockups

**Important:** Frontend tasks need visual guidance before implementation:

1. Create wireframes or mockups (low/high fidelity)
2. Get stakeholder approval on UI design
3. Attach mockups to the task in ADO

**Future Enhancement:** Sub-agent mockup generation will be integrated into workflow.

## ❓ Key Questions to Ask Stakeholders

### Business Context

- [ ] What **problem** are we solving?
- [ ] Who is the **user** (role/persona)?
- [ ] What **outcome** do they want?
- [ ] What's the **business value**? (time savings, error reduction, compliance)

### Technical Scope

- [ ] **Which application?** OeeWeb (dashboards/OEE) or ProcessingMes (coil processing)?
- [ ] **Which service(s)?** (Check `catalogs/service-catalog.md`)
  - Extend existing service? (e.g., CoilProcessingService, MachineStateService)
  - Create new service? (justify why existing won't work)
- [ ] **Which UI components?** (Check component catalogs)
  - **OeeWeb:** `catalogs/oeeweb-component-catalog.md`
  - **ProcessingMes:** `catalogs/processingmes-component-catalog.md`
  - Reuse existing components? (list them + time savings)
  - Build from scratch? (why can't we reuse?)
- [ ] **Database changes?**
  - MES10 (legacy, manual updates) or MES20 (Liquibase scripts)?
  - Use MCP tools to investigate existing tables, validation rules, and constraints
  - Query live database instead of referring to static schema catalogs

### Dependencies & Constraints

- [ ] Dependencies on other teams/services?
  - Common: PlantModelService, ShiftService, UserService
- [ ] Non-functional requirements? (performance, security, compliance)
- [ ] Feature flag needed? (gradual rollout)
- [ ] Target sprint/iteration?

## 🎯 Typical Estimates by Task Type

### Backend Tasks (6-12 hrs typical)

- **Simple:** 6 hrs - Single gRPC endpoint, basic CRUD, no complex logic
- **Medium:** 8-10 hrs - Multiple endpoints, business rules, Liquibase migration
- **Complex:** 12+ hrs - Complex business logic, multiple services, performance optimization

### Frontend Tasks (8-16 hrs typical)

- **Reuse heavy:** 8 hrs - Mostly reusing existing components, minor adaptations
- **Mixed:** 12 hrs - Some reuse, some new components, standard complexity
- **From scratch:** 16+ hrs - New page pattern, complex state, custom components

### Component Reuse Time Savings

| Component Type                  | Reuse   | From Scratch | Savings   |
| ------------------------------- | ------- | ------------ | --------- |
| **MachineDashboard** (OeeWeb)   | 6-8 hrs | 16+ hrs      | 8-10 hrs  |
| **DataGrid** (ProcessingMes)    | 2-3 hrs | 12-16 hrs    | 10-13 hrs |
| **Config Page** (ProcessingMes) | 6-8 hrs | 12-16 hrs    | 4-8 hrs   |
| **Chart/Gauge** (OeeWeb)        | 1-2 hrs | 4-6 hrs      | 3-4 hrs   |
| **Dialog** (ProcessingMes)      | 1-3 hrs | 3-8 hrs      | 2-5 hrs   |

**Always check catalogs first to avoid overestimating!**

## 📚 Template Locations

All templates in: `documentation/work-item-templates/`

- `story-template.md` - User Story
- `backend-task-template.md` - Backend (gRPC, business logic, DB)
- `frontend-task-template.md` - Frontend (React, UI, state)
- `test-plan-task-template.md` - ADO test plan updates (**always include**)
- `spike-task-template.md` - Investigation/research
- `task-template.md` - Generic task

### 📊 Estimates Guidance

**NEW:** Estimates now separated from task documents!

- See **`ESTIMATES-TEMPLATE.md`** for format and structure
- See **`ESTIMATES-SEPARATION-GUIDE.md`** for full context and examples
- Create separate `ESTIMATES-[feature].md` file during work item creation
- Reference estimates file in sprint planning, not in task scope

## 🗂️ Catalog Quick Reference

### When to Use Which Catalog

```
┌─────────────────────────────────────┐
│ What are you building?             │
├─────────────────────────────────────┤
│ ☐ OEE dashboard / Machine page     │ → oeeweb-component-catalog.md
│ ☐ Coil processing / Production UI  │ → processingmes-component-catalog.md
│ ☐ Backend service / API             │ → service-catalog.md
│ ☐ Not sure / Overview              │ → COMPONENT-CATALOG-SUMMARY.md
└─────────────────────────────────────┘
```

**Catalog locations:** `documentation/catalogs/`

### Database Investigation (Use MCP Tools)

**DO NOT use static schema catalogs** - Query live databases using MCP tools:

```
┌────────────────────────────────────┐
│ Need database information?         │
├────────────────────────────────────┤
│ ✓ Use mcp_mssql-mes_ListTables     │ → See all tables
│ ✓ Use mcp_mssql-mes_DescribeTable  │ → Get table schema
│ ✓ Use mcp_mssql-mes_ReadData       │ → Query data, validation rules
│ ✗ DO NOT use database-schema/      │ → Outdated static catalogs
└────────────────────────────────────┘
```

**Available MCP Databases:**

- `mcp_mssql-mes_*` - MES10 (legacy)
- `mcp_mssql-newmes_*` - MES20 (modern, preferred for new work)
- `mcp_mssql-lims_*` - LIMS
- `mcp_mssql-procbar_*`, `mcp_mssql-procmmi_*`, `mcp_mssql-reportservices_*`, `mcp_mssql-xfererp_*`

**📖 Detailed guides:**

- [DATABASE-INVESTIGATION.md](./DATABASE-INVESTIGATION.md) - Examples and best practices for quick queries
- [MCP-DATABASE-TOOLS-INTEGRATION.md](./MCP-DATABASE-TOOLS-INTEGRATION.md) - Integration guide for work item creation (`/story`, `/decompose`, `/bug` workflows)

### Database Decision Tree

```
┌─────────────────────────────────────┐
│ Which database?                     │
├─────────────────────────────────────┤
│ MES10 (Legacy)                      │
│ • Manual SQL changes required       │
│ • Legacy business logic             │
│ • Coordinate with DBA               │
│                                     │
│ MES20 (Modern)                      │
│ • Liquibase scripts                 │
│ • Auto-deploy with service          │
│ • Preferred for new tables          │
└─────────────────────────────────────┘
```

## ✍️ Creating Work Items

### Step 1: Start with User Story

1. Always create new work item files in the active release folder (e.g., `documentation/work-items/[Release]`). If a release is not specified, use the current sprint/release.
2. Copy `story-template.md` to `[Release]/user-story.md`
3. Fill in all `[placeholders]`
4. Check catalogs for component/service references
5. List task breakdown at bottom

### Step 2: Create Tasks

1. Copy appropriate task templates to `work-items/[feature-name]/`
2. Name: `task-1-[name].md`, `task-2-[name].md`, etc.
3. **Always include test plan task** (use `test-plan-task-template.md`)
4. Fill in all `[placeholders]`
5. Verify developer disclaimer is present

### Step 3: Create Quick-Add Format

1. Create `work-items/[feature-name]/tasks.md`
2. Format for copy-paste into ADO:
   - Title, Description, Acceptance Criteria
   - Estimate, Priority, Tags, Area/Iteration paths

### Step 4: Create Mockups (if UI changes)

1. Create `work-items/[feature-name]/mockups/`
2. Add HTML mockups or design files
3. Reference in frontend task

## ✅ Quality Checklist

Before finalizing work items:

### User Story

- [ ] Clear user role, outcome, and business value
- [ ] Given/When/Then acceptance criteria
- [ ] Component/service catalog checked
- [ ] Database approach identified (MES10/MES20)
- [ ] In-scope and out-of-scope explicitly stated
- [ ] Dependencies identified

### Backend Task

- [ ] Service identified (extend existing vs new)
- [ ] Proto definition outlined
- [ ] Database changes documented (Liquibase vs manual)
- [ ] Service dependencies listed (PlantModel, Shift, User, etc.)
- [ ] **NO effort estimates in task document** (use separate ESTIMATES file)
- [ ] Definition of Done includes code quality, testing, deployment criteria

### Frontend Task

- [ ] Application identified (OeeWeb vs ProcessingMes)
- [ ] Component catalog checked for reuse
- [ ] Reusable components listed with time savings
- [ ] New components justified (why can't we reuse?)
- [ ] **NO effort estimates in task document** (use separate ESTIMATES file)
- [ ] Responsive design considered
- [ ] Accessibility requirements noted

### Test Plan Task

- [ ] **ALWAYS INCLUDED** (never skip this)
- [ ] Test case count estimated (~20-30 for medium feature)
- [ ] Test suites identified (new + updates to existing)
- [ ] Priority tagging planned (P0, P1, P2, P3)
- [ ] **NO effort estimates in task document** (use separate ESTIMATES file)

### Separate Estimates File

- [ ] Created: `ESTIMATES-[feature-name].md`
- [ ] Story-level estimates with breakdown by component
- [ ] Phase breakdowns with time allocations
- [ ] Effort by skill (Backend, Frontend, QA, etc.)
- [ ] Risk adjustments and confidence levels
- [ ] Variation factors (experience level, extra requirements)
- [ ] Historical accuracy tracking notes
- [ ] Discussion questions for team planning

### All Tasks

- [ ] Developer verification disclaimer present
- [ ] **NO hour estimates or time breakdowns** (reference ESTIMATES file instead)
- [ ] Acceptance Criteria in Given/When/Then format
- [ ] Definition of Done checklist
- [ ] Dependencies and blockers clearly identified
- [ ] ADO fields complete (Priority, Tags, Area/Iteration)

## 🎨 Example: Creating a New Feature

**Stakeholder Request:** "We need a way to view rework batch coils for tag printing"

### 1. Clarify Requirements (5 min)

- **Who:** Production operators (TagPrint screen users)
- **What:** Select "Rework Batch" mode, enter batch ID, see coils, print tags
- **Why:** Currently manual coil-by-coil entry (slow, error-prone)
- **App:** ProcessingMes (TagPrint page)
- **Database:** MES10 (stored procedure exists: M_GetCoilsForReworkJob)

### 2. Check Catalogs (5 min)

- **Service:** CoilProcessingService (extend existing)
- **Frontend:** ProcessingMes - TagPrint page already exists (reuse)
  - Add selection mode (radio buttons)
  - Add batch input field
  - Reuse existing coil table
  - Time savings: 4-6 hrs (not building page from scratch)

### 3. Create Work Items (20 min)

1. **User Story** (using `story-template.md`)
2. **Task 1:** Investigation Spike - Find stored procedure (3 hrs)
3. **Task 2:** Backend - gRPC endpoint for GetReworkBatchCoils (6 hrs)
4. **Task 3:** Frontend - Add Rework Batch mode to TagPrint (14 hrs)
   - Includes reuse time savings documented
5. **Task 4:** ADO Test Plan Updates (2 hrs) - **NEVER FORGET THIS**

**Total:** 25 hours

### 4. Review & Refine (10 min)

- Check estimates against component reuse
- Verify all acceptance criteria are testable
- Confirm database approach (MES10 manual vs MES20 Liquibase)
- Review with team lead

**Total time to create work items:** ~40 minutes

## 🔄 Common Patterns

### Pattern: Add Field to Existing Page

- **Backend:** 2-4 hrs (add field to proto, business logic, DB column)
- **Frontend:** 2-4 hrs (add form field, validation)
- **Test Plan:** 2 hrs (update existing test cases + new validation tests)
- **Total:** 6-10 hrs

### Pattern: New Report/Grid Page

- **Backend:** 6-8 hrs (new gRPC endpoint, query logic)
- **Frontend:** 6-8 hrs (reuse DataGrid + toolbar, 2-3 hrs vs 12-16 from scratch)
- **Test Plan:** 2 hrs (new test suite)
- **Total:** 14-18 hrs

### Pattern: New Machine Dashboard (OeeWeb)

- **Backend:** 8-10 hrs (machine state queries, OEE calcs)
- **Frontend:** 6-8 hrs (reuse MachineDashboard pattern, 6-8 hrs vs 16+ from scratch)
- **Test Plan:** 2 hrs
- **Total:** 16-20 hrs

## 🚨 Common Mistakes to Avoid

❌ **Forgetting ADO test plan task** - Always include (2 hrs standard)  
❌ **Not checking component catalogs** - Results in overestimates and duplicate work  
❌ **Vague acceptance criteria** - Must be testable (Given/When/Then)  
❌ **No developer disclaimer** - Required on all generated tasks  
❌ **Creating new service without justification** - Check service catalog first  
❌ **Estimating from scratch when components exist** - Always check catalogs first  
❌ **Using story points instead of hours** - Hours required for tasks  
❌ **Forgetting database approach** - Must specify MES10 (manual) or MES20 (Liquibase)

## 📖 Related Documentation

- **Templates:** `documentation/work-item-templates/README.md`
- **Catalogs:** `documentation/catalogs/README.md`
- **Work Items Examples:** `documentation/work-items/`
- **Task Breakdown Pattern:** `documentation/work-items/README.md`

## 💡 Pro Tips

1. **Always start with catalogs** - Check service/component catalogs before estimating
2. **Document reuse savings** - "Reuse DataGrid (2-3 hrs) vs from scratch (12-16 hrs)"
3. **Be explicit about out-of-scope** - Prevents scope creep
4. **Include service dependencies** - PlantModel, Shift, User are common
5. **Use time-boxes for spikes** - Investigation tasks should have hard limits
6. **Update catalogs when done** - Add new reusable components/patterns

---

**Questions?** Check `documentation/work-items/README.md` or ask your team lead.

**Contributing?** Update templates in `documentation/work-item-templates/` as patterns evolve.
