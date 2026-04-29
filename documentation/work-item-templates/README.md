# Work Item Templates

This directory contains reusable templates for creating consistent work item documentation.

## Available Templates

### Core Templates

- **`story-template.md`** - User Story / Product Backlog Item template
- **`task-template.md`** - Generic task template with all standard sections
- **`business-focused-task-template.md`** - ⭐ **Recommended:** Simple task template (Objective + Requirements + Technical Context)

### Specialized Task Templates (Simplified - Recommended)

- **`backend-task-simple.md`** - ⭐ **Recommended:** Backend implementation (business logic, API, database)
- **`frontend-task-simple.md`** - ⭐ **Recommended:** Frontend implementation (UI, user interactions, workflows)
- **`test-plan-task-template.md`** - ADO test plan updates (test case documentation)
- **`spike-task-template.md`** - Investigation/research spike tasks

### Detailed Task Templates (Legacy - Use for Complex Scenarios)

- **`backend-task-template.md`** - Detailed backend implementation with hour breakdowns
- **`frontend-task-template.md`** - Detailed frontend implementation with component analysis

## Usage

### Creating a New Work Item

1. **Copy the appropriate template** to `documentation/work-items/[feature-name]/`
2. **Rename the file** following the naming convention:
   - User Story: `user-story.md`
   - Tasks: `task-[n]-[description].md`
3. **Fill in all placeholders** (marked with `[brackets]`)
4. **Remove inapplicable sections** or mark as "N/A"

### Template Selection Guide

**Use `business-focused-task-template.md` when:** ⭐ **Recommended for most tasks**

- Creating a generic task that doesn't fit frontend/backend categories
- Need Objective + Requirements + Technical Context structure
- Want to avoid prescribing implementation details

**Use `backend-task-simple.md` when:** ⭐ **Recommended for backend work**

- Implementing business logic and data processing
- Creating or updating gRPC services
- Working with databases (MES10/MES20)
- Need to specify what data operations are required

**Use `frontend-task-simple.md` when:** ⭐ **Recommended for frontend work**

- Building user interfaces in OeeWeb or ProcessingMes
- Creating user interaction workflows
- Need to specify what users see and do
- **Note:** Requires UI mockup/wireframe before implementation

**Use `test-plan-task-template.md` when:**

- Creating a standalone test plan task (rare - testing requirements are typically captured in the story's acceptance criteria)
- Documenting complex test scenarios that need separate tracking
- Legacy projects that still use separate test plan tasks

**Note:** Most projects capture testing requirements in the story's acceptance criteria rather than creating separate test tasks.

**Use `spike-task-template.md` when:**

- Investigating unknowns before committing to implementation
- Researching technologies or approaches
- Validating feasibility
- Time-boxed research needed

**Use `task-template.md` when:**

- Creating tasks that don't fit other categories
- Documentation tasks
- Configuration tasks
- Deployment tasks

## Standard Task Breakdown Pattern

When decomposing a User Story, follow this standard order:

1. **Spike Task** (if unknowns exist) - 2-4 hours
2. **Backend Task** - 6-12 hours
3. **Frontend Task** - 8-16 hours
4. **Test Plan Task** - 2 hours (**always include**)
5. **Other Tasks** (documentation, deployment, etc.) - as needed

See `documentation/work-items/README.md` for detailed breakdown pattern.

## Template Features

### All Templates Include

✅ **Objective Section** - Clear statement of what the task accomplishes  
✅ **Requirements Section** - What needs to be built (investigation, implementation, validation)  
✅ **Estimates Reference** - Link to separate `ESTIMATES-[feature].md` file

**Note:** Story-level acceptance criteria lives in User Story, not tasks. Estimates are separated into dedicated files.

### Backend Template Includes

✅ **Backend Checklist** - gRPC, proto, business service, database, testing, observability  
✅ **Database Architecture Guidance** - MES10 vs MES20 decision

### Frontend Template Includes

✅ **Component Reuse Analysis** - Check existing components before building from scratch  
✅ **Frontend Checklist** - UX states, accessibility, gRPC-web, responsive design

### Test Plan Template Includes

✅ **Test Case Count Estimate** - Typical output: 20-30 test cases  
✅ **Test Suite Organization** - Suggested structure  
✅ **Test Case Naming Convention** - Consistent format  
✅ **Priority Guidelines** - P0-P3 tagging

## Customization

Templates are designed to be **starting points**. Feel free to:

- Add project-specific sections
- Remove sections that don't apply
- Adjust estimates based on team velocity
- Add custom checklists or guidelines

## Related Documentation

- **Work Items README:** `documentation/work-items/README.md` - Standard task breakdown pattern

## Maintenance

These templates should be updated when:

- New standard sections are identified
- Team processes change
- ADO field requirements change
- New checklists or best practices emerge

**Template Owner:** Product Analyst role / Team Lead
