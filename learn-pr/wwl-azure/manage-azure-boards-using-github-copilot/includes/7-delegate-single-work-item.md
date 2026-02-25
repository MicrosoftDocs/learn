Single-item delegation is the safest starting pattern for teams new to this integration. It provides a controlled path to learn how Copilot works with Azure Boards context.

## Delegation sequence

1. Open a refined work item in Azure Boards.
2. Start Copilot-assisted pull request creation from the work item integration action.
3. Select the connected GitHub repository and base branch.
4. Confirm the task scope and create the working session.

## Monitor in-flight execution

During execution, monitor both platforms:

- In GitHub, track activity in the pull request and related agent updates.
- In Azure Boards, review discussion updates and linked development artifacts.

## What good progress looks like

- Pull request description reflects the work item objective.
- Commits align with acceptance criteria.
- Discussion threads show clear status communication.
- Tests or validation notes appear in the pull request.

## When to pause and reset

Stop and clarify if you see:

- Scope expansion beyond the original work item.
- Repeated misunderstanding of requirements.
- Missing or weak test coverage.
- Changes that conflict with architecture guardrails.

Starting with one item builds team confidence and improves prompt and work-item quality before scaling.
