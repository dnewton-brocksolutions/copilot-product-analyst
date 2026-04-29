---
description: Generate structured release notes from a list of work items, commit log, or story descriptions. Groups changes by category (features, fixes, improvements) and formats for the target audience.
agent: agent
---

Generate release notes from completed work items or a commit log.

## Before Writing

Ask for (or request the user provide):

1. **Source**: Work item IDs/titles, sprint board export, or commit log
2. **Version or sprint name** (e.g., `v2.3.0`, `Sprint 42`)
3. **Target audience**: Internal team, stakeholders, or end users — this controls how technical the language should be
4. **Release date** (if known)

## Formatting Rules by Audience

| Audience          | Tone                            | Technical Detail                              |
| ----------------- | ------------------------------- | --------------------------------------------- |
| **End Users**     | Plain language, benefit-focused | Minimal — avoid code terms                    |
| **Stakeholders**  | Business value, no jargon       | Medium — mention features, not implementation |
| **Internal/Team** | Technical, precise              | Full — include component names, DB changes    |

## Release Notes Template

```markdown
# Release Notes — [Version / Sprint Name]

**Release Date:** [Date or TBD]
**Environment:** [Production / Staging]

---

## What's New

- **[Feature name]**: [1 sentence benefit description. What the user can now do.]
- **[Feature name]**: [Same format]

## Bug Fixes

- **[Area/Application]**: [What was broken, now fixed. No jargon for external audiences.]
- **[Area/Application]**: [Same format]

## Improvements

- **[Area/Application]**: [Performance, reliability, or usability improvement]

---

## Technical Notes _(internal only — remove for external release)_

### Breaking Changes

- [API changes, deprecated endpoints, renamed fields]

### Database Changes

- [Migrations run, schema changes, new indexes]

### Configuration Changes

- [New env variables, feature flags, changed defaults]

### Dependencies Updated

- [Package upgrades, version bumps relevant to ops]

---

## Known Issues

- [Any known defects shipping with this release and their workarounds]

---

_Questions? Contact the [team name] team._
```

## Categorization Rules

When processing a list of work items:

| Work Item Type            | Release Notes Category             |
| ------------------------- | ---------------------------------- |
| User Story / Feature      | What's New                         |
| Bug                       | Bug Fixes                          |
| Technical Debt / Refactor | Improvements                       |
| Performance improvement   | Improvements                       |
| Schema migration          | Technical Notes → Database Changes |
| Dependency update         | Technical Notes → Dependencies     |
| Breaking API change       | Technical Notes → Breaking Changes |

## Quality Checks

Before outputting, verify:

- [ ] No internal jargon in external/stakeholder sections
- [ ] Each item has a clear user-facing description (not just work item title)
- [ ] Technical Notes section is clearly marked as internal-only
- [ ] Known issues section is included even if empty
