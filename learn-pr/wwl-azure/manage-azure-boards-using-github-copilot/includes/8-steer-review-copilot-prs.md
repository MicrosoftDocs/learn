Copilot-assisted pull requests still require active human supervision. Steering and review are where teams convert AI speed into reliable outcomes.

## Real-time steering practices

When an active session is running, provide concise steering inputs such as:

- Preferred UI/component patterns to match existing code.
- Required ordering or filtering behavior.
- Documentation and naming conventions.
- Test additions needed before review.

Keep steering focused on clarifications and constraints. For major requirement changes, update the work item first, then continue.

## Human-in-the-loop review checklist

Before merge, verify:

- [ ] All acceptance criteria are satisfied.
- [ ] Security and privacy expectations are preserved.
- [ ] Unit and integration tests are present and meaningful.
- [ ] No unrelated changes are included in the pull request.

## Review outcomes

Use one of three outcomes consistently:

- **Approve** when criteria are fully met.
- **Request changes** with clear, actionable feedback.
- **Close/restart** if the scope or assumptions are no longer valid.

This disciplined review approach preserves quality while maintaining delivery velocity.
