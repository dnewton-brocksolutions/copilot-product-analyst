# Product Analyst Agent - Visual Diagrams

> Visual reference for how the Product Analyst AI agent works, its workflow, structure, and outputs.

---

## 1. Architecture

Overview of all components the PA agent uses to generate work items.

```mermaid
graph TB
    subgraph Agent["🤖 Product Analyst Agent"]
        Core["Core Agent Definition<br/><i>Role, Goals, Approach,<br/>Output Formats, DoR/DoD</i>"]
    end

    subgraph Inputs["📥 Inputs"]
        Stakeholder["👤 Stakeholder Request"]
        Commands["⌨️ Slash Commands<br/>/pa-story /pa-decompose<br/>/pa-bug /pa-investigate<br/>/pa-pr /pa-push-ado"]
    end

    subgraph Config["⚙️ Project Configuration"]
        ProjConfig["project-config.json<br/><i>Tech stack, apps,<br/>work tracking, standards</i>"]
    end

    subgraph Resources["📚 Reference Resources"]
        Templates["Work Item Templates<br/><i>Story, Backend Task, Frontend Task,<br/>Spike, Test Plan, Estimates</i>"]
        Codebase["Project Codebase<br/><i>Services, components,<br/>patterns (explored live)</i>"]
    end

    subgraph DB["🗄️ MCP Tools (Optional)"]
        DBAccess["Database MCP<br/><i>Schema, stored procs,<br/>live data queries</i>"]
        ADOAccess["Azure DevOps MCP<br/><i>Create work items,<br/>set parent links</i>"]
    end

    subgraph Outputs["📤 Generated Work Items"]
        Story["User Story<br/><i>Business context + AC</i>"]
        Technical["Technical Spec<br/><i>Requirements + Tasks + DoD</i>"]
        Estimates["Estimates File<br/><i>Hours + Breakdown + Risks</i>"]
    end

    Stakeholder --> Agent
    Commands --> Agent
    Agent --> ProjConfig
    Agent --> Resources
    Agent --> DB
    Agent --> Outputs

    style Agent fill:#4A90D9,color:#fff
    style Inputs fill:#F5A623,color:#fff
    style Config fill:#7B68EE,color:#fff
    style Resources fill:#50C878,color:#fff
    style DB fill:#E74C3C,color:#fff
    style Outputs fill:#2ECC71,color:#fff
```

**Key points:**

- The agent always reads `project-config.json` first to understand tech stack
- The agent explores the project codebase directly to identify existing services and components
- MCP database tools allow live schema/data investigation (optional, configured per project)
- Azure DevOps MCP enables pushing work items directly to ADO (optional)
- Three output files are generated per feature (story, technical spec, estimates)

---

## 2. Work Item Creation Workflow

Step-by-step process from stakeholder request to sprint-ready work items.

```mermaid
flowchart TD
    A["👤 Stakeholder Describes<br/>Feature or Problem"] --> B["📖 Load Project Context<br/><i>Read project-config.json</i>"]
    B --> C{"❓ Requirements<br/>Clear?"}
    C -->|No| D["Ask Clarifying Questions<br/><i>Business problem, user role,<br/>outcome, constraints, app</i>"]
    D --> C
    C -->|Yes| E["🔍 Investigate Existing System"]

    E --> E1["Codebase Exploration<br/><i>Existing services & components</i>"]
    E --> E2["MCP Database Tools (Optional)<br/><i>Tables, constraints, procedures</i>"]

    E1 --> F["📝 Define Scope<br/><i>In-scope + out-of-scope</i>"]
    E2 --> F

    F --> G["✍️ Write Acceptance Criteria<br/><i>Given / When / Then format</i>"]
    G --> H["📋 Create Work Items"]

    H --> H1["📄 User Story<br/><i>Business context + AC<br/>(concise, scannable)</i>"]
    H --> H2["📄 Technical Spec<br/><i>Requirements + Task Breakdown<br/>+ Definition of Done</i>"]
    H --> H3["📄 Estimates File<br/><i>Hours by component,<br/>phase breakdown, risks</i>"]

    H1 --> I["✅ Verify Quality<br/><i>DoR + DoD + No estimates in tasks</i>"]
    H2 --> I
    H3 --> I

    I --> J["🚀 Ready for ADO Entry<br/>& Sprint Planning"]

    style A fill:#F5A623,color:#fff
    style B fill:#7B68EE,color:#fff
    style E fill:#50C878,color:#fff
    style G fill:#4A90D9,color:#fff
    style H fill:#2ECC71,color:#fff
    style I fill:#E74C3C,color:#fff
    style J fill:#27AE60,color:#fff
```

**Key workflow rules:**

