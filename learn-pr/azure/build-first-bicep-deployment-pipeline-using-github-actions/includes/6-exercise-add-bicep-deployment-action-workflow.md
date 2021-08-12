You've created a basic workflow, and you've configured your Azure and GitHub environments to connect. Now, you're ready to deploy your website's Bicep file to Azure from your workflow.

In this exercise, you'll:

> [!div class="checklist"]
> * Add a Bicep file to your repository.
> * Add a workflow step to download your repository source code to the runner's file system.
> * Add a workflow step to sign in to Azure.
> * Add a workflow step to deploy your Bicep file.
> * Run your workflow again and verify that it successfully deployed your website.

## Add your website's Bicep file to the GitHub repository

You've already prepared your website's Bicep file, which can be used to deploy different configurations of the website resources depending on the environment and configuration. Here, you add your Bicep file to your repository.

1. Open the Visual Studio Code Explorer.

1. At the root of your repository, create a *deploy* folder.

1. In the *deploy* folder, create a new file named *main.bicep*. Make sure you create the file inside the *deploy* folder:

   :::image type="content" source="../media/6-visual-studio-code-main-bicep.png" alt-text="Screenshot of the Visual Studio Code Explorer, with the main dot bicep file highlighted and located in the deploy folder.":::

1. Copy the following code into the *main.bicep* file:

   :::code language="bicep" source="code/6-main.bicep":::

1. Save your changes to the file.

1. In the Visual Studio Code terminal, run this code to stage the changes, commit the changes, and push the changes to your repository:

   ```bash
   git add deploy/main.bicep
   git commit -m 'Add Bicep file'
   git push
   ```

## Replace the workflow steps

Next, update your workflow definition to deploy your Bicep file to Azure.

1. In Visual Studio Code, open the *.github/workflows/workflow.yml* file.

1. To remove the `placeholder` step from the workflow definition, delete the bottom two lines of the file.

1. As a first step you will add a task to check out the code to the runner's file system. Add a new step at the bottom of the file:

   :::code language="yaml" source="code/6-workflow.yml" range="9-14" highlight="5" :::

   > [!NOTE]
   > It's a good idea to type this code yourself instead of copying and pasting it from this module. Pay attention to the file's indentation. If your indentation isn't correct, your YAML file won't be valid. Visual Studio Code indicates errors by displaying squiggly lines.

1. Below the step that you just added, add a task to sign in to your Azure environment. This task will make use of the `AZURE_CREDENTIALS` secret value you created earlier:

   :::code language="yaml" source="code/6-workflow.yml" range="9-17" highlight="6-8" :::

1. Below the step that you just added, add another step to perform the Bicep deployment:

   :::code language="yaml" source="code/6-workflow.yml" range="9-22" highlight="9-14" :::

   Notice that this task uses environment variables for the resource group name, and for the parameter that the Bicep file includes. It also uses the `github.run_number` default environment variable to name the deployment in Azure.

1. Add these variables and their values at the top of your workflow file, below the `on: [workflow_dispatch]` trigger and above the `jobs`: 

   :::code language="yaml" source="code/6-workflow.yml" range="5-8" :::

1. Save your changes to the file. Your file should look like this example:

   :::code language="yaml" source="code/6-workflow.yml" :::

1. In the Visual Studio Code terminal, stage your changes, commit them to your repository, and push them to Azure Repos:

   ```bash
   git add .
   git commit -m 'Add Azure CLI tasks to workflow'
   git push
   ```

## Run your workflow

Now, you're ready to run your workflow!

1. In your browser, open the workflow by selecting **Actions** > **deploy-toy-website**. 

1. Select **Run workflow** > **Run workflow**.

1. A new run of your workflow will appear in the runs list. If it doesn't appear, refresh your browser page.

1. Select the running workflow to view the details of the run.

   Wait for the run to finish.

1. Select the **deploy** job.

   :::image type="content" source="../media/6-workflow-run-deploy-job.png" alt-text="Screenshot of the GitHub interface showing the run page, with the deploy job highlighted." border="true":::

1. Select **Run azure/arm-deploy@v1**. This displays the task details.

1. Select **Run azure/arm-deploy@v1** in the task details. 

   :::image type="content" source="../media/6-log-variables.png" alt-text="Screenshot of the GitHub interface showing the workflow log, with the 'environment variables' highlighted." border="true":::

   Notice that this step uses the environment variables you added to the workflow file.

1. Inspect the rest of your workflow output.

   The workflow shows a successful deployment.

## Verify the deployment

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true).

1. In the left menu, select **Resource groups**.

1. Select **ToyWebsite**.

1. In **Overview**, view the deployment status. You can see that one deployment succeeded.

   :::image type="content" source="../media/6-portal-resource-group.png" alt-text="Screenshot of the Azure portal that shows the resource group with one successful deployment.":::

   Notice that the name of the deployment matches the workflow's run number in GitHub Actions, because you used the `github.run_number` environment variable to name your deployment.

1. Select **1 Succeeded** to see the details of the deployment.

   :::image type="content" source="../media/6-portal-deployment-list.png" alt-text="Screenshot of the Azure portal that shows the resource group deployment history, with the deployment highlighted.":::

   The deployment name is the same as the name of the workflow run.

1. To see what resources were deployed, select the deployment. To expand the deployment to see more details, select **Deployment details**. In this case, there's a storage account, an Azure App Service plan, and an app.

   :::image type="content" source="../media/6-portal-deployment-details.png" alt-text="Screenshot of the Azure portal that shows the resource group deployment details, with the App Service resources highlighted.":::
