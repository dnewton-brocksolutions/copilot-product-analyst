# Component Catalog

> **Purpose:** Reference guide for reusable frontend components  
> **Last Updated:** YYYY-MM-DD  
> **How to use:** Replace all placeholder text with your actual components. Add a new `###` section for each significant component.

---

## Quick Reference

| Component           | Purpose            | Reuse Estimate | From Scratch  |
| ------------------- | ------------------ | -------------- | ------------- |
| TODO: ComponentName | TODO: What it does | TODO: X-Y hrs  | TODO: X-Y hrs |
| TODO: ComponentName | TODO: What it does | TODO: X-Y hrs  | TODO: X-Y hrs |

_The "Reuse Estimate" is the cost to configure and integrate an existing component. "From Scratch" is the cost if it doesn't exist yet._

---

## Page Components

_Full pages that users navigate to. High reuse value._

### TODO: PageComponentName

**Purpose:** TODO: What this page does and which user role uses it.

**Application:** TODO: Which frontend app this belongs to (e.g. AdminPortal, CustomerApp)

**Route:** TODO: `/path/to/page`

**Key Features:**

- TODO: Feature 1 (e.g. sortable data table with 10 columns)
- TODO: Feature 2 (e.g. filter panel with 3 dropdowns)
- TODO: Feature 3 (e.g. export to CSV button)

**Data Dependencies:**

- TODO: Which API or service provides data for this page

**Estimation:**

- Adapt for new use case: TODO: X-Y hours
- Build from scratch: TODO: X-Y hours

---

## Widget / Shared Components

_Reusable UI building blocks. High leverage for estimates._

### TODO: WidgetComponentName

**Purpose:** TODO: What this component does.

**Used In:** TODO: Pages or features that use this component (X+ places)

**Props / Configuration:**

- `TODO: propName` — TODO: What it controls

**Estimation:**

- Reuse (configure + wire data): TODO: X-Y hours
- Build from scratch: TODO: X-Y hours

---

### TODO: WidgetComponentName

**Purpose:** TODO: Description

**Used In:** TODO

**Estimation:**

- Reuse: TODO: X-Y hours
- From scratch: TODO: X-Y hours

---

<!-- Copy a ### block above to add more components -->

---

## Form Components

_Input forms and validation patterns._

| Component | Purpose | Reuse Est. |
| --------- | ------- | ---------- |
| TODO      | TODO    | TODO       |

---

## Dialog / Modal Components

_Confirmation dialogs, info modals, and action sheets._

| Component | Purpose | Reuse Est. |
| --------- | ------- | ---------- |
| TODO      | TODO    | TODO       |

---

## Data Display Components

_Tables, charts, grids, and data visualizations._

| Component | Purpose | Reuse Est. |
| --------- | ------- | ---------- |
| TODO      | TODO    | TODO       |

---

## Adding New Components

When a significant new component is built, add it here within one sprint. The catalog is most valuable when it reflects the current state of the codebase.

**A component is worth cataloging if:**

- It will likely be reused in 3+ places, OR
- It took more than 4 hours to build, OR
- It encapsulates complex business logic or UX patterns
