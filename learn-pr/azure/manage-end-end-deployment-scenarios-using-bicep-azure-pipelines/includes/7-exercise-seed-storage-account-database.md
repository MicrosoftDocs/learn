TODO

## Add storage container

Your Bicep file already defines a storage account, but it doesn't define a blob container. Here, you add a blob container to your Bicep file. You also provide the name of the storage account and blob container to the application by using its configuration settings. That way, the app knows which storage account to access.

1. In Visual Studio Code, open the *main.bicep* file in the *deploy* folder.

1. Below the variable definitions, add a new variable definition for the blob storage container's name:

   :::code language="bicep" source="code/7-main.bicep" range="34" :::

1. Update the `storageAccount` resource to define the blob container:

   :::code language="bicep" source="code/7-main.bicep" range="134-153" highlight="9-19" :::

1. Update the app's `appSettings` property to add two new application settings - one for the storage account name, and one for the blob container's name:

   :::code language="bicep" source="code/7-main.bicep" range="78-113, 118-121" highlight="25-36" :::

1. At the bottom of the file, add new outputs to expose the names of the storage account and blob container:

   :::code language="bicep" source="code/7-main.bicep" range="182-183" :::

1. Commit your changes to your Git repository, but don't push them yet. Run the following commands in the Visual Studio Code terminal:

    ```cmd
    git add .
    git commit -m "Add storage container"
    ```

## Add SQL server and database to Bicep file

Your Bicep file doesn't currently deploy an Azure SQL logical server or database. Here, you add these resources to your Bicep file.

1. In the *main.bicep* file, add two new parameters below the `reviewApiKey` parameter near the top of the file:

   :::code language="bicep" source="code/7-main.bicep" range="22-27" :::

1. Below the variable definitions, add new variables to define the names of your Azure SQL logical server and database:

   :::code language="bicep" source="code/7-main.bicep" range="35-36" :::

1. Near the bottom of the file, above the outputs, add the Azure SQL logical server and database resources:

   :::code language="bicep" source="code/7-main.bicep" range="155-178" :::

1. Below the variables you just added, define a new variable that creates a connection string for the application to access the database:

   :::code language="bicep" source="code/7-main.bicep" range="38-39" :::

   <!-- TODO warning - bad practice -->

1. Update the `environmentConfigurationMap` variable to define the SKUs to use for your database for each environment:

   :::code language="bicep" source="code/7-main.bicep" range="42-70" highlight="9-14, 22-27" :::

1. Add an additional app setting to your App Service app for the database connection string:

   :::code language="bicep" source="code/7-main.bicep" range="78-120" highlight="37-40" :::

1. At the bottom of the file, add outputs to expose the host name of the Azure SQL logical server and the name of the database:

   :::code language="bicep" source="code/7-main.bicep" range="180-185" highlight="5-6" :::

<!-- TODO here -->

## Add build steps for database project

1. Open build.yml file

1. Add step to build and publish the Visual Studio database project

   :::code language="yaml" source="code/7-build.yml" highlight="31-50" :::

## Add values to variable group

1. Add to ToyWebsiteProduction

   | Name | Value |
   |-|-|
   | SqlServerAdministratorLogin | ToyCompanyAdmin |
   | SqlServerAdministratorLoginPassword | SecurePassword!111 |

1. Make password secure

   :::image type="content" source="../media/7-variable-group-secure.png" alt-text="TODO":::

1. Save

   :::image type="content" source="../media/7-variable-group-edit.png" alt-text="TODO":::

1. Add to ToyWebsiteTest

   | Name | Value |
   |-|-|
   | SqlServerAdministratorLogin | TestToyCompanyAdmin |
   | SqlServerAdministratorLoginPassword | SecurePassword!999 |

## Add parameter values to validate and preview stages

1. Open deploy.yml

1. Add parameter values to validate step

   :::code language="yaml" source="code/7-deploy.yml" range="23-31" highlight="7-9" :::

1. Add parameter values to what-if step

   :::code language="yaml" source="code/7-deploy.yml" range="49-57" highlight="7-9" :::

## Update deploy stage

1. Add parameter values to deploy step

   :::code language="yaml" source="code/7-deploy.yml" range="82-92" highlight="9-11" :::

1. Propagate storage and SQL output values to variables

   :::code language="yaml" source="code/7-deploy.yml" range="93-104" highlight="3-6, 9-12" :::

## Add DACPAC deployment step

1. Add step to deploy DACPAC file

   :::code language="yaml" source="code/7-deploy.yml" range="117-129" :::

## Add sample data to test environments

1. Add step to seed database, and condition

   :::code language="yaml" source="code/7-deploy.yml" range="131-143" :::

1. Add step to upload sample images by using the Azure CLI

   :::code language="yaml" source="code/7-deploy.yml" range="145-156" :::

## Verify deploy.yml

:::code language="yaml" source="code/7-deploy.yml" :::

## Commit and push

```cmd
git add .
git commit -m "Add SQL database"
git push
```

## Run pipeline and see smoke test pass

1. Open pipeline and watch

   All test stages complete successfully, including smoke test. The *Preview (Production Environment)* stage pauses - needs permission to variable group

1. Select View > Permit > Permit

   Preview stage completes successfully, then pauses again at *Deploy (Production Environment)* for environment permission

1. Select View > Permit > Permit

   Deployment stage completes successfully, and the production smoke test stage passes

1. Open website for test and see it's showing the sample data

   <!-- TODO screenshots -->

1. Open website for prod and see it doesn't show sample data

   <!-- TODO screenshots -->

## Clean up resources

Now that you've completed the exercise, you can remove the resources so you aren't billed for them.

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
