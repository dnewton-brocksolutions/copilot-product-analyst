# Component and Service Catalogs

This directory contains your project's catalogs. These catalogs are read by the Product Analyst agent when creating work items to produce accurate effort estimates and suggest component reuse.

## Catalog Files

| File                   | Purpose                  | When to Use                        |
| ---------------------- | ------------------------ | ---------------------------------- |
| `service-catalog.md`   | Backend services/modules | Agent reference for backend tasks  |
| `component-catalog.md` | Frontend components      | Agent reference for frontend tasks |

## Getting Started

1. Copy the templates below into the corresponding `.md` files
2. Fill in your actual services and components
3. Add more entries as your project grows

Templates are in:

- `service-catalog.template.md` — backend services
- `component-catalog.template.md` — frontend components

## How the Agent Uses Catalogs

When creating a backend task, the agent checks `service-catalog.md` to:

- Identify which service to extend (vs. creating a new one)
- Surface a baseline extension estimate
- Reference similar existing patterns

When creating a frontend task, the agent checks `component-catalog.md` to:

- Identify reusable components that can accelerate development
- Compare reuse estimate vs. build-from-scratch estimate
- Reference existing patterns and conventions

## Investment vs. Value

| Catalog maturity | Agent quality                                     |
| ---------------- | ------------------------------------------------- |
| Empty            | Generic work items with no project context        |
| 5-10 entries     | Reasonable work items with partial context        |
| 20+ entries      | Highly accurate work items with reuse suggestions |

**Recommendation:** Spend 1-2 hours populating catalogs during initial setup. Return and add new entries whenever a new service or significant component is built.
