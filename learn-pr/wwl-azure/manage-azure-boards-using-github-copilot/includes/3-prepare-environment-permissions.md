Preparation is the biggest success factor for AI-assisted delivery. Before delegating work, verify access, permissions, and baseline project setup across Azure DevOps and GitHub.

## Prerequisites

Minimum setup usually includes:

- An Azure DevOps organization and project using Azure Boards.
- A GitHub account with repository permissions.
- A GitHub Copilot subscription that supports your workflow.
- A shared branching and review policy for the repository.

## Access and permission checklist

To enable AI-assisted work, you need appropriate access levels in both Azure DevOps and GitHub. These tools work together in your workflow: Azure Boards tracks work items, while GitHub manages code and pulls data about what you're building. Without proper permissions, you'll encounter blockers when trying to create branches, link code to work items, or approve changes.

### Azure DevOps

- Permission to view and edit work items.
- Permission to manage project settings (if you set up the connection).
- Visibility into backlog, boards, and sprint views.

### GitHub

- Permission to install or approve the Azure Boards app scope as needed.
- Permission to create branches and pull requests.
- Permission to view agent activity and review comments.

## Environment quality gates

Before starting the first AI-assisted work cycle, validate your foundational setup. A well-structured project reduces confusion and helps AI generate more relevant suggestions. Work items should follow a clear hierarchy so AI understands the scope of each task. Sprints and team assignments provide context for prioritization. Templates and done criteria ensure everyone (including AI) knows what success looks like.

- Work item hierarchy exists (epic, feature, story/bug, task where needed).
- Sprint or iteration path is configured.
- Team fields and areas are aligned to ownership.
- Test expectations are documented in the work item template.

## Common setup issues

Avoiding common mistakes prevents delays later. Overly permissive access introduces security risks and makes it harder to track who changed what. Unclear work ownership slows down reviews because people aren't sure who should approve changes. Vague work item descriptions lead to poor AI suggestions because the system lacks context. Without documented acceptance criteria, you'll spend time debating whether work is actually complete.

- **Overly broad permissions**: Increases security and governance risks.
- **Unclear ownership**: Slows clarification and review cycles.
- **Incomplete work item descriptions**: Causes low-quality AI output.
- **No definition of done**: Creates inconsistent merge decisions.

Establishing these basics up front reduces rework later in the flow.

## Summary

This section emphasizes that successful AI-assisted delivery depends on establishing the right foundation before delegating work to GitHub Copilot. By securing proper access, aligning permissions across Azure DevOps and GitHub, and ensuring your project infrastructure is well-structured, you enable Copilot to generate relevant suggestions while maintaining security and clarity throughout your development workflow.