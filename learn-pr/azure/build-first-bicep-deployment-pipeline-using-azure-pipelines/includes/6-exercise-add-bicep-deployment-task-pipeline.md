Now that you have a basic pipeline, you want to use it to deploy your website's Bicep file to Azure.

In this exercise, you'll:

> [!div class="checklist"]
> * Add a Bicep file to your repository.
> * Add a pipeline step to deploy your Bicep file.
> * Run your pipeline again and verify that it successfully deployed your website.

## Add your website's Bicep file to the Git repository

1. In Visual Studio Code, in the _deploy_ folder, create a new file named _main.bicep_.

1. Copy the following into the _main.bicep_ file:

   :::code language="bicep" source="code/6-main.bicep" :::

1. Save the file.

1. In the Visual Studio Code **Terminal**, stage the changes, commit the changes and push the changes to your repository by using the following commands:

   ```bash
   git add .
   git commit -m 'Add Bicep file'
   git push
   ```

## Replace the pipeline steps

Here, you update your pipeline definition to deploy your Bicep file to Azure by using the service connection.

1. In Visual Studio Code, open the _deploy/azure-pipelines.yml_ file.

1. Remove the `script` step from the pipeline definition by deleting the bottom two lines of the file.

1. Because Bicep is still new, it changes regularly. It's a good idea to upgrade the version of Bicep on the agent before you start to use it, to ensure you can use all of the latest features. Add a new task at the bottom of the file to run the `az bicep upgrade` command:

   :::code language="yaml" source="code/6-pipeline.yaml" range="9-14" :::

   Notice that the task includes a variable named `$(ServiceConnectionName)`. This variable hasn't been defined yet. You'll add it soon.

   > [!NOTE]
   > It's a good idea to type this in yourself instead of copying and pasting. Watch out for the file's indentation. If your indentation isn't correct, your YAML file won't be valid. Visual Studio Code indicates errors by showing you squiggly lines.

1. Below the task you just added, add another Azure CLI task to deploy your Bicep file by using the `az deployment group create` command:

   :::code language="yaml" source="code/6-pipeline.yaml" range="16-21" :::

   > [!TIP]
   > When you work in Visual Studio Code and have installed the Azure Pipelines extension, try using the <kbd>Ctrl+Space</kbd> key combination. It shows a context menu of suggested elements to add at your current cursor position. 

1. Save the changes to the file. Your file should look like the below:

   :::code language="yaml" source="code/6-pipeline.yaml" :::

1. In the Visual Studio Code **Terminal**, stage your changes, commit them to your repository, and push them to Azure Repos:

   ```bash
   git add .
   git commit -m 'Add Azure CLI tasks to pipeline'
   git push
   ```

## Add pipeline variables

1. In your browser, select **Pipelines**. Select your pipeline.

1. Select the **Edit** button to configure your pipeline.

   :::image type="content" source="../media/6-edit-pipeline.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline, with the Edit button highlighted." border="true":::

1. Select the **Variables** button to manage your pipeline's variables.

   :::image type="content" source="../media/6-edit-pipeline-variables.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline editor, with the Variables button highlighted." border="true":::

1. Select the **New variable** button.

   :::image type="content" source="../media/6-edit-pipeline-new-variable.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline variable editor, with the 'New variable' button highlighted." border="true":::

1. In **Name**, enter _ServiceConnectionName_. In **Value**, enter _ToyWebsite_.

   Leave the checkboxes unchecked, and select **OK**.

   :::image type="content" source="../media/6-edit-pipeline-variable-serviceconnectionname.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline variable editor, with the OK button highlighted." border="true":::

1. Select the **+** button.

   :::image type="content" source="../media/6-edit-pipeline-additional-variable.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline variable list, with the + button highlighted." border="true":::

   Create these variables in the same way as the previous variable:

   | Variable name       | Value        |
   |---------------------|--------------|
   | _ResourceGroupName_ | _ToyWebsite_ |
   | _EnvironmentType_   | _nonprod_    |

1. Follow the process one more time to create a variable named _DeployToyManualsStorageAccount_, with a value of _true_. For this variable, check the box titled **Let users override this value when running this pipeline**.

   :::image type="content" source="../media/6-edit-pipeline-variable-deploytoymanualsstorageaccount.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline variable editor." border="true":::

1. After you've created all three variables, select **Save**.

   :::image type="content" source="../media/6-edit-pipeline-save-variables.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline variable editor, with the Save button highlighted." border="true":::

## Run your pipeline

Now you're ready to run your pipeline!

1. Select **Run**.

   :::image type="content" source="../media/6-edit-pipeline-run.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline, with the Run button highlighted." border="true":::

1. The **Run pipeline** panel appears. You can use this panel to configure settings for this specific run of the pipeline. Select **Variables**.

   :::image type="content" source="../media/6-pipeline-run.png" alt-text="Screenshot of the Azure DevOps interface showing the 'Run pipeline' page, with the Variables menu item highlighted." border="true":::

1. Select the **DeployToyManualsStorageAccount** variable and change its value to _false_, then select **OK**.

   :::image type="content" source="../media/6-pipeline-run-edit-variable.png" alt-text="Screenshot of the Azure DevOps interface showing the 'Run pipeline' page, with the DeployToyManualsStorageAccount variable editor, and the OK button highlighted." border="true":::

1. Select the back arrow.

   :::image type="content" source="../media/6-pipeline-run-edit-variables-back.png" alt-text="Screenshot of the Azure DevOps interface showing the 'Run pipeline' page, with the back arrow highlighted." border="true":::

1. Select **Run** to start a new pipeline run. It might take a few minutes for the pipeline to start, and once it's started, it might take a few minutes for your deployment to complete.

1. Select **Job** to open the job. You can monitor the job as it runs, or wait until the job completes to review its history.

1. Select **fx 1 queue time variable used**.

   :::image type="content" source="../media/6-log-variables.png" alt-text="Screenshot of the Azure DevOps interface showing the pipeline log, with the '1 queue time variable used' item highlighted." border="true":::

   The value that you override for this pipeline's run are shown. Notice that the `DeployToyManualsStorageAccount` variable's value is _false_, since you overrode it.

1. Inspect the rest of your pipeline output.

   The pipeline shows a successful deployment.

## Verify the deployment

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. On the left-side panel, select **Resource groups**.

1. Select **ToyWebsite**.

1. In **Overview**, you can see that one deployment succeeded.

   :::image type="content" source="../media/6-portal-resource-group.png" alt-text="Screenshot of the Azure portal, showing the resource group with one successful deployment." border="true":::

1. Select **1 Succeeded** to see the details of the deployment.

1. Select the deployment to see what resources were deployed, and then select **Deployment details** to expand it. In this case, there's an App Service plan and an app.
