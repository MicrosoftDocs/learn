Your website's development team has asked you to update the website to run on the Linux operating system. In this exercise, you'll add a validation workflow that automatically runs when a pull request is opened or updated. Then, you'll create a pull request for your website's operating system change.

During the process, you'll:

> [!div class="checklist"]
> * Create a workflow for pull request create and update events.
> * Add Bicep linting to the workflow.
> * Create a pull request, and watch the workflow run.
> * Fix the errors identified by the pull request validation.
> * Re-run the workflow, and close the pull request.

## Create a workflow to run when pull requests are created and updated

1. In Visual Studio Code, create a new file named *pr-validation.yml* in the *.github/workflows* folder.

   :::image type="content" source="../media/4-visual-studio-code-pr-validation-workflow.png" alt-text="Screenshot of Visual Studio Code that shows the P R validation dot Y M L file within the workflows folder.":::

1. Add the following code into the file:

   :::code language="yaml" source="code/4-pr-validation.yml" range="1-3" :::

   This code ensures that the workflow is executed whenever a pull request is created or updated.

   > [!TIP]
   > You're working directly against your repository's *main* branch. Normally, you wouldn't do this, but in this exercise you'll work against *main* to simplify the steps. In your own projects, it's important to set up branch protection rules to protect your main branch.

## Add a lint job to your workflow

When a pull request is opened or edited you want to run a linting step for your Bicep files. There's a reusable *lint* workflow in the repository that you can call from this workflow.

1. At the bottom of the file, add the following lines to reuse the *lint* workflow defined in your repository:

   :::code language="yaml" source="code/4-pr-validation.yml" range="5-7" :::

1. Save your changes.

1. Commit and push your changes to your Git repository's *main* branch by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Add first version of pull request validation workflow"
   git push
   ```

## Update the Bicep file

Here, you modify your website's Bicep file to update the website's operating system to Linux.

1. In the Visual Studio Code terminal, run the following command to create a new branch for your changes:

   ```bash
   git checkout -b feature/linux-app
   ```

1. Open the *main.bicep* file in the *deploy* folder.

1. Near the top of the file, below the variable definitions, define a new variable for the application framework to use:

   :::code language="bicep" source="code/4-main-broken.bicep" range="15-20" highlight="6" :::

   This setting tells Azure App Service that the application will be built using version 14 of the Node.js framework.

1. Update the `appServicePlan` resource definition. Change its `kind`, and add a new property named `reserved` in the `properties` object:

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

1. Next to the **feature/linux-app** branch, select **New pull request**.

   :::image type="content" source="../media/4-create-pull-request.png" alt-text="Screenshot of GitHub that shows the link to create a pull request for the feature slash linux app branch.":::

1. Select **Create pull request**.

   :::image type="content" source="../media/4-create-pull-request-details.png" alt-text="Screenshot of GitHub that shows the pull request creation page.":::

   The pull request detail page is displayed.

1. Look at the **Checks** section of the pull request details.

   After a moment, notice that an automatic check has been triggered. The check runs your pull request validation workflow.

   It might take some time for the workflow to start running. Refresh your browser window until you see the status checks.
   
   Wait until the check completes. The check fails.

   :::image type="content" source="../media/4-checks-failed.png" alt-text="Screenshot of GitHub that shows the failed status check on the pull request details page.":::

   > [!TIP]
   > Notice that you can still merge the pull request even while the status checks fail. In a real solution, you should configure a branch protection rule to prevent a pull request from being merged until its status checks have succeeded.

## Fix the errors of the pull request validation

1. On the status check, select **Details** to inspect the workflow log.

   :::image type="content" source="../media/4-linter-error.png" alt-text="Screenshot of GitHub that shows the workflow log.":::

   Notice that the log includes this message from the Bicep linter:

   ```output
   Error no-unused-vars: Variable "appServiceAppLinuxFrameworkVersion" is declared but never used. 
   ```

1. In Visual Studio Code, open the *deploy/main.bicep* file.

   Notice that there is a variable named `appServiceAppLinuxFrameworkVersion` on line 20. The variable isn't used. Next, you'll fix this error.

1. In the `appServiceApp` resource definition, update the `linuxFxVersion` property to use the variable instead of setting the property to the hard-coded value:

   :::code language="bicep" source="code/4-main-fixed.bicep" range="61-72" highlight="8" :::

1. In the Visual Studio Code terminal, commit your changes and push them to the repository.

   ```bash
   git add .
   git commit -m "Fix Bicep file"
   git push origin feature/linux-app
   ```

## Monitor and merge the pull request

1. Reopen your browser back to the pull request details page.

   The pull request validation runs again. If you don't see the status check running, refresh your page.
   
   Wait for the check to complete. This time, it succeeds. There are no syntax or linter errors in the Bicep file, so you're ready to merge the pull request.

1. Select **Merge pull request** to close the pull request and merge the changes in your main branch.

   :::image type="content" source="../media/4-merge-pull-request.png" alt-text="Screenshot of GitHub that shows the Merge pull request button on the pull request details page.":::

1. Select **Confirm merge**.
