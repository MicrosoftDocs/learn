Well-written work items are the foundation of successful AI-assisted implementation. Before delegation, update each selected item with actionable acceptance criteria and explicit constraints.

## A practical work item template

Use this structure in your work item description or discussion:

### Problem

Explain the observed issue or required capability in one concise paragraph.

### Acceptance criteria

- [ ] User-observable behavior is clear.
- [ ] Edge case behavior is defined.
- [ ] Expected tests are specified.
- [ ] Done criteria are measurable.

### Technical context

Include known implementation hints, for example:

- Relevant components, controllers, or services.
- Known properties, fields, or APIs.
- Files likely affected.

### Nonfunctional constraints

Document standards that must be preserved:

- Performance expectations.
- Security and data handling requirements.
- Existing design system conventions.

## Why this helps Copilot

Refined work items reduce ambiguity and make generated code easier to review. They also improve traceability because intent, criteria, and implementation discussions remain attached to the same work item.

## Quality check before delegation

Confirm:

- [ ] The task is small enough for one pull request.
- [ ] Dependencies are identified or intentionally excluded.
- [ ] Validation steps are included.
- [ ] A reviewer can decide pass/fail from written criteria.
