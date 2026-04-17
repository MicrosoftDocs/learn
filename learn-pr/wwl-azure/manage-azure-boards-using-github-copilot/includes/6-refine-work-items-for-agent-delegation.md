Well-written work items are the foundation of successful AI-assisted implementation. Before delegation, update each selected item with actionable acceptance criteria and explicit constraints.

## A practical work item template

When a work item is vague, Copilot has to guess. When a work item is precise, Copilot can generate changes that are easier to review and test. Use a standard template so every delegated task includes the same core information. This is especially useful for learners and new team members because it creates a repeatable format for writing high-quality items.

Use this structure in your work item description or discussion:

### Problem

Explain the observed issue or required capability in one concise paragraph. Focus on the user impact and business context, not just technical symptoms. A clear problem statement helps everyone understand why the task matters.

### Acceptance criteria

- User-observable behavior is clear.
- Edge case behavior is defined.
- Expected tests are specified.
- Done criteria are measurable.

### Technical context

Include known implementation hints so Copilot and reviewers can quickly find the right code areas. This reduces unnecessary exploration and lowers the risk of unrelated changes.

Include known implementation hints, for example:

- Relevant components, controllers, or services.
- Known properties, fields, or APIs.
- Files likely affected.

### Nonfunctional constraints

Document standards that must be preserved, even if they are not visible in the UI. These requirements are often where teams see defects if they are omitted from the work item.

Document standards that must be preserved:

- Performance expectations.
- Security and data handling requirements.
- Existing design system conventions.

## Why this helps Copilot

Refined work items reduce ambiguity and make generated code easier to review. They also improve traceability because intent, criteria, and implementation discussions remain attached to the same work item. For less experienced learners, this creates a stronger learning loop: you can compare the original requirement to the final pull request and understand how decisions were made.

## Quality check before delegation

Before you delegate, run a short quality gate. This prevents avoidable churn and helps ensure the task can be completed in one focused pull request. If any checklist item is missing, update the work item first and then delegate.

Confirm:

- The task is small enough for one pull request.
- Dependencies are identified or intentionally excluded.
- Validation steps are included.
- A reviewer can decide pass/fail from written criteria.

## Summary

High-quality work items are the most important input to successful AI-assisted delivery. By using a consistent template and validating scope before delegation, you improve output quality, shorten review time, and make the entire workflow easier for new learners to follow.
