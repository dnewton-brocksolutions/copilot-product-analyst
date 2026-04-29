# Customization Guide: Product Analyst Chatmode

> **Purpose:** Instructions for adapting the Product Analyst chatmode for new projects  
> **Last Updated:** 2025-10-21

---

## Overview

The Product Analyst chatmode system consists of:

1. **`product-analyst-core.chatmode.md`** - Universal PA guidance (tech-stack agnostic)
2. **`project-config.json`** - Project-specific configuration (tech stack, tools, standards)
3. **Templates** - Reusable work item templates
4. **Quick Start Guide** - User documentation

This design allows **one chatmode to serve multiple projects** by loading project-specific context from configuration files.

---

## Quick Start (New Project)

### 1. Copy Core Files (5 minutes)

```bash
# From template/reference project
cp .github/chatmodes/product-analyst-core.chatmode.md <new-project>/.github/chatmodes/
cp documentation/project-config.template.json <new-project>/documentation/project-config.json
cp -r documentation/work-item-templates/ <new-project>/documentation/
cp documentation/QUICK-START-PRODUCT-ANALYST.md <new-project>/documentation/
```

### 2. Configure Your Project (15-30 minutes)

Edit `documentation/project-config.json`:

```json
{
  "projectName": "Your Project Name",
  "frontend": {
    "framework": "React",  // or Vue, Angular, Svelte, etc.
    "applications": [...],  // Your apps/modules
  },
  "backend": {
    "framework": "C#",      // or Java, Python, Node, Go, etc.
    "architecture": "Microservices",  // or Monolith, Serverless
    "protocol": "gRPC",     // or REST, GraphQL
  },
  "database": {...},
  "workTracking": {...},
  "standards": {...}
}
```

### 3. Customize Templates (30-60 minutes)

Update `documentation/work-item-templates/` with project-specific examples:

- Replace placeholder tech stack references
- Add project-specific checklist items

### 4. Test It Out (15 minutes)

Create a sample work item using the chatmode:

1. Activate the chatmode in GitHub Copilot Chat
2. Ask: "Create a user story for adding a new field to the user profile page"
3. Verify it loads your project config
4. Check estimates match your project's patterns

---

## Detailed Customization

### Project Config Structure

#### Required Sections

**`projectName`** - Your project name and description

**`frontend`** - Frontend tech stack

- `framework`: React, Vue, Angular, Svelte, etc.
- `applications`: List of apps/modules
- `stateManagement`: Redux, Vuex, Pinia, NgRx, etc.
- `dataFetching`: REST client, gRPC-web, Apollo, etc.

**`backend`** - Backend tech stack

- `framework`: C#, Java, Python, Node, Go, etc.
- `architecture`: Microservices, Monolith, Serverless
- `protocol`: gRPC, REST, GraphQL

**`database`** - Database systems and migration approach

- `systems`: List of databases with update processes
- `migrationTool`: Liquibase, Flyway, EF Migrations, Alembic, etc.

**`workTracking`** - Work tracking tool and structure

- `tool`: Azure DevOps, Jira, GitHub Issues, Linear, etc.
- `process`: Agile, Scrum, Kanban
- `areaPath`/`iterationPath`: Organization structure

**`standards`** - Team standards and policies

- `estimationUnit`: hours or points
- `testPlanUpdateEstimate`: Standard estimate for test plan updates
- `coverage`: Code coverage targets
- `accessibility`: Accessibility standards (WCAG AA, etc.)
- `featureFlags`: Feature flag policy and tool

#### Optional Sections

**`documentation`** - Documentation locations  
**`estimationGuidelines`** - Project-specific estimation baselines  
**`definitionOfReady`** - Project-specific DoR additions  
**`definitionOfDone`** - Project-specific DoD additions

---

### Estimation Guidelines

Build project-specific estimation baselines based on **actual hours** from completed work.

#### Estimation Config Template

