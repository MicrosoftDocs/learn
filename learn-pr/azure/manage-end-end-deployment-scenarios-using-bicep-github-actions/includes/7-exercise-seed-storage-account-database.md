You updated your workflow to build and deploy your website's application to the Azure App Service app defined in your Bicep file. But the smoke test job is failing because the database isn't working yet. In this unit, you'll deploy a new Azure SQL logical server and database, and you'll configure your workflow to build and deploy the database's schema. You'll also update your workflow to add some sample product data for your test environment so that your team can try out the website.

In the process, you'll:

> [!div class="checklist"]
> * Add a blob container to the Azure storage account.
> * Add an Azure SQL logical server and database.
> * Update the build stage to build the database project into a DACPAC file.
> * Add new variables and secrets for the Azure SQL logical server and database.
> * Update your workflow to use the new variables and secrets.
> * Add new workflow steps to deploy your DACPAC file.
> * Run the workflow and view the website.

## Add a storage container

Your Bicep file already defines a storage account, but it doesn't define a blob container. Here, you add a blob container to your Bicep file. You also provide the name of the storage account and blob container to the application by using its configuration settings. That way, the app knows which storage account to access.

1. In Visual Studio Code, open the *main.bicep* file in the *deploy* folder.

1. Below the variables that define resource names (near line 27), add a new variable definition for the blob storage container's name:

   :::code language="bicep" source="code/7-main.bicep" range="34" :::

1. Update the `storageAccount` resource to define the blob container:

   :::code language="bicep" source="code/7-main.bicep" range="134-153" highlight="9-19" :::

1. Update the app's `appSettings` property to add two new application settings, one for the storage account name and one for the blob container name:

   :::code language="bicep" source="code/7-main.bicep" range="78-113, 118-121" highlight="25-36" :::

1. At the end of the file contents, add new outputs to expose the names of the storage account and blob container:

   :::code language="bicep" source="code/7-main.bicep" range="182-183" :::

1. Save your changes to the file.

1. Commit your changes to your Git repository, but don't push them yet. In the Visual Studio Code terminal, run the following commands:

    ```cmd
    git add .
    git commit -m "Add storage container"
    ```

## Add an Azure SQL logical server and database

Your Bicep file doesn't currently deploy an Azure SQL logical server or database. In this section, you add these resources to your Bicep file.

1. In the *main.bicep* file, add two new parameters below the `reviewApiKey` parameter near the top of the file:

   :::code language="bicep" source="code/7-main.bicep" range="22-27" :::

1. Below the variables that define resource names, add new variables to define the names of your Azure SQL logical server and database:

   :::code language="bicep" source="code/7-main.bicep" range="35-36" :::

1. Below the variables you just added, define a new variable that creates a connection string for the application to access the database:

   :::code language="bicep" source="code/7-main.bicep" range="38-39" :::

   > [!NOTE]
   > For simplicity, the application uses the administrator login and password to access the database. This isn't good practice for a production solution, though. It's better to use an App Service managed identity to access the database, and grant the managed identity the minimum permissions needed by the application. We link to more information in the summary. <!-- TODO check we do -->

1. Near the end of the file contents, above the outputs, add the Azure SQL logical server and database resources:

   :::code language="bicep" source="code/7-main.bicep" range="155-178" :::

1. Update the `environmentConfigurationMap` variable to define the SKUs to use for your database for each environment:

   :::code language="bicep" source="code/7-main.bicep" range="42-70" highlight="9-14, 22-27" :::

1. Add an additional app setting to your App Service app for the database connection string:

   :::code language="bicep" source="code/7-main.bicep" range="78-120" highlight="37-40" :::

1. At the bottom of the file, add outputs to expose the host name of the Azure SQL logical server and the name of the database:

   :::code language="bicep" source="code/7-main.bicep" range="180-185" highlight="5-6" :::

1. Save your changes to the file.

## Add new build steps for the database project

