<!-- Guidance on writing the opening to an exercise unit: https://review.docs.microsoft.com/en-us/learn-docs/docs/id-guidance-introductions?branch=master#use-the-standard-exercise-unit-introduction-format -->

One of the key aspects of any Git workflow is making commits to your branch. Committing is the Git equivalent of saving your file. In this exercise, you'll make a change to your code, stage the changes, and commit them, all without leaving your code files.
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
## Commit a change

1. Open Program.cs by selecting the file from Solution Explorer. Change the output message to "Hello Everyone!". Save the file.

2. Open Git Changes window to view the pending changes. Select the plus button next to Program.cs to stage the file.

3. Now that the changes are staged, enter a commit message in the text box "Updated output message", and select **Commit staged**

## Verify the commit

You'll see the gold info bar in the Git Changes window telling you the commit was created locally. Select the Commit ID to open the details of the commit. You can also select the **1 outgoing / 0 incoming** link above the text box to open the Git Repository window. View the 1 outgoing commit you created in your current branch's commit graph. Next, you'll learn how to push it.