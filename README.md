# Product Analyst Agent Plugin

A VS Code **agent plugin** that provides an AI-powered Product Analyst mode for GitHub Copilot. The agent helps your team create concise, well-structured work items (User Stories, Tasks, Bugs, PRs, Release Notes) grounded in your project's specific tech stack and architecture.

---

## What You Get

- **AI-powered PA mode** — activate via the Product Analyst custom chat mode in GitHub Copilot Chat
- **Project-aware work items** — agent reads your `project-config.json` before creating any work item
- **Built-in skills** — `/product-analyst:story`, `/product-analyst:bug`, `/product-analyst:decompose`, and more, each loading on-demand
- **Consistent output** — three-file story pattern, Objective + Requirements tasks, strict ADO bug format
- **Scalable catalog system** — service and component catalogs for accurate estimation

---

## Install the Plugin (2 minutes)

> **Prerequisite:** Claude Code (bundled in VS Code Copilot Chat 0.45+) or the standalone Claude Code CLI.

### Option A — Install from GitHub (recommended)

In Claude Code (or the Copilot Chat panel), run:

```
/plugin marketplace add dnewton-brocksolutions/copilot-product-analyst
```

Then install the plugin:

```
/plugin install product-analyst@dnewton-brocksolutions-copilot-product-analyst
```

### Option B — Install from a local clone

Clone this repo, then add it as a local marketplace:

```
/plugin marketplace add /path/to/copilot-product-analyst
```

Then install:

```
/plugin install product-analyst@copilot-product-analyst
```

### Option C — Load for a single session (no install)

```
claude --plugin-dir /path/to/copilot-product-analyst
```

---

## Set Up Your Project (15–60 minutes)

The plugin provides the agent globally. Each project needs its own configuration so the agent understands your tech stack.

### Step 1 — Copy the documentation templates

Copy the `documentation/` folder from this repo into your project:

```
<your-project>/documentation/product-analyst-workflow/
```

This gives you the project config template, work item templates, catalog templates, and guides.

### Step 2 — Configure your project

Edit `documentation/product-analyst-workflow/project-config.json`. Replace all `TODO` placeholders:

- Project name and description
- Frontend framework and applications
- Backend framework, architecture, protocol
- Database systems and migration tools
- Work tracking tool and organization paths
- Team standards (estimation, coverage, accessibility)

See [SETUP-CHECKLIST.md](SETUP-CHECKLIST.md) for a step-by-step walkthrough.

### Step 3 — Build your catalogs (recommended)

Populate the catalog templates in `documentation/product-analyst-workflow/catalogs/` with your actual services and components. Better catalogs = more accurate estimates.

### Step 4 — Test it

Open GitHub Copilot Chat, select the **Product Analyst** custom mode, and type:

```
/product-analyst:context
```

The agent should read your `project-config.json` and summarize your tech stack. Then try:

```
/product-analyst:story Add a login page for operators
```

> **Optional — Live database investigation:** The agent can query your databases directly during task decomposition (inspecting table schemas and stored procedures before writing backend requirements). This requires a compatible MCP server registered in VS Code. See the [VS Code MCP documentation](https://code.visualstudio.com/docs/copilot/chat/mcp-servers) for setup. The agent works fully without MCP — database investigation just becomes a manual step.

---

## Available Skills

Each skill loads its detailed instructions on demand when you invoke it. Skills are automatically prefixed with the plugin name when installed via the plugin.

| Slash Command                    | Description                                                                           |
| -------------------------------- | ------------------------------------------------------------------------------------- |
| `/product-analyst:context`       | Analyze and summarize project configuration and tech stack                            |
| `/product-analyst:story`         | Create a user story using the Three-File Pattern (story + technical spec + estimates) |
| `/product-analyst:decompose`     | Break a story into backend and frontend tasks with Objective + Requirements structure |
| `/product-analyst:bug`           | Create a structured bug with Description, Repro Steps, Severity, and Impact           |
| `/product-analyst:pr`            | Generate a structured PR description from completed code changes                      |
| `/product-analyst:investigate`   | Research a request and produce a findings report before creating work items           |
| `/product-analyst:release-notes` | Generate release notes from a sprint or list of completed work items                  |

---

## Plugin Structure

```
copilot-product-analyst/
├── .claude-plugin/
│   ├── plugin.json                        ← Plugin manifest (name, version, author)
│   └── marketplace.json                   ← Marketplace catalog (required for /plugin marketplace add)
├── README.md                           ← You are here
├── SETUP-CHECKLIST.md                  ← Step-by-step project config guide
│
├── agents/
│   └── product-analyst-core.agent.md     ← Agent persona, role, defaults, DoR/DoD
│
├── skills/                             ← On-demand skill instructions
│   ├── context/SKILL.md                   ← /product-analyst:context
│   ├── story/SKILL.md                     ← /product-analyst:story
│   ├── decompose/SKILL.md                 ← /product-analyst:decompose
│   ├── bug/SKILL.md                       ← /product-analyst:bug
│   ├── pr/SKILL.md                        ← /product-analyst:pr
│   ├── investigate/SKILL.md               ← /product-analyst:investigate
│   └── release-notes/SKILL.md             ← /product-analyst:release-notes
│
└── documentation/                      ← Copy this into each project that uses the agent
    ├── project-config.json                ← Template config (fill in your details)
    ├── CUSTOMIZATION-GUIDE.md             ← Detailed guide for adapting to any project
    ├── PA-AGENT-DIAGRAMS.md           ← Architecture diagrams of how the agent works
    ├── MCP-DATABASE-SETUP.md          ← Optional: connect agent to live databases
    │
    ├── guides/
    │   ├── QUICK-START-PRODUCT-ANALYST.md
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
    └── product-analyst-workflow/
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

- `agents/product-analyst-core.agent.md` — persona, role, DoR/DoD — never needs editing
- `skills/<name>/SKILL.md` — per-command instructions, loaded only when that skill is invoked
- `project-config.json` — all project-specific details live here
- `catalogs/` — optional but improves estimate accuracy significantly

---

## Troubleshooting

**"no plugins found … does not appear to be a valid plugin marketplace"?**

- The marketplace is defined at `.claude-plugin/marketplace.json`, not at the repo root. Make sure you cloned the latest version of this repo.
- Use `/plugin marketplace add <path>` pointing to the repo directory (not to a specific file).

**Agent skills don't appear after installing?**

- Run `/reload-plugins` inside Claude Code to pick up newly installed plugins.
- Verify the plugin is listed in `/plugin` → Installed tab.

**Agent produces generic work items without using my tech stack?**

- Verify `project-config.json` exists at `documentation/product-analyst-workflow/project-config.json` in your workspace
- Check for JSON syntax errors in the config file
- Start with `/product-analyst:context` — the agent will read and confirm your project config before proceeding

**Work item templates not referenced?**

- The agent reads templates from `documentation/product-analyst-workflow/work-item-templates/`
- Ensure that path exists relative to your workspace root

---

## Questions & Feedback

This agent was built for teams using GitHub Copilot Chat. For customizations beyond what `project-config.json` supports, see `documentation/product-analyst-workflow/CUSTOMIZATION-GUIDE.md` and the inline comments in each `skills/<name>/SKILL.md` file.
