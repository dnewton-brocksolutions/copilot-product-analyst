# Task Decomposition Quick Reference

**Updated:** February 19, 2026

## Overview

This guide provides the simplified approach to decomposing user stories into tasks with two key sections: **Objective** and **Requirements**.

## Critical Workflow Rule

**ALWAYS investigate database BEFORE creating backend tasks.**

- Use MCP tools to find actual table names, stored procedures, and schema details
- Use findings to write informed requirements
- **DO NOT** create "Investigation Needed" sections or ask developers to investigate
- Reference similar features in requirements so developers know where to look

## Task Structure (Required Sections)

### 1. Objective

**Purpose:** One clear sentence explaining what this task accomplishes and why it matters.

**Example:**

```
Implement UI to allow operators to view and acknowledge coil requests from the work queue.
```

**Guidelines:**

- Single sentence (or two at most)
- Focus on WHAT and WHY
- Should be understandable by non-developers

### 2. Requirements

**Purpose:** Bulleted list of things that need to happen for this task.

**Examples:**

**Frontend Requirements:**

- User can view list of pending coil requests
- User can select a request and view details
- User can click "Acknowledge" button
- System shows confirmation message on success
- System shows error message if acknowledgment fails

**Backend Requirements:**

- API endpoint accepts coil request ID and user ID
- System validates user has permission to acknowledge requests
- System updates request status to "Acknowledged"
- System records timestamp and user who acknowledged
- System returns success/error response

**Guidelines:**

- Not as high-level as user story
- Not prescriptive about HOW to implement
- Gives developer freedom to choose approach
- Focus on business requirements, not technical implementation
- Can reference similar features developers can examine

## Frontend vs Backend Tasks

### Frontend Tasks

**Focus Areas:**

- What users see and interact with
- User workflows and interactions
- Data display requirements
- Form inputs and validation
- Error handling and user feedback

**Key Addition:**

> **Note:** This task requires UI design/mockup. Consider using sub-agent for mockup generation or create wireframes before implementation.

### Backend Tasks

**Focus Areas:**

- Business logic and validation rules
- Data processing and transformations
- Data storage and retrieval
- API endpoints (gRPC)
- Integration with other services
- Error conditions and handling

## Common Decomposition Pattern

When decomposing a user story, typically create:

1. **Backend Task** - Implement business logic, API, database changes
2. **Frontend Task** - Implement UI, user workflows, interactions

**Task Creation Order:**

1. Backend first (provides API for frontend)
2. Frontend second (depends on backend)

**Note:** Testing is included in the Definition of Done for each task rather than as a separate task.

## What NOT to Include in Tasks

❌ **Avoid These:**

- Detailed implementation steps
- Specific technology choices (unless critical)
- Hour estimates (goes in separate ESTIMATES file)
- Acceptance criteria (lives in user story)
- Definition of Done (standard DoD applies)
- How to structure code
- Which design patterns to use

✅ **Include These:**

- What needs to be built
- Why it's needed
- Key business rules
- Where to start looking in codebase
- Similar features to reference

## Examples

### Example 1: Frontend Task

**Title:** Display Coil Request Acknowledgment Status - Frontend

**Objective:**
Enable operators to view which coil requests have been acknowledged and by whom.

**Requirements:**

- User can see "Acknowledged" badge on acknowledged requests
- User can hover over badge to see who acknowledged and when
- Acknowledged requests show green checkmark icon
- Unacknowledged requests show orange pending icon
- Badge updates in real-time when acknowledgment occurs

> **Note:** This task requires UI mockup. Attach wireframe showing badge placement and tooltip design.

**UI Design Considerations:**

**Mockup should show:**

- Badge placement on coil request list items
- Badge styling (colors, icons, borders)
- Tooltip content and positioning on hover
- Real-time badge update animation (if any)
- Mobile responsive layout considerations

---

### Example 2: Backend Task

**Title:** Add Coil Request Acknowledgment Tracking - Backend

**Objective:**
Track when and by whom coil requests are acknowledged for audit and workflow purposes.

**Requirements:**

- Store acknowledgment timestamp when request is acknowledged
- Store user ID of person who acknowledged request
- Return acknowledgment details in GetCoilRequests API
- Validate user has permission before allowing acknowledgment
- Return error if request already acknowledged by different user
- Log acknowledgment event for audit trail

## Templates Available

- **`backend-task-simple.md`** - For backend implementation tasks
- **`frontend-task-simple.md`** - For frontend implementation tasks
- **`business-focused-task-template.md`** - Generic task template

**Location:** `documentation/business-analyst-workflow/work-item-templates/`

## Future Enhancements

- **UI Mockup Sub-Agent:** Automated generation of wireframes/mockups for frontend tasks
- **Database Schema Auto-Discovery:** Use MCP tools to automatically populate database table information
- **Similar Feature Finder:** Sub-agent to find similar features in codebase

## Questions?

Refer to:

- [QUICK-START-BUSINESS-ANALYST.md](../guides/QUICK-START-BUSINESS-ANALYST.md) - Complete workflow guide
- [work-item-templates/README.md](../work-item-templates/README.md) - Template selection guide
