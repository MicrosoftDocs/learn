You spoke to your team and decided to further automate your deployments by using a workflow. You want to build more confidence in what you deploy.

In this exercise, you'll add validation jobs to your workflow. You'll then run the linter and preflight validation before each deployment.

During the process, you do the following tasks:

> [!div class="checklist"]
>
> - Update your existing workflow to add two new jobs to lint and validate your Bicep code.
> - Run your workflow.
> - Fix any issues that your workflow detects.

## Add lint and validation jobs to your workflow

1. In Visual Studio Code, open the _workflow.yml_ file in the _.github/workflows_ folder.

1. In the `env:` section, change the `AZURE_RESOURCEGROUP_NAME` variable's value to `ToyWebsiteTest`:

   :::code language="yaml" source="code/5-workflow.yml" range="13-15" highlight="2" :::

1. Below the `jobs:` line, above the `deploy` job, add a new lint job:

   :::code language="yaml" source="code/5-workflow.yml" range="17-23" highlight="2-7" :::

   This job defines a step to check out the code and a step that runs the `az bicep build` command to lint the Bicep file.

   > [!TIP]
   > YAML files are sensitive to indentation. Whether you type or paste this code, make sure your indentation is correct. Later in this exercise, you'll see the complete YAML workflow definition so that you can verify that your file matches.

1. Below the lines that you just added, and above the deploy job, add a validation job:

   :::code language="yaml" source="code/5-workflow.yml" range="25-42":::

   This job defines steps to check out the code, sign in to your Azure environment, and use the `azure/arm-deploy` action with the `Validate` deployment mode.

   Your workflow definition now has three jobs. The first lints your Bicep file, the second performs a preflight validation, and the third performs the deployment to Azure.

1. Below the `runs-on` line in the `deploy` job, add a `needs` statement:

   :::code language="yaml" source="code/5-workflow.yml" range="44-50" highlight="3" :::

   The `needs` statement indicates that the deploy job depends on the lint and validate jobs completing successfully before it can run.

   Also notice that both the validate and deploy jobs sign into Azure, and all of the jobs check out the code from the repository. Those steps are necessary because each job uses a new GitHub runner.

1. Save the file.

## Configure the linter

By default, the Bicep linter provides a warning when it detects a problem with your file. GitHub Actions doesn't treat linter warnings as problems that should stop your workflow. To customize this behavior, you create a _bicepconfig.json_ file that reconfigures the linter.

1. Add a new file in the _deploy_ folder and name it _bicepconfig.json_.

   :::image type="content" source="../media/5-visual-studio-code-bicep-config-file.png" alt-text="Screenshot of Visual Studio Code Explorer, with the new file shown in the deploy folder.":::

1. Copy and paste the following code into the file:

   :::code language="json" source="code/5-bicepconfig.json" :::

1. Save the file.

## Configure the deploy job to work with the linter

When you use a custom linter configuration, Bicep writes log data that GitHub Actions interprets as an error. To disable this behavior, you configure the `arm-deploy` task to ignore the standard error (stderr) log stream.

1. Open the _workflow.yml_ file.

1. In the `deploy` job's _Deploy website_ test step, set the `failOnStdErr` property to `false`:

   :::code language="yaml" source="code/5-workflow.yml" range="44-62" highlight="15" :::

1. Save the file.

## Verify and commit your workflow definition

