# Backend Task Template

**Work Item Type:** Task
**Title:** [Feature Name] - Backend Implementation
**Parent:** [Link to parent User Story]

### Objective

[One clear sentence: What business logic or data processing this task delivers]

### Requirements

- **Business Logic:** [What business rules need to be implemented]
- **Data Processing:** [What data transformations or calculations are needed]
- **Data Storage:** [What data needs to be stored, updated, or retrieved]
- **API Endpoints:** [What gRPC endpoints need to be created/updated]
- **Data Validation:** [What validation rules apply to incoming data]
- **Business Rules:** [What constraints or calculations apply]
- **Integration Points:** [What other services or systems need to be called]
- **Error Scenarios:** [What errors need to be handled and how]

> **Note:** See separate `ESTIMATES-[feature].md` file for effort estimates

---

## Usage Guidelines

### Backend Tasks Should Focus On ⚙️

- **Business Logic:** What rules govern the data and processes
- **Data Operations:** What data is created, read, updated, or deleted
- **Integration:** How this service communicates with other services
- **Data Integrity:** How data consistency is maintained
- **Validation:** What data is accepted and what is rejected
- **Performance:** Expected throughput and response times

### What to Include ✅

- Business rules and validation logic
- Data that needs to be stored or retrieved
- Calculations or transformations
- Integration with other services
- Error conditions and handling approach
- Performance requirements (if applicable)
- Reference to similar existing backend logic

### What to Avoid ❌

- Specific C# implementation patterns (LINQ queries, specific libraries)
- ORM details (Entity Framework specifics)
- Infrastructure concerns (deployment, scaling)
- Specific design patterns
- Database optimization techniques (unless performance is critical)

### Database Investigation 🔍

**CRITICAL: Complete this investigation BEFORE creating the task, not during implementation.**

Use MCP database tools to investigate and populate Technical Context with actual findings:

- Existing stored procedures for similar business logic
- Database schema and constraints
- Validation rules in database triggers
- Related tables and relationships

Use tools like:

- `mcp_mssql_mcp_mssql-mes_ListTables` - Find relevant tables
- `mcp_mssql_mcp_mssql-mes_DescribeTable` - Understand table structure
- `mcp_mssql_mcp_mssql-mes_GetStoredProcedure` - Examine existing business logic

**Populate Technical Context with actual table names and SPs, not "investigate" notes.**

**Remember:** Describe what data needs to be processed and why, let developers decide how to implement it!
