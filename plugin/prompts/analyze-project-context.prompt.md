---
agent: business-analyst
description: "Analyze project context and provide tech stack summary for work item creation"
---

Read and analyze the project configuration to provide context for creating work items:

1. **Load Project Config**: Read `documentation/business-analyst-workflow/project-config.json` and summarize:
   - **Applications**: Available frontend applications (Processing OEE, Processing MES) and their purposes
   - **Tech Stack**: Frontend and backend technologies, versions, patterns
   - **Architecture**: Microservices, databases, communication protocols
   - **Standards**: Estimation units, testing requirements, deployment patterns

2. **Component Catalogs**: Check `documentation/business-analyst-workflow/catalogs/` for:
   - Existing UI components that can be reused
   - Service patterns and APIs already available
   - Common implementation approaches

3. **Recommendations**: Based on the project context, suggest:
   - Which application (Processing OEE vs Processing MES) is most appropriate
   - Relevant technology tags to use
   - Existing patterns or components to leverage
   - Appropriate estimation ranges for similar work

4. **Output**: Provide a concise summary that helps with:
   - Technology selection decisions
   - Realistic effort estimation
   - Leveraging existing work
   - Following established patterns

**Use this analysis** as context for creating user stories, tasks, and estimates that align with the current project architecture and standards.
