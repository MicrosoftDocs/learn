The pull request (PR) is your ticket to getting your knowledge onto the Learn platform. You’ve created a PR, but it hasn’t been submitted yet to the destination repository’s PR queue. As with many open-source projects, there are a series of checks and reviews that take place to validate changes before publishing. 

## Anatomy of a PR

:::row:::
   :::column span="2":::
      :::image type="content" source="../media/pr-sc-overview-final.png" alt-text="Screenshot of an open pull request.":::
   :::column-end:::
   :::column span="":::
      A PR shows the GitHub user who created the PR, the destination repository, and the branch in which the PR was created. PRs contain several tabs at the top, including:
        -Conversation tab: A dashboard where you can view and reply to comments from other collaborators, see a list of notifications throughout the build and review process, and use comment automation to perform actions.
        -Commits tab: A record of the changes that have been made to that branch.
        -Files changed tab: A comparison of the changed file(s) in the PR with their prior state. 
   :::column-end:::
:::row-end:::


You’ll want to pay careful attention to the conversations tab, which is where any updates or notifications appear and any discussions between you, the reviewers, and other collaborators take place. You’ll also add hashtag comments here to perform actions, such as signing off on the PR to indicate it’s ready to be validated and merged, or holding off if you need to pause the process. 

PRs often have labels attached to indicate their status, such as `draft` to specify draft PRs that aren’t ready for review, or `do-not-merge` for PRs that are new or unreviewed. 

## Validation

Before your PR can be merged into its destination branch, it might be required to pass through one or more PR validation processes. After you select Create pull request, GitHub runs the validations configured for your repository. When the validation process finishes, the results appear in the PR. 

Validation processes vary depending on the scope of proposed changes and the rules of the destination repository. After you submit your PR, you can expect one or more of the following to happen:

- **Mergeability**: A baseline GitHub mergeability test occurs first to verify whether the proposed changes in your branch are in conflict with the destination branch. If the PR indicates that this test failed, you must reconcile the content that’s causing the merge conflict before processing can continue.
- **Contribution Licensing Agreement** (**CLA**): If you’re contributing to a public repository and aren’t a Microsoft employee, depending on the magnitude of the proposed changes, you might be asked to complete a short CLA the first time you submit a PR to that repository. After the CLA step is cleared, your PR will be processed.
- **Labeling**: Labels are automatically applied to your PR to indicate the state of your PR as it passes through the validation workflow. For instance, new PRs might automatically receive the "do-not-merge" label, indicating that the PR has not yet completed the validation, review, and sign-off steps. 
- **Validation and build**: Automated checks verify whether your changes pass validation tests. The validation tests might yield warnings or errors, requiring you to make changes to one or more files in your PR before it can be merged. The validation test results are added as a comment in your PR for your review, and they might be sent to you in e-mail too. 
- **Staging**: The article pages affected by your changes are automatically deployed to a staging environment for review upon successful validation and build. Preview URLs appear in a PR comment.
- **Auto-merge**: The PR might be automatically merged if it passes validation testing and certain criteria. In this case, you don't need to do anything else.

## Review and sign-off

You’re almost there! After all PR processing is completed, it’s best practice to review the results (for example, PR comments, preview URLs) to determine if more changes are required before you sign off for merging. If a PR reviewer has reviewed your PR, they can also provide feedback via comments if there are outstanding issues or questions preventing the merge.

Use comment automation to perform important actions in the PR. Comment automation enables users to assign the appropriate label to their PR to update its state or categorize it. If you’re working in a repository where comment automation has been implemented, use the hashtag comments to assign or change labels, close a PR, or pause merging. For example, when you’re done making changes, you’ll type the comment “#sign-off” to change your PR label from `do-not-merge` to `ready-for-review.` 

Use the comments in the following table to perform key actions in your PR:

| **Hashtag comment** | **What it does** |
| --- | --- |
| `#sign-off` | Automatically assigns the **ready-to-merge** label to let the reviewers in the repo know the PR is ready for review/merge. <br/><br/> If you are <em>not</em> the listed author and try to sign off on a public repo PR using the <code>#sign-off</code> comment, the PR is updated to indicate that only the author can assign the label. |
| `#hold-off` | Removes the **ready-to-merge** label in case you change your mind or make a mistake. |
| `#please-close` | Closes the PR if you decide not to have the changes merged. |
| `#please-open` | Reopens a closed PR or issue. |

You must enter the comment #sign-off to merge your changes. Even if all reviews and validation checks pass, you’re responsible for using this comment to tell the PR reviewers and repo administrators that your changes are ready for merging from your side of things. When the reviewers determine that your PR is issue-free and signed off, your changes are merged back into the parent branch and the PR is closed.

:::image type="content" source="../media/pr-sc-signoff.png" alt-text="Screenshot of the comment box on a PR with #sign-off typed into the comment field and the Comment button highlighted.":::

## Publishing

Remember, your PR must be merged by a PR reviewer before the changes can be included in the next scheduled publishing run. Normally, PRs are reviewed and merged in order of submission. 

After your contributions are approved and merged, the publishing process picks them up. Depending on the team that manages the repository you’re contributing to, publishing times can vary, but they typically occur at least once every weekday. It can take up to 45 minutes for articles to appear online after publishing. 

Once your changes are published, they’ll go live on Microsoft Learn for others to start learning from! 
