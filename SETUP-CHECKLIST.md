# Setup Checklist — Product Analyst Agent

Use this checklist after installing the agent to configure it for your project. Work through it top to bottom — it takes about 30–60 minutes for a new project.

## Prerequisites

- [ ] VS Code with GitHub Copilot Chat extension installed
- [ ] `.github/agents/product-analyst-core.agent.md` copied to your VS Code user prompts folder (see [README.md](README.md) install steps)
- [ ] VS Code window reloaded — **Product Analyst** mode appears in the Copilot Chat mode picker

## Phase 0: Copy Templates into Your Project (~2 min)

Copy two folders from this repo into your project:

```bash
# Workflow slash commands (gives you /pa-story, /pa-bug, etc.)
cp -r .github/prompts/  <your-project>/.github/prompts/

# Project config, work item templates, and guides
cp -r documentation/  <your-project>/documentation/product-analyst-workflow/
```

---

## Phase 1: Core Configuration (Required — ~15 min)

Edit `documentation/product-analyst-workflow/project-config.json` and replace every `TODO` field.

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
- [ ] Select the **Product Analyst** custom mode from the mode picker
- [ ] Type: `/pa-context`
- [ ] Confirm the agent reads your config and reflects the correct stack
- [ ] Type: `/pa-story Add a login page for users`
- [ ] Confirm the work item references your actual applications and tech stack

---

## Phase 3: Team Onboarding (~15 min)

- [ ] Share the [QUICK-START-PRODUCT-ANALYST.md](guides/QUICK-START-PRODUCT-ANALYST.md) guide with your team
- [ ] Review the [TASK-DECOMPOSITION-GUIDE.md](guides/TASK-DECOMPOSITION-GUIDE.md) so everyone understands the Backend → Frontend task order
- [ ] Review the [ESTIMATES-SEPARATION-GUIDE.md](guides/ESTIMATES-SEPARATION-GUIDE.md) so everyone knows estimates belong in separate files
- [ ] Run a quick demo: create a sample story and decompose it together

---

## Phase 4: Optional Enhancements

These are optional but can improve the agent's quality over time.

- [ ] Add `estimationGuidelines` to `project-config.json` with baseline estimates for your most common task types
- [ ] Add `definitionOfReady.additionalCriteria` for project-specific DoR gates
- [ ] Add `definitionOfDone.additionalCriteria` for project-specific DoD requirements
- [ ] **Add MCP database access** — lets the agent query live databases during task creation so backend task requirements are grounded in actual table/procedure definitions rather than guesswork

  **How it works:** MCP tools are registered in VS Code and made available to all agents automatically. The PA agent knows how and when to call them — you just need a compatible MCP server running and registered.

  **Setup steps:**
  1. Set up an MCP server that can connect to your database (build your own or use an existing one compatible with your DB engine)
  2. Register the server in VS Code by adding an entry to `.vscode/mcp.json`
  3. Confirm tools are available — open Copilot Chat and verify the MCP tools appear

  **Reference:** [VS Code MCP documentation](https://code.visualstudio.com/docs/copilot/chat/mcp-servers)

- [ ] Keep an `ESTIMATES-actual.md` to track estimate vs. actual and improve future estimates

---

## Quick Reference

| What                | Where                                                                          |
| ------------------- | ------------------------------------------------------------------------------ |
| Project config      | `documentation/product-analyst-workflow/project-config.json`                   |
| Work item templates | `documentation/product-analyst-workflow/work-item-templates/`                  |
| Work item output    | `documentation/work-items/`                                                    |
| Quick start guide   | `documentation/product-analyst-workflow/guides/QUICK-START-PRODUCT-ANALYST.md` |
| Agent definition    | `.github/agents/product-analyst-core.agent.md`                                 |
| Slash commands      | `.github/prompts/`                                                             |

---

## Common Problems

**Agent doesn't load project config?**
→ Check that `project-config.json` is at `documentation/product-analyst-workflow/project-config.json` relative to your workspace root.

**JSON parse error?**
→ Paste your `project-config.json` into [jsonlint.com](https://jsonlint.com/) to find syntax errors.

**Work items don't reference my tech stack?**
→ Start a fresh Copilot Chat session, then explicitly say: _"Read project-config.json before we begin."_

**Agent not found in Copilot Chat?**
→ Ensure `product-analyst-core.agent.md` has been copied to your VS Code user prompts folder and you've reloaded the window. See [README.md](README.md) for the exact path for your OS.
