You've created a basic pipeline, and you've configured your Azure and Azure Pipelines environments to connect. Now, you're ready to deploy your website's Bicep file to Azure from your pipeline.

In this exercise, you'll:

> [!div class="checklist"]
>
> - Add a Bicep file to your repository.
> - Add a pipeline step to deploy your Bicep file.
> - Run your pipeline again and verify that it successfully deployed your website.

## Add your website's Bicep file to the Git repository

You've already prepared your website's Bicep file. You can use the Bicep file to deploy different configurations of the website resources, depending on the environment and configuration. Here, you add your Bicep file to your repository.

1. Open the Visual Studio Code Explorer.

1. In the _deploy_ folder, create a new file named _main.bicep_. Make sure you create the file inside the _deploy_ folder, and not at the root of the repository:

   :::image type="content" source="../media/6-visual-studio-code-main-bicep.png" alt-text="Screenshot of the Visual Studio Code Explorer, with the main dot bicep file highlighted and located in the deploy folder.":::

1. Copy the following code into the _main.bicep_ file:

   :::code language="bicep" source="code/6-main.bicep":::

1. Save your changes to the file.

1. In the Visual Studio Code terminal, run this code to stage the changes, commit the changes, and push the changes to your repository:

   ```bash
   git add deploy/main.bicep
   git commit -m 'Add Bicep file'
   git push
   ```

## Replace the pipeline steps

Next, update your pipeline definition to deploy your Bicep file to Azure by using the service connection.

1. In Visual Studio Code, open the _deploy/azure-pipelines.yml_ file.

1. Before the `jobs:` line, add `variables:` to define a variable named `deploymentDefaultLocation`:

   :::code language="yaml" source="code/6-pipeline.yml" range="1-10" highlight="6-8":::

1. To remove the `script` step from the pipeline definition, delete the bottom two lines of the file.

   > [!TIP]
   > When you work in Visual Studio Code and have installed the Azure Pipelines extension, try using the <kbd>Ctrl+Space</kbd> key combination. It shows a context menu with suggested elements to add at your current cursor position.

1. At the bottom of the file, add a task that uses the `AzureResourceManagerTemplateDeployment` task to deploy your Bicep file:

   :::code language="yaml" source="code/6-pipeline.yml" range="10-23" highlight="5-14":::

   > [!NOTE]
   > It's a good idea to type this code yourself instead of copying and pasting it from this module. Pay attention to the file's indentation. If your indentation isn't correct, your YAML file won't be valid. Visual Studio Code indicates errors by displaying squiggly lines.

   This step uses a system variable, `$(Build.BuildNumber)`, to name the deployment. The variable can help you easily see which pipeline run a deployment corresponds to.

   The `location` task property is required by the `AzureResourceManagerTemplateDeployment` task. It specifies the Azure region into which a resource group should be created. In this exercise, you already created a resource group and so the location you specify here doesn't matter. But you need to provide the value anyway. Here, you set it to the value of the `deploymentDefaultLocation` variable that you set in a previous step.

1. Save your changes to the file. Your file should look like this example:

   :::code language="yaml" source="code/6-pipeline.yml":::

1. In the Visual Studio Code terminal, stage your changes, commit them to your repository, and push them to Azure Repos:

   ```bash
   git add deploy/azure-pipelines.yml
   git commit -m 'Add deployment task to pipeline'
   git push
   ```

## Add pipeline variables

1. In your browser, select **Pipelines**.

   :::image type="content" source="../media/6-pipelines-menu.png" alt-text="Screenshot of Azure DevOps that shows the menu, with Pipelines highlighted.":::

1. Select your pipeline.

   :::image type="content" source="../media/6-pipelines-list.png" alt-text="Screenshot of Azure DevOps that shows the pipelines list, with the toy-website pipeline highlighted.":::

1. Select **Edit**.

   :::image type="content" source="../media/6-edit-pipeline.png" alt-text="Screenshot of Azure DevOps that shows the pipeline, with Edit highlighted.":::

1. Select **Variables**.

   :::image type="content" source="../media/6-edit-pipeline-variables.png" alt-text="Screenshot of Azure DevOps that shows the pipeline editor, with the Variables button highlighted.":::

1. Select **New variable**.

   :::image type="content" source="../media/6-edit-pipeline-new-variable.png" alt-text="Screenshot of Azure DevOps that shows the pipeline variable editor, with the 'New variable' button highlighted.":::