1. Always load project context **before** asking questions
2. Clarify requirements iteratively until scope is clear
3. Investigate existing implementation before writing requirements
4. Define explicit in-scope and out-of-scope boundaries
5. Validate against DoR/DoD checklists before finalizing

---

## 3. Three-Document Pattern

How each feature produces three separate files with distinct responsibilities.

```mermaid
graph LR
    subgraph Story["📄 User Story Document"]
        S1["Business Context<br/><i>Why is this needed?</i>"]
        S2["Description<br/><i>What users need</i>"]
        S3["Acceptance Criteria<br/><i>Given / When / Then</i>"]
        S4["Links to companion files"]
    end

    subgraph Tech["📄 Technical Specification"]
        T1["Business Requirements<br/><i>UI + Backend details</i>"]
        T2["Task Breakdown<br/><i>Backend + Frontend tasks</i>"]
        T3["Definition of Done<br/><i>Quality checklist</i>"]
        T4["Meta<br/><i>Priority, Tags, Paths</i>"]
    end

    subgraph Est["📄 Estimates File"]
        E1["Summary Table<br/><i>Hours by component</i>"]
        E2["Phase Breakdowns<br/><i>30min-1hr activities</i>"]
        E3["Risk Adjustments<br/><i>Multipliers + confidence</i>"]
        E4["Revision History<br/><i>Estimated vs actual</i>"]
    end

    Story ---|"TECHNICAL-*.md"| Tech
    Story ---|"ESTIMATES-*.md"| Est

    style Story fill:#4A90D9,color:#fff
    style Tech fill:#7B68EE,color:#fff
    style Est fill:#E67E22,color:#fff
```

**Why three files?**

- **User Story** stays concise and scannable (business stakeholders read this)
- **Technical Spec** has implementation details (developers read this)
- **Estimates** can be revised independently without changing requirements

---

## 4. Story Decomposition - Task Breakdown

Standard order and types of tasks generated from every user story.

```mermaid
flowchart TD
    US["📄 User Story"] --> TB["Task Breakdown"]

    TB --> SP{"Spike<br/>Needed?"}
    SP -->|Yes| T1["🔬 Investigation Spike<br/><i>Research unknowns,<br/>verify assumptions</i><br/>Skip if no unknowns"]
    SP -->|No| BE

    T1 --> BE["⚙️ Backend Task<br/><i>gRPC endpoints, business logic,<br/>database changes, EF Core</i><br/>Never skip if BE needed"]

    BE --> FE["🖥️ Frontend Task<br/><i>React components, state mgmt,<br/>RTK Query, MUI styling</i><br/>Never skip if UI needed"]

    FE --> TP["🧪 Test Plan Task<br/><i>ADO test plan updates,<br/>20-30 test cases</i><br/>NEVER SKIP"]

    TP --> EST["📊 Estimates File<br/><i>Created separately:<br/>ESTIMATES-feature.md</i>"]

    subgraph Complexity["Typical Effort Ranges"]
        BERange["Backend: 6-12 hrs"]
        FERange["Frontend: 8-16 hrs"]
        TPRange["Test Plan: 2 hrs"]
        TotalRange["Total: 18-30 hrs/story"]
    end

    style US fill:#4A90D9,color:#fff
    style T1 fill:#9B59B6,color:#fff
    style BE fill:#E74C3C,color:#fff
    style FE fill:#2ECC71,color:#fff
    style TP fill:#F39C12,color:#fff
    style EST fill:#E67E22,color:#fff
    style Complexity fill:#ECF0F1,color:#333
```

**Rules:**

- Spike is optional (skip if no unknowns exist)
- Backend and Frontend tasks are mandatory when applicable
- Test Plan task is **NEVER** skipped
- Estimates always go in a separate file, never in task documents

---

## 5. Agent Commands and Outputs

Available slash commands and what each produces.

