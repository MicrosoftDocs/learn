You've completed the work to add a queue to your website. Now, the website development team is ready for you to merge the changes to your main branch. In this exercise, you'll create and merge a pull request for your changes.

During the process, you'll: 

> [!div class="checklist"]
> * Create a pull request.
> * Review the pull request.
> * Complete the pull request.
> * Verify that the changes have been merged.

## Create a pull request to merge the feature branch

Because you can't push changes directly to your repository's *main* branch, you need to create a pull request.

::: zone pivot="github"

1. In your browser, navigate to **Code**.

1. Select **2 branches** to list the branches in your GitHub repository.

   :::image type="content" source="../media/5-github-branches.png" alt-text="TODO":::

1. Next to **add-orders-queue**, select **New pull request**.

   :::image type="content" source="../media/5-github-new-pull-request.png" alt-text="TODO":::

1. On the pull request creation page, notice that GitHub automatically used the Git commit message as the pull request title.

   Enter the following description:

   *This PR adds a new Azure Storage queue for processing orders, and updates the website configuration to include the storage account and queue information.*

1. Select **Create pull request**.

   :::image type="content" source="../media/5-github-pull-request-create.png" alt-text="TODO":::

::: zone-end

::: zone pivot="azurerepos"

1. In your browser, navigate to **Repos** > **Files**.

1. Select the **add-orders-queue** branch.

   Notice that Azure DevOps shows a banner indicating there are changes in the *add-orders-queue* branch, and offering to create a pull request for them.

1. Select **Create a pull request**.

1. Enter the following details for the pull request:

   **Title:** Add order processing queue
   **Description:** This PR adds a new Azure Storage queue for processing orders, and updates the website configuration to include the storage account and queue information.

1. TODO create button?

::: zone-end

## Review the pull request

> [!NOTE]
> Normally, a pull request is reviewed by someone other than its author. For this example, you'll pretend to be another team member and you'll review your own pull request.

::: zone pivot="github"

1. On the pull request page, select the **Files changed** tab.

   :::image type="content" source="../media/5-github-pull-request-review-files-changed.png" alt-text="TODO":::

   GitHub shows you the files that were changed in this pull request. Notice that it highlights all of the lines that have changed, so you can easily see what you should review.

   > [!TIP]
   > Imagine you're reviewing this for your own team. Would you make any suggestions?

1. In the **main.bicep** file that was changed, hover over line 12 and select the button with the plus sign (**+**).

   :::image type="content" source="../media/5-github-pull-request-review-line.png" alt-text="TODO":::

1. In the comment box, enter the following text: **Should this be capitalized?**.

1. Select **Start a review**.

   :::image type="content" source="../media/5-github-pull-request-review-comment.png" alt-text="TODO":::

1. Select **Submit review**.

   :::image type="content" source="../media/5-github-pull-request-review-submit.png" alt-text="TODO":::

   GitHub returns you to the pull request's **Conversation** tab.

1. Now, imagine you're the author of this file. Respond to the review on the pull request with the comment *No, storage queues must have lowercase names.*

   :::image type="content" source="../media/5-github-pull-request-respond-comment.png" alt-text="TODO":::

1. Select **Comment**, and then select **Resolve conversation** to indicate there discussion on the line is over.

::: zone-end

::: zone pivot="azurerepos"

1. On the pull request page, select the **Files** tab.

   Azure DevOps shows you the files that were changed in this pull request.

   > [!TIP]
   > Imagine you're reviewing this for your own team. Would you make any suggestions?

1. In the **main.bicep** file that was changed, find line 12.

1. Hover your mouse pointer over the line in the right window with the changes, and select the **comment** button that appears.

1. In the comment box, enter the following text: **TODO**.

1. Select **Comment**.

1. Select the **Overview** tab.

1. Add a comment: **This looks good. Ok to merge.**. 

1. Select **Approve**.

::: zone-end

## Complete the pull request

Your pull request has been approved. Your website's development team has confirmed they're also ready for you to send the orders to the queue. So, you're ready to complete and merge your pull request.

::: zone pivot="github"

1. Select **Merge pull request**.

   :::image type="content" source="../media/5-github-pull-request-merge.png" alt-text="TODO":::

1. GitHub asks you to confirm the merge. When GitHub merges the pull request, it creates a commit and uses the commit message . Select **Confirm merge**.

   :::image type="content" source="../media/5-github-pull-request-merge-confirm.png" alt-text="TODO":::

   Your pull request is merged, and your new feature is now in the main branch of your repository.

1. It's a good practice to delete your feature branches when you're done with them. This helps you to avoid confusing team members in future about which work is sitll in progress. Select **Delete branch.**

   :::image type="content" source="../media/5-github-pull-request-merge-delete.png" alt-text="TODO":::

::: zone-end

::: zone pivot="azurerepos"

1. On the pull request page, select **Complete**.

1. In the slide out window, leave all the defaults in place and select **Complete merge**.

   Your pull request is merged, and your new feature is now in the main branch of your repository.

::: zone-end

## Verify the changes

Because this is your first time merging a pull request, it's a good idea to confirm that the changes have been merged successfully.

::: zone pivot="github"

1. Navigate to **Code**.

1. Navigate to the *deploy/main.bicep* file, and then to the *deploy/modules/appService.bicep* file.

   :::image type="content" source="../media/5-github-code-final.png" alt-text="TODO":::

   Notice that the queue, and your other changes, are now in the file.

::: zone-end

::: zone pivot="azurerepos"

1. Navigate to **Repos** > **Files**.

1. Navigate to the *deploy/main.bicep* file, and then to the *deploy/modules/appService.bicep* file.

   Notice that the queue, and your other changes, are now in the file.

::: zone-end
