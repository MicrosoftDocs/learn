You updated your pipeline to build and deploy your website's application to the Azure App Service app defined in your Bicep file. But the smoke test stage is failing because the database isn't working yet. In this unit, you'll deploy a new Azure SQL logical server and database, and you'll configure your pipeline to build and deploy the database's schema. You'll also update your pipeline to add some sample product data for your test environment so that your team can try out the website.

In the process, you'll do the following tasks:

> [!div class="checklist"]
>
> - Add a blob container to the Azure storage account.
> - Add an Azure SQL logical server and database.
> - Update the build stage to build the database project into a DACPAC file.
> - Add new variables to your variable group for the Azure SQL logical server and database.
> - Update your deployment stages to use the new variables as parameter values.
> - Add new pipeline steps to deploy your DACPAC file.
> - Run the pipeline and view the website.

## Add a storage container

Your Bicep file already defines a storage account, but it doesn't define a blob container. Here, you add a blob container to your Bicep file. You also provide the name of the storage account and blob container to the application by using its configuration settings. That way, the app knows which storage account to access.

1. In Visual Studio Code, open the _main.bicep_ file in the _deploy_ folder.

1. Below the variables that define resource names (near Line 27), add a new variable definition for the blob storage container's name:

   :::code language="bicep" source="code/7-main.bicep" range="35" :::

1. Update the `storageAccount` resource to define the blob container:

   :::code language="bicep" source="code/7-main.bicep" range="151-168" highlight="7-15" :::

1. Update the app's `appSettings` property to add three new application settings for the storage account name, blob endpoint, and blob container name:

   :::code language="bicep" source="code/7-main.bicep" range="89-124, 129-132" highlight="25-36" :::

1. At the end of the file, add new outputs to expose the names of the storage account and blob container:

   :::code language="bicep" source="code/7-main.bicep" range="197-198" :::

1. Save your changes to the file.

1. Commit your changes to your Git repository, but don't push them yet. In the Visual Studio Code terminal, run the following commands:

    ```cmd
    git add .
    git commit -m "Add storage container"
    ```

## Add an Azure SQL logical server and database

Your Bicep file doesn't currently deploy an Azure SQL logical server or database. In this section, you add these resources to your Bicep file.

1. In the _main.bicep_ file, add two new parameters below the `reviewApiKey` parameter:

   :::code language="bicep" source="code/7-main.bicep" range="22-27" :::

1. Below the variables that define resource names, add new variables to define the names of your Azure SQL logical server and database:

   :::code language="bicep" source="code/7-main.bicep" range="36-37" :::

1. Below the variables you just added, define a new variable that creates a connection string for the application to access the database:

   :::code language="bicep" source="code/7-main.bicep" range="39-40" :::

   > [!NOTE]
   > For simplicity, the application uses the administrator login and password to access the database. This isn't good practice for a production solution, though. It's better to use an App Service managed identity to access the database, and grant the managed identity the minimum permissions needed by the application. We link to more information on the Summary page.

1. Near the end of the file, above the outputs, add the Azure SQL logical server and database resources:

   :::code language="bicep" source="code/7-main.bicep" range="170-193" :::

1. Update the `environmentConfigurationMap` variable to define the SKUs to use for your database for each environment:

   :::code language="bicep" source="code/7-main.bicep" range="43-81" highlight="14-19, 32-37" :::

1. Add another app setting to your App Service app for the database connection string:

   :::code language="bicep" source="code/7-main.bicep" range="89-132" highlight="37-40" :::

1. At the bottom of the file, add outputs to expose the host name of the Azure SQL logical server and the name of the database:

   :::code language="bicep" source="code/7-main.bicep" range="195-200" highlight="5-6" :::

1. Save your changes to the file.

## Add new build steps for the database project

Your website developers have prepared a Visual Studio database project that deploys and configures your website database table. Here, you update your pipeline _Build_ stage to build the database project into a DACPAC file and publish it as a pipeline artifact.

1. Open the _build.yml_ file in the _deploy/pipeline-templates_ folder.

1. To build the Visual Studio database project, copy the generated DACPAC file to a staging folder, and publish it as a pipeline artifact, add the following steps:

   :::code language="yaml" source="code/7-build.yml" highlight="30-48" :::

1. Save your changes to the file.

## Add values to the variable groups

1. In your browser, go to **Pipelines** > **Library**.

1. Select the **ToyWebsiteProduction** variable group.

   :::image type="content" source="../media/7-variable-groups.png" alt-text="Screenshot of Azure DevOps showing the list of variable groups, with the ToyWebsiteProduction variable group highlighted.":::

