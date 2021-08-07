You've created a basic pipeline, and you've configured your Azure and Azure Pipelines environments to connect together. Now you're ready to deploy your website's Bicep file to Azure from your pipeline.

In this exercise, you'll:

> [!div class="checklist"]
> * Add a Bicep file to your repository.
> * Add a pipeline step to deploy your Bicep file.
> * Run your pipeline again and verify that it successfully deployed your website.

## Add your website's Bicep file to the Git repository

You've already prepared your website's Bicep file, which can be used to deploy different configurations of the website resources depending on the environment and configuration. Here, you add your Bicep file to your repository.

1. Open the Visual Studio Code **Explorer**.

1. In the *deploy* folder, create a new file named *main.bicep*. Make sure you create the file inside the *deploy* folder and not at the root of the repository:

   :::image type="content" source="../media/6-visual-studio-code-main-bicep.png" alt-text="Screenshot of the Visual Studio Code Explorer, with the main.bicep file highlighted and located in the deploy folder." border="true":::

1. Copy the following into the *main.bicep* file:

   :::code language="bicep" source="code/6-main.bicep" :::

1. Save your changes to the file.

1. In the Visual Studio Code **Terminal**, stage the changes, commit the changes and push the changes to your repository by using the following commands:

   ```bash
   git add deploy/main.bicep
   git commit -m 'Add Bicep file'
   git push
   ```

## Replace the pipeline steps

Here, you update your pipeline definition to deploy your Bicep file to Azure by using the service connection.

1. In Visual Studio Code, open the *deploy/azure-pipelines.yml* file.

1. Remove the `script` step from the pipeline definition by deleting the bottom two lines of the file.

   > [!TIP]
   > When you work in Visual Studio Code and have installed the Azure Pipelines extension, try using the <kbd>Ctrl+Space</kbd> key combination. It shows a context menu with suggested elements to add at your current cursor position. 

1. Because Bicep is still new, it changes regularly. It's a good idea to upgrade the version of Bicep on the agent before you start to use it, to ensure you can use all of the latest features. Add a new task at the bottom of the file to run the `az bicep upgrade` command:

   :::code language="yaml" source="code/6-pipeline.yml" range="6-14" highlight="4-9" :::

   Notice that the task includes a variable named `$(ServiceConnectionName)`. This variable hasn't been defined yet. You'll add it soon.

   > [!NOTE]
   > It's a good idea to type this in yourself instead of copying and pasting. Watch out for the file's indentation. If your indentation isn't correct, your YAML file won't be valid. Visual Studio Code indicates errors by showing you squiggly lines.

1. Below the task you just added, add another Azure CLI task to deploy your Bicep file by using the `az deployment group create` command:

   :::code language="yaml" source="code/6-pipeline.yml" range="6-26" highlight="11-21" :::

   Notice that this step uses a system variable, `$(Build.BuildNumber)`, to name the deployment. This way, you can easily see which pipeline run a deployment corresponds to.

1. Save your changes to the file. Your file should look like the below:

   :::code language="yaml" source="code/6-pipeline.yml" :::

1. In the Visual Studio Code **Terminal**, stage your changes, commit them to your repository, and push them to Azure Repos:

   ```bash
   git add deploy/azure-pipelines.yml
   git commit -m 'Add Azure CLI tasks to pipeline'
   git push
   ```

## Add pipeline variables

1. In your browser, select **Pipelines**.

   :::image type="content" source="../media/6-pipelines-menu.png" alt-text="Screenshot of the Azure DevOps interface showing the menu, with Pipelines highlighted." border="true":::

1. Select your pipeline.

   :::image type="content" source="../media/6-pipelines-list.png" alt-text="Screenshot of the Azure DevOps interface showing the pipelines list, with the toy-website pipeline highlighted." border="true":::

1. Select the **Edit** button to configure your pipeline.

   :::image type="content" source="../media/6-edit-pipeline.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline, with the Edit button highlighted." border="true":::

1. Select the **Variables** button to manage your pipeline's variables.

   :::image type="content" source="../media/6-edit-pipeline-variables.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline editor, with the Variables button highlighted." border="true":::

1. Select the **New variable** button.

   :::image type="content" source="../media/6-edit-pipeline-new-variable.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline variable editor, with the 'New variable' button highlighted." border="true":::