Your website developers have prepared a Visual Studio database project that deploys and configures your website database table. Here, you update your workflow *build* called workflow to build the database project into a DACPAC file and upload it as a workflow artifact.

1. Open the *build.yml* file in the *.github/workflows* folder.

1. To build the Visual Studio database project and upload the generated DACPAC file as a workflow artifact, add the following job:

   :::code language="yaml" source="code/7-build.yml" highlight="34-51" :::

1. Save your changes to the file.

## Define the secrets

<!-- TODO explain -->

1. In your browser, go to **Settings** > **Secrets**.

   :::image type="content" source="../media/7-secrets.png" alt-text="Screenshot of GitHub that shows the Secrets menu item under the Settings category.":::

1. Select the **New repository secret** button.

1. Enter *SQL_SERVER_ADMINISTRATOR_LOGIN_PASSWORD_TEST* as the secret name, and *SecurePassword!111* as the value.

   :::image type="content" source="../media/7-secrets-new-test.png" alt-text="Screenshot of GitHub showing a new secret.":::

1. Select **Add secret**.

1. Repeat the process to add another secret named *SQL_SERVER_ADMINISTRATOR_LOGIN_PASSWORD_PRODUCTION* as the secret name, and *SecurePassword!999* as the value. Select **Add secret**.

## Add the secrets and inputs to your workflow

1. In Visual Studio Code, open the *deploy.yml* file in the *.github/workflows* folder.

TODO

1. Open the *workflow.yml* file.

1. In the *deploy-test* definition, define a value for the `sqlServerAdministratorLogin` input, and propagate the value for the `sqlServerAdministratorLoginPassword` secret:

   :::code language="yaml" source="code/7-workflow.yml" range="18-29" highlight="8, 12" :::

1. Repeat the process in the *deploy-production* definition, with the production environment's values:

   :::code language="yaml" source="code/7-workflow.yml" range="31-42" highlight="8, 12" :::

<!-- TODO define in workflow.yml and deploy.yml -->

## Add parameter values to the validate and preview steps

The Bicep file now has two new mandatory parameters: `sqlServerAdministratorLogin` and `sqlServerAdministratorLoginPassword`. Here, you propagate those parameter values from your workflow inputs and secrets, for both the *validate* and *preview* steps.

1. In Visual Studio Code, open the *deploy.yml* file in the *.github/workflows* folder.

