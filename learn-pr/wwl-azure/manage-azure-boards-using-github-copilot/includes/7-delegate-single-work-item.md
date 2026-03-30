Single-item delegation is the safest starting pattern for teams new to this integration. It provides a controlled path to learn how Copilot works with Azure Boards context.

## Delegation sequence

Single-item delegation means you intentionally start small. Instead of asking Copilot to solve multiple problems at once, you assign one clearly refined work item and follow it from start to finish. This gives your team a clear view of what works well, what needs adjustment, and how to improve future delegations.

1. Open a refined work item in Azure Boards.
2. Start Copilot-assisted pull request creation from the work item integration action.
3. Select the connected GitHub repository and base branch.
4. Confirm the task scope and create the working session.

## Monitor in-flight execution

After delegation starts, watch progress in both Azure Boards and GitHub. This helps you catch misunderstandings early, before they become larger review problems. For beginners, monitoring also builds confidence because you can see how work-item context translates into branch updates, commits, and pull request activity.

During execution, monitor both platforms:

- In GitHub, track activity in the pull request and related agent updates.
- In Azure Boards, review discussion updates and linked development artifacts.

## What good progress looks like

Good progress is not only "more commits." It means the implementation stays aligned with the work item and remains easy to validate. Use the following indicators as a quick health check before approving further progress.

- Pull request description reflects the work item objective.
- Commits align with acceptance criteria.
- Discussion threads show clear status communication.
- Tests or validation notes appear in the pull request.

## When to pause and reset

Sometimes the best decision is to pause. If Copilot starts drifting from scope or repeatedly misses requirements, stop and clarify the work item before continuing. Resetting early is faster than reviewing a large pull request that no longer matches the expected outcome.

Stop and clarify if you see:

- Scope expansion beyond the original work item.
- Repeated misunderstanding of requirements.
- Missing or weak test coverage.
- Changes that conflict with architecture guardrails.

Starting with one item builds team confidence and improves prompt and work-item quality before scaling.

## Summary

Delegating one work item at a time is the most effective way to learn and stabilize your team workflow. With active monitoring and clear stop conditions, you can improve quality, reduce rework, and build a reliable foundation before moving to parallel delegation.
