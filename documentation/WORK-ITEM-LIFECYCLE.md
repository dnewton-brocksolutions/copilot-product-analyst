# Work Item Lifecycle — Markdown Files to Azure DevOps

> **Purpose:** Clarify the role of generated markdown files and their lifecycle in the Product Analyst workflow  
> **Audience:** Teams using the Product Analyst agent to create work items

---

## The Model: Temporary Staging → ADO as Source of Truth

Generated markdown files (`.md`) are **temporary working documents**. They are:

- ✅ Created for refinement and review in Copilot Chat
- ✅ Pushed to Azure DevOps as permanent work items via `/pa-push-ado`
- ❌ NOT meant to stay in your repo indefinitely after pushing

---

## File Lifecycle

### Phase 1: Creation (Draft)

**When:** Run a PA workflow command (`/pa-story`, `/pa-bug`, `/pa-decompose`, etc.)

**What:** Agent generates `.md` files in `documentation/work-items/`

**Files created:**

- `USER-STORY-*.md` — Story definition
- `TECHNICAL-*.md` — Tech spec / implementation guide
- `ESTIMATES-*.md` — Effort breakdown
- `TASK-*.md` — Individual implementation tasks
- `BUG-*.md` — Bug report
- `PR-*.md` — PR description template

**Action:** Review and refine in Copilot Chat. Ask follow-up questions, request changes.

---

### Phase 2: Confirmation & Refinement

**When:** After reviewing generated files

**Action:** Adjust work items directly in the `.md` files using VS Code editor, or ask the agent to refine them. Common changes:

- Split/combine tasks
- Adjust story points or estimates
- Rewrite acceptance criteria for clarity
- Add missing technical details

**Files:** Modified `.md` files remain in `documentation/work-items/`

---

### Phase 3: Push to ADO

**When:** Ready to commit work items into the project backlog

**How:** Use `/pa-push-ado` workflow command

**What happens:**

- Agent reads all `.md` files from your current session
- Confirms hierarchy with you (parent/child structure, story points, etc.)
- Pushes work items to Azure DevOps
- Returns ADO work item IDs and URLs

**Result:** ✅ Work items now live in ADO (source of truth)

---

### Phase 4: Cleanup (Optional but Recommended)

**After pushing to ADO:**

- **Delete `.md` files** — They're no longer needed. Your work items are now in ADO.

  ```bash
  rm documentation/work-items/*.md
  ```

- **OR archive them** — Keep for sprint/release reference (e.g., `git mv documentation/work-items/ documentation/work-items-sprint-N-archived/`)

- **OR do nothing** — If you prefer to keep them, they won't break anything. But treat ADO as the source of truth going forward.

**Why cleanup?**

- Prevents confusion: Teams know to look in ADO, not old `.md` files
- Reduces repo clutter
- Clear separation: Local drafts ≠ committed backlog items

---

## Common Workflows

### Workflow 1: Create Story → Push Same Session

```
1. Run /pa-story
   → USER-STORY-*.md, TECHNICAL-*.md, ESTIMATES-*.md created

2. Review in chat, ask for adjustments
   → Agent updates suggestions (you don't edit files)

3. Run /pa-push-ado
   → Work items created in ADO

4. rm documentation/work-items/*.md
   → Cleanup (optional)
```

### Workflow 2: Create Story → Decompose → Push All

```
1. Run /pa-story
   → USER-STORY-*.md created

2. Run /pa-decompose
   → TASK-backend-*.md, TASK-frontend-*.md, ESTIMATES-*.md created

3. Review full hierarchy, refine as needed

4. Run /pa-push-ado
   → Story + all tasks created in ADO as linked hierarchy

5. rm documentation/work-items/*.md
   → Cleanup
```

### Workflow 3: Investigate Request → Create Work Items → Push

```
1. Run /pa-investigate
   → FINDINGS-*.md created (exploration notes)

2. Based on findings, run /pa-story or /pa-bug
   → Work item `.md` files created

3. Review, refine, push to ADO via /pa-push-ado

4. rm documentation/work-items/*.md
   → Delete work item files (you can keep FINDINGS for reference if useful)
```

---

## Rules of Thumb

| Question                                                   | Answer                                                                                                        |
| ---------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------- |
| Should I edit `.md` files directly vs. using the agent?    | Use the agent in chat for major changes. Direct edits are fine for small tweaks.                              |
| Should `.md` files go in version control (git)?            | Optional. If you do commit them, treat them as drafts, not the source of truth.                               |
| What if I need to modify a work item after pushing to ADO? | Edit it in ADO directly, not in a local `.md` file. The `.md` becomes stale.                                  |
| Can I keep `.md` files as backups after pushing?           | Yes, but remember they're not synced with ADO. If ADO changes, the `.md` is outdated.                         |
| What if multiple people are creating work items?           | Each person runs the PA workflows independently and pushes their own batch. Delete `.md` files after pushing. |

---

## Summary

```
Generated .md files:
├─ Phase 1: Created (temporary draft)
├─ Phase 2: Refined in chat (still temporary)
├─ Phase 3: Pushed to ADO (becomes permanent work item)
└─ Phase 4: Deleted/archived (no longer needed)
            ↓
        Azure DevOps = Source of Truth
```

**Key point:** Once you push to ADO, the local `.md` files are **historical artifacts**. Treat ADO as the single source of truth for your backlog.
