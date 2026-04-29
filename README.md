# Product Analyst Agent

A **custom Copilot Chat agent** that helps your team create well-structured work items — User Stories, Tasks, Bugs, PRs, and Release Notes — grounded in your project's specific tech stack and architecture.

---

## Install

Copy three things from this repo into your project:

```bash
# 1. Agent definition (workspace-scoped chat mode)
cp -r .github/  <your-project>/.github/

# 2. Project config, templates, and guides
cp -r documentation/  <your-project>/documentation/product-analyst-workflow/
```

Then reload VS Code (`Ctrl+Shift+P` → **Reload Window**).

The **Product Analyst** mode will appear in the Copilot Chat mode picker, and `/pa-story`, `/pa-bug`, etc. will be available as slash commands.

> **What gets installed:**
>
> - `.github/agents/product-analyst-core.agent.md` — the chat mode (workspace-scoped)
> - `.github/prompts/pa-*.prompt.md` — workflow slash commands
> - `documentation/product-analyst-workflow/` — config template, work item templates, guides

---

## Configure Your Project

Edit `documentation/product-analyst-workflow/project-config.json` and replace the `TODO` placeholders with your project's details:

- Frontend framework, applications, state management, testing
- Backend framework, architecture, API protocol, ORM
- Database systems and migration tools
- Work tracking tool (ADO, Jira, GitHub Issues), area/iteration paths
- Team standards: estimation unit, coverage target, accessibility

See [SETUP-CHECKLIST.md](SETUP-CHECKLIST.md) for a step-by-step walkthrough (~30–60 min for a new project).

---

## Verify It Works

Open Copilot Chat, select **Product Analyst** mode, and run:

```
/pa-context
```

The agent reads your `project-config.json` and summarizes your tech stack. Then try:

```
/pa-story Add a login page for operators
```

---

## Available Workflows

| Slash Command       | What it does                                                               |
| ------------------- | -------------------------------------------------------------------------- |
| `/pa-context`       | Summarize project configuration and tech stack                             |
| `/pa-story`         | Create a user story (story + technical spec + estimates)                   |
| `/pa-decompose`     | Break a story into backend and frontend tasks                              |
| `/pa-bug`           | Create a structured bug with repro steps and severity                      |
| `/pa-pr`            | Generate a PR description from completed changes                           |
| `/pa-investigate`   | Research a request and produce a findings report before writing work items |
| `/pa-release-notes` | Generate release notes from a sprint or list of completed work items       |

---

## What Gets Created

Work items the agent creates go in `documentation/work-items/`:

```
documentation/work-items/
├── USER-STORY-*.md
├── TECHNICAL-*.md
├── ESTIMATES-*.md
├── TASK-1-backend-*.md
├── TASK-2-frontend-*.md
├── BUG-*.md
└── PR-*.md
```

---

## Repo Structure

```
copilot-product-analyst/
├── README.md
├── SETUP-CHECKLIST.md
│
├── .github/
│   ├── agents/
│   │   └── product-analyst-core.agent.md  ← chat mode definition
│   └── prompts/
│       ├── pa-context.prompt.md
│       ├── pa-story.prompt.md
│       ├── pa-decompose.prompt.md
│       ├── pa-bug.prompt.md
│       ├── pa-pr.prompt.md
│       ├── pa-investigate.prompt.md
│       └── pa-release-notes.prompt.md
│
└── documentation/
    ├── project-config.json                ← fill in your project details
    ├── CUSTOMIZATION-GUIDE.md
    ├── PA-AGENT-DIAGRAMS.md
    ├── MCP-SETUP.md
    ├── guides/
    └── work-item-templates/
```

---

## Customization

The agent uses a **core + config** pattern. You never need to edit the agent or prompt files — all project-specific behavior comes from:

- `project-config.json` — tech stack, area paths, estimation unit, standards

See [CUSTOMIZATION-GUIDE.md](documentation/CUSTOMIZATION-GUIDE.md) for advanced configuration.

---

## Troubleshooting

**Product Analyst mode doesn't appear?**
→ Confirm `.github/agents/product-analyst-core.agent.md` exists in the workspace root and reload VS Code.

**Slash commands not appearing?**
→ Confirm `.github/prompts/` exists in the workspace and reload VS Code.

**Work items are generic (not using my stack)?**
→ Run `/pa-context` first. If it doesn't reflect your stack, check `project-config.json` for `TODO` placeholders or JSON syntax errors.

**Want the agent available in every workspace (not just this one)?**
→ Copy `.github/agents/product-analyst-core.agent.md` to your VS Code user prompts folder:

```bash
# Linux / VS Code Server
cp .github/agents/product-analyst-core.agent.md ~/.vscode-server/data/User/prompts/

# macOS local
cp .github/agents/product-analyst-core.agent.md ~/Library/Application\ Support/Code/User/prompts/
```
