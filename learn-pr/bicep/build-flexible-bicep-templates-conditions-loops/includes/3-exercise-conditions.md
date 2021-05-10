[!INCLUDE [Sandbox explanation](../../shared/includes/bicep-sandbox-subscription.md)]

For your toy company, you need to deploy resources to different type of environments. You want to use parameters and conditions to control what gets deployed to different environments. In this exercise, you'll create an Azure SQL server and database. You'll then add auditing settings to ensure that auditing is enabled - but only when you're deploying to a production environment. For auditing you need to have a storage account, which you will also deploy only when you're deploying to a production environment.

During the process, you'll:

> [!div class="checklist"]
> * Create a Bicep file that defines a SQL server with a database.
> * Add a storage account and audit settings, both of which are deployed with a condition.
> * Provision your infrastructure for your development environment and verify the result.
> * Redeploy your infrastructure against your production environment and look at the changes.

This exercise uses [the Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep). Be sure to install this extension in Visual Studio Code.

## Create a Bicep template with SQL server and database

1. Open Visual Studio Code, and create a new file called *main.bicep*. Save the empty file so that Visual Studio Code loads the Bicep tooling. You can select File > Save, or use the <kbd>Ctrl+S</kbd> keyboard shortcut (<kbd>⌘+S</kbd> on macOS). Make sure you remember where you save the file - for example, you might want to create a **scripts** folder to save it in.

1. Add the following content into the file to define a SQL server and database, and the parameters and variable that these resources need.

   ::: code language="bicep" source="code/3-template.bicep" range="1-16, 27-29, 32-47" :::

   Notice that all of the parameters include `@description` decorators, which helps to make them easier to work with. Also, notice that the `sqlServerAdministratorLogin` and `sqlServerAdministratorLoginPassword` parameters have the `@secure` decorator applied to them. This tells Bicep that these parameter values are sensitive. Azure will avoid saving these values to logs.

## Add a storage account

Auditing settings for SQL servers need to specify a storage account to contain the auditing data. You'll update your Bicep file to create this storage account, but only when auditing is going to be enabled.

1. Below the parameter declarations, add the following parameters:

   ::: code language="bicep" source="code/3-template.bicep" range="18-26" :::

1. Under the variable declarations, add the following two variables:

   ::: code language="bicep" source="code/3-template.bicep" range="30-31" :::

   Notice you're creating a variable called `auditingEnabled`, which you'll use as the condition for deploying the auditing resources. Creating a variable like this makes your Bicep code clearer and easier to read, since anyone who looks at the conditions on your resources will understand what's happening.

   Also, notice that the `sqlServerName` variable uses a function called `take()`. Storage account names have a maximum length of 24 characters, so this function trims the end off the string to make sure the name is valid.

1. At the bottom of the file, below the resources, add the following resource definition for the storage account:

   ::: code language="bicep" source="code/3-template.bicep" range="49-56" :::

   Notice that the definitions for the storage account includes the `if` keyword to specify a deployment condition.

## Add auditing settings

1. Underneath the storage account resource you just added, add the following:

   ::: code language="bicep" source="code/3-template.bicep" range="58-66" :::

   Notice that the definition includes the same `if` condition as the storage account. Also, the `storageEndpoint` and `storageAccountAccessKey` properties use the `?` ternary operator to ensure their values are always valid. If you didn't do this, Resource Manager would evaluate the expression values before evaluating the resource deployment condition, and it will return an error since the storage account can't be found.

   After you finish, your Bicep file should look like this:

   ::: code language="bicep" source="code/3-template.bicep" :::

1. Save the changes to the file.

## Deploy the Bicep template to Azure

::: zone pivot="cli"

[!INCLUDE [Bootstrapping instructions for first Bicep exercise - CLI](../../shared/includes/bicep-exercise-deploy-cli.md)]

### Deploy the template to Azure by using the Azure CLI

Run the following code from the terminal in Visual Studio Code to deploy the Bicep template to Azure. Notice that you're explicitly setting the `location` parameter to `westeurope`.

```azurecli
az deployment group create --template-file main.bicep --parameters location=westeurope
```

::: zone-end

::: zone pivot="powershell"

[!INCLUDE [Bootstrapping instructions for first Bicep exercise - PowerShell](../../shared/includes/bicep-exercise-deploy-powershell.md)]

### Deploy the template to Azure by using Azure PowerShell

Deploy the template to Azure by using the following Azure PowerShell command in the terminal. This process can take couple of minutes to complete, and then you'll see a successful deployment.

```azurepowershell
New-AzResourceGroupDeployment -TemplateFile main.bicep -location westeurope
```

::: zone-end

You're prompted to enter the values for `sqlServerAdministratorLogin` and `sqlServerAdministratorPassword` parameters when you execute the deployment.

> [!TIP]
> When you enter the secure parameters, the values you choose must follow some rules:
> 
> - `sqlServerAdministratorLogin` must not be an easily guessable login name like `admin` or `root`. It can contain only alphanumeric characters and must start with a letter.
> - `sqlServerAdministratorPassword` must be at least eight characters long and include lowercase letters, uppercase letters, numbers, and symbols. For more information on password complexity, see the [SQL Azure password policy](/sql/relational-databases/security/password-policy#password-complexity).
>
> If the parameter values don't meet the requirements, Azure SQL won't deploy your server.
> 
> Also, *make sure you keep a note of the login and password that you enter*. You'll use them again shortly.

You'll see `Running...` in the terminal. Since you didn't specify a value for the `environmentName` parameter, the default value of `Development` will be used.

Wait for deployment to finish.

## Verify the deployment

You'll use the Azure portal to look at the resources that you deploy, and to inspect the results of each deployment.

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true) and make sure you're in the sandbox subscription:

   1. Select your avatar in the upper-right corner of the page.
   1. Select **Switch directory**. In the list, choose the **Microsoft Learn Sandbox** directory.

1. On the left-side panel, select **Resource groups**.

1. Select **<rgn>[sandbox resource group name]</rgn>**.

1. In **Overview**, you can see that one deployment succeeded. You can see that SQL server and SQL database are deployed, but the storage account for auditing was not deployed. Note that the storage account with a name beginning with 'cloudshell' is not related to your deployment and was created by the Learn sandbox.

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
az deployment group create --template-file main.bicep --parameters environmentName=Production location=westeurope
```

::: zone-end

::: zone pivot="powershell"

Deploy the template to Azure by using the following Azure PowerShell command in the terminal. This can take couple of minutes to complete, and then you'll see a successful deployment.

```azurepowershell
New-AzResourceGroupDeployment -TemplateFile main.bicep -environmentName Production location=westeurope
```

::: zone-end

You'll see `Running...` in the terminal. After minute or two you should get successful deployment result.

### Check your deployment

1. Return to the Azure portal. Go to your resource group. You'll see that additional storage account for auditing purposes has been deployed.

    :::image type="content" source="../media/3-production-deployment.png" alt-text="Screenshot of the Azure portal interface for the deployments, with the additional storage account for auditing deployed." border="true":::

1. Select SQL Server **toylaunchsql** in resource group and select **Auditing** under Security group in left menu. You can verify that auditing has been enabled for this SQL server.

    :::image type="content" source="../media/3-sql-auditing.png" alt-text="Screenshot of the Azure portal interface for the SQL server, with auditing configuration enabled." border="true":::
