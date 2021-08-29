You want to further automate your deployment and build better confidence in what you deploy by adding a validation stages to your pipeline. 

During the process, you'll: 

> [!div class="checklist"]
> * Update your existing pipeline to add two validation stages. 
> * Run your pipeline.
> * Fix the issues detected by your pipeline.

## Update your pipeline to prepare for stages

First, you need to update your pipeline file to define a stage. Azure Pipelines automatically creates a single stage for you, but because you'll add more stages soon, you need to update your pipeline to explicitly define stages.

1. In Visual Studio Code, open the *deploy/azure-pipelines.yml* file. 

1. Remove everything in the file below the `vmImage` line.

1. At the bottom of the file, add the following:

   :::code language="yaml" source="code/5-pipeline.yml" range="9, 39-55" :::

## Add lint and validation stages to your pipeline

1. Below the line that says `stages:`, add a lint stage:

   :::code language="yaml" source="code/5-pipeline.yml" range="11-19" :::

1. Below the lines you just added, add a validation stage:

   :::code language="yaml" source="code/5-pipeline.yml" range="21-37" :::

   Your pipeline definition now has three stages: one for validating your Bicep file, one to perform a preflight validation, and one to perform the deployment to Azure.

1. Save the file.

## Configure the linter

By default, the Bicep linter provides a warning when it detects a problem with your file. Azure Pipelines doesn't treat linter warnings as issues that should stop your pipeline. To customize this behavior, you create a *bicepconfig.json* that reconfigures the linter.

1. Add a new file in the *deploy* folder and name it *bicepconfig.json*.
   
   :::image type="content" source="../media/5-visual-studio-code-bicep-config-file.png" alt-text="Screenshot of the Visual Studio Code Explorer, with the deploy folder and the bicepcnfig dot J S O N file shown.":::

1. Copy the following into the file:    

   :::code language="json" source="code/5-bicepconfig.json" :::

   > [!NOTE]
   > The *bicepconfig.json* file also controls how Visual Studio Code shows errors and warnings in the editor. It displays red and yellow squiggly lines under misconfigured parts in your Bicep template. This gives you even quicker feedback when you're writing your Bicep code, further reducing the chance of an error.

1. Save the file.

1. Commit and push your changes to your Git repository by running the following commands in the Visual Studio Code terminal:

   ```bash
   git add .
   git commit -m "Add lint and validation stages"
   git push
   ```

   Immediately after you push, Azure Pipelines starts a new pipeline run.

## View the pipeline run

1. In your browser, navigate to your pipeline.

1. Select the most recent run of your pipeline.

1. Wait until the pipeline run is finished. While Azure Pipelines automatically updates the page with the latest status, it's a good idea to refresh your page occasionally.

   Notice that the pipeline run now shows the three stages you defined in the YAML file. Also notice that the **Lint** stage has failed.

1. Select the **Lint** stage to see its details.

1. Select the **Lint** step to view the pipeline log.

   Notice that the error displayed is similar to the following:

   > Error no-unused-params: Parameter "storageAccountNameParam" is declared but never used.

   This indicates that the linter found a rule violation in your Bicep file.

## Fix the linter error

1. In Visual Studio Code, open the *deploy/main.bicep* file.

1. Notice that the Bicep linter has detected that a parameter isn't used. In Visual Studio Code, it indicates this by displaying a squiggly line. Normally this would be yellow, but because you customized the *bicepconfig.json* file, it treats it as an error and displays the squiggly line in red.

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

1. Select the most recent run of your pipeline.

1. Wait until the pipeline run is finished. While Azure Pipelines automatically updates the page with the latest status, it's a good idea to refresh your page occasionally.

   Notice that the **Lint** stage completed successfully, but now the **Validate** stage has failed.

1. Select the **Validate** stage to see its details.

1. Select the **Run preflight validation** step to view the pipeline log.

   Notice that the error displayed includes the following message:

   > mystorageresourceNameSuffix is not a valid storage account name. Storage account name must be between 3 and 24 characters in length and use numbers and lower-case letters only.

   This indicates that the storage account name isn't valid.

## Fix the validation error

1. In Visual Studio Code, open the *deploy/main.bicep* file.

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

1. Select the most recent run of your pipeline.

1. Wait until the pipeline run is finished. While Azure Pipelines automatically updates the page with the latest status, it's a good idea to refresh your page occasionally.

   Notice that all three stages of the pipeline have run successfully.

You now have a pipeline that successfully detects errors in your Bicep code early in your deployment process.
