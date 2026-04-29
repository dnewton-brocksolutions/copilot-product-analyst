---
description: Push a confirmed work item hierarchy directly to Azure DevOps using the ADO MCP server. Always confirm the full hierarchy with the user before creating anything.
agent: agent
---

Push work items to Azure DevOps following the instructions below.

## Prerequisites — Check Before Proceeding

1. **Load project config** — Read `documentation/product-analyst-workflow/project-config.json`
   - Confirm `workTracking.tool` is `"Azure DevOps"`
   - Read `workTracking.ado.orgUrl`, `ado.project`, `ado.processTemplate`, `ado.defaultTeam`
   - Read `workTracking.areaPath` and `workTracking.iterationPath`
   - If `workTracking.ado.mcpEnabled` is `false`, stop and tell the user to configure `.vscode/mcp.json` first (see `documentation/MCP-SETUP.md` pattern, adapted for ADO)

2. **Confirm work items exist** — The user must have already created work items in this session (via `/pa-story`, `/pa-decompose`, etc.) or provide them now. Do not invent work items.

---

## Step 1: Confirm Hierarchy Before Creating Anything

Present a summary table of what will be created. Example:

```
Ready to push to ADO (project: MyProject)?

| # | Type         | Title                                      | Parent |
|---|------------- |--------------------------------------------|--------|
| 1 | Feature      | Add user login                             | —      |
| 2 | User Story   | As a user I can log in with email/password | #1     |
| 3 | Task (BE)    | Implement POST /auth/login endpoint        | #2     |
| 4 | Task (FE)    | Build login form component                 | #2     |
| 5 | Task (Test)  | Write integration tests for login flow     | #2     |

AreaPath:      MyProject\Team
IterationPath: MyProject\Sprint 5

Confirm? (yes / adjust)
```

**Do not create anything until the user confirms.**

---

## Step 2: Field Mapping by Process Template

Use the process template from `workTracking.ado.processTemplate` to determine field names.

### Agile Process

| PA Field                 | ADO System Field                                                       |
| ------------------------ | ---------------------------------------------------------------------- |
| Title                    | `System.Title`                                                         |
| Work Item Type           | `System.WorkItemType` (`Epic`, `Feature`, `User Story`, `Task`, `Bug`) |
| Description              | `System.Description`                                                   |
| Acceptance Criteria      | `Microsoft.VSTS.Common.AcceptanceCriteria`                             |
| Priority                 | `Microsoft.VSTS.Common.Priority` (1–4)                                 |
| Effort (story/PBI)       | `Microsoft.VSTS.Scheduling.Effort`                                     |
| Original Estimate (task) | `Microsoft.VSTS.Scheduling.OriginalEstimate`                           |
| Remaining Work (task)    | `Microsoft.VSTS.Scheduling.RemainingWork`                              |
| Area Path                | `System.AreaPath`                                                      |
| Iteration Path           | `System.IterationPath`                                                 |
| Tags                     | `System.Tags` (semicolon-delimited)                                    |
| Parent link              | Set via `System.LinkTypes.Hierarchy-Reverse`                           |

### Scrum Process

- Replace `User Story` with `Product Backlog Item`
- Story points field: `Microsoft.VSTS.Scheduling.Effort` (same)

### CMMI Process

- Replace `User Story` with `Requirement`
- Additional required field: `Microsoft.VSTS.CMMI.RequirementType`

---

## Step 3: Creation Order (Parent Before Child)

Always create in this order to ensure parent IDs are available for child links:

1. Epics (if any)
2. Features
3. User Stories / PBIs
4. Tasks (backend, frontend, test, spike — in the order from `taskBreakdownOrder`)
5. Bugs (if any)

---

## Step 4: Set Parent Links

After creating each child work item, set the parent link using the ID returned by the MCP tool from the parent creation step.

Use the `System.LinkTypes.Hierarchy-Reverse` relation type to wire child → parent.

---

## Step 5: Report Results

After all work items are created, output a results table with ADO URLs:

---

## After Pushing to ADO: Cleanup (Optional)

Once work items are successfully created in Azure DevOps, you can clean up the local markdown files:

```bash
# Option 1: Delete all work item files
rm documentation/work-items/*.md

# Option 2: Archive them for reference (by sprint or date)
mv documentation/work-items/ documentation/work-items-SPRINT-N-archived/

# Option 3: Keep them (no cleanup needed — just remember ADO is now the source of truth)
```

**Why cleanup?**

- Prevents confusion — teams know to look in ADO, not old `.md` files
- Reduces repo clutter
- Clear separation: local drafts ≠ committed backlog

For full details on file lifecycle and cleanup, see [WORK-ITEM-LIFECYCLE.md](../../documentation/WORK-ITEM-LIFECYCLE.md).

```
Work items created in MyProject:

| # | Type       | Title                                     | ADO ID | URL                                      |
|---|------------|-------------------------------------------|--------|------------------------------------------|
| 1 | Feature    | Add user login                            | 1042   | https://dev.azure.com/org/project/_workitems/edit/1042 |
| 2 | User Story | As a user I can log in with email/password | 1043  | https://dev.azure.com/org/project/_workitems/edit/1043 |
...
```

---

## Error Handling

- If a work item creation fails, report the error and the field values that were sent. Do not silently skip.
- If a parent ID is missing (creation failed upstream), do not attempt to create children — ask the user how to proceed.
- If required config fields are missing (e.g. `areaPath` is still a TODO placeholder), stop and ask the user to fill them in before pushing.
