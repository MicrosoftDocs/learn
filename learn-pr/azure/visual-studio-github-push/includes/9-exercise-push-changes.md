<!-- Guidance on writing the opening to an exercise unit: https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-introductions?branch=master#use-the-standard-exercise-unit-introduction-format -->

The final stage in a simple Git workflow is to push changes to your remote. In this exercise, you'll learn how Visual Studio helps you visualize your local changes and push the commits to the remote branch on GitHub.

<!-- 

See here for general guidance on exercise units: https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-structure-exercise-content?branch=master

The titles of exercise units specified in the YAML should be prefixed with "Exercise - ".

If your module uses sample code or other supporting resources, talk to your contact on the Learn team about creating an official GitHub repository for the module in the MicrosoftDocs organization. Check with your contact before using code or resources from any other source, including official Microsoft sources.

SANDBOXES: There's lots to know about sandbox restrictions, limitations and initial setup - it's best to talk to your contact on the Learn team. The following guidance focuses on actually using the sandbox within your content:

- YAML and resource group referencing: https://review.docs.microsoft.com/en-us/learn-docs/docs/unit-labs-use-sandbox?branch=master
- Cloud shell: https://review.docs.microsoft.com/en-us/learn-docs/docs/unit-labs-sandbox-use-the-cloudshell?branch=master
- Azure portal: https://review.docs.microsoft.com/en-us/learn-docs/docs/unit-labs-sandbox-use-azure-portal?branch=master
- Task validation - confirming resource creation and configuration: https://review.docs.microsoft.com/en-us/learn-docs/docs/unit-labs-sandbox-add-task-validation?branch=master

-->
1. Select the **1 outgoing / 0 incoming** link in the Git Changes window to open the Git Repository window.

:::image type="content" source="../media/9-outgoing-link.png" alt-text="Screenshot of Git Changes window with one outgoing commit":::

1. Under the Outgoing section, double click on the commit to view the Commit Details window.

:::image type="content" source="../media/9-outgoing-commit.png" alt-text="Screenshot of Git Repository window with one outgoing commit":::

1. Select the Program.cs file to view the diff between the base version of the file and your commit.

:::image type="content" source="../media/9-commit-details.png" alt-text="Screenshot of Commit Details window":::

1. In the Git Repository window, under the Outgoing section, select Push.

:::image type="content" source="../media/9-push-commit.png" alt-text="Screenshot of Push button in Git Repository window":::

1. View the operation being performed in the background through the Task Status Center notification.

:::image type="content" source="../media/9-tsc.png" alt-text="Screenshot of Task Status Center notification for push":::

1. Confirm successful completion of the operation by viewing the gold info bar in the Git Repository window.

:::image type="content" source="../media/9-success.png" alt-text="Screenshot of success message for push":::
