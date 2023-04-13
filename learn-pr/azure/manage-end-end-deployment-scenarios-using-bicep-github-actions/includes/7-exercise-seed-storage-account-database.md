You updated your workflow to build and deploy your website's application to the Azure App Service app defined in your Bicep file. But the smoke test job is failing because the database isn't working yet. In this unit, you'll deploy a new Azure SQL logical server and database, and you'll configure your workflow to build and deploy the database's schema. You'll also update your workflow to add some sample product data for your test environment so that your team can try out the website.

In the process, you'll:

> [!div class="checklist"]
>
> - Add a blob container to the Azure storage account.
> - Add an Azure SQL logical server and database.
> - Update the build job to build the database project into a DACPAC file.
> - Add new variables and secrets for the Azure SQL logical server and database.
> - Update your workflow to use the new variables and secrets.
> - Add new workflow steps to deploy your DACPAC file.
> - Run the workflow and view the website.

## Add a storage container

Your Bicep file already defines a storage account, but it doesn't define a blob container. Here, you add a blob container to your Bicep file. You also provide the name of the storage account and blob container to the application by using its configuration settings. That way, the app knows which storage account to access.

1. In Visual Studio Code, open the _main.bicep_ file in the _deploy_ folder.

1. Below the variables that define resource names (near line 27), add a new variable definition for the blob storage container's name:

   :::code language="bicep" source="code/7-main.bicep" range="35" :::

1. Update the `storageAccount` resource to define the blob container:

   :::code language="bicep" source="code/7-main.bicep" range="151-168" highlight="7-17" :::

1. Update the app's `appSettings` property to add two new application settings, one for the storage account name and one for the blob container name:

   :::code language="bicep" source="code/7-main.bicep" range="89-124, 129-132" highlight="25-36" :::

1. At the end of the file contents, add new outputs to expose the names of the storage account and blob container:

   :::code language="bicep" source="code/7-main.bicep" range="197-198" :::

1. Save your changes to the file.

1. Commit your changes to your Git repository, but don't push them yet. In the Visual Studio Code terminal, run the following commands:

    ```cmd
    git add .
    git commit -m "Add storage container"
    ```

## Add an Azure SQL logical server and database

Your Bicep file doesn't currently deploy an Azure SQL logical server or database. In this section, you add these resources to your Bicep file.

1. In the _main.bicep_ file, add two new parameters below the `reviewApiKey` parameter near the top of the file:

   :::code language="bicep" source="code/7-main.bicep" range="22-27" :::

1. Below the variables that define resource names, add new variables to define the names of your Azure SQL logical server and database:

   :::code language="bicep" source="code/7-main.bicep" range="36-37" :::

1. Below the variables you just added, define a new variable that creates a connection string for the application to access the database:

   :::code language="bicep" source="code/7-main.bicep" range="39-40" :::

   > [!NOTE]
   > For simplicity, the application uses the administrator login and password to access the database. This isn't good practice for a production solution, though. It's better to use an App Service managed identity to access the database, and grant the managed identity the minimum permissions needed by the application. We link to more information in the Summary page at the end of the module.

1. Near the end of the file contents, above the outputs, add the Azure SQL logical server and database resources:

   :::code language="bicep" source="code/7-main.bicep" range="170-193" :::

1. Update the `environmentConfigurationMap` variable to define the SKUs to use for your database for each environment:

   :::code language="bicep" source="code/7-main.bicep" range="43-81" highlight="14-19, 32-37" :::

1. Add another app setting to your App Service app for the database connection string:

   :::code language="bicep" source="code/7-main.bicep" range="89-132" highlight="37-40" :::

1. At the bottom of the file, add outputs to expose the host name of the Azure SQL logical server and the name of the database:

   :::code language="bicep" source="code/7-main.bicep" range="195-200" highlight="5-6" :::

1. Save your changes to the file.

## Add new build steps for the database project

Your website developers have prepared a Visual Studio database project that deploys and configures your website database table. Here, you update your workflow _build_ called workflow to build the database project into a DACPAC file and upload it as a workflow artifact.

1. Open the _build.yml_ file in the _.github/workflows_ folder.

1. To build the Visual Studio database project and upload the generated DACPAC file as a workflow artifact, add the _build-database_ job:

   :::code language="yaml" source="code/7-build.yml" highlight="34-51" :::

   The _build-database_ job uses a Windows runner. Currently, Visual Studio database projects must be built on the Windows operating system.

1. Save your changes to the file.

## Define the secrets

You need to securely store your Azure SQL logical server's administrator password for each environment. You decide to use GitHub secrets to protect the information.

1. In your browser, go to **Settings** > **Secrets** > **Actions**.

   :::image type="content" source="../media/7-secrets.png" alt-text="Screenshot of GitHub that shows the Secrets menu item under the Settings category.":::

1. Select the **New repository secret** button.

1. Enter _SQL_SERVER_ADMINISTRATOR_LOGIN_PASSWORD_TEST_ as the secret name, and _SecurePassword!111_ as the value.

   :::image type="content" source="../media/7-secrets-new-test.png" alt-text="Screenshot of GitHub showing a new secret.":::

1. Select **Add secret**.

1. Repeat the process to add another secret named _SQL_SERVER_ADMINISTRATOR_LOGIN_PASSWORD_PRODUCTION_ as the secret name, and _SecurePassword!999_ as the value. Select **Add secret**.

## Add the secrets and inputs to your workflow

1. In Visual Studio Code, open the _deploy.yml_ file in the _.github/workflows_ folder.

1. At the top of the file, define a new input named `sqlServerAdministratorLogin`, and a new secret named `sqlServerAdministratorLoginPassword`:

   :::code language="yaml" source="code/7-deploy.yml" range="1-28" highlight="15-17, 27-28" :::