```json
{
  "estimationGuidelines": {
    "componentReuseSavings": "50-75%",
    "taskEstimates": {
      "backend": {
        "simple": "4-6 hrs - Single endpoint, basic CRUD",
        "medium": "8-10 hrs - Multiple endpoints, business rules",
        "complex": "12-16 hrs - Complex logic, performance optimization"
      },
      "frontend": {
        "reuseHeavy": "6-8 hrs - Mostly reusing components",
        "mixed": "10-12 hrs - Some reuse, some new",
        "fromScratch": "16-20 hrs - New page, complex state"
      }
    },
    "riskMultipliers": {
      "newTechnology": "+25-50%",
      "externalDependencies": "+20-30%",
      "unclearRequirements": "+40-75%"
    }
  }
}
```

**Update these based on:**

- Sprint retrospectives (actual vs estimated)
- Completed work item time tracking
- Team velocity changes
- New team member onboarding

---

## Work Tracking Tool Integration

### Azure DevOps (ADO)

**Config:**

```json
{
  "workTracking": {
    "tool": "Azure DevOps (ADO)",
    "process": "Agile", // or "Scrum"
    "workItemTypes": ["Epic", "Feature", "User Story", "Task", "Bug"],
    "areaPath": "YourProject\\Team\\Area",
    "iterationPath": "YourProject\\Team\\Sprint"
  }
}
```

**Field Mapping:** Already included in core chatmode

### Jira

**Config:**

```json
{
  "workTracking": {
    "tool": "Jira",
    "project": "PROJ",
    "issueTypes": ["Epic", "Story", "Task", "Bug", "Sub-task"],
    "components": ["Frontend", "Backend", "Database"],
    "customFields": {
      "acceptanceCriteria": "customfield_10001",
      "testPlan": "customfield_10002"
    }
  }
}
```

**Field Mapping:** Reference in core chatmode, customize for your Jira instance

### GitHub Issues

**Config:**

```json
{
  "workTracking": {
    "tool": "GitHub Issues",
    "repository": "org/repo",
    "labels": {
      "workItemTypes": ["epic", "story", "task", "bug"],
      "areas": ["frontend", "backend", "database"],
      "priorities": ["P0", "P1", "P2", "P3"]
    },
    "projects": {
      "board": "Project Board Name"
    }
  }
}
```

---

## Maintenance

### Keep Catalogs Updated

**When to update:**

- New service/component created → Add to catalog
- Service extended → Update "Extend Estimate" based on actuals
- Component reused → Increment "Reuse Count"
- Estimation error discovered → Update baselines

**Review Schedule:**

- **Quarterly:** Review estimation accuracy, update baselines
- **After major feature:** Add new patterns to catalogs
- **Sprint retrospective:** Identify catalog gaps

### Track Estimation Accuracy

Create a simple tracking spreadsheet:

| Work Item      | Estimated | Actual | Variance | Notes                      |
| -------------- | --------- | ------ | -------- | -------------------------- |
| Add user field | 8 hrs     | 10 hrs | +25%     | Forgot about validation    |
| Reuse DataGrid | 2 hrs     | 2 hrs  | 0%       | Catalog accurate           |
| New service    | 16 hrs    | 24 hrs | +50%     | External dependency issues |

**Use variance data to:**

- Adjust catalog estimates
- Identify risk multipliers
- Improve future estimates
- Coach team on estimation

---

## Example: Customizing for Different Tech Stacks

### Example 1: Vue + Python (FastAPI) + PostgreSQL

```json
{
  "projectName": "Customer Portal",
  "frontend": {
    "framework": "Vue 3",
    "stateManagement": "Pinia",
    "dataFetching": "Axios (REST)",
    "styling": "Vuetify",
    "catalogPath": "documentation/catalogs/component-catalog.md"
  },
  "backend": {
    "framework": "Python",
    "architecture": "Monolith with FastAPI",
    "protocol": "REST",
    "orm": "SQLAlchemy",
    "catalogPath": "documentation/catalogs/api-catalog.md"
  },
  "database": {
    "systems": [
      {
        "name": "PostgreSQL",
        "migrationTool": "Alembic"
      }
    ]
  },
  "workTracking": {
    "tool": "Jira",
    "process": "Scrum"
  }
}
```

