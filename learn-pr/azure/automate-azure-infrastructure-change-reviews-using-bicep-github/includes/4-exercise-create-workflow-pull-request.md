Your website's development team asked you to update the website to run on the Linux operating system. In this exercise, you'll add a validation workflow that automatically runs when a pull request is opened or updated. Then, you'll create a pull request for your website's operating system change.

During the process, you'll:

> [!div class="checklist"]
>
> - Create a workflow for pull request validation.
> - Add Bicep linting to the workflow.
> - Create a pull request, and watch the workflow run.
> - Fix any errors that are identified by the pull request validation workflow.
> - Rerun the workflow, and then merge and close the pull request.

## Create a workflow to run when pull requests are created and updated

1. In Visual Studio Code, create a new file named _pr-validation.yml_ in the _.github/workflows_ folder.

   :::image type="content" source="../media/4-visual-studio-code-workflow.png" alt-text="Screenshot of Visual Studio Code that shows the PR validation dot YML file within the workflows folder.":::

1. Add the following code to the file:

   :::code language="yaml" source="code/4-pr-validation.yml" range="1-3" :::

   This code ensures that the workflow is executed whenever a pull request is created or updated.

   > [!NOTE]
   > You're working directly against your repository's _main_ branch. You wouldn't ordinarily do this, but in this exercise you'll work against _main_ to simplify the steps. In your own projects, it's important to set up branch-protection rules to protect your main branch.

## Add a lint job to your workflow

Whenever you open or edit a pull request, you want to run a linting step for your Bicep files. There's a reusable _lint_ workflow in the repository that you can call from this workflow.

1. At the end of the existing file contents, to reuse the _lint_ workflow that's defined in your repository, add the following lines:

   :::code language="yaml" source="code/4-pr-validation.yml" range="5-7" :::

   Your repository has a _bicepconfig.json_ file that configures the linter to emit errors instead of warnings, so any failures during the lint job will cause the workflow to fail.

1. Save your changes.

1. Commit and push your changes to your Git repository's _main_ branch by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Add first version of pull request validation workflow"
   git push
   ```

## Update the Bicep file

Next, modify your website's Bicep file to update the website's operating system to Linux.

1. In the Visual Studio Code terminal, create a new branch for your changes by running the following command:

   ```bash
   git checkout -b feature/linux-app
   ```

1. Open the _main.bicep_ file in the _deploy_ folder.

1. Near the top of the file, below the variable definitions, define a new variable for the application framework to use:

   :::code language="bicep" source="code/4-main-broken.bicep" range="15-20" highlight="6" :::

   This setting tells Azure App Service that the application will be built using version 14 of the Node.js framework.

1. Update the `appServicePlan` resource definition. Add the `kind` property and the `reserved` property in the `properties` object:

   :::code language="bicep" source="code/4-main-broken.bicep" range="51-59" highlight="5-8" :::

1. Update the `appServiceApp` resource definition to set the application framework:

   :::code language="bicep" source="code/4-main-broken.bicep" range="61-71" highlight="7-9" :::

   > [!NOTE]
   > You might notice that Bicep warns you that you aren't using the `appServiceAppLinuxFrameworkVersion` variable. Here, you're intentionally causing a linter error so you can see how it looks within the GitHub pull request.

1. Save your changes.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Update operating system to Linux"
   git push origin feature/linux-app
   ```

## Create a pull request

Now that the workflow is configured and your Bicep file is updated, you can create a pull request.

1. In your browser, select **Code**.

1. Select **2 branches** to open the list of branches in your GitHub repository.

   :::image type="content" source="../media/4-branches.png" alt-text="Screenshot of GitHub that shows the repository's branch list.":::

   **Compare & pull request** is displayed for a short time when you push changes to branch that doesn't already have an open pull request. It's a shortcut to the **Open a pull request** page.

1. Next to the **feature/linux-app** branch, select **New pull request**. You might need to select the **More** icon (**...**) to display the **New pull request** option.

   :::image type="content" source="../media/4-create-pull-request.png" alt-text="Screenshot of GitHub that shows the link to create a pull request for the feature slash linux app branch.":::

1. Select **Create pull request**.

   :::image type="content" source="../media/4-create-pull-request-details.png" alt-text="Screenshot of GitHub 'Open a pull request' pane, which displays the 'Create pull request' button.":::

   The pull request details page is displayed.

1. View the **Checks** section of the pull request details.

   After a moment, notice that an automatic check is triggered. The check runs your pull request validation workflow.

   It might take some time for the workflow to start running. Refresh your browser window until you see the status checks.

   When the check finishes, you can see that it failed.

   :::image type="content" source="../media/4-checks-failed.png" alt-text="Screenshot of GitHub that shows the failed status check on the pull request details page.":::

   > [!NOTE]
   > GitHub allows you to merge the pull request even though the status checks have failed. In a real solution, you should configure a branch-protection rule to prevent a pull request from being merged until its status checks have succeeded.

## Fix the pull request validation errors

1. On the status check pane, select **Details** to inspect the workflow log.

   :::image type="content" source="../media/4-linter-error.png" alt-text="Screenshot of GitHub that shows the workflow log, including the validation error.":::

   The log includes this message from the Bicep linter:

   ```output
   Error no-unused-vars: Variable "appServiceAppLinuxFrameworkVersion" is declared but never used.
   ```

1. In Visual Studio Code, open the _deploy/main.bicep_ file.

   At line 20, there's a variable named `appServiceAppLinuxFrameworkVersion`. The variable isn't used. Next, you'll fix this error.

1. In the `appServiceApp` resource definition, update the `linuxFxVersion` property to use the variable instead of setting the property to the hard-coded value:

   :::code language="bicep" source="code/4-main-fixed.bicep" range="61-72" highlight="8" :::

1. In the Visual Studio Code terminal, commit your changes and push them to the repository.

   ```bash
   git add .
   git commit -m "Fix Bicep file"
   git push origin feature/linux-app
   ```

## Monitor and merge the pull request

1. Reopen your browser to the pull request details page.

   The pull request validation runs again. If the status check isn't running, refresh your page.

   Wait for the check to finish. This time, it succeeds. There are no syntax or linter errors in the Bicep file, so you're ready to merge the pull request.

1. Select **Merge pull request** to close the pull request and merge the changes in your main branch.

   :::image type="content" source="../media/4-merge-pull-request.png" alt-text="Screenshot of GitHub that shows the 'Merge pull request' button on the pull request details page.":::

1. Select **Confirm merge**.