1. Add the following variables to the variable group:

   | Name | Value |
   |-|-|
   | SqlServerAdministratorLogin | ToyCompanyAdmin |
   | SqlServerAdministratorLoginPassword | SecurePassword!111 |

1. Select the padlock icon next to the **SqlServerAdministratorLoginPassword** variable. This feature tells Azure Pipelines to treat the variable's value securely.

   :::image type="content" source="../media/7-variable-group-secure.png" alt-text="Screenshot of the production variable group, with the secret variable button highlighted.":::

1. Save the variable group.

   :::image type="content" source="../media/7-variable-group-edit.png" alt-text="Screenshot of the production variable group, with the Save button highlighted.":::

1. Repeat the process to add the following variables to the **ToyWebsiteTest** variable group:

   | Name | Value |
   |-|-|
   | SqlServerAdministratorLogin | TestToyCompanyAdmin |
   | SqlServerAdministratorLoginPassword | SecurePassword!999 |

   Remember to select the padlock icon next to the **SqlServerAdministratorLoginPassword** variable and save the variable group.

## Add parameter values to the Validate and Preview stages

The Bicep file now has two new mandatory parameters: `sqlServerAdministratorLogin` and `sqlServerAdministratorLoginPassword`. Here, you propagate those parameter values from your variable group, for both the _Validate_ and _Preview_ stages.

1. In Visual Studio Code, open the _deploy.yml_ file in the _deploy/pipeline-templates_ folder.

1. Update the _Validate_ stage's _RunPreflightValidation_ step to add the new parameters:

   :::code language="yaml" source="code/7-deploy.yml" range="19-33" highlight="14-15" :::

1. Update the _Preview_ stage's _RunWhatIf_ step to add the new parameters:

   :::code language="yaml" source="code/7-deploy.yml" range="51-59" highlight="7-9" :::

   > [!IMPORTANT]
   > Be sure to add the backslash character (`\`) at the end of the line that sets the `reviewApiKey` parameter value, and on the subsequent line. The `\` character indicates that there are further lines that are part of the same Azure CLI command.

## Add parameter values to the Deploy stage

1. Update the _Deploy_ stage's _DeployBicepFile_ step to add the new parameters:

   :::code language="yaml" source="code/7-deploy.yml" range="77-92" highlight="14-15" :::

1. Create pipeline variables that contain the values of the Bicep outputs you recently added for the storage account and Azure SQL resources:

   :::code language="yaml" source="code/7-deploy.yml" range="94-104" highlight="4-7" :::

## Add database deployment steps

In this section, you define the steps that are required to deploy the database components of your website. First, you add a step to deploy the DACPAC file that the pipeline previously built. Then, you add sample data to the database and storage account, but only for non-production environments.

1. Below the _DeployWebsiteApp_ step in the _Deploy_ stage, add a new step to deploy the DACPAC file:

   :::code language="yaml" source="code/7-deploy.yml" range="117-129" :::

1. Below the step you just added, define a step to seed the database with sample data.

   :::code language="yaml" source="code/7-deploy.yml" range="131-143" :::

   Notice that this step has a condition applied to it so that it only runs for non-production environments.

1. Below the step you just added, and still within the scope of the condition, add a step to upload some sample toy images to the blob container by using Azure CLI:

   :::code language="yaml" source="code/7-deploy.yml" range="145-156" :::

## Verify files and commit your changes

1. Verify that your _main.bicep_ file looks like this:

   :::code language="bicep" source="code/7-main.bicep" highlight="22-27, 34-40, 56-61, 74-79, 113-128, 157-167, 170-193, 197-200" :::

   If it doesn't, update it to match the file contents.

1. Verify that your _deploy.yml_ file looks like this:

   :::code language="yaml" source="code/7-deploy.yml" highlight="32-33, 57-59, 90-91, 97-100, 117-156" :::

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

1. Wait for the pipeline to pause again before the _Preview (Production Environment)_ stage, because it needs permission to a different variable group this time.

   :::image type="content" source="../media/7-pipeline-run-deploy-permission.png" alt-text="Screenshot of Azure DevOps showing the pipeline run paused at the Deploy stage. Permission is required to continue. The View button is highlighted.":::

1. Select **View**, and then select **Permit** > **Permit**.

   The _Preview (Production Environment)_ stage finishes successfully.

1. Monitor the pipeline as it completes the final stages.

   The _Deploy (Production Environment)_ stage finishes successfully, and the _Smoke Test (Production Environment)_ stage also finishes successfully.

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
