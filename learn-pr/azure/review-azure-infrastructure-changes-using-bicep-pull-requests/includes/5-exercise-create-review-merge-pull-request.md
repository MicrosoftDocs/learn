You've completed the work to add a queue to your website. Now, the website development team is ready for you to merge the changes to your main branch. In this exercise, you'll create and merge a pull request for your changes.

During the process, you'll:

> [!div class="checklist"]
>
> * Create a pull request.
> * Review the pull request.
> * Complete the pull request.
> * Verify that the changes have been merged.

## Create a pull request to merge the feature branch

Because you can't push changes directly to your repository's main branch, you need to create a pull request.

::: zone pivot="github"

1. In your browser, go to **Code**.

1. Select **2 branches** to list the branches in your GitHub repository.

   :::image type="content" source="../media/5-github-branches.png" alt-text="Screenshot of GitHub that shows the repository page with the link to the branch list highlighted.":::

1. Next to **add-orders-queue**, select **New pull request**.

   :::image type="content" source="../media/5-github-new-pull-request.png" alt-text="Screenshot of GitHub that shows the branch list. The button for a new pull request is highlighted for the add-orders-queue branch.":::

1. On the page for creating a pull request, notice that GitHub automatically used the Git commit message as the pull request title.

   Update the description to the following text:

   **This PR adds a new Azure Storage queue for processing orders, and updates the website configuration to include the storage account and queue information.**

1. Select **Create pull request**.

   :::image type="content" source="../media/5-github-pull-request-create.png" alt-text="Screenshot of GitHub that shows the pull request creation page, with the button for creating a pull request highlighted.":::

::: zone-end

::: zone pivot="azurerepos"

1. In your browser, go to **Repos** > **Files**.

   Notice that Azure DevOps shows a banner that indicates there are changes in the _add-orders-queue_ branch. The banner offers to create a pull request for those changes.

   :::image type="content" source="../media/5-repos-new-pull-request.png" alt-text="Screenshot of Azure DevOps that shows the repository's file list, including a banner that offers to create a pull request.":::

1. Select **Create a pull request**.

1. On the page for creating a pull request, notice that Azure DevOps automatically used the Git commit message as the pull request title.

   Update the description to the following text:

   **This PR adds a new Azure Storage queue for processing orders, and updates the website configuration to include the storage account and queue information.**

1. Select **Create**.

   :::image type="content" source="../media/5-repos-pull-request-create.png" alt-text="Screenshot of Azure DevOps that shows the pull request creation page, with the button for creating a pull request highlighted.":::

::: zone-end

## Review the pull request

Normally, a pull request is reviewed by someone other than its author. For this example, you'll pretend to be another team member and review your own pull request.

::: zone pivot="github"

1. On the pull request page, select the **Files changed** tab.

   :::image type="content" source="../media/5-github-pull-request-review-files-changed.png" alt-text="Screenshot of GitHub that shows the tab for changed files in a pull request.":::

   GitHub shows you the files that were changed in this pull request. Notice that it highlights all of the lines that have changed, so you can easily see what you should review.

   > [!TIP]
   > Imagine that you're reviewing this for your own team. Would you make any suggestions?

1. In the _main.bicep_ file that was changed, hover over line 18 and select the button with the plus sign (**+**).

   :::image type="content" source="../media/5-github-pull-request-review-line.png" alt-text="Screenshot of GitHub that shows changes to the main dot bicep file. The mouse is hovering over line 18, and the button for adding comments is highlighted.":::

1. In the comment box, enter the following text: **Should this be capitalized?**

1. Select **Start a review**.

   :::image type="content" source="../media/5-github-pull-request-review-comment.png" alt-text="Screenshot of GitHub that shows the comment field, with the button for starting a review highlighted.":::

   > [!TIP]
   > GitHub doesn't let you approve your own pull requests. Here, you'll comment on your pull request but won't approve it. When you work with your own team's pull requests, this is the point at which you'd approve it to indicate you're happy for it to be merged.

1. Select **Finish your review**.

1. In the review panel that appears, select **Submit review**.

   :::image type="content" source="../media/5-github-pull-request-review-submit.png" alt-text="Screenshot of GitHub that shows the panel for finishing a review, with the button for submitting a review highlighted.":::

   GitHub returns you to the pull request's **Conversation** tab.

::: zone-end

::: zone pivot="azurerepos"

1. On the pull request page, select the **Files** tab.

   :::image type="content" source="../media/5-repos-pull-request-review-files-changed.png" alt-text="Screenshot of Azure DevOps that shows the files changed in the pull request.":::

   Azure DevOps shows you the files that were changed in this pull request. Notice that it highlights all of the lines that have changed, so you can easily see what you should review.

   > [!TIP]
   > Imagine that you're reviewing this for your own team. Would you make any suggestions?

