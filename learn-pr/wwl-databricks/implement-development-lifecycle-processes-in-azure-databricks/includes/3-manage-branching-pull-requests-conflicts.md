Collaborative development in Azure Databricks relies on effective **version control practices**. When multiple team members work on notebooks and code files simultaneously, you need a structured approach to **isolate changes**, **review code**, and **integrate work** without disrupting production workflows.

Azure Databricks Git folders provide a visual Git client that integrates directly with your workspace. This integration lets you perform common Git operations—branching, committing, and merging—without leaving the Databricks environment.

## Create and manage branches

**Feature branches** isolate your work from the main codebase. When you create a branch in Azure Databricks, you can develop and test changes independently before merging them into shared branches.

To create a new branch:

1. Open the Git dialog by selecting the branch button next to your notebook name.
2. Select **Create branch** and enter a descriptive name.
3. Base your branch on the appropriate source branch, typically `main`.

Use a **consistent naming convention** for branches to identify work clearly. Common patterns include:

- `feature/feature-name` for new functionality
- `bugfix/issue-description` for fixes
- `users/username/description` for personal development work

When you switch branches, **uncommitted changes carry over** to the new branch if they don't conflict with existing code. Discard changes before switching if you don't intend to carry them to the new branch.

> [!IMPORTANT]
> Switching branches may delete workspace assets when the new branch doesn't contain those assets. Verify the asset exists on the target branch before switching, especially if you've shared or bookmarked notebooks.

## Commit and push changes

After modifying notebooks or files, **commit your changes** to create a snapshot in your branch history. The Git folders UI highlights modified files and shows **visual diffs** so you can review changes before committing.

To commit and push changes:

1. Open the Git dialog from your notebook or the workspace browser.
2. Review the list of changed files in the dialog.
3. Enter a descriptive commit message that explains what changed and why.
4. Select **Commit & Push** to save changes and sync with the remote repository.

If you lack permission to commit directly to **protected branches** like `main`, create a feature branch first. You can then use your Git provider's interface to create a pull request for merging.

> [!NOTE]
> Notebook outputs aren't included in commits by default when notebooks use source file formats like `.py`, `.scala`, `.sql`, or `.r`. Use the IPYNB format if you need to version control outputs.

## Work with pull requests

**Pull requests** let team members **review code changes** before merging them into shared branches. While Azure Databricks provides the Git operations for branching and committing, you create and review pull requests through your Git provider's interface—GitHub, Azure DevOps, GitLab, or Bitbucket.

A typical collaboration workflow follows these steps:

1. Clone the repository to your Databricks workspace.
2. Create a feature branch from `main`.
3. Make modifications to notebooks and files.
4. Commit and push changes to the remote repository.
5. Open your Git provider's website and create a pull request.
6. Review code with your team and address feedback.
7. Merge the pull request into the deployment branch.

Databricks recommends that each developer **work on their own branch** to minimize conflicts. When contributors push to the same Git folder, one user switching branches affects everyone sharing that folder.

After a pull request merges, you can sync the changes to your local workspace by pulling the updated branch.

## Resolve merge conflicts

**Merge conflicts** occur when multiple users modify the same lines of a file, and Git can't automatically determine which changes to keep. Conflicts can arise during **pull**, **merge**, or **rebase** operations.

When a conflict occurs, the Git folders UI displays a list of conflicting files with resolution options:

**Keep current or take incoming changes**: Use this approach when you know you want all changes from one side. Select the kebab menu next to the file and choose **Keep all current changes** or **Take all incoming changes**.

**Manual resolution**: For complex conflicts, edit the file directly. Git marks conflicting sections with markers:

```text
<<<<<<< HEAD
Your current changes
=======
Incoming changes
>>>>>>> branch-name
```

Remove the markers and edit the content to keep the correct code. Select **Mark As Resolved** when finished.

After resolving all conflicts, select **Continue Merge** or **Continue Rebase** to complete the operation. If you made incorrect choices, select **Abort** to cancel and return to the previous state.

> [!TIP]
> **Pull changes frequently** from the remote repository to catch conflicts early. Small, frequent merges are easier to resolve than large, complex ones.

With these branching and conflict resolution skills, you can participate effectively in team development workflows. Your next step is understanding how these practices integrate with broader CI/CD processes for deploying code across environments.