1. Update the *Validate* stage's *RunPreflightValidation* step to add the new parameters:

   :::code language="yaml" source="code/7-deploy.yml" range="23-31" highlight="7-9" :::

   > [!IMPORTANT]
   > Be sure to add the backslash character (`\`) at the end of the line that sets the `reviewApiKey` parameter value, and on the subsequent line. The `\` character indicates that there are further lines that are part of the same command.

1. Update the *Preview* stage's *RunWhatIf* step to add the new parameters:

   :::code language="yaml" source="code/7-deploy.yml" range="49-57" highlight="7-9" :::

## Add parameter values to the Deploy stage

1. Update the *Deploy* stage's *DeployBicepFile* step to add the new parameters:

   :::code language="yaml" source="code/7-deploy.yml" range="82-92" highlight="9-11" :::

1. Create pipeline variables that contain the values of the Bicep outputs you recently added for the storage account and Azure SQL resources:

   :::code language="yaml" source="code/7-deploy.yml" range="93-104" highlight="3-6, 9-12" :::

## Add database deployment steps

In this section, you define the steps that are required to deploy the database components of your website. First, you add a step to deploy the DACPAC file that the pipeline previously built. Then, you add sample data to the database and storage account, but only for non-production environments.

1. Below the *DeployWebsiteApp* step in the *Deploy* stage, add a new step to deploy the DACPAC file:

   :::code language="yaml" source="code/7-deploy.yml" range="117-129" :::

1. Below the step you just added, define a step to seed the database with sample data.

   :::code language="yaml" source="code/7-deploy.yml" range="131-143" :::

   Notice that this step has a condition applied to it. That is, it runs only for non-production environments.

1. Below the step you just added, and still within the scope of the condition, add a step to upload some sample toy images to the blob container by using the Azure CLI:

   :::code language="yaml" source="code/7-deploy.yml" range="145-156" :::

## Verify files and commit your changes

1. Verify that your *main.bicep* file looks like this:

   :::code language="bicep" source="code/7-main.bicep" highlight="22-27, 34-36, 38-39, 50-55, 63-68, 102-117, 142-152, 155-178, 182-185" :::

   If it doesn't, update it to match the file contents.

1. Verify that your *deploy.yml* file looks like this:

   :::code language="yaml" source="code/7-deploy.yml" highlight="29-31, 55-57, 90-93, 95-99, 100-104, 117-156" :::

   If it doesn't, update it to match the file contents.

1. Save your changes to the file.

1. Commit and push your changes to your Git repository. In the Visual Studio Code terminal, run the following commands:

    ```cmd
    git add .
    git commit -m "Add SQL database"
    git push
    ```

## Run the pipeline

1. In your browser, go to **Pipelines**.

1. Select the most recent run of your pipeline.

   Wait until all the stages for the test environment finish successfully. Notice that the smoke test now also succeeds.

   :::image type="content" source="../media/7-smoke-test-success.png" alt-text="Screenshot of Azure DevOps showing the pipeline run's Smoke Test stage for the test environment. The status shows that the stage has succeeded.":::

1. Wait for the pipeline to pause again before the *Preview (Production Environment)* stage, because it needs permission to a different variable group this time.

   :::image type="content" source="../media/7-pipeline-run-deploy-permission.png" alt-text="Screenshot of Azure DevOps showing the pipeline run paused at the Deploy stage. Permission is required to continue. The View button is highlighted.":::

1. Select **View**, and then select **Permit** > **Permit**.

   The *Preview (Production Environment)* stage finishes successfully.

   The pipeline then pauses again at the *Deploy (Production Environment)* stage.

1. Select **View**, and then select **Permit** > **Permit**.

   The *Deploy (Production Environment)* stage finishes successfully, and the *Smoke Test (Production Environment)* stage also finishes successfully.

   :::image type="content" source="../media/7-pipeline-run-success.png" alt-text="Screenshot of Azure DevOps showing the pipeline run with all stages showing success.":::

## View the website

1. Select the **Deploy (Test Environment)** stage to open the pipeline log.

1. Select the **Deploy website** step.

   Hold down the <kbd>Ctrl</kbd> key (<kbd>⌘</kbd> on macOS) and select the URL of the App Service app to open it in a new browser tab.

   :::image type="content" source="../media/7-url-test.png" alt-text="Screenshot of Azure DevOps showing the pipeline run log for the test environment's Deploy stage. The URL of the App Service app is highlighted.":::

1. Select **Toys**.

   :::image type="content" source="../media/7-website-test-welcome.png" alt-text="Screenshot of the toy company website homepage, with the Toys link highlighted.":::

   Notice that sample data is displayed in the test environment.

   :::image type="content" source="../media/7-website-test-toys.png" alt-text="Screenshot of the test website's toy page, with the sample toys displayed.":::

1. Repeat the preceding process for the **Deploy (Production Environment)** stage's app.

   Notice that no sample data is displayed in the production environment.

   :::image type="content" source="../media/7-website-production-toys.png" alt-text="Screenshot of the production website's toy page, with no toys displayed.":::

## Clean up resources

Now that you've completed the exercise, you'll want to remove the resources so that you aren't billed for them.

In the Visual Studio Code terminal, run the following commands:

::: zone pivot="cli"

```azurecli
az group delete --resource-group ToyWebsiteTest --yes --no-wait
az group delete --resource-group ToyWebsiteProduction --yes --no-wait
```

The resource group is deleted in the background.

::: zone-end

::: zone pivot="powershell"

```azurepowershell
Remove-AzResourceGroup -Name ToyWebsiteTest -Force
Remove-AzResourceGroup -Name ToyWebsiteProduction -Force
```

::: zone-end
