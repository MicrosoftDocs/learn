Preparation is the biggest success factor for AI-assisted delivery. Before delegating work, verify access, permissions, and baseline project setup across Azure DevOps and GitHub.

## Prerequisites

Minimum setup usually includes:

- An Azure DevOps organization and project using Azure Boards.
- A GitHub account with repository permissions.
- A GitHub Copilot subscription that supports your workflow.
- A shared branching and review policy for the repository.

## Access and permission checklist

### Azure DevOps

- [ ] Permission to view and edit work items.
- [ ] Permission to manage project settings (if you set up the connection).
- [ ] Visibility into backlog, boards, and sprint views.

### GitHub

- [ ] Permission to install or approve the Azure Boards app scope as needed.
- [ ] Permission to create branches and pull requests.
- [ ] Permission to view agent activity and review comments.

## Environment quality gates

Before starting the first AI-assisted work cycle, validate:

- Work item hierarchy exists (epic, feature, story/bug, task where needed).
- Sprint or iteration path is configured.
- Team fields and areas are aligned to ownership.
- Test expectations are documented in the work item template.

## Common setup issues

- **Overly broad permissions**: Increases security and governance risks.
- **Unclear ownership**: Slows clarification and review cycles.
- **Incomplete work item descriptions**: Causes low-quality AI output.
- **No definition of done**: Creates inconsistent merge decisions.

Establishing these basics up front reduces rework later in the flow.
