You've created a basic workflow, and you've configured your Azure and GitHub environments to connect together. Now you're ready to deploy your website's Bicep file to Azure from your workflow.

In this exercise, you'll:

> [!div class="checklist"]
> * Add a Bicep file to your repository.
> * Add a workflow step to download your repository source code to the runner.
> * Add a workflow step to login to Azure.
> * Add a workflow step to deploy your Bicep file.
> * Run your workflow again and verify that it successfully deployed your website.

## Add your website's Bicep file to the GitHub repository

You've already prepared your website's Bicep file, which can be used to deploy different configurations of the website resources depending on the environment and configuration. Here, you add your Bicep file to your repository.

1. Open the Visual Studio Code **Explorer**.

1. Create a _deploy_ folder.
1. In the _deploy_ folder, create a new file named _main.bicep_. Make sure you create the file inside the _deploy_ folder and not at the root of the repository:

   :::image type="content" source="../media/6-vs-code-main-bicep.png" alt-text="Screenshot of the Visual Studio Code Explorer, with the main.bicep file highlighted and located in the deploy folder." border="true":::

1. Copy the following into the _main.bicep_ file:

   :::code language="bicep" source="code/6-main.bicep" :::

1. Save the file.

1. In the Visual Studio Code **Terminal**, stage the changes, commit the changes and push the changes to your repository by using the following commands:

   ```bash
   git add .
   git commit -m 'Add Bicep file'
   git push
   ```

## Replace the workflow steps

Here, you update your workflow definition to deploy your Bicep file to Azure by using the GitHub secret.

1. In Visual Studio Code, open the _.github/workflows/workflow.yml_ file.

1. Remove the `placeholder` step from the pipeline definition by deleting the bottom two lines of the file.

1. As a first step you will add a task to checkout the code on the runner. Add a new task at the bottom of the file that checks out your code. 

   :::code language="yaml" source="code/6-workflow.yaml" range="7-11" highlight="11" :::

   > [!NOTE]
   > It's a good idea to type this in yourself instead of copying and pasting. Watch out for the file's indentation. If your indentation isn't correct, your YAML file won't be valid. Visual Studio Code indicates errors by showing you squiggly lines.

1. Below the task you just added, add a task to sign in to your Azure environment. This task will make use of the `AZURE_CREDENTIALS` secret value you created earlier:

   :::code language="yaml" source="code/6-workflow.yaml" range="7-14" highlight="12-14" :::

1. Add a third task to perform the Bicep deployment:

   :::code language="yaml" source="code/6-workflow.yaml" range="7-19" highlight="15-19" :::

   Notice that this task uses environment variables for the resource group name, and for the two parameters that the Bicep file includes. 

1. Add these variables and their values at the top of your workflow file, below the `workflow_dispatch` trigger and above the `jobs`: 

   :::code language="yaml" source="code/6-workflow.yaml" range="1-7" highlight="3-6" :::

1. Save the changes to the file. Your file should look like the below:

   :::code language="yaml" source="code/6-pipeline.yaml" :::

1. In the Visual Studio Code **Terminal**, stage your changes, commit them to your repository, and push them to Azure Repos:

   ```bash
   git add .
   git commit -m 'Add Azure CLI tasks to pipeline'
   git push
   ```

## Run your workflow

Now you're ready to run your workflow!

1. In your browser, select **Actions** > **learn-github-actions**. 

   :::image type="content" source="../media/6-select-actions.png" alt-text="Screenshot of the GitHub interface showing the workflows, with the Actions tab and the learn-github-actions workflow highlighted." border="true":::

1. Select **Run workflow** > **Run workflow**.

   :::image type="content" source="../media/6-workflow-run.png" alt-text="Screenshot of the GitHub interface showing the workflow, with the Run workflow dropdown and button highlighted." border="true":::

1. A new run of your pipeline will appear in the runs table. If it does not, refresh the screen. Select your running workflow to go to the detail screen of the run. 

   :::image type="content" source="../media/6-workflow-runs.png" alt-text="Screenshot of the GitHub interface showing the workflow runs, with the running workflow highlighted." border="true":::

   Wait for the run to complete.

1. Select the **deploy** job.

   :::image type="content" source="../media/6-workflow-run-deploy-job.png" alt-text="Screenshot of the GitHub interface showing the run page, with the deploy job highlighted." border="true":::

1. Select **Run azure/arm-deploy@v1**. This opens up the task details. Select **Run azure/arm-deploy@v1** in the task details. 

   :::image type="content" source="../media/6-log-variables.png" alt-text="Screenshot of the GitHub interface showing the workflow log, with the 'environment variables' highlighted." border="true":::

   Notice that this task makes use of the environment variables you added to the workflow file.

1.  Inspect the rest of your workflow output.

   The workflow shows a successful deployment.

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