1. In **Name**, enter _ServiceConnectionName_. In **Value**, enter _ToyWebsite_.

   Leave the checkboxes cleared, and select **OK**.

   :::image type="content" source="../media/6-edit-pipeline-variable-serviceconnectionname.png" alt-text="Screenshot of Azure DevOps that shows the pipeline variable editor, with the OK button highlighted.":::

1. To create more variables, select **+**.

   :::image type="content" source="../media/6-edit-pipeline-additional-variable.png" alt-text="Screenshot of Azure DevOps that shows the pipeline variable list, with the plus button highlighted.":::

   Create the following variables the same way you created the _ServiceConnectionName_ variable:

   | Variable name       | Value        |
   |---------------------|--------------|
   | _ResourceGroupName_ | _ToyWebsite_ |
   | _EnvironmentType_   | _nonprod_    |

1. Complete the steps again to create a variable named _DeployToyManualsStorageAccount_, with a value of _true_. For this variable, select the **Let users override this value when running this pipeline** checkbox.

   :::image type="content" source="../media/6-edit-pipeline-variable-deploytoymanualsstorageaccount.png" alt-text="Screenshot of Azure DevOps that shows the pipeline variable editor.":::

1. When you've created all four variables, select **Save**.

   :::image type="content" source="../media/6-edit-pipeline-save-variables.png" alt-text="Screenshot of Azure DevOps that shows the pipeline variable editor, with the Save button highlighted.":::

## Run your pipeline

Now, you're ready to run your pipeline!

Your template includes a storage account, which your website team uses to store instruction manuals for toys. Because you're still testing your environment, you don't need to deploy the storage account every time you deploy the website. So, you created a Bicep parameter to control whether the storage account is deployed. Here, you run the pipeline and override the deployment so that it doesn't deploy the storage account this time.

1. Select **Run**.

   :::image type="content" source="../media/6-edit-pipeline-run.png" alt-text="Screenshot of Azure DevOps that shows the pipeline, with the Run button highlighted.":::

   The **Run pipeline** pane appears. On this pane, you can configure settings for this specific run of the pipeline.

1. Select **Variables**.

   :::image type="content" source="../media/6-pipeline-run.png" alt-text="Screenshot of Azure DevOps that shows the 'Run pipeline' page, with the Variables menu item highlighted.":::

1. Select the **DeployToyManualsStorageAccount** variable and change its value to _false_. Then select **Update**.

   :::image type="content" source="../media/6-pipeline-run-edit-variable.png" alt-text="Screenshot of Azure DevOps that shows the 'Run pipeline' variable editor, with the Update button highlighted.":::

1. Select the back arrow.

   :::image type="content" source="../media/6-pipeline-run-edit-variables-back.png" alt-text="Screenshot of Azure DevOps that shows the 'Run pipeline' page, with the back arrow highlighted.":::

1. To start a new pipeline run, select **Run**. The pipeline might take a few minutes to start. After the pipeline starts, the deployment might take a few minutes to finish.

1. To open the job, in the **Jobs** section select **Job**. You can monitor the job as it runs, or you can wait until the job completes to review its history.

   Wait for the job to finish.

1. Select **Job**.

   :::image type="content" source="../media/6-pipeline-run-job.png" alt-text="Screenshot of Azure DevOps that shows the job page, with the Job menu item highlighted.":::

1. Select **1 queue time variable used**.

   :::image type="content" source="../media/6-log-variables.png" alt-text="Screenshot of Azure DevOps that shows the pipeline log, with the '1 queue time variable used' item highlighted.":::

   The overridden value for this pipeline run is shown. The `DeployToyManualsStorageAccount` variable's value is _false_ because you overrode the original value.

1. Inspect the rest of your pipeline output.

   The pipeline shows a successful deployment.

## Verify the deployment

1. Go to the [Azure portal](https://portal.azure.com).

1. In the left menu, select **Resource groups**.

1. Select **ToyWebsite**.

1. In **Overview**, view the deployment status. You can see that one deployment succeeded.

   :::image type="content" source="../media/6-portal-resource-group.png" alt-text="Screenshot of the Azure portal that shows the resource group with one successful deployment.":::

1. Select **1 Succeeded** to see the details of the deployment.

   :::image type="content" source="../media/6-portal-deployment-list.png" alt-text="Screenshot of the Azure portal that shows the resource group deployment history, with the deployment highlighted.":::

   The deployment name is the same as the name of the pipeline run.

1. To see what resources were deployed, select the deployment. To expand the deployment to see more details, select **Deployment details**. In this case, there's an Azure App Service plan and an app.

   :::image type="content" source="../media/6-portal-deployment-details.png" alt-text="Screenshot of the Azure portal that shows the resource group deployment details, with the App Service resources highlighted.":::
