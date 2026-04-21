# Setup Checklist — Business Analyst Agent

Use this checklist after running `install.sh` to configure the agent for your project. Work through it top to bottom — it takes about 30–60 minutes for a new project.

---

## Phase 1: Core Configuration (Required — ~15 min)

Edit `documentation/business-analyst-workflow/project-config.json` and replace every `TODO` field.

### 1.1 Project Identity

- [ ] Set `projectName` — your project's full name
- [ ] Set `description` — one sentence about what your application does

### 1.2 Frontend Stack

- [ ] Set `frontend.framework` — React, Vue, Angular, Svelte, etc.
- [ ] Set `frontend.version` — e.g. `18.x`
- [ ] Set `frontend.stateManagement` — Redux Toolkit, Pinia, Vuex, etc.
- [ ] Set `frontend.dataFetching` — RTK Query, React Query, Axios, etc.
- [ ] Set `frontend.styling` — Material-UI, Tailwind, Bootstrap, etc.
- [ ] Set `frontend.testing` — Jest + RTL, Vitest, Cypress, etc.
- [ ] Add entries to `frontend.applications` — one entry per distinct app/module
  - [ ] Set `name` — short identifier (e.g. `AdminPortal`)
  - [ ] Set `description` — what this app does and who uses it

### 1.3 Backend Stack

- [ ] Set `backend.framework` — C#, Java, Python, Node.js, Go, etc.
- [ ] Set `backend.version` — e.g. `.NET 8.0`, `Java 21`
- [ ] Set `backend.architecture` — Microservices, Monolith, Serverless, etc.
- [ ] Set `backend.protocol` — gRPC, REST, GraphQL, tRPC, etc.
- [ ] Set `backend.orm` — EF Core, Hibernate, TypeORM, etc.
- [ ] Set `backend.testing` — xUnit + Moq, JUnit + Mockito, pytest, etc.
- [ ] (Optional) List `backend.commonServices` — shared platform services other features depend on

### 1.4 Database

- [ ] Add entries to `database.systems` — one entry per database
  - [ ] Set `name` — identifier used in work items (e.g. `MainDB`)
  - [ ] Set `description` — what this database stores
  - [ ] Set `migrationTool` — Liquibase, Flyway, EF Migrations, etc.
  - [ ] Set `updateProcess` — how schema changes reach production
  - [ ] Set `preferredUse` — when to target this database for new work

### 1.5 Work Tracking

- [ ] Set `workTracking.tool` — Azure DevOps, Jira, GitHub Issues, Linear, etc.
- [ ] Set `workTracking.process` — Agile, Scrum, Kanban
- [ ] Set `workTracking.workItemTypes` — list the types used (e.g. Epic, Feature, Story, Task, Bug)
- [ ] Set `workTracking.areaPath` — team/project path in your tool
- [ ] Set `workTracking.iterationPath` — default sprint or iteration

### 1.6 Standards

- [ ] Set `standards.estimationUnit` — `hours` or `story-points`
- [ ] Set `standards.coverage.target` — e.g. `≥80%`
- [ ] Set `standards.accessibility.standard` — WCAG AA, Section 508, or none
- [ ] Set `standards.featureFlags.policy` — always, risk-based, or never
- [ ] Add default `tags` for your tech stack

---

## Phase 2: Verify Agent Works (~5 min)

- [ ] Open VS Code
- [ ] Open GitHub Copilot Chat (`Ctrl+Shift+I` or sidebar)
- [ ] Type: `@business-analyst Read project-config.json and tell me what tech stack we use`
- [ ] Confirm the agent reads your config and reflects the correct stack
- [ ] Type: `@business-analyst /story Add a login page for users`
- [ ] Confirm the work item references your actual applications and tech stack

---

## Phase 3: Build Catalogs (Recommended — ~1-2 hrs)

Catalogs dramatically improve work item quality and estimate accuracy.

### 3.1 Service Catalog (`catalogs/service-catalog.md`)

