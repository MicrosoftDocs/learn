GitHub flow illustrates how GitHub can add value to the traditional Git-based collaborative software development. Its purpose is to streamline updates to GitHub-hosted projects by providing a prescriptive guidance on the process of applying changes to the project's repository. The organization in our sample scenario would likely benefit from incorporating GitHub Flow into their DevOps practices, especially considering their lack of experience in using Git-based repositories. In this unit, review the sequence of steps that represent the most common use case of GitHub flow.

## Following GitHub flow

:::image type="content" source="../media/4-git-workflow.png" alt-text="Diagram showing a basic branch workflow.":::

GitHub flow consists of the following steps:

1. **Creating a repository**. To follow GitHub flow, you'll need a GitHub account and a repository. By default, a new repository includes the default branch, typically named *main*.
1. **Creating a branch**. Creating another branch allows you to develop and save your changes without affecting the default branch. In addition, it allows others to collaborate on your changes by reviewing them before they're merged into the main branch. You could create a branch directly in GitHub or clone the repository to your local computer and create a branch there.
1. **Making changes to the branch**. Apply changes to the newly created branch by invoking the commit and (if working locally) push actions. You can edit files directly in the GitHub hosted repository by using the GitHub web interface. For every commit, provide a short message describing the changes you applied. Repeat these steps until you consider your changes complete and you're ready to ask others to review them.
1. **Creating a pull request**. Request for feedback by creating a pull request (commonly abbreviated as *PR*) following the last commit to the branch you created. Provide a summary of changes included in the branch and explain the improvement they intend to bring. Use the *@* mention notation if you want to request a review from specific individuals or teams.

    :::image type="content" source="../media/3-pull-requests.png" alt-text="Diagram showing main and feature branches, and a pull request.":::

1. **Reviewing the pull request**. This is where others step in, review your pull request, and submit their feedback, including comments, questions, and suggestions.
1. **Addressing review comments**. Once the reviews are completed, you adjust your changes to take them into account and await the pull request approval.
1. **Merging the pull request**. Approving the pull request allows you to merge the content of the branch you created with the default (main) branch. GitHub by default retains the comments and commits in the pull request, which allows you and others to revisit them at any point. When implementing branch protection, its restrictions might affect the ability to merge, so ensure that they're satisfied first.
1. **Deleting the branch**. Once the merge is complete, you can delete the branch you created. This helps minimize the size of the repository and prevents an accidental use of stale branches.