1. Save your changes to the file.

1. Open the _workflow.yml_ file.

1. In the _deploy-test_ definition, define a value for the `sqlServerAdministratorLogin` input, and propagate the value for the `sqlServerAdministratorLoginPassword` secret:

   :::code language="yaml" source="code/7-workflow.yml" range="24-38" highlight="9, 15" :::

1. Repeat the process in the _deploy-production_ definition, with the production environment's values:

   :::code language="yaml" source="code/7-workflow.yml" range="40-57" highlight="12, 18" :::

1. Save your changes to the file.

## Add parameter values and outputs

The Bicep file now has two new mandatory parameters: `sqlServerAdministratorLogin` and `sqlServerAdministratorLoginPassword`. Here, you propagate those parameter values from your workflow inputs and secrets, for the _validate_ and _deploy_ jobs. You also propagate the Bicep deployments's outputs to the job's outputs.

1. Open the _deploy.yml_ file.

1. Update the _validate_ job's _Run preflight validation_ step to add the new parameters:

   :::code language="yaml" source="code/7-deploy.yml" range="30-54" highlight="23-24" :::

1. Update the _Run what-if_ step to add the new parameters:

   :::code language="yaml" source="code/7-deploy.yml" range="55-68" highlight="12-13" :::

1. Update the _deploy_ job's _Deploy Bicep file_ step to add the new parameters:

   :::code language="yaml" source="code/7-deploy.yml" range="70-76, 81-102" highlight="28-29" :::

1. In the _deploy_ job's definition, add new outputs for the Bicep file's outputs:

   :::code language="yaml" source="code/7-deploy.yml" range="70-80" highlight="8-11" :::

## Add database and data seed jobs

In this section, you define the steps that are required to deploy the database components of your website. First, you add a step to deploy the DACPAC file that the workflow previously built. Then, you add sample data to the database and storage account, but only for non-production environments.

1. Below the _deploy-website_ job, add a new job to deploy the DACPAC file:

   :::code language="yaml" source="code/7-deploy.yml" range="122-139" :::

1. Below the job you just added, and above the _smoke-test_ job, define a new job to seed the database with sample data.

   :::code language="yaml" source="code/7-deploy.yml" range="141-161" :::

   Notice that the _Add test data to database_ step has a condition applied to it. That is, it runs only for non-production environments. The condition is applied to the step, not to the whole job, so that later jobs can depend on this job regardless of the environment type.

1. Below the job you just added, and above the _smoke-test_ job, define another job to upload some sample toy images to the blob container by using Azure CLI:

   :::code language="yaml" source="code/7-deploy.yml" range="163-183" :::

   Notice that this job uses an Ubuntu runner, because the `azure/cli` action requires Linux to run. But the `build-database` job you defined earlier uses a Windows runner to build the database project. This workflow is a good example of using various operating systems to achieve your requirements.

## Update the dependencies for the smoke test job

1. Update the _smoke-test_ job's dependencies to ensure it runs after all of the deployment steps are completed:

   :::code language="yaml" source="code/7-deploy.yml" range="185-203" highlight="3-8" :::

1. Save your changes to the file.

## Verify files and commit your changes

1. Verify that your _main.bicep_ file looks like this:

   :::code language="bicep" source="code/7-main.bicep" highlight="22-27, 35-37, 39-40, 56-61, 74-79, 113-128, 157-167, 170-193, 197-200" :::

   If it doesn't, update it to match the file contents.

1. Verify that your _deploy.yml_ file looks like this:

   :::code language="yaml" source="code/7-deploy.yml" highlight="15-17, 27-28, 52-53, 66-67, 77-80, 101-102, 122-183, 187-192" :::

   If it doesn't, update it to match the file contents.

1. Save your changes to the file.

1. Commit and push your changes to your Git repository. In the Visual Studio Code terminal, run the following commands:

    ```cmd
    git add .
    git commit -m "Add SQL database"
    git push
    ```

## Run the workflow

1. In your browser, go to your workflow runs.

1. Select the most recent run.

   Wait until all the jobs for the test environment finish successfully. Notice that the smoke test now also succeeds.

   :::image type="content" source="../media/7-smoke-test-success.png" alt-text="Screenshot of GitHub Actions showing the workflow run's Smoke Test job for the test environment. The status shows that the job has succeeded.":::

1. Wait until the workflow completes successfully, including the production deployment.

## View the website

1. Select the **deploy-test / deploy-website** job to open the workflow log.

1. Select the **Deploy website** step.

   Hold down the <kbd>Ctrl</kbd> key (<kbd>⌘</kbd> on macOS) and select the URL of the App Service app to open it in a new browser tab.

   :::image type="content" source="../media/7-url-test.png" alt-text="Screenshot of GitHub Actions showing the workflow log for the test environment's deploy-website job. The URL of the App Service app is highlighted.":::

1. Select **Toys**.

   :::image type="content" source="../media/7-website-test-welcome.png" alt-text="Screenshot of the toy company website homepage, with the Toys link highlighted.":::

   Notice that sample data is displayed in the test environment.

   :::image type="content" source="../media/7-website-test-toys.png" alt-text="Screenshot of the test website's toy page, with the sample toys displayed.":::

1. Repeat the preceding process for the **deploy-production / deploy-website** job's app.

   Notice that no sample data is displayed in the production environment.

   :::image type="content" source="../media/7-website-production-toys.png" alt-text="Screenshot of the production website's toy page, with no toys displayed.":::

## Clean up resources

Now that you've completed the exercise, you'll want to remove the Azure resources so that you aren't billed for them.

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
