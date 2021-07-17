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
   git add -A
   git commit -m 'Add Bicep file'
   git push
   ```

##  Replace the existing tasks in the pipeline by a task that will deploy your Bicep template

Here, you update your pipeline definition to deploy your Bicep file to Azure by using the service connection.

1. In Visual Studio Code, open the _deploy/azure-pipelines.yml_ file.

1. Remove the `script` step from the pipeline definition by deleting the bottom two lines of the file.

1. Because Bicep is still new, it changes regularly. It's a good idea to upgrade the version of Bicep on the agent before you start to use it, to ensure you can use all of the latest features. Add a new task at the bottom of the file to run the `az bicep upgrade` command:

   :::code language="yaml" source="code/6-pipeline.yaml" range="7-12" :::

   Notice that the task includes a variable named `$(ServiceConnectionName)`. This doesn't exist yet. You will add it soon.

   > [!NOTE]
   > It's a good idea to type this in yourself instead of copying and pasting. Watch out for the file's indentation. If your indentation isn't correct, your YAML file won't be valid. Visual Studio Code indicates errors by showing you squiggly lines.

1. Below the task you just added, add another Azure CLI task to deploy your Bicep file by using the `az deployment group create` command:

   :::code language="yaml" source="code/6-pipeline.yaml" range="14-19" :::

   > [!TIP]
   > When you work in Visual Studio Code and have installed the Azure Pipelines extension, try using the <kbd>Ctrl+Space</kbd> key combination. It shows a context menu of suggested elements to add at your current cursor position. 

1. Save the changes to the file. Your file should look like the below:

   :::code language="yaml" source="code/6-pipeline.yaml" :::

1. In the Visual Studio Code **Terminal**, stage your changes, commit them to your repository, and push them Azure Repos:

   ```bash
   git add .
   git commit -m 'Add Azure CLI task to pipeline'
   git push
   ```

## Add pipeline variables

1. In your browser, select **Pipelines**. Select your pipeline.

1. Select the **Edit** button to configure your pipeline.

1. Select the **Variables** button to manage your pipeline's variables.

1. Select the **New variable** button.

1. In **Name**, enter _ServiceConnectionName_. In **Value**, enter _ToyWebsite_.

   Leave the checkboxes unchecked, and select **OK**.

1. Follow the same process to create a variable named **ResourceGroupName**, with a value of _ToyWebsite_.

1. Follow the process one more time to create a variable named **Environment**, with a value of _Test_. For this variable, check the box titled **Let users override this value when running this pipeline**.

1. After you've created all three variables, select **Save**.

## Run your pipeline

Now you're ready to run your pipeline!

1. Select **Run**.

   The **Run pipeline** panel appears. You can use this panel to configure settings for this specific run of the pipeline.

1. Select **Variables**, and then select the **EnvironmentType** variable.

1. Change the value to _Production_.

1. Select **Update**.

1. Select the back arrow.

1. Select **Run** to start a new pipeline run.

1. Select **Job** to monitor the job as it runs. It might take a few minutes for the pipeline to start, and once it's started, it might take a few minutes for your deployment to complete.

1. Select **fx 3 queue time variables used**.

   This shows the values that are used for each variable for this pipeline run. Notice that the `ResourceGroupName` and `ServiceConnectionNam` variables are the values that you set for the pipeline variables, and the `EnvironmentType` variable's value is _Production_ since you overrode it for this pipeline run.

1. Inspect the rest of your pipeline output.

   The pipeline shows a successful deployment.

## Verify the deployment

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. On the left-side panel, select **Resource groups**.

1. Select **ToyWebsite**.

1. In **Overview**, you can see that one deployment succeeded.

1. Select **1 Succeeded** to see the details of the deployment.

1. Select the deployment to see what resources were deployed, and then select **Deployment details** to expand it. In this case, there's an App Service plan and app, and an Application Insights instance.
