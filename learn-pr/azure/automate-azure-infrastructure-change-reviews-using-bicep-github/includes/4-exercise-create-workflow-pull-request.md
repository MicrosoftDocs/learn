You need to update your website to run on the Linux operating system. In this exercise you'll add a validation workflow that automatically runs when a pull request is opened or updated. Then, you'll create a pull request for your website's operating system change.

During the process, you'll:

> [!div class="checklist"]
> * Create a workflow for pull request create and update events.
> * Add Bicep linting to the workflow.
> * Add a branch protection rule to enforce the check succeeds before a pull request is merged.
> * Create a pull request, and watch the workflow run.
> * Fix the errors identified by the pull request validation.
> * Re-run the workflow, and close the pull request.

## Create a workflow to run when pull requests are created and updated

1. In Visual Studio Code, create a new file named *pr-validation.yml* in the *.github/workflows* folder.

   :::image type="content" source="../media/4-visual-studio-code-pr-validation-workflow.png" alt-text="Screenshot of Visual Studio Code that shows the P R validation dot Y M L file within the workflows folder.":::

1. Add the following code into the file:

   :::code language="yaml" source="code/4-pr-validation.yml" range="1-3" :::

   This code ensures that the workflow is executed whenever a pull request is created or updated. Also, we can trigger the workflow manually.

## Add a lint job to your workflow

When a pull request is opened or edited you want to run a linting step for your Bicep files. There's a reusable *lint* workflow in the repository that you can call from this workflow.

1. Add the following lines to reuse the *lint* workflow defined in your repository:

   :::code language="yaml" source="code/4-pr-validation.yml" range="5-7" :::

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Add first version of pull request validation workflow"
   git push
   ```

   <!-- TODO note you're doing this on main, which you might not do in real life -->

## Add a branch protection rule

Configure your Git repository to prevent pull requests from being merged until the checks have succeeded.

1. In your browser, select **Actions**.

1. Select the **pr-validation** workflow.

1. Select **Run workflow** > **Run workflow**.

   :::image type="content" source="../media/4-run-workflow-manual.png" alt-text="Screenshot of GitHub that shows the Actions page with the Run workflow button highlighted.":::

   Your workflow starts running on the *main* branch.

1. Refresh the page to view the workflow status.

   Wait for the workflow to finish running.

   > [!NOTE]
   > You're running your workflow manually so that GitHub detects the *lint* job in your workflow. The workflow needs to have run at least one time before you create the status check in the next steps.

1. Select **Settings**.

1. Select **Branches**.

1. Select **Add rule**.

   :::image type="content" source="../media/4-branch-protections.png" alt-text="Screenshot of GitHub that shows the add branch protection rule page, with the Add rule button highlighted.":::

1. In the **Branch name pattern** text box, enter **main**.

1. Select **Require a pull request before merging**.

1. Deselect **Require approvals**. Normally, you'd select this option. But in this sample, you're going to merge your own pull request, and the **Require approvals** option prevents you from doing so.

1. Select **Require status checks to pass before merging**.

1. In the text box that appears, enter **lint**.

1. Select the **lint / Lint Code** job.

1. Select **Include administrators**. By selecting this option, you enforce the rule on yourself, too.

   Leave the other configuration options with their default values.

1. Near the bottom of the page, select **Create**.

   :::image type="content" source="../media/4-branch-protections-add.png" alt-text="Screenshot of GitHub that shows the add branch protection rule page.":::

   GitHub might ask you to sign in again to confirm your identity.

## Create a pull request

Now that the pull request validation workflow and branch protection rule are configured, let's see how pull requests use your workflow. We've pre-created a branch in your repository with some Bicep changes, which you can use to create your pull request.

1. In your browser, select **Code**.

   Notice that GitHub detects there are two branches with changes.

1. In the box with the branch name **feature/linux-app**, select **Compare & pull request**.

   :::image type="content" source="../media/4-create-pull-request.png" alt-text="Screenshot of GitHub that shows the pull request creation buttons for both branches.":::

   > [!IMPORTANT]
   > Be sure to select the correct branch. Don't select the **feature/container-app** branch yet - you'll use that later in the module.

<!-- TODO up to here -->

1. Select **Contribute** > **Open pull request**.

1. Select **Create pull request**.

   The pull request detail page is displayed.

1. Look at the **Checks** section of the pull request details.

   Notice that an automatic check has been triggered, which runs your pull request validation workflow.
   
   Wait until the check completes. The check fails. Notice that you can't merge the pull request while the check fails.

## Fix the errors of the pull request validation

1. Select **details** to inspect the details of why your pull request validation is failing. <!-- TODO explain error -->

1. In the Visual Studio Code terminal, download all of the branches, and then switch to the *feature/linux-app* branch.

   ```bash
   git pull --all
   git checkout feature/linux-app
   ```

1. In Visual Studio Code, open the *deploy/main.bicep* file.

   Notice that there is a variable named `appServiceAppLinuxFrameworkVersion` on line 21. The variable isn't used. Next, you'll fix this error.

1. In the `appServiceApp` resource definition, update the `linuxFxVersion` property to use the variable instead of setting the property to a hard-coded value:

   :::code language="bicep" source="code/4-main-fixed.bicep" range="62-82" highlight="8" :::

1. In the Visual Studio Code terminal, commit your changes and push them to the repository.

   ```bash
   git add .
   git commit -m "Fix Bicep file"
   git push
   ```

## Monitor and merge the pull request

1. Reopen your browser to the pull request details page.

   Notice that the pull request validation is running again. Wait for the check to complete. This time, it succeeds. There are no syntax or linting errors in the Bicep file, so you're ready to merge the pull request.

1. Select *Merge pull request* to close the pull request and merge the changes in your main branch.

1. Select *Confirm merge*.

1. Select *Delete branch* to delete the *feature/linux-app* branch.