Start from `catalogs/service-catalog.template.md`. For each backend service/module:

- [ ] Document its purpose (one sentence)
- [ ] List its key endpoints or methods (3-5 most common)
- [ ] Provide extension estimates (add endpoint, add feature)
- [ ] Note any patterns, dependencies, or gotchas

**Priority:** Document your 5 most commonly extended services first.

### 3.2 Component Catalog (`catalogs/component-catalog.md`)

Start from `catalogs/component-catalog.template.md`. For each significant frontend component:

- [ ] Document its purpose
- [ ] List which pages or features already use it
- [ ] Provide reuse estimate vs. build-from-scratch estimate

**Priority:** Document your most-reused widgets and page templates first.

---

## Phase 4: Team Onboarding (~15 min)

- [ ] Share the [QUICK-START-BUSINESS-ANALYST.md](guides/QUICK-START-BUSINESS-ANALYST.md) guide with your team
- [ ] Review the [TASK-DECOMPOSITION-GUIDE.md](guides/TASK-DECOMPOSITION-GUIDE.md) so everyone understands the Backend → Frontend task order
- [ ] Review the [ESTIMATES-SEPARATION-GUIDE.md](guides/ESTIMATES-SEPARATION-GUIDE.md) so everyone knows estimates belong in separate files
- [ ] Run a quick demo: create a sample story and decompose it together

---

## Phase 5: Optional Enhancements

These are optional but can improve the agent's quality over time.

- [ ] Add `estimationGuidelines` to `project-config.json` with baseline estimates for your most common task types
- [ ] Add `definitionOfReady.additionalCriteria` for project-specific DoR gates
- [ ] Add `definitionOfDone.additionalCriteria` for project-specific DoD requirements
- [ ] **Add MCP database access** — lets the agent query live databases during task creation so backend task requirements are grounded in actual table/procedure definitions rather than guesswork

  **How it works:** MCP tools are registered in VS Code and made available to all agents automatically. The BA agent knows how and when to call them — you just need a compatible MCP server running and registered.

  **Setup steps:**
  1. Set up an MCP server that can connect to your database (build your own or use an existing one compatible with your DB engine)
  2. Register the server in VS Code by adding an entry to `.vscode/mcp.json`
  3. Confirm tools are available — open Copilot Chat and verify the MCP tools appear

  **Reference:** [VS Code MCP documentation](https://code.visualstudio.com/docs/copilot/chat/mcp-servers)

- [ ] Review and update catalogs after major features are delivered
- [ ] Keep an `ESTIMATES-actual.md` to track estimate vs. actual and improve future estimates

---

## Quick Reference

| What                | Where                                                                            |
| ------------------- | -------------------------------------------------------------------------------- |
| Project config      | `documentation/business-analyst-workflow/project-config.json`                    |
| Service catalog     | `documentation/business-analyst-workflow/catalogs/service-catalog.md`            |
| Component catalog   | `documentation/business-analyst-workflow/catalogs/component-catalog.md`          |
| Work item templates | `documentation/business-analyst-workflow/work-item-templates/`                   |
| Work item output    | `documentation/work-items/`                                                      |
| Quick start guide   | `documentation/business-analyst-workflow/guides/QUICK-START-BUSINESS-ANALYST.md` |
| Agent definition    | `.github/agents/business-analyst-core.agent.md`                                  |

---

## Common Problems

**Agent doesn't load project config?**
→ Check that `project-config.json` is at `documentation/business-analyst-workflow/project-config.json` relative to your workspace root.

**JSON parse error?**
→ Paste your `project-config.json` into [jsonlint.com](https://jsonlint.com/) to find syntax errors.

**Work items don't reference my tech stack?**
→ Start a fresh Copilot Chat session, then explicitly say: _"Read project-config.json before we begin."_

**Agent not found in Copilot Chat?**
→ Ensure `.github/agents/business-analyst-core.agent.md` exists and VS Code extension is up to date. Reload window.
