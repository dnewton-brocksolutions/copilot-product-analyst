# Product Analyst Mode - Updated Instructions Summary

## Recent Updates to Best Practices

### Effort Estimates Now Separated from Task Documents

**Decision:** Keep task documents focused on requirements; move time estimates to separate files.

**Rationale:**

- Tasks describe _what_ needs to be built and _why_ → easier to read and understand
- Estimates show _how long_ and with what confidence → separate tracking document
- Reduces cognitive load when reviewing work scope
- Enables independent estimate revision without changing requirements
- Builds historical accuracy data over time

---

## Updated Workflow

### Old Approach ❌

```
Task Document:
├─ Description
├─ Requirements
├─ Acceptance Criteria
├─ Definition of Done
├─ Effort Estimate (30 min + 1 hour + 45 min + ...)  ← MIXED IN
└─ Dependencies
```

### New Approach ✅

```
Task Document:
├─ Description
├─ Requirements
├─ Acceptance Criteria
├─ Definition of Done
└─ Dependencies
   (References separate estimates file)

ESTIMATES-[feature].md:
├─ Story-level summary table
├─ Detailed phase breakdown by task
├─ Effort by skill
├─ Risk adjustments & variations
└─ Discussion questions
```

---

## Key Changes for Product Analysts

### 1. Task Documents

- **Do NOT include** effort estimates, hour breakdowns, or time allocations
- Focus on: _What_ needs to be built, _why_ it matters, _how_ success is measured
- Include acceptance criteria, definition of done, dependencies, technical approach
- Keep concise and scannable (easier to review with team)

### 2. New: Separate Estimates File

- **Create:** `ESTIMATES-[feature-id]-[description].md` in `work-items/`
- **Include:**
  - Story-level summary (total hours by component)
  - Phase breakdowns (30-min to 1-hour chunks)
  - Effort by skill (Backend hours, Frontend hours, QA hours)
  - Estimation methodology (complexity, risks, assumptions)
  - Variations (how estimates change if conditions differ)
  - Phased delivery options (if applicable)

### 3. Story Documents

- Reference estimates file in summary section (e.g., "See ESTIMATES-[file] for detailed breakdown")
- Keep story focus on business value, not time tracking
- Suggested task breakdown remains high-level (no hour estimates)

### 4. User Stories & Acceptance Criteria

- **No change** – continue using Given/When/Then format
- **No estimates** in acceptance criteria section

---

## Template Updates

### QUICK-START Guide Updates

✅ Added section: **"Estimates: Keep Separate from Task Documents"**

- Explains benefits
- Shows example of what to do vs. not do
- References new estimates template

✅ Updated Quality Checklist:

- Added: "NO effort estimates in task document"
- Added: Separate "Estimates File" section with checklist
- Removed estimate-related items from individual task checklists

### New Template Created

📄 **ESTIMATES-TEMPLATE.md**

- Complete structure for estimates files
- Full example with all sections
- Formatting guidelines
- Tips for creating accurate estimates
- Revision history tracking

### Existing Task Templates (No Changes)

- Backend, Frontend, Test Plan templates remain unchanged
- Just: Remove any effort estimate sections before using

---

## Example: CS001685 - Request Coils Date Acknowledged

**Files Created:**

1. **User Story:** `us-request-coils-date-acknowledged-cs001685.md`

   - Business context, acceptance criteria, task breakdown
   - NO effort estimates in document

2. **Task: Backend** → `task-backend-acknowledged-at-column.md`

   - Technical requirements, acceptance criteria, definition of done
   - NO effort estimates

3. **Task: Frontend** → `task-frontend-acknowledged-at-column.md`

   - UI requirements, acceptance criteria, definition of done
   - NO effort estimates

4. **Task: Testing** → `task-testing-acknowledged-at-column.md`

   - Test plan structure, test cases, verification criteria
   - NO effort estimates

5. **Separate Estimates** → `ESTIMATES-cs001685-request-coils-acknowledged.md`
   - Story summary (21 hours total)
   - Phase breakdowns by task
   - Risk adjustments and variations
   - Discussion questions for team

---

## Guidance for Team

### When Creating New Work Items

1. **Start with requirements** (user story + tasks)

   - Don't think about time yet
   - Focus on _what_ and _why_
   - Get team alignment on scope

2. **Then create estimates document**

   - Break down by phase/activity
   - Document assumptions and risks
   - Get team input on accuracy

3. **Review separately**
   - Scope review: Does task make sense?
   - Estimate review: Are hours realistic?
   - Adjust each independently

### During Sprint Planning

1. **Review task document first**

   - "Do we understand what needs to be built?"
   - "Are acceptance criteria clear?"
   - Raise scope questions if needed

2. **Reference estimates file**

   - "What's the recommended estimate?"
   - "What variations might apply to our team?"
   - "What risks should we track?"

3. **Make final decision**
   - Assign hours in ADO based on team capacity
   - Document any deviations from recommendations
   - Track actual hours for future accuracy

### After Implementation

1. **Update estimates file**
   - Add "Actual Hours" row to summary table
   - Note any surprises (overruns, savings)
   - Document reasons for variance
   - Track estimate accuracy over time

---

## Documentation Structure

```
documentation/
├─ QUICK-START-PRODUCT-ANALYST.md (updated)
│  └─ Now includes "Estimates: Keep Separate" section
│  └─ Updated quality checklist
│
├─ ESTIMATES-TEMPLATE.md (new)
│  └─ Template + structure guide
│  └─ Best practices + tips
│  └─ Complete example
│
├─ project-config.json (unchanged)
│  └─ Tech stack, applications, standards
│
├─ work-item-templates/
│  ├─ story-template.md (unchanged)
│  ├─ backend-task-template.md (unchanged)
│  ├─ frontend-task-template.md (unchanged)
│  ├─ test-plan-task-template.md (unchanged)
│  └─ [other templates]
│
└─ work-items/
   ├─ us-request-coils-date-acknowledged-cs001685.md
   ├─ task-backend-acknowledged-at-column.md
   ├─ task-frontend-acknowledged-at-column.md
   ├─ task-testing-acknowledged-at-column.md
   └─ ESTIMATES-cs001685-request-coils-acknowledged.md (new pattern)
```

---

## FAQ

**Q: Should estimates be in the User Story?**
A: No. User story focuses on business value and acceptance criteria. Reference the separate estimates file if summary is needed.

**Q: What if I need to update estimates during the sprint?**
A: Update the ESTIMATES-[file].md with actual progress. Don't change task scope document unless scope changed.

**Q: Should task templates include an "Estimates" section?**
A: No. Task templates should focus on requirements, acceptance criteria, and definition of done.

**Q: How do we share estimates with the team?**
A: Link to ESTIMATES-[file].md during sprint planning. It's a standalone reference document.

**Q: What if the story is very simple (2-3 hours total)?**
A: Still create estimates file. Even small stories benefit from documented assumptions and risks.

**Q: Who updates the estimates file after work is done?**
A: Developer or PM can add actual hours and notes. Helpful for tracking estimate accuracy.

---

## Rollout Notes

- **Effective Immediately:** All new work items follow this pattern
- **Existing Work Items:** No changes needed; this is forward-looking
- **Templates:** Update before use to remove any estimate sections
- **Team Training:** Reference QUICK-START guide and this summary
- **Historical Data:** Start building estimate-vs.-actual tracking with new items

---

## Contacts & Questions

- See QUICK-START-PRODUCT-ANALYST.md for detailed guidance
- See ESTIMATES-TEMPLATE.md for structure and examples
- Check work-items/ directory for real examples
