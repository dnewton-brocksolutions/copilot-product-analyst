# Product Analyst Agent - Visual Diagrams

> Visual reference for how the Product Analyst AI agent works, its workflow, structure, and outputs.

---

## 1. "Architecture"

Overview of all components the PA agent uses to generate work items.

```mermaid
graph TB
    subgraph Agent["🤖 Product Analyst Agent (GitHub Copilot Chatmode)"]
        Core["Core System Prompt<br/><i>Role, Goals, Approach,<br/>Output Formats, DoR/DoD</i>"]
    end

    subgraph Inputs["📥 Inputs"]
        Stakeholder["👤 Stakeholder Request"]
        Commands["⌨️ Commands<br/>/story /task /decompose<br/>/bug /refine /estimate"]
    end

    subgraph Config["⚙️ Project Configuration"]
        ProjConfig["project-config.json<br/><i>Tech stack, apps, standards,<br/>estimation guidelines</i>"]
    end

    subgraph Resources["📚 Reference Resources"]
        Templates["Work Item Templates<br/><i>Story, Backend Task, Frontend Task,<br/>Spike, Test Plan, Estimates</i>"]
    end

    subgraph DB["🗄️ MCP Database Tools"]
        MES10["MES10 (Legacy)"]
        MES20["MES20 (Modern)"]
        OtherDB["ProcBar / ProcMMI /<br/>LIMS / xferERP"]
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
- MCP database tools allow live schema/data investigation
- The agent explores the project codebase directly to identify existing services and components
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
    C -->|Yes| E["🔍 Check Reference Resources"]

    E --> E1["Codebase Exploration<br/><i>Existing services & components?</i>"]
    E --> E2["MCP Database Tools<br/><i>Existing tables, validation,<br/>stored procedures?</i>"]

    E1 --> F["📝 Define Scope"]
    E2 --> F

    F --> F1["In-Scope Items"]
    F --> F2["Out-of-Scope Items"]

    F1 --> G["✍️ Write Acceptance Criteria<br/><i>Given / When / Then format</i>"]
    F2 --> G

    G --> H["📋 Create Work Items"]

    H --> H1["📄 User Story<br/><i>Business context + AC<br/>(concise, scannable)</i>"]
    H --> H2["📄 Technical Spec<br/><i>Requirements + Task Breakdown<br/>+ Definition of Done</i>"]
    H --> H3["📄 Estimates File<br/><i>Hours by component,<br/>phase breakdown, risks</i>"]

    H1 --> I["✅ Verify Quality"]
    H2 --> I
    H3 --> I

    I --> I1["DoR Checklist"]
    I --> I2["DoD Checklist"]
    I --> I3["No Estimates in Tasks"]

    I1 --> J["🚀 Ready for ADO Entry<br/>& Sprint Planning"]
    I2 --> J
    I3 --> J

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
3. Check all three resource types (services, components, database)
4. Define explicit in-scope and out-of-scope boundaries
5. Validate against DoR/DoD checklists before finalizing

---

## 3. Two-Document Pattern

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

Current prompt sources: `.github/agents/product-analyst.agent.md` and `.github/agents/product-analyst-core.agent.md`.

```mermaid
flowchart LR
    subgraph Commands["Agent Commands"]
        C1["/story"]
        C2["/task"]
        C3["/decompose"]
        C4["/bug"]
        C5["/refine"]
        C6["/estimate"]
    end

    C1 -->|"New feature<br/>or user need"| O1["User Story/PBI + AC<br/><i>Business value focused</i>"]
    C2 -->|"Implementation<br/>work"| O2["Task(s)<br/><i>Objective + Requirements</i>"]
    C3 -->|"Story exists,<br/>need breakdown"| O3["Backend + Frontend Tasks<br/><i>Using simple templates</i>"]
    C4 -->|"Something<br/>is broken"| O4["ADO Bug<br/><i>Description + Repro + Fix</i>"]
    C5 -->|"Work item<br/>lacks detail"| O5["Improved Work Item<br/><i>Clarified scope + criteria</i>"]
    C6 -->|"Need time<br/>estimates only"| O6["Hour Estimates<br/><i>Breakdown + rationale</i>"]

    style Commands fill:#4A90D9,color:#fff
    style O1 fill:#2ECC71,color:#fff
    style O2 fill:#2ECC71,color:#fff
    style O3 fill:#2ECC71,color:#fff
    style O4 fill:#E74C3C,color:#fff
    style O5 fill:#F39C12,color:#fff
    style O6 fill:#9B59B6,color:#fff
```

| Command      | When to Use                         | Output                                            |
| ------------ | ----------------------------------- | ------------------------------------------------- |
| `/story`     | Stakeholder describes a new feature | User Story/PBI with business context + AC         |
| `/task`      | Breaking down implementation work   | Task(s) with Objective + Requirements             |
| `/decompose` | Story exists, need full breakdown   | Backend + Frontend tasks using simple templates   |
| `/bug`       | Something is broken                 | Single ADO bug with Description, Repro Steps, Fix |
| `/refine`    | Work item lacks detail or clarity   | Improved work item with clarified scope/criteria  |
| `/estimate`  | Need timing without full work items | Hour-based estimates with rationale and breakdown |

---

## 6. Repository Structure

File organization for all PA workflow resources.

```mermaid
graph TB
    subgraph Folder["📁 documentation/product-analyst-workflow/"]
        README["README.md<br/><i>Overview & navigation</i>"]
        Config["project-config.json<br/><i>Tech stack, apps, standards</i>"]
        Custom["CUSTOMIZATION-GUIDE.md<br/><i>Adapt for new projects</i>"]

        subgraph Guides["📁 guides/"]
            QS["QUICK-START.md<br/><i>One-page reference</i>"]
            ESG["ESTIMATES-SEPARATION-GUIDE.md"]
            EST["ESTIMATES-TEMPLATE.md"]
            RN["RELEASE-NOTES-GUIDE.md"]
        end

        subgraph Templates["📁 work-item-templates/"]
            UST["user-story-template.md"]
            BET["backend-task-template.md"]
            FET["frontend-task-template.md"]
            SPT["spike-task-template.md"]
            TPT["test-plan-task-template.md"]
            TST["technical-spec-template.md"]
        end

        subgraph Items["📁 archive/items/"]
            Tasks["tasks/"]
            Stories["user-stories/"]
            Bugs["bugs/"]
            Estimates["estimates/"]
            ReleaseNotes["release-notes/"]
        end
    end

    Config -.->|"Agent reads first"| QS
    QS -.->|"References"| Templates
    Templates -.->|"Produces"| Items

    style Folder fill:#f9f9f9,color:#333
    style Guides fill:#4A90D9,color:#fff
    style Templates fill:#7B68EE,color:#fff
    style Items fill:#E67E22,color:#fff
```

**Data flow:**

1. Agent reads `project-config.json` first (tech stack context)
2. Quick Start guide references templates
3. Templates are used to produce work items in `archive/items/`

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
