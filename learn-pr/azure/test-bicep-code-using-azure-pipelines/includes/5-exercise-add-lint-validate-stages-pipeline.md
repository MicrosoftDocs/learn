You've spoken to your team and have decided you'll further automate your deployments by using a pipeline. You want to build more confidence in what you deploy. In this exercise, you'll add validation stages to your pipeline, and run the linter and preflight validation before each deployment.

During the process, you'll: 

> [!div class="checklist"]
> * Update your existing pipeline to add two new stages to lint and validate your Bicep code.
> * Run your pipeline.
> * Fix any issues detected by your pipeline.

## Update your pipeline to prepare for stages

First, you need to update your pipeline file to define a stage. Azure Pipelines automatically creates a single stage for you, but because you'll add more stages soon, you need to update your pipeline to explicitly define stages.

1. In Visual Studio Code, open the *azure-pipelines.yml* file in the *deploy* folder.

1. Remove everything in the file from line 9 to the bottom of the file. Make sure you remove the line that says `jobs:` as well.

1. At the bottom of the file, add the following:

   :::code language="yaml" source="code/5-pipeline.yml" range="9-10, 39-55" :::

## Add lint and validation stages to your pipeline

1. Below the line that says `stages:`, add a lint stage:

   :::code language="yaml" source="code/5-pipeline.yml" range="11-19" :::

   This stage defines a single step, which runs the `az bicep build` command to lint the Bicep file.

1. Below the lines you just added, add a validation stage:

   :::code language="yaml" source="code/5-pipeline.yml" range="21-37" :::

   This stage defines a single step, which runs the `az deployment group validate` command. Notice that this includes a reference to your service connection, because the preflight validation process requires communicating with Azure.

   Your pipeline definition now has three stages: the first lints your Bicep file, the second performs a preflight validation, and the third performs the deployment to Azure.

1. Save the file.

## Configure the linter

By default, the Bicep linter provides a warning when it detects a problem with your file. Azure Pipelines doesn't treat linter warnings as issues that should stop your pipeline. To customize this behavior, you create a *bicepconfig.json* that reconfigures the linter.

1. Add a new file in the *deploy* folder and name it *bicepconfig.json*.
   
   :::image type="content" source="../media/5-visual-studio-code-bicep-config-file.png" alt-text="Screenshot of the Visual Studio Code Explorer, with the deploy folder and the bicepconfig dot J S O N file shown.":::

1. Copy the following into the file:    

   :::code language="json" source="code/5-bicepconfig.json" :::

1. Save the file.

## Verify and commit your pipeline definition

1. Verify that your *azure-pipelines.yaml* file looks like the following:

   :::code language="yaml" source="code/5-pipeline.yml" :::

   If it doesn't, update it to match this example, then save it.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Add lint and validation stages"
   git push
   ```

   Immediately after you push, Azure Pipelines starts a new pipeline run.

## View the pipeline run

1. In your browser, navigate to **Pipelines**.

1. Select the most recent run of your pipeline.

   :::image type="content" source="../media/5-pipeline-last-run.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline, with the link to the latest pipeline run highlighted.":::

   If the pipeline is still running, wait until it's finished. While Azure Pipelines automatically updates the page with the latest status, it's a good idea to refresh your page occasionally.

1. Notice that the pipeline run now shows the three stages you defined in the YAML file. Also notice that the **Lint** stage has failed.

   :::image type="content" source="../media/5-pipeline-run-stages-lint.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline run, with the Lint stage reporting failure.":::

1. Select the **Lint** stage to see its details.

   :::image type="content" source="../media/5-pipeline-run-lint-stage-select.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline run, with the name of the Lint stage highlighted.":::

1. Select the **Run Bicep linter** step to view the pipeline log.

   :::image type="content" source="../media/5-pipeline-run-lint-stage-step.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline log for the Lint stage, with the 'Run Bicep linter' step highlighted.":::

   Notice that the error displayed is similar to the following:

   > Error no-unused-params: Parameter "storageAccountNameParam" is declared but never used.

   This indicates that the linter found a rule violation in your Bicep file.

## Fix the linter error

Now that you've identified the problem, you can fix it in your Bicep file.

1. In Visual Studio Code, open the *main.bicep* file in the *deploy* folder.

1. Notice that the Bicep linter has also detected that the `storageAccountNameParam` parameter isn't used. In Visual Studio Code, it indicates this by displaying a squiggly line. Normally this would be yellow to indicate a warning, but because you customized the *bicepconfig.json* file, it treats it as an error and displays the squiggly line in red.

   :::code language="bicep" source="code/5-template-1.bicep" range="15" :::

1. Delete the `storageAccountNameParam` parameter.

1. Save the file.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Remove unused parameter"
   git push
   ```

## View the pipeline run again

1. In your browser, navigate to your pipeline.

1. Select the most recent run.

   Wait until the pipeline run is finished. While Azure Pipelines automatically updates the page with the latest status, it's a good idea to refresh your page occasionally.

1. Notice that the **Lint** stage completed successfully, but now the **Validate** stage has failed:

   :::image type="content" source="../media/5-pipeline-run-stages-validate.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline run, with the Lint stage reporting success and the Validate stage reporting failure.":::

1. Select the **Validate** stage to see its details.

1. Select the **Run preflight validation** step to view the pipeline log.

   :::image type="content" source="../media/5-pipeline-run-validate-stage-step.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline log for the Validate stage, with the 'Run preflight validation' step highlighted.":::

   Notice that the error displayed in the log includes the following message:

   > mystorageresourceNameSuffix is not a valid storage account name. Storage account name must be between 3 and 24 characters in length and use numbers and lower-case letters only.

   This indicates that the storage account name isn't valid.

## Fix the validation error

You've found another problem in the Bicep file. Here, you fix the problem.

1. In Visual Studio Code, open the *main.bicep* file in the *deploy* folder.

1. Look at the definition of the `storageAccountName` variable:

   :::code language="bicep" source="code/5-template-2.bicep" range="16-19" highlight="4" :::

   There seems to be a typo and the string interpolation hasn't been configured correctly.

1. Update the `storageAccountName` variable to use string interpolation correctly:

   :::code language="bicep" source="code/5-template-3.bicep" range="19" :::

1. Save the file.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Fix string interpolation"
   git push
   ```

## View the successful pipeline run

1. In your browser, navigate to your pipeline.

1. Select the most recent run.

   Wait until the pipeline run is finished. While Azure Pipelines automatically updates the page with the latest status, it's a good idea to refresh your page occasionally.

1. Notice that all three stages of the pipeline have completed successfully:

   :::image type="content" source="../media/5-pipeline-run-stages-success.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline run, with all three stages reporting success.":::

You now have a pipeline that successfully detects errors in your Bicep code early in your deployment process, and then deploys to Azure if there are no errors.