### Example 2: Angular + Java (Spring Boot) + MySQL

```json
{
  "projectName": "Enterprise Dashboard",
  "frontend": {
    "framework": "Angular 17",
    "stateManagement": "NgRx",
    "dataFetching": "HttpClient (REST)",
    "styling": "Angular Material",
    "catalogPath": "documentation/catalogs/component-catalog.md"
  },
  "backend": {
    "framework": "Java",
    "architecture": "Microservices with Spring Boot",
    "protocol": "REST",
    "orm": "JPA/Hibernate",
    "catalogPath": "documentation/catalogs/service-catalog.md"
  },
  "database": {
    "systems": [
      {
        "name": "MySQL",
        "migrationTool": "Flyway"
      }
    ]
  },
  "workTracking": {
    "tool": "Azure DevOps (ADO)",
    "process": "Agile"
  }
}
```

### Example 3: Next.js + Node.js (Express) + MongoDB

```json
{
  "projectName": "SaaS Application",
  "frontend": {
    "framework": "Next.js 14 (React)",
    "stateManagement": "React Context + SWR",
    "dataFetching": "SWR (REST)",
    "styling": "Tailwind CSS + shadcn/ui",
    "catalogPath": "documentation/catalogs/component-catalog.md"
  },
  "backend": {
    "framework": "Node.js",
    "architecture": "API-first with Express",
    "protocol": "REST",
    "orm": "Mongoose",
    "catalogPath": "documentation/catalogs/api-catalog.md"
  },
  "database": {
    "systems": [
      {
        "name": "MongoDB",
        "migrationTool": "Manual scripts"
      }
    ]
  },
  "workTracking": {
    "tool": "Linear",
    "process": "Issue-based workflow"
  }
}
```

---

## Troubleshooting

### Issue: Chatmode not loading project config

**Solution:**

1. Verify `documentation/project-config.json` exists
2. Check JSON syntax (use a validator)
3. Ensure file is in correct location relative to workspace root
4. Explicitly reference config in your prompt: "Using project-config.json, create a story for..."

### Issue: Estimates don't match our project

**Solution:**

1. Update `estimationGuidelines` in project config
2. Build/update catalogs with actual estimates
3. Track estimation variance for 2-3 sprints
4. Adjust baselines quarterly

### Issue: Catalogs are out of date

**Solution:**

1. Assign catalog maintenance to rotating team member
2. Add "Update catalog" to DoD for new components/services
3. Review catalogs in retrospectives
4. Set up quarterly catalog review meeting

### Issue: Team not using the chatmode

**Solution:**

1. Run training session with Quick Start Guide
2. Create example work items as templates
3. Pair with team members to create first few work items
4. Share time savings metrics (50-75% faster with catalogs)
5. Make catalog checking mandatory in DoR

---

## Getting Help

- **Quick Start:** `documentation/QUICK-START-PRODUCT-ANALYST.md`
- **Templates:** `documentation/work-item-templates/README.md`
- **Catalogs:** `documentation/catalogs/README.md`
- **Issues:** Open an issue in the template repo or contact maintainer

---

## Contributing Back

If you create improvements to the core chatmode or discover new patterns:

1. **Generic improvements** - Submit PR to core chatmode template repo
2. **Tech-stack-specific patterns** - Share as examples in discussions
3. **Estimation data** - Help build industry baselines

**Example contributions:**

- Better context questions
- New output formats (e.g., Notion, ClickUp)
- Tech-stack-specific checklist templates
- Estimation accuracy tracking tools

---

## Version History

- **1.0** (2025-10-21) - Initial customization guide
  - Core chatmode extraction from Charter MES
  - Project config JSON structure
  - Catalog templates
  - Multiple tech stack examples