1. In **Name**, enter *ServiceConnectionName*. In **Value**, enter *ToyWebsite*.

   Leave the checkboxes unchecked, and select **OK**.

   :::image type="content" source="../media/6-edit-pipeline-variable-serviceconnectionname.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline variable editor, with the OK button highlighted." border="true":::

1. Select the **+** button.

   :::image type="content" source="../media/6-edit-pipeline-additional-variable.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline variable list, with the + button highlighted." border="true":::

   Create these variables in the same way as the previous variable:

   | Variable name       | Value        |
   |---------------------|--------------|
   | *ResourceGroupName* | *ToyWebsite* |
   | *EnvironmentType*   | *nonprod*    |

1. Follow the process one more time to create a variable named *DeployToyManualsStorageAccount*, with a value of *true*. For this variable, select **Let users override this value when running this pipeline**.

   :::image type="content" source="../media/6-edit-pipeline-variable-deploytoymanualsstorageaccount.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline variable editor." border="true":::

1. After you've created all four variables, select **Save**.

   :::image type="content" source="../media/6-edit-pipeline-save-variables.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline variable editor, with the Save button highlighted." border="true":::

## Run your pipeline

Now you're ready to run your pipeline!

Your template includes a storage account, which your website team uses to store toy instruction manuals. Because you're still testing your environments, you don't need to deploy the storage account every time you deploy the website. So you created a Bicep parameter to control whether the storage account is deployed. Here, you run the pipeline and override the deployment so that it doesn't deploy the storage account this time.

1. Select **Run**.

   :::image type="content" source="../media/6-edit-pipeline-run.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline, with the Run button highlighted." border="true":::

1. The **Run pipeline** panel appears. You can use this panel to configure settings for this specific run of the pipeline. Select **Variables**.

   :::image type="content" source="../media/6-pipeline-run.png" alt-text="Screenshot of the Azure DevOps interface showing the 'Run pipeline' page, with the Variables menu item highlighted." border="true":::

1. Select the **DeployToyManualsStorageAccount** variable and change its value to *false*, then select **Update**.

   :::image type="content" source="../media/6-pipeline-run-edit-variable.png" alt-text="Screenshot of the Azure DevOps interface showing the 'Run pipeline' variable editor, with the Update button highlighted." border="true":::

1. Select the back arrow.

   :::image type="content" source="../media/6-pipeline-run-edit-variables-back.png" alt-text="Screenshot of the Azure DevOps interface showing the 'Run pipeline' page, with the back arrow highlighted." border="true":::

1. Select **Run** to start a new pipeline run. It might take a few minutes for the pipeline to start, and once it's started, it might take a few minutes for your deployment to complete.

1. Select **Job** to open the job. You can monitor the job as it runs, or wait until the job completes to review its history.

   Wait for the job to complete.

1. Select **Job**.

   :::image type="content" source="../media/6-pipeline-run-job.png" alt-text="Screenshot of the Azure DevOps interface showing the job page, with the Job menu item highlighted." border="true":::

1. Select **1 queue time variable used**.

   :::image type="content" source="../media/6-log-variables.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline log, with the '1 queue time variable used' item highlighted." border="true":::

   The value that you override for this pipeline's run is shown. Notice that the `DeployToyManualsStorageAccount` variable's value is *false*, since you overrode it.

1. Inspect the rest of your pipeline output.

   The pipeline shows a successful deployment.

## Verify the deployment

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. On the left-side panel, select **Resource groups**.

1. Select **ToyWebsite**.

1. In **Overview**, you can see that one deployment succeeded.

   :::image type="content" source="../media/6-portal-resource-group.png" alt-text="Screenshot of the Azure portal, showing the resource group with one successful deployment." border="true":::

1. Select **1 Succeeded** to see the details of the deployment.

   :::image type="content" source="../media/6-portal-deployment-list.png" alt-text="Screenshot of the Azure portal, showing the resource group deployment history, and the deployment highlighted." border="true":::

   Notice that the deployment name is the same as the pipeline run name.

1. Select the deployment to see what resources were deployed, and then select **Deployment details** to expand it. In this case, there's an App Service plan and an app.

   :::image type="content" source="../media/6-portal-deployment-details.png" alt-text="Screenshot of the Azure portal, showing the resource group deployment details, with the App Service resources highlighted." border="true":::
