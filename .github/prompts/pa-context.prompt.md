---
description: Analyze and summarize the project configuration and tech stack. Use this before creating any work item to understand the project's applications, frameworks, architecture, and standards.
agent: agent
---

Read and analyze the project configuration to provide context for creating work items.

## Steps

1. **Load Project Config**: Read `documentation/product-analyst-workflow/project-config.json` and summarize:
   - **Applications**: Available frontend applications (from `frontend.applications[].name`) and their purposes
   - **Tech Stack**: Frontend and backend technologies, versions, patterns
   - **Architecture**: Microservices, databases, communication protocols
   - **Standards**: Estimation units, testing requirements, deployment patterns

2. **Codebase Discovery**: When available, explore the project source to:
   - Identify existing services, endpoints, and components
   - Surface patterns and conventions used in the codebase
   - Ground estimates in actual project complexity

3. **Recommendations**: Based on the project context, suggest:
   - Which application is most appropriate for this type of work
   - Relevant technology tags to use
   - Existing patterns or components to leverage
   - Appropriate estimation ranges for similar work

4. **Output**: Provide a concise summary that helps with:
   - Technology selection decisions
   - Realistic effort estimation
   - Leveraging existing work
   - Following established patterns
