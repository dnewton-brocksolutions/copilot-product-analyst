# Effort Estimates Template & Format Guide

This guide explains how to create and structure a separate estimates tracking file for features.

---

## Why Separate Estimates from Tasks?

### Problems with estimates IN tasks:

- ❌ Tasks become cluttered and harder to read
- ❌ Estimates tied to requirements (hard to revise without changing scope)
- ❌ Cognitive overload: "What needs to be built?" mixed with "How long will it take?"
- ❌ Difficult to build historical accuracy data

### Benefits of separate estimates file:

- ✅ Task documents remain clean and focused on _what_ and _why_
- ✅ Estimates can be reviewed, adjusted, and tracked separately
- ✅ Easy to build estimation accuracy trends over time
- ✅ Clear assumptions and risk factors documented
- ✅ Useful for capacity planning without conflating scope

---

## Naming Convention

```
ESTIMATES-[feature-id]-[brief-description].md

Examples:
- ESTIMATES-cs001685-request-coils-acknowledged.md
- ESTIMATES-feature-printer-queue-analytics.md
- ESTIMATES-us-coil-split-workflow.md
```

---

## Minimum Section Structure

Every estimates file should include:

### 1. Story-Level Summary (Required)

```markdown
# Effort Estimates - [Feature Name] ([ID])

| Component            | Hours | Notes               |
| -------------------- | ----- | ------------------- |
| Backend Development  | X     | Description of work |
| Frontend Development | X     | Description of work |
| Testing & QA         | X     | Description of work |
| **Total**            | **X** |                     |
```

### 2. Detailed Phase Breakdown (Required)

For each component (Backend, Frontend, Testing):

```markdown
## [Component Name] (X hours)

**Task:** [Task Title]

### Phase 1: [Phase Name] (X hours)

- Item 1: Y min
- Item 2: Z min

### Phase 2: [Phase Name] (X hours)

- Item 1: Y min
- Item 2: Z min
```

### 3. Effort by Skill (Recommended)

```markdown
## Effort Summary by Skill

| Skill                    | Hours | Component                |
| ------------------------ | ----- | ------------------------ |
| C# Backend Developer     | X     | Service, database, gRPC  |
| React Frontend Developer | X     | UI, state, integration   |
| QA/Tester                | X     | Test planning, execution |
| **Total**                | **X** |                          |
```

### 4. Estimation Methodology (Recommended)

```markdown
## Estimation Methodology

Estimates are based on:

1. **Complexity Factors:**

   - Feature scope: [Simple/Moderate/Complex]
   - Technical dependencies: [Low/Moderate/High]
   - Testing coverage: [Basic/Comprehensive]

2. **Risk Adjustments:**

   - [Risk area]: +X min (rationale)
   - [Risk area]: +X min (rationale)

3. **Assumptions:**
   - Team familiar with [technology/pattern]
   - [Dependency] is already integrated
   - [External factor] is available
```

### 5. Variations (Optional)

If estimates vary significantly based on conditions:

```markdown
## Effort Adjustments for Variations

### If [scenario]: +X-Y hours

- Rationale and breakdown

### If [scenario]: +X-Y hours

- Rationale and breakdown
```

### 6. Phased Delivery Option (Recommended)

If the feature can be split into releases:

```markdown
## Phased Delivery Option (if needed)

- **Phase 1 (X hours):** [Description] (deploy)
- **Phase 2 (X hours):** [Description] (deploy)
```

---

## Complete Example Structure