1. In the _main.bicep_ file that was changed, hover over line 18 and select the comment button.

   :::image type="content" source="../media/5-repos-pull-request-review-line.png" alt-text="Screenshot of Azure DevOps that shows changes to the main dot bicep file. The mouse is hovering over line 18, and the button for adding a comment is highlighted.":::

1. In the comment box, enter the following text: **Should this be capitalized?**

1. Select **Comment**.

   :::image type="content" source="../media/5-repos-pull-request-review-comment.png" alt-text="Screenshot of Azure DevOps that shows the comment field, with the Comment button highlighted.":::

1. Select **Approve**.

   :::image type="content" source="../media/5-repos-pull-request-approve.png" alt-text="Screenshot of Azure DevOps that shows the Approve button for the pull request.":::

::: zone-end

## Respond to the pull request review

When you create or review a pull request, you can participate in a conversation about its contents. Imagine that you're the author of this file and you want to respond to a comment from the reviewer.

::: zone pivot="github"

1. Respond to the review on the pull request with the following comment: **No, storage queues must have lowercase names.**

1. Select **Comment**, and then select **Resolve conversation** to indicate that the discussion on the line is over.

   :::image type="content" source="../media/5-github-pull-request-respond-comment.png" alt-text="Screenshot of GitHub that shows the response to a comment, with the buttons for entering a comment and resolving a conversation highlighted.":::

::: zone-end

::: zone pivot="azurerepos"

1. Select the **Overview** tab.

   :::image type="content" source="../media/5-repos-pull-request-overview.png" alt-text="Screenshot of Azure DevOps that shows the Overview tab.":::

1. Now, imagine that you're the author of this file. Respond to the review on the pull request with the following comment: **No, storage queues must have lowercase names.**

1. Select **Reply & resolve** to indicate that the discussion on the line is over.

   :::image type="content" source="../media/5-repos-pull-request-respond-comment.png" alt-text="Screenshot of Azure DevOps that shows the response to a comment, with the button for replying and resolving highlighted.":::

::: zone-end

## Complete the pull request

::: zone pivot="github"

Your website's development team has confirmed it's ready for you to send the orders to the queue. So, you're ready to complete and merge your pull request.

::: zone-end

::: zone pivot="azurerepos"

Your pull request has been approved. Your website's development team has confirmed it's ready for you to send the orders to the queue. So, you're ready to complete and merge your pull request.

::: zone-end

::: zone pivot="github"

1. Select **Merge pull request**.

   :::image type="content" source="../media/5-github-pull-request-merge.png" alt-text="Screenshot of GitHub that shows a pull request with the button for merging highlighted.":::

1. GitHub asks you to confirm the merge. When GitHub merges the pull request, it creates a commit and automatically generates a commit message. Select **Confirm merge**.

   :::image type="content" source="../media/5-github-pull-request-merge-confirm.png" alt-text="Screenshot of GitHub that shows a pull request with the button for confirming a merge highlighted.":::

   Your pull request is merged, and your new feature is now in the main branch of your repository.

1. It's a good practice to delete your feature branches when you're done with them. This helps you avoid confusing team members in the future about which work is still in progress. Select **Delete branch**.

   :::image type="content" source="../media/5-github-pull-request-merge-delete.png" alt-text="Screenshot of GitHub that shows a pull request with the button for deleting a branch highlighted.":::

::: zone-end

::: zone pivot="azurerepos"

1. Select **Complete**.

   :::image type="content" source="../media/5-repos-pull-request-complete.png" alt-text="Screenshot of Azure DevOps that shows the Complete button for a pull request.":::

1. In the slide-out window, leave all the default settings. Select **Complete merge**.

   :::image type="content" source="../media/5-repos-pull-request-complete-merge.png" alt-text="Screenshot of Azure DevOps that shows the pull request completion panel, with the button for completing a merge highlighted.":::

   Your pull request is merged, and your new feature is now in the main branch of your repository.

   Azure DevOps automatically deleted the feature branch when you merged the pull request. It's a good practice to delete your feature branches when you're done with them. This helps you avoid confusing team members in the future about which work is still in progress.

::: zone-end

## Verify the changes

Because this is your first time merging a pull request, it's a good idea to confirm that the changes have been merged successfully.

::: zone pivot="github"

1. Go to **Code**.

1. Go to the _deploy/main.bicep_ file, and then to the _deploy/modules/appService.bicep_ file.

   :::image type="content" source="../media/5-github-code-final.png" alt-text="Screenshot of GitHub that shows the repository's file list after the pull request is merged.":::

   Notice that the queue and your other changes are now in the files.

::: zone-end

::: zone pivot="azurerepos"

1. Go to **Repos** > **Files**.

1. Go to the _deploy/main.bicep_ file, and then to the _deploy/modules/appService.bicep_ file.

   Notice that the queue and your other changes are now in the files.

::: zone-end