```mermaid
flowchart LR
    subgraph Commands["Slash Commands"]
        C1["/pa-story"]
        C2["/pa-decompose"]
        C3["/pa-bug"]
        C4["/pa-investigate"]
        C5["/pa-pr"]
        C6["/pa-release-notes"]
        C7["/pa-push-ado"]
        C8["/pa-context"]
    end

    C1 -->|"New feature<br/>or user need"| O1["User Story + Technical Spec<br/>+ Estimates<br/><i>Three-file pattern</i>"]
    C2 -->|"Story exists,<br/>need breakdown"| O2["Backend + Frontend Tasks<br/><i>Using simple templates</i>"]
    C3 -->|"Something<br/>is broken"| O3["Bug Work Item<br/><i>Description + Repro + Fix</i>"]
    C4 -->|"Need research<br/>before planning"| O4["Investigation Summary<br/><i>Findings + recommendations</i>"]
    C5 -->|"PR is ready<br/>for review"| O5["PR Description<br/><i>Summary + changes + testing</i>"]
    C6 -->|"Sprint or<br/>release done"| O6["Release Notes<br/><i>Features + fixes + breaking</i>"]
    C7 -->|"Push confirmed<br/>items to ADO"| O7["ADO Work Items<br/><i>Created with parent links</i>"]
    C8 -->|"Check agent<br/>config"| O8["Config Summary<br/><i>Tech stack + standards</i>"]

    style Commands fill:#4A90D9,color:#fff
    style O1 fill:#2ECC71,color:#fff
    style O2 fill:#2ECC71,color:#fff
    style O3 fill:#E74C3C,color:#fff
    style O4 fill:#9B59B6,color:#fff
    style O5 fill:#F39C12,color:#fff
    style O6 fill:#F39C12,color:#fff
    style O7 fill:#7B68EE,color:#fff
    style O8 fill:#95A5A6,color:#fff
```

| Command             | When to Use                          | Output                                          |
| ------------------- | ------------------------------------ | ----------------------------------------------- |
| `/pa-story`         | Stakeholder describes a new feature  | User Story + Technical Spec + Estimates         |
| `/pa-decompose`     | Story exists, need task breakdown    | Backend + Frontend tasks using simple templates |
| `/pa-bug`           | Something is broken                  | Bug with Description, Repro Steps, Fix          |
| `/pa-investigate`   | Need research before planning        | Investigation summary with findings             |
| `/pa-pr`            | PR is ready for review               | PR description with summary and testing notes   |
| `/pa-release-notes` | Sprint or release is complete        | Release notes with features, fixes, breaking    |
| `/pa-push-ado`      | Work items confirmed, push to ADO    | Work items created in ADO with parent links     |
| `/pa-context`       | Verify agent is configured correctly | Summary of loaded project config and tech stack |

---

## 6. Repository Structure

File organization for all PA workflow resources.

```text
repository-root/
├── .github/
│   ├── agents/
│   │   └── product-analyst-core.agent.md
│   └── prompts/
│       ├── pa-context.prompt.md
│       ├── pa-story.prompt.md
│       ├── pa-decompose.prompt.md
│       ├── pa-bug.prompt.md
│       ├── pa-investigate.prompt.md
│       ├── pa-pr.prompt.md
│       ├── pa-release-notes.prompt.md
│       └── pa-push-ado.prompt.md
└── documentation/
    ├── project-config.json
    ├── CUSTOMIZATION-GUIDE.md
    ├── MCP-SETUP.md
    ├── PA-AGENT-DIAGRAMS.md
    ├── guides/
    │   ├── QUICK-START-PRODUCT-ANALYST.md
    │   ├── TASK-DECOMPOSITION-GUIDE.md
    │   ├── ESTIMATES-SEPARATION-GUIDE.md
    │   └── ESTIMATES-TEMPLATE.md
    └── work-item-templates/
        ├── business-focused-user-story-template.md
        ├── business-focused-task-template.md
        ├── backend-task-simple.md
        ├── frontend-task-simple.md
        ├── spike-task-template.md
        └── test-plan-task-template.md
```

**Data flow:**

1. Agent loads project context from `documentation/project-config.json`
2. Slash commands route to prompt files in `.github/prompts/`
3. Prompts use `documentation/work-item-templates/` to keep outputs consistent

---

## 7. Estimates Separation Pattern

The critical pattern of keeping estimates out of task documents.

```mermaid
flowchart TD
    subgraph Old["❌ Old Approach"]
        OT["Task Document<br/>Description + Requirements +<br/>AC + DoD + <b>Effort: 8hrs</b><br/><i>(mixed concerns)</i>"]
    end

    subgraph New["✅ New Approach"]
        NT["Task Document<br/>Description + Requirements +<br/>AC + DoD<br/><i>(pure scope/requirements)</i>"]
        NE["ESTIMATES-feature.md<br/>Summary table + Phase breakdown +<br/>Risk adjustments + Skill allocation<br/><i>(pure timing/planning)</i>"]
    end

    Old -->|"Evolved to"| New
    NT -.->|"References"| NE

    subgraph Benefits["Benefits"]
        B1["Independent revision"]
        B2["Reduced cognitive load"]
        B3["Historical accuracy tracking"]
        B4["Clean requirements review"]
    end

    New --> Benefits

    style Old fill:#E74C3C,color:#fff
    style New fill:#2ECC71,color:#fff
    style Benefits fill:#4A90D9,color:#fff
```

**The rule is simple:** Task documents describe _what_ and _why_. Estimates describe _how long_ and _with what confidence_. They change for different reasons, so they live in different files.
