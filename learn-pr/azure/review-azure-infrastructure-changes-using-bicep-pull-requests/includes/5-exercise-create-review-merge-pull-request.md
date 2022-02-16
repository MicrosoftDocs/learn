You've completed the work to add a queue to your website. Now, the website development team is ready for you to merge the changes to your main branch. In this exercise, you'll create and merge a pull request for your changes.

During the process, you'll: 

> [!div class="checklist"]
> * Create a pull request.
> * Review the pull request.
> * Complete the pull request.
> * Verify that the changes have been merged.

## Create a pull request to merge the feature branch

Because you can't push changes directly to your repository's *main* branch, you need to create a pull request.

1. In your browser, navigate to **Repos** > **Files**.

1. Select the **add-orders-queue** branch.

   Notice that Azure DevOps shows a banner indicating there are changes in the *add-orders-queue* branch, and offering to create a pull request for them.

1. Select **Create a pull request**.

1. Enter the following details for the pull request:

   **Title:** Add order processing queue
   **Description:** This PR adds a new Azure Storage queue for processing orders, and updates the website configuration to include the storage account and queue information.

## Review the pull request

> [!NOTE]
> Normally, a pull request is reviewed by someone other than its author. For this example, you'll pretend to be another team member and you'll review your own pull request.

1. On the pull request page, select the **Files** tab.

   Azure DevOps shows you the files that were changed in this pull request.

1. In the **main.bicep** file that was changed, find line TODO.

1. Hover your mouse pointer over the line in the right window with the changes, and select the **comment** button that appears.

1. In the comment box, type the following text: **Standard service plan not allowed for test environments, change back to the free plan**.

1. Select **Comment**.

1. Select the **Overview** tab.

1. Add a comment: **This looks good. Ok to merge.**. 

1. Select **Approve**.

## Complete the pull request

Your pull request has been approved. Your website's development team has confirmed they're also ready for you to send the orders to the queue. So, you're ready to complete and merge your pull request.

1. On the pull request page, select **Complete**.

1. In the slide out window, leave all the defaults in place and select **Complete merge**.

   Your pull request is merged, and your new feature is now in the main branch of your repository.

## Verify the changes

1. Navigate to **Repos** > **Files**.

1. Navigate to the **deploy/main.bicep** file.

   Notice that the queue, and your other changes, are now in the file.