```markdown
# Effort Estimates - Add Date Acknowledged Column (CS001685)

**Note:** Estimates are separated from task documents...

---

## Story-Level Estimates

| Component            | Hours  | Rationale                                    |
| -------------------- | ------ | -------------------------------------------- |
| Backend Development  | 9.5    | Database migration + gRPC update + testing   |
| Frontend Development | 6      | Column UI addition + responsive testing      |
| Testing & QA         | 5.5    | Unit, integration, functional, accessibility |
| **Total Estimate**   | **21** |                                              |

---

## Backend Task Breakdown (9.5 hours)

**Task:** Backend - Add acknowledged_at Column and Update gRPC Contract

### Phase 1: Database Migration (2 hours)

- 30 min: Write Liquibase script
- 30 min: Test locally
- 30 min: Verify no conflicts
- 30 min: Code review and docs

### Phase 2: Business Logic (2 hours)

- 45 min: Implement timestamp capture
- 45 min: Add logging/error handling
- 30 min: Testing and review

### Phase 3: gRPC Update (2.5 hours)

- 30 min: Update .proto file
- 1 hour: Implement mapping in service
- 45 min: Test with client
- 15 min: Code review

### Phase 4: Testing (3 hours)

- 1 hour: Unit tests
- 1 hour: Integration tests
- 45 min: Run and debug
- 15 min: Coverage review

---

## Frontend Task Breakdown (6 hours)

**Task:** Frontend - Add "Date Acknowledged" Column

### Phase 1: Component Update (2 hours)

- 45 min: Add column definition
- 30 min: Rename existing column
- 30 min: Test formatting
- 15 min: Code review

### Phase 2: Testing (2.5 hours)

- 1 hour: Manual testing
- 45 min: Data refresh behavior
- 30 min: Cross-browser testing
- 15 min: Accessibility check

### Phase 3: Verification (1.5 hours)

- 30 min: Type generation verification
- 45 min: Scenario testing
- 15 min: Final review

---

## Testing Task Breakdown (5.5 hours)

**Task:** Testing - Test Plan and QA Verification

### Phase 1: Test Plan (1 hour)

- Document test cases and data

### Phase 2: Unit Tests (1.5 hours)

- Write 4 tests, execute

### Phase 3: Integration Tests (1.5 hours)

- Write 3 tests, execute

### Phase 4: Functional Testing (1 hour)

- Execute 7 test cases manually

### Phase 5: Accessibility (30 min)

- Screen reader and keyboard testing

### Phase 6: QA Sign-off (30 min)

- Verify criteria, compile evidence

---

## Effort Summary by Skill

| Skill                    | Hours  | Component                           |
| ------------------------ | ------ | ----------------------------------- |
| C# Backend Developer     | 9.5    | DB, service, gRPC, backend tests    |
| React Frontend Developer | 6      | UI columns, formatting, testing     |
| QA/Tester                | 5.5    | Test plan, execution, accessibility |
| **Total**                | **21** |                                     |

---

## Estimation Methodology

Estimates are based on:

1. **Complexity Factors:**

   - Feature scope: Moderate (column addition + timestamp)
   - Data mapping: Straightforward (existing patterns)
   - Testing: Comprehensive (unit, integration, functional, a11y)

2. **Risk Adjustments:**

   - Liquibase migration compatibility: +30 min
   - Null value edge cases: +45 min
   - Cross-browser testing: +30 min

3. **Assumptions:**
   - Team familiar with gRPC and protobuf
   - RTK Query auto-generates types
   - No external dependencies
   - Build pipeline is stable

---

## Effort Adjustments for Variations

### If team has less gRPC experience: +2-3 hours

- Protobuf research and regeneration debugging

### If custom type mappings required: +1-2 hours

- Manual TypeScript type updates

### If WCAG AAA required: +1-1.5 hours

- Extended accessibility testing

### If historical data backfill needed: +2-3 hours

- Migration script and testing

---

## Phased Delivery Option

- **Phase 1 (12 hours):** Backend + testing (deploy structure)
- **Phase 2 (9 hours):** Frontend + QA (deploy UI)

---

## Revision History

| Version | Date       | Notes             |
| ------- | ---------- | ----------------- |
| 1.0     | 2025-12-09 | Initial estimates |

---

## Questions for Team Discussion

1. Does team use auto-generated or manual TypeScript types?
2. Historical data backfill required?
3. Timezone standards (UTC vs. local)?
4. Feature flags needed?
5. WCAG AA or AAA required?
```

---

## Tips for Creating Estimates Files

### Do's ✅

- **Document assumptions:** Spell out what you're assuming about tech, team skill, dependencies
- **Include rationale:** For each major time block, explain _why_ it takes that time
- **List variations:** Show how estimates change if conditions differ
- **Track history:** Update when feature is completed to track estimate accuracy
- **Be specific:** "2 hours" is better than "2-3 hours" for planning
- **Break down phases:** 30-min to 1-hour chunks are easier to estimate than 5-hour blocks

### Don'ts ❌

- **Don't include estimates in task documents** – they belong here only
- **Don't use ranges without rationale:** "5-8 hours" without explaining the variables
- **Don't ignore risks:** Add time for unknowns and edge cases
- **Don't overcomplicate:** Keep it scannable; teams don't read 20-page estimates docs
- **Don't forget testing:** QA work is often underestimated; build in time

---

## References

- **QUICK-START guide:** `documentation/QUICK-START-BUSINESS-ANALYST.md`
- **Task templates:** `documentation/work-item-templates/`
- **Example estimates:** Look in `work-items/` directory for completed features

---

## Changelog

- **v1.0 (2025-12-09):** Template created to standardize estimates tracking
