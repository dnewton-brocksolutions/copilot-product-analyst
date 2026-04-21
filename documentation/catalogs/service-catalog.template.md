# Service Catalog

> **Purpose:** Reference guide for backend services and modules  
> **Last Updated:** YYYY-MM-DD  
> **How to use:** Replace all placeholder text with your actual services. Add a new `###` section for each service.

---

## Quick Reference

| Service           | Purpose            | Extend Estimate |
| ----------------- | ------------------ | --------------- |
| TODO: ServiceName | TODO: What it does | TODO: X-Y hrs   |
| TODO: ServiceName | TODO: What it does | TODO: X-Y hrs   |

_Add one row per service. This table is scanned first by the agent for quick lookup._

---

## Services

### TODO: ServiceName

**Purpose:** TODO: One sentence describing what this service does and the business domain it owns.

**Technology:**

- Language: TODO: C# | Java | Python | Node.js | Go | other
- Framework: TODO: ASP.NET Core | Spring Boot | FastAPI | Express | other
- Database: TODO: Which database(s) does this service own?

**Common Endpoints/Methods:**

- `TODO: GET /api/resource` — TODO: What it returns
- `TODO: POST /api/resource` — TODO: What it creates
- `TODO: PUT /api/resource/{id}` — TODO: What it updates

**Estimation Baseline:**

- Add new endpoint (simple): TODO: X hours
- Add new endpoint (with business logic): TODO: X-Y hours
- Major new feature: TODO: X-Y hours

**Patterns & Notes:**

- TODO: Any patterns specific to this service (e.g. event sourcing, CQRS, outbox pattern)
- TODO: Known dependencies on other services
- TODO: Any quirks or gotchas developers should know

---

### TODO: ServiceName

**Purpose:** TODO: Description

**Technology:**

- Language: TODO
- Framework: TODO
- Database: TODO

**Common Endpoints/Methods:**

- `TODO: method/path` — TODO: description

**Estimation Baseline:**

- Add new endpoint: TODO: X hours
- Major feature: TODO: X-Y hours

---

<!-- Copy the ### block above to add more services -->

---

## Platform / Shared Services

TODO: List any shared infrastructure services (e.g. API Gateway, Auth service, Message broker).

| Service | Purpose | Notes |
| ------- | ------- | ----- |
| TODO    | TODO    | TODO  |

---

## Adding New Services

When a new service is created, add it here within one sprint. Include:

1. Purpose and business domain
2. Technology stack
3. Key endpoints or methods
4. Baseline estimate for extending it

This keeps the catalog current and ensures the PA agent produces accurate estimates.
