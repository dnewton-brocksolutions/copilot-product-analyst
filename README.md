# Business Analyst Agent Plugin

A VS Code **agent plugin** that provides an AI-powered Business Analyst mode for GitHub Copilot. The agent helps your team create concise, well-structured work items (User Stories, Tasks, Bugs, PRs, Release Notes) grounded in your project's specific tech stack and architecture.

---

## What You Get

- **AI-powered BA mode** — activate via the Business Analyst custom chat mode in GitHub Copilot Chat
- **Project-aware work items** — agent reads your `project-config.json` before creating any work item
- **Built-in skills** — `/business-analyst:story`, `/business-analyst:bug`, `/business-analyst:decompose`, and more, each loading on-demand
- **Consistent output** — three-file story pattern, Objective + Requirements tasks, strict ADO bug format
- **Scalable catalog system** — service and component catalogs for accurate estimation

---

## Install the Plugin (2 minutes)

> **Prerequisite:** GitHub Copilot with agent plugin support (VS Code 1.99+, `chat.plugins.enabled: true`)

### Option A — Install from Git URL (recommended)

1. Open the Command Palette (`Ctrl+Shift+P`)
2. Run **Chat: Install Plugin From Source**
3. Enter the Git repository URL for this plugin
4. VS Code clones and installs it — the Business Analyst agent is now available globally

### Option B — Use a local clone

Add the cloned directory to your VS Code settings:

```json
// settings.json
"chat.pluginLocations": {
    "/path/to/ba-agent-installer": true
}
```

---

## Set Up Your Project (15–60 minutes)

The plugin provides the agent globally. Each project needs its own configuration so the agent understands your tech stack.

### Step 1 — Copy the documentation templates

Copy the `documentation/` folder from this repo into your project:

```
<your-project>/documentation/business-analyst-workflow/
```

This gives you the project config template, work item templates, catalog templates, and guides.

### Step 2 — Configure your project

Edit `documentation/business-analyst-workflow/project-config.json`. Replace all `TODO` placeholders:

- Project name and description
- Frontend framework and applications
- Backend framework, architecture, protocol
- Database systems and migration tools
- Work tracking tool and organization paths
- Team standards (estimation, coverage, accessibility)

See [SETUP-CHECKLIST.md](SETUP-CHECKLIST.md) for a step-by-step walkthrough.

### Step 3 — Build your catalogs (recommended)

Populate the catalog templates in `documentation/business-analyst-workflow/catalogs/` with your actual services and components. Better catalogs = more accurate estimates.

### Step 4 — Test it

Open GitHub Copilot Chat, select the **Business Analyst** custom mode, and type:

```
/business-analyst:context
```

The agent should read your `project-config.json` and summarize your tech stack. Then try:

```
/business-analyst:story Add a login page for operators
```

> **Optional — Live database investigation:** The agent can query your databases directly during task decomposition (inspecting table schemas and stored procedures before writing backend requirements). This requires a compatible MCP server registered in VS Code. See the [VS Code MCP documentation](https://code.visualstudio.com/docs/copilot/chat/mcp-servers) for setup. The agent works fully without MCP — database investigation just becomes a manual step.

---

## Available Skills

Each skill loads its detailed instructions on demand when you invoke it. Skills are automatically prefixed with the plugin name when installed via the plugin.

| Slash Command                     | Description                                                                           |
| --------------------------------- | ------------------------------------------------------------------------------------- |
| `/business-analyst:context`       | Analyze and summarize project configuration and tech stack                            |
| `/business-analyst:story`         | Create a user story using the Three-File Pattern (story + technical spec + estimates) |
| `/business-analyst:decompose`     | Break a story into backend and frontend tasks with Objective + Requirements structure |
| `/business-analyst:bug`           | Create a structured bug with Description, Repro Steps, Severity, and Impact           |
| `/business-analyst:pr`            | Generate a structured PR description from completed code changes                      |
| `/business-analyst:investigate`   | Research a request and produce a findings report before creating work items           |
| `/business-analyst:release-notes` | Generate release notes from a sprint or list of completed work items                  |

---

## Plugin Structure

```
ba-agent-installer/
├── plugin.json                         ← Plugin manifest (auto-detected by VS Code)
├── README.md                           ← You are here
├── SETUP-CHECKLIST.md                  ← Step-by-step project config guide
│
├── agents/
│   └── business-analyst-core.agent.md     ← Agent persona, role, defaults, DoR/DoD
│
├── skills/                             ← On-demand skill instructions
│   ├── context/SKILL.md                   ← /business-analyst:context
│   ├── story/SKILL.md                     ← /business-analyst:story
│   ├── decompose/SKILL.md                 ← /business-analyst:decompose
│   ├── bug/SKILL.md                       ← /business-analyst:bug
│   ├── pr/SKILL.md                        ← /business-analyst:pr
│   ├── investigate/SKILL.md               ← /business-analyst:investigate
│   └── release-notes/SKILL.md             ← /business-analyst:release-notes
│
└── documentation/                      ← Copy this into each project that uses the agent
    ├── project-config.json                ← Template config (fill in your details)
    ├── CUSTOMIZATION-GUIDE.md             ← Detailed guide for adapting to any project
    ├── BA-AGENT-DIAGRAMS.md           ← Architecture diagrams of how the agent works
    ├── MCP-DATABASE-SETUP.md          ← Optional: connect agent to live databases
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

## Project Setup: Folder Structure

After copying `documentation/` into your project:

```
<your-project>/
└── documentation/
    └── business-analyst-workflow/
        ├── project-config.json               ← Your project config (required)
        ├── CUSTOMIZATION-GUIDE.md
        ├── guides/                           ← Process guides
        ├── work-item-templates/              ← Work item templates
        └── catalogs/                         ← Service & component catalogs
```

Work items the agent creates go in:

```
<your-project>/
└── documentation/
    └── work-items/
        ├── USER-STORY-*.md
        ├── TECHNICAL-*.md
        ├── ESTIMATES-*.md
        ├── TASK-1-backend-*.md
        ├── TASK-2-frontend-*.md
        ├── BUG-*.md
        └── PR-*.md
```

---

## Customization

See [SETUP-CHECKLIST.md](SETUP-CHECKLIST.md) for the full configuration walkthrough.

The agent follows a **core + config** pattern:

- `agents/business-analyst-core.agent.md` — persona, role, DoR/DoD — never needs editing
- `skills/<name>/SKILL.md` — per-command instructions, loaded only when that skill is invoked
- `project-config.json` — all project-specific details live here
- `catalogs/` — optional but improves estimate accuracy significantly

---

## Troubleshooting

**Agent doesn't appear in Copilot Chat?**

- Confirm `chat.plugins.enabled` is `true` in VS Code settings
- Run **MCP: List Servers** or check **Extensions > Agent Plugins — Installed**
- Reload the VS Code window (`Ctrl+Shift+P` → "Reload Window")

**Agent produces generic work items without using my tech stack?**

- Verify `project-config.json` exists at `documentation/business-analyst-workflow/project-config.json` in your workspace
- Check for JSON syntax errors in the config file
- Start with `/business-analyst:context` — the agent will read and confirm your project config before proceeding

**Work item templates not referenced?**

- The agent reads templates from `documentation/business-analyst-workflow/work-item-templates/`
- Ensure that path exists relative to your workspace root

---

## Questions & Feedback

This agent was built for teams using GitHub Copilot Chat. For customizations beyond what `project-config.json` supports, see `documentation/business-analyst-workflow/CUSTOMIZATION-GUIDE.md` and the inline comments in each `skills/<name>/SKILL.md` file.
