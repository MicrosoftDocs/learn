
GitHub is the best tool to enable collaboration in your projects. GitHub flow is a branch-based workflow suggested for GitHub.

> [!NOTE]
> To implement GitHub flow, you'll need a GitHub account and a repository. See "[Signing up for GitHub](https://docs.github.com/en/github/getting-started-with-github/signing-up-for-github)" and "[Create a repo](https://docs.github.com/en/github/getting-started-with-github/create-a-repo)."

> [!TIP]
> You can complete all steps of GitHub flow through the GitHub web interface, command line, [GitHub CLI](https://cli.github.com/), or [GitHub Desktop](https://docs.github.com/en/free-pro-team@latest/desktop).

The first step is to create a branch in your repository to work without affecting the default branch, and you give collaborators a chance to review your work.

For more information, see "[Creating and deleting branches within your repository](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/creating-and-deleting-branches-within-your-repository)."

:::image type="content" source="../media/create-branch-8f64a7d3.png" alt-text="Screenshot of a branching model representing the branch creation.":::


Make any desired changes to the repository. If you make a mistake, you can revert or push extra changes to fix it.

Commit and push your changes to your branch to back up your work to remote storage, giving each commit a descriptive message. Each commit should contain an isolated, complete change making it easy to revert if you take a different approach.

Anyone collaborating with your project can see your work, answer questions, and make suggestions or contributions. Continue to create, commit, and push changes to your branch until you're ready to ask for feedback.

> [!TIP]
> You can make a separate branch for each change to make it easy for reviewers to give feedback or for you to understand the differences.

Once you're ready, you can create a pull request to ask collaborators for feedback on your changes. See "[Creating a pull request](https://docs.github.com/en/articles/creating-a-pull-request)."

Pull request review is one of the most valuable features of collaboration. You can require approval from your peers and team before merging changes. Also, you can mark it as a draft in case you want early feedback or advice before you complete your changes.

:::image type="content" source="../media/open-pull-request-5c5ad0c7.png" alt-text="Screenshot of a branching model representing an open a pull request.":::


Describe the pull request as much as possible with the suggested changes and what problem you're resolving. You can add images, links, related issues, or any information to document your change and help reviewers understand the PR without opening each file. See "[Basic writing and formatting syntax](https://docs.github.com/en/github/writing-on-github/basic-writing-and-formatting-syntax)" and "[Linking a pull request to an issue](https://docs.github.com/en/github/managing-your-work-on-github/linking-a-pull-request-to-an-issue)."

:::image type="content" source="../media/github-pull-request-162b47c0.png" alt-text="Screenshot of open a pull request representation with description field, related issue and a checklist template.":::


Another way to improve PR quality and documentation and explicitly point something out to the reviewers is to use the comment session area. Also, you can @mention or request a review from specific people or teams.

:::image type="content" source="../media/github-pull-request-comment-bd7b9038.png" alt-text="Screenshot of pull request comment field.":::


There are other Pull Requests configurations, such as automatically requesting a review from specific teams or users when a pull request is created or checks to run on pull requests. For more information, see "[About status checks](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/about-status-checks)" and "[About protected branches](https://docs.github.com/en/github/administering-a-repository/about-protected-branches)."

After the reviewers' comments and checks validation, the changes should be ready to be merged, and they can approve the Pull Request. See [Merging a pull request](https://docs.github.com/en/pull-requests/collaborating-with-pull-requests/incorporating-changes-from-a-pull-request/merging-a-pull-request)."

If you have any conflicts, GitHub will inform you to resolve them. "[Addressing merge conflicts](https://docs.github.com/en/github/collaborating-with-issues-and-pull-requests/addressing-merge-conflicts)."

:::image type="content" source="../media/merge-branch-640aa393.png" alt-text="Screenshot of a branching model representing the branch merge.":::


After a successful pull request merges, there's no need for the remote branch to stay there. You can delete your branch to prevent others from accidentally using old branches. For more information, see "[Deleting and restoring branches in a pull request](https://docs.github.com/en/github/administering-a-repository/deleting-and-restoring-branches-in-a-pull-request)."

> [!NOTE]
> GitHub keeps the commit and merges history if you need to restore or revert your pull request.
