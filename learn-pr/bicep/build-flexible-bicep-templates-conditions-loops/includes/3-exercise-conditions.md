[!INCLUDE [Sandbox explanation](../../shared/includes/bicep-sandbox-subscription.md)]

For your toy company, you need to deploy resources to different type of environments. You want to use parameters and conditions to control what gets deployed to different environments. In this exercise, you'll create an Azure SQL database. You will add auditing settings to ensure auditing is enabled only when deploying to 'Production' environment. For auditing you need a storage account which you will deploy conditionally only when deploying to 'Production' environment.

During the process, you'll:

> [!div class="checklist"]
> * Create a template that defines an Azure SQL Server with Database and storage account for auditing which is deployed with conditions.
> * Provision your infrastructure as 'Development' environment and verify the result.
> * Redeploy infrastructure with changed parameter as 'Production' environment and observe changes.

This exercise uses [the Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep). Be sure to install this extension in Visual Studio Code.

## Create a Bicep template with SQL server and database

<!-- TODO mention that we'll eventually create multiple servers, but for now you've decided to just create a single server -->

1. Open Visual Studio Code, and create a new file called *database.bicep*. Save the empty file so that Visual Studio Code loads the Bicep tooling. You can select File > Save, or use the <kbd>Ctrl+S</kbd> keyboard shortcut (<kbd>⌘+S</kbd> on macOS). Make sure you remember where you save the file - for example, you might want to create a **scripts** folder to save it in.

1. Add the following content into the file to define a SQL server and database, and the parameters and variable that these resources need.

   ::: code language="plaintext" source="code/3-template.bicep" range="1-16, 31-48" :::

   There are a few things to note about what you've just entered:
   - The parameters include `@description` decorators.
   - The `sqlServerAdministratorLogin` and `sqlServerAdministratorLoginPassword` parameters have the `@secure` decorator, which tells Bicep that these parameter values are sensitive. Azure will avoid saving these values to logs.
   - The `sqlServerName` variable uses a function called `take()`. Storage account names have a maximum length of 24 characters, so this function trims the end off the string to make sure the name is valid.

## Add a storage account and auditing settings

1. Below the parameter declarations, add the following parameters:

   ::: code language="bicep" source="code/3-template.bicep" range="18-29" :::

1. At the bottom of the file, below the resources, add the following resource definition for the storage account:

   ::: code language="bicep" source="code/3-template.bicep" range="50-57" :::

   Notice that the definitions for the storage account includes the `if` keyword to specify a deployment condition.

1. Underneath the storage account resource you just added, add the following:

   ::: code language="bicep" source="code/3-template.bicep" range="59-67" :::

   Notice that the definition includes the same `if` condition as the storage account. Also, the `storageEndpoint` and `storageAccountAccessKey` properties use the `?` ternary operator to ensure their values are always valid. If you didn't do this, Resource Manager would evaluate the expression values before evaluating the resource deployment condition, and it will return an error since the storage account can't be found.

   After you finish, your Bicep file should look like this:

   ::: code language="bicep" source="code/3-template.bicep" :::

1. Save the changes to the file.

## Deploy the Bicep template to Azure

::: zone pivot="cli"

[!INCLUDE [Bootstrapping instructions for first Bicep exercise - CLI](../../shared/includes/bicep-exercise-deploy-cli.md)]

### Deploy the template to Azure by using the Azure CLI

Run the following code from the terminal in Visual Studio Code to deploy the Bicep template to Azure. This process can take couple of minutes to complete, and then you'll see a successful deployment.

```azurecli
az deployment group create --template-file database.bicep
```

::: zone-end

::: zone pivot="powershell"

[!INCLUDE [Bootstrapping instructions for first Bicep exercise - PowerShell](../../shared/includes/bicep-exercise-deploy-powershell.md)]

### Deploy the template to Azure by using Azure PowerShell

Deploy the template to Azure by using the following Azure PowerShell command in the terminal. This process can take couple of minutes to complete, and then you'll see a successful deployment.

```azurepowershell
New-AzResourceGroupDeployment -TemplateFile database.bicep
```

::: zone-end

<!-- TODO mention how to specify secure param values -->

You'll see `Running...` in the terminal. Since you didn't specify a value for the `environmentName` parameter, the default value of `Development` will be used.

Wait for deployment to finish.

## Verify the deployment

You'll use the Azure portal to look at the resources that you deploy, and to inspect the results of each deployment.

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true) and make sure you're in the sandbox subscription:

   1. Select your avatar in the upper-right corner of the page.
   1. Select **Switch directory**. In the list, choose the **Microsoft Learn Sandbox** directory.

1. On the left-side panel, select **Resource groups**.

1. Select **<rgn>[sandbox resource group name]</rgn>**.

1. In **Overview**, you can see that one deployment succeeded. You can see that SQL server and SQL database are deployed, but the storage account for auditing was not deployed. Note that the storage account a with name beginning with 'cloudshell' is not related to your deployment and was created by the Learn sandbox.

    :::image type="content" source="../media/3-development-deployment.png" alt-text="Screenshot of the Azure portal interface for the resource group overview, with the deployments section showing that one succeeded." border="true":::

1. Select **1 Succeeded** to see the details of the deployment.

    :::image type="content" source="../media/3-deployment-succeeded.png" alt-text="Screenshot of the Azure portal interface for the deployments, with the one deployment listed and a succeeded status." border="true":::

1. Select the deployment called **database** to see what resources were deployed, and then select **Deployment details** to expand it. In this case, there's one SQL server and one SQL database deployed. Notice that the storage account and auditing settings aren't on the list of resources.

    :::image type="content" source="../media/3-development-deployment-details.png" alt-text="Screenshot of the Azure portal interface for the specific deployment, with SQL server and database resource listed." border="true":::

1. Leave the page open in your browser. You'll check on deployments again later.

## Redeploy for the production environment

In the previous deployment the default value for the `environmentName` parameter was used. Now you will explicitly set it to `Production`. You expect that by modifying parameter value to 'Production' storage account for auditing purposes will be deployed. Also SQL Server should be configured with auditing enabled.

### Deploy the template with specified environment parameter value

::: zone pivot="cli"

Run the following code from the terminal in Visual Studio Code to deploy the Bicep template to Azure. This can take couple of minutes to complete.

```azurecli
az deployment group create --template-file database.bicep --parameters environmentName='Production'
```

::: zone-end

::: zone pivot="powershell"

Deploy the template to Azure by using the following Azure PowerShell command in the terminal. This can take couple of minutes to complete, and then you'll see a successful deployment.

```azurepowershell
New-AzResourceGroupDeployment -TemplateFile database.bicep -environmentName Production
```

::: zone-end

You'll see `Running...` in the terminal. After minute or two you should get successful deployment result.

### Check your deployment

1. Return to the Azure portal. Go to your resource group. You'll see that additional storage account for auditing purposes has been deployed.

    :::image type="content" source="../media/3-production-deployment.png" alt-text="Screenshot of the Azure portal interface for the deployments, with the additional storage account for auditing deployed." border="true":::

1. Select SQL Server **toylaunchsql** in resource group and select **Auditing** under Security group in left menu. You can verify that auditing has been enabled for this SQL server.

    :::image type="content" source="../media/3-sql-auditing.png" alt-text="Screenshot of the Azure portal interface for the SQL server, with auditing configuration enabled." border="true":::