1. Verify that your _workflow.yml_ file looks like the following code:

   :::code language="yaml" source="code/5-workflow.yml" highlight="14, 18-42, 46, 58" :::

   If your file looks different, update it to match this example, and then save it.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Add lint and validation jobs"
   git push
   ```

1. This commit is the first time you pushed to this repository, so you might be prompted to sign in.

   On Windows, type *1* to authenticate using a web browser, and select **Enter**.

   On macOS, select **Authorize**.

1. A browser window appears. You might need to sign in to GitHub again. Select **Authorize**.

   Immediately after you push, GitHub Actions starts a new workflow run.

## View the workflow run

1. In your browser, go to **Actions**.

   The first run of your workflow, labeled _Initial commit_, is shown as a failure. GitHub automatically ran the workflow when you created the repository. It failed because the secrets weren't ready at that time. You can ignore this failure.

1. Select the most recent run of your workflow.

   :::image type="content" source="../media/5-workflow-last-run.png" alt-text="Screenshot of GitHub Actions with the link to the latest workflow run highlighted.":::

   Notice that the workflow run now shows the three jobs that you defined in the YAML file. The **lint** and **validate** jobs run in parallel before the **deploy** job starts.

1. If the workflow is still running, wait until it finishes. Although workflows automatically update the page with the latest status, it's a good idea to refresh your page occasionally.

   Notice that the **lint** and **validate** jobs failed.

   :::image type="content" source="../media/5-workflow-run-jobs-lint-validate.png" alt-text="Screenshot of a workflow run in GitHub Actions, with the Lint and Validate jobs reporting failure.":::

1. Select the **lint** job to see its details.

1. Select the **Run Bicep linter** step to view the workflow log.

   :::image type="content" source="../media/5-workflow-run-lint-job-step.png" alt-text="Screenshot of the workflow log for the Lint job, with the step for running a Bicep linter highlighted.":::

   The error in the workflow log includes a linter error message:

   ```Output
   Error no-unused-params: Parameter "storageAccountNameParam" is declared but never used.
   ```

   This error message indicates that the linter found a rule violation in your Bicep file.

## Fix the linter error

Now that you identified the problem, you can fix it in your Bicep file.

1. In Visual Studio Code, open the _main.bicep_ file in the _deploy_ folder.

1. Notice that the Bicep linter also detected that the `storageAccountNameParam` parameter isn't used. In Visual Studio Code, a squiggly line is displayed under the parameter. Normally, the line would be yellow to indicate a warning. But because you customized the _bicepconfig.json_ file, the linter treats the code as an error and displays the line in red.

   :::code language="bicep" source="code/5-template-1.bicep" range="15" :::

1. Delete the `storageAccountNameParam` parameter.

1. Save the file.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Remove unused parameter"
   git push
   ```

   Once again, GitHub Actions automatically triggers a new run of your workflow.

## View the workflow run again

1. In your browser, go to your workflow.

1. Select the most recent run.

   Wait until the workflow run finishes. Although GitHub Actions automatically updates the page with the latest status, it's a good idea to refresh your page occasionally.

1. Notice that the **lint** job finished successfully, but the **validate** job is still failing.

   :::image type="content" source="../media/5-workflow-run-jobs-validate.png" alt-text="Screenshot of the workflow run, with the Lint job reporting success and the Validate job reporting failure.":::

1. Select the **validate** job to see its details.

1. Select the **Run preflight validation** step to view the workflow log.

   :::image type="content" source="../media/5-workflow-run-validate-job-step.png" alt-text="Screenshot of the workflow log for the Validate job, with the step for running preflight validation highlighted.":::

   The error displayed in the workflow log includes the following message:

   ```Output
   mystorageresourceNameSuffix is not a valid storage account name. Storage account name must be between 3 and 24 characters in length and use numbers and lower-case letters only.
   ```

   This error indicates that the storage account name isn't valid.

## Fix the validation error

You found another problem in the Bicep file. Here, you fix the problem.

1. In Visual Studio Code, open the _main.bicep_ file in the _deploy_ folder.

1. Look at the definition of the `storageAccountName` variable:

   :::code language="bicep" source="code/5-template-2.bicep" range="16-20" highlight="5" :::

   There seems to be a typo, and the string interpolation isn't configured correctly.

1. Update the `storageAccountName` variable to use string interpolation correctly:

   :::code language="bicep" source="code/5-template-3.bicep" range="20" :::

1. Save the file.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Fix string interpolation"
   git push
   ```

## View the successful workflow run

1. In your browser, go to your workflow.

1. Select the most recent run.

   Wait until the workflow run finishes. Although GitHub Actions automatically updates the page with the latest status, it's a good idea to refresh your page occasionally.

1. Notice that all three jobs in the workflow finished successfully:

   :::image type="content" source="../media/5-workflow-run-jobs-success.png" alt-text="Screenshot of the workflow run in GitHub Actions, with all three jobs reporting success.":::

   Some warnings are listed in the **Annotations** panel. These warnings appear because of the way Bicep writes informational messages to the workflow log. You can ignore these warnings.

You now have a workflow that successfully detects errors in your Bicep code early in your deployment process, and then deploys to Azure if there are no errors.
