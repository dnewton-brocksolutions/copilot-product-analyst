# MCP Database Access — Setup Guide

> **What this is:** Instructions for connecting the Product Analyst agent to your SQL Server databases via the Model Context Protocol (MCP). This is optional but enables the agent to investigate live database schema and business logic during work item creation.

---

## Why Add MCP Database Access?

Without MCP, the agent writes work items based only on what you tell it. With MCP, the agent can:

- **Investigate live database schema** — list tables, describe columns, find constraints
- **Read stored procedures** — understand existing validation and business logic
- **Write informed requirements** — reference actual table names and service patterns instead of generic placeholders
- **Eliminate "Investigation Needed" sections** — do the research before writing the work item

---

## Overview: How It Works

```
GitHub Copilot (PA Agent)
        │
        │ calls MCP tools (e.g. ListTables, DescribeTable, ReadData)
        ▼
MCP Server (one instance per database connection)
        │
        │ READ-ONLY SQL queries via connection string
        ▼
SQL Server Database
```

VS Code manages the MCP server lifecycle. Each server is a separate process that communicates over stdio. One server instance typically handles one database connection.

---

## Option A: Use an Existing MSSQL MCP Server

If your organisation already has an MCP server for SQL Server (or you are sharing this one), you only need to register it in VS Code and point it at your databases.

Skip to [Step 2: Register in VS Code](#step-2-register-in-vs-code).

---

## Option B: Build Your Own MSSQL MCP Server

This project uses a lightweight custom MCP server written in C# (.NET 8+). You can build your own following the same pattern, or adapt the one from this project's source:

### What the server provides

Per registered database, the following tools are exposed to the agent:

| Tool                   | Description                                     |
| ---------------------- | ----------------------------------------------- |
| `ListTables`           | List all tables in the database                 |
| `DescribeTable`        | Get column names, types, and constraints        |
| `ReadData`             | Execute SELECT queries (read-only, row-limited) |
| `ListStoredProcedures` | List all stored procedures                      |
| `GetStoredProcedure`   | Get the full body of a stored procedure         |
| `ListFunctions`        | List all user-defined functions                 |
| `GetFunction`          | Get the full body of a function                 |

### Tool naming convention

Tools follow this pattern: `mcp_mssql-{database}_{Operation}`

Examples:

- `mcp_mssql-maindb_ListTables`
- `mcp_mssql-maindb_DescribeTable`
- `mcp_mssql-maindb_ReadData`

The database name segment comes from your environment variable key (see below).

### Security

The server must enforce **read-only** access. Reject any query containing `INSERT`, `UPDATE`, `DELETE`, `DROP`, `TRUNCATE`, `ALTER`, `EXEC`, or `EXECUTE` (when not part of a `SELECT`). Use a dedicated read-only SQL account, not `sa`.

---

## Step 1: Prepare Connection Strings

Create a `.env`-style file for your database credentials. **Never commit this file.**

```bash
# .vscode/mcp.env  (add to .gitignore)

MCP_CONN_MSSQL_MAINDB='Server=your-server,1433;Database=MainDB;User Id=mcp_readonly;Password=yourpassword;TrustServerCertificate=True'
MCP_CONN_MSSQL_REPORTING='Server=your-server,1433;Database=Reporting;User Id=mcp_readonly;Password=yourpassword;TrustServerCertificate=True'
```

**Key points:**

- One environment variable per database
- The variable name suffix (e.g. `MAINDB`, `REPORTING`) becomes the database identifier in tool names
- Use a **dedicated read-only SQL account** — never a DBA or admin account
- `TrustServerCertificate=True` is required for self-signed certs; remove if you have a valid cert

---

## Step 2: Register in VS Code

Add your MCP server(s) to `.vscode/mcp.json` in your project:

```json
{
  "servers": {
    "mssql-maindb": {
      "type": "stdio",
      "command": "dotnet",
      "args": [
        "run",
        "--project",
        "path/to/your/MssqlMcp.csproj",
        "--no-build"
      ],
      "envFile": "${workspaceFolder}/.vscode/mcp.env"
    }
  }
}
```

**Or using Docker** (if you distribute a pre-built image):

```json
{
  "servers": {
    "mssql-maindb": {
      "type": "stdio",
      "command": "docker",
      "args": [
        "run",
        "--rm",
        "-i",
        "--env-file",
        "${workspaceFolder}/.vscode/mcp.env",
        "your-mcp-image:latest"
      ]
    }
  }
}
```

> **Note:** Each database connection that should be independently discoverable by Copilot can be a separate server entry, or you can run a single server that connects to multiple databases simultaneously using multiple environment variables.

---

## Step 3: Update project-config.json

Tell the PA agent that MCP database access is available. In `documentation/product-analyst-workflow/project-config.json`:

```json
"database": {
  "systems": [...],
  "mcpAccess": {
    "description": "Use MCP tools for live database analysis before creating backend tasks",
    "availableDatabases": [
      "MSSQL-MainDB (primary application database)",
      "MSSQL-Reporting (read-only reporting database)"
    ],
    "preferredApproach": "Query live database using MCP tools instead of guessing schema",
    "commonOperations": [
      "ListTables - Find relevant tables for a feature",
      "DescribeTable - Understand column types and constraints",
      "GetStoredProcedure - Read existing business logic and validation rules",
      "ReadData - Sample data to understand current state"
    ]
  }
}
```

This is what triggers the agent to proactively use MCP during task decomposition.

---

## Step 4: Verify It Works

1. Reload VS Code window (`Ctrl+Shift+P` → "Reload Window")
2. Open GitHub Copilot Chat
3. Type: `@product-analyst Use MCP to list the tables in MainDB`
4. The agent should call `mcp_mssql-maindb_ListTables` and return a table list

---

## Step 5: Update the QUICK-START guide (optional)

If you want your team to know MCP is available, add a note to `documentation/product-analyst-workflow/guides/QUICK-START-PRODUCT-ANALYST.md` describing which databases are accessible and the typical investigation workflow.

---

## Recommended Workflow (with MCP)

When decomposing a story into backend tasks, the agent should:

1. `ListTables` — find all tables related to the feature area
2. `DescribeTable` — understand data structures and constraints
3. `ListStoredProcedures` + `GetStoredProcedure` — read existing business logic
4. `ReadData` — sample current data to understand real-world usage
5. **Write requirements using actual findings** — no "Investigation Needed" sections

Prompt the agent explicitly if needed:

> "Before creating the backend task, investigate the database schema for anything related to [feature area]."

---

## Troubleshooting

**Tool calls fail or return no results?**

- Check that `mcp.env` exists at the path referenced in `mcp.json`
- Verify connection string is correct and the SQL account can connect
- Check VS Code Output panel → "MCP" for error messages

**Agent doesn't use MCP automatically?**

- Ensure `mcpAccess` is populated in `project-config.json`
- Explicitly ask: "Use MCP to investigate the database before writing requirements"

**Tools not visible to the agent?**

- Reload VS Code window after changing `mcp.json`
- Confirm the MCP server process starts successfully (check VS Code MCP output panel)

---

## Security Checklist

- [ ] Dedicated read-only SQL account (not `sa`, not a DBA account)
- [ ] `mcp.env` added to `.gitignore`
- [ ] No credentials hardcoded in `mcp.json`
- [ ] Server enforces read-only at the application level (not just DB permissions)
- [ ] Connection strings scoped to only the databases the agent needs
