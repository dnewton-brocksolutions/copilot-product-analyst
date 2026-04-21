# Business Analyst Agent — Standalone Installer

This folder contains everything you need to install the **Business Analyst AI agent** into any project using GitHub Copilot. Once installed, the agent helps your team create concise, well-structured work items (User Stories, Tasks, Bugs, Epics) grounded in your project's specific tech stack and architecture.

---

## What You Get

- **AI-powered BA mode** — activate via `@business-analyst` in GitHub Copilot Chat
- **Project-aware work items** — agent reads your `project-config.json` before creating any work item
- **Consistent templates** — backend tasks, frontend tasks, estimates, bugs, and user stories
- **Separation of concerns** — requirements and estimates kept in separate documents
- **Scalable catalog system** — service and component catalogs for accurate estimation

---

## Quick Install (5 minutes)

> **Prerequisite:** GitHub Copilot with agent/chatmode support (VS Code extension v1.99+)

> **Optional — Live database investigation:** The agent can query your databases directly during task creation (e.g. inspecting table schemas and stored procedures before writing backend requirements). This requires a compatible MCP server to be registered in VS Code. See the [VS Code MCP documentation](https://code.visualstudio.com/docs/copilot/chat/mcp-servers) for setup guidance. The agent works fully without MCP — database investigation just becomes a manual step.

### Step 1 — Run the install script

From terminal, inside your project root:

```bash
bash /path/to/ba-agent-installer/install.sh /path/to/your/project
```

Or copy files manually — see [manual install](#manual-install) below.

### Step 2 — Configure your project

Edit `documentation/business-analyst-workflow/project-config.json` in your project. Replace all `TODO` placeholders with your project's information:

- Project name and description
- Frontend framework and applications
- Backend framework, architecture, protocol
- Database systems and migration tools
- Work tracking tool and organization paths
- Team standards (estimation, coverage, accessibility)

See [SETUP-CHECKLIST.md](SETUP-CHECKLIST.md) for a step-by-step configuration walkthrough.

### Step 3 — Build your catalogs (optional but recommended)

Populate the catalog templates in `documentation/business-analyst-workflow/catalogs/` with your actual services and components. Better catalogs = more accurate estimates.

### Step 4 — Test it

Open GitHub Copilot Chat and type:

```
@business-analyst /story Add a login page for operators
```

The agent should respond by first reading your `project-config.json` and producing a work item that references your actual tech stack.

---

## Manual Install

If you prefer to copy files manually:

```
1. Copy agent file:
   agent/business-analyst-core.agent.md       →  <project>/.github/agents/business-analyst-core.agent.md

2. Copy prompt files:
   agent/prompts/*.prompt.md                  →  <project>/.github/prompts/

3. Copy documentation folder:
   documentation/                             →  <project>/documentation/business-analyst-workflow/

4. Edit project config:
   <project>/documentation/business-analyst-workflow/project-config.json
```

---

## Folder Structure (This Package)

```
ba-agent-installer/
├── README.md                          ← You are here
├── SETUP-CHECKLIST.md                 ← Step-by-step config guide
├── install.sh                         ← Automated install script
│
├── agent/
│   ├── business-analyst-core.agent.md ← The universal agent (copy to .github/agents/)
│   └── prompts/                        ← Reusable prompt files (copy to .github/prompts/)
│       ├── analyze-project-context.prompt.md
│       ├── create-bug.prompt.md
│       ├── create-user-story.prompt.md
│       ├── decompose-story-tasks.prompt.md
│       ├── investigate-request.prompt.md
│       └── release-notes.prompt.md
│
└── documentation/
    ├── project-config.json            ← Template config (fill in your details)
    ├── CUSTOMIZATION-GUIDE.md         ← Detailed guide for adapting to any project
    ├── BA-AGENT-DIAGRAMS.md           ← Architecture diagrams (Mermaid) of how the agent works
    ├── MCP-DATABASE-SETUP.md          ← Optional: connect agent to live SQL Server databases
    │
    ├── guides/
    │   ├── QUICK-START-BUSINESS-ANALYST.md
    │   ├── ESTIMATES-TEMPLATE.md
    │   ├── ESTIMATES-SEPARATION-GUIDE.md
    │   └── TASK-DECOMPOSITION-GUIDE.md
    │
    ├── work-item-templates/
    │   ├── README.md
    │   ├── backend-task-simple.md
    │   ├── frontend-task-simple.md
    │   ├── business-focused-task-template.md
    │   ├── business-focused-user-story-template.md
    │   ├── spike-task-template.md
    │   └── test-plan-task-template.md
    │
    └── catalogs/
        ├── README.md
        ├── service-catalog.template.md    ← Fill in your backend services
        └── component-catalog.template.md  ← Fill in your frontend components
```

---

## After Installation: Folder Structure in Your Project

```
<your-project>/
├── .github/
│   ├── agents/
│   │   └── business-analyst-core.agent.md   ← Agent definition
│   └── prompts/
│       ├── analyze-project-context.prompt.md
│       ├── create-bug.prompt.md
│       ├── create-user-story.prompt.md
│       ├── decompose-story-tasks.prompt.md
│       ├── investigate-request.prompt.md
│       └── release-notes.prompt.md
│
└── documentation/
    └── business-analyst-workflow/
        ├── project-config.json               ← Your project config
        ├── guides/                           ← Process guides
        ├── work-item-templates/              ← Work item templates
        └── catalogs/                         ← Service & component catalogs
```

---

## Customization

See [SETUP-CHECKLIST.md](SETUP-CHECKLIST.md) for the full list of things to customize.

The agent is designed around a **core + config** pattern:

- `business-analyst-core.agent.md` — universal behavior, never needs editing
- `project-config.json` — all project-specific details live here
- `catalogs/` — optional but improves estimate accuracy significantly

---

## Troubleshooting

**Agent doesn't appear in Copilot Chat?**

- Ensure the file is at `.github/agents/business-analyst-core.agent.md`
- Ensure VS Code GitHub Copilot extension is up to date (v1.99+)
- Reload VS Code window (`Ctrl+Shift+P` → "Reload Window")

**Agent produces generic work items without using my tech stack?**

- Verify `project-config.json` exists at `documentation/business-analyst-workflow/project-config.json`
- Check for JSON syntax errors in the config file
- Try explicitly asking: "Read project-config.json first, then create a story for..."

**Work item templates are not referenced?**

- The agent reads templates from `documentation/business-analyst-workflow/work-item-templates/`
- Ensure that path exists relative to your workspace root

---

## Questions & Feedback

This agent was built for teams using GitHub Copilot Chat. For customizations beyond what `project-config.json` supports, see the inline comments in `business-analyst-core.agent.md`.
