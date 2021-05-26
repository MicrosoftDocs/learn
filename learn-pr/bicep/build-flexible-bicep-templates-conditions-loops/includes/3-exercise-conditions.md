[!INCLUDE [Sandbox explanation](../../shared/includes/bicep-sandbox-subscription.md)]

You need to deploy your toy company's resources to a variety of environments. And you want to use parameters and conditions to control what gets deployed to each environment. 

In this exercise, you create an Azure SQL Server instance and a database. You then add auditing settings to ensure that auditing is enabled, but you want it enabled only when you're deploying to a production environment. For auditing purposes, you need to have a storage account, which you also deploy only when you're deploying resources to a production environment.

During the creation process, you'll:

> [!div class="checklist"]
> * Create a Bicep file that defines a SQL Server instance with a database.
> * Add a storage account and audit settings, both of which are deployed with a condition.
> * Set up an infrastructure for your development environment and verify the result.
> * Redeploy your infrastructure against your production environment and then look at the changes.

This exercise uses [the Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep). Be sure to install this extension in Visual Studio Code.

## Create a Bicep template with a SQL server instance and database

1. Open Visual Studio Code, and create a new file called *main.bicep*. Save the empty file so that Visual Studio Code loads the Bicep tooling. You can select **File** > **Save** or <kbd>Ctrl+S</kbd> (<kbd>⌘+S</kbd> on macOS). 
 
   Remember where you've saved the file. For example, you might want to create a *scripts* folder to save it to.

1. To define a SQL server instance and database, add the following content to the file, along with the parameters and variable that these resources need.

   ::: code language="bicep" source="code/3-template.bicep" range="1-16, 27-29, 32-47" :::

   Notice that all of the parameters include `@description` decorators, which helps to make them easier to work with. Also notice that the `sqlServerAdministratorLogin` and `sqlServerAdministratorLoginPassword` parameters have the `@secure` decorator applied to them. This tells Bicep that these parameter values are sensitive. Azure doesn't print sensitive values to logs.

## Add a storage account

In the auditing settings for the SQL server instances, you need to specify a storage account to contain the auditing data. You'll update your Bicep file to create this storage account, but only when auditing is going to be enabled.

1. Below the parameter declarations, add the following parameters:

   ::: code language="bicep" source="code/3-template.bicep" range="18-26" :::

1. Below the variable declarations, add the following two variables:

   ::: code language="bicep" source="code/3-template.bicep" range="30-31" :::

   Notice that you're creating a variable called `auditingEnabled`, which you'll use as the condition for deploying the auditing resources. When you create a variable like this, you make your Bicep code clearer and easier to read. Anyone who looks at the conditions on your resources will understand what's happening.

   Also notice that the `sqlServerName` variable uses a function called `take()`. Storage account names have a maximum length of 24 characters, so this function trims the end off the string to ensure that the name is valid.

1. At the bottom of the file, below the resources, add the following resource definition for the storage account:

   ::: code language="bicep" source="code/3-template.bicep" range="49-56" :::

   Notice that the definitions for the storage account include the `if` keyword, which specifies a deployment condition.

## Add auditing settings

1. Below the storage account resource you just added, add the following:

   ::: code language="bicep" source="code/3-template.bicep" range="58-66" :::

   Notice that the definition includes the same `if` condition as the storage account. Also, the `storageEndpoint` and `storageAccountAccessKey` properties use the question mark (`?`) ternary operator to ensure that their values are always valid. If you don't do this, Azure Resource Manager evaluates the expression values before it evaluates the resource deployment condition and returns an error, because the storage account can't be found.

   After you finish, your Bicep file should look like this:

   ::: code language="bicep" source="code/3-template.bicep" :::

1. Save the changes to the file.

## Deploy the Bicep template to Azure

::: zone pivot="cli"

[!INCLUDE [Bootstrapping instructions for first Bicep exercise - CLI](../../shared/includes/bicep-exercise-deploy-cli.md)]

### Deploy the template to Azure by using the Azure CLI

In the Visual Studio Code terminal, deploy the Bicep template to Azure by running the following code. Notice that you're explicitly setting the `location` parameter to `westeurope`.

```azurecli
az deployment group create --template-file main.bicep --parameters location=westeurope
```

::: zone-end

::: zone pivot="powershell"

[!INCLUDE [Bootstrapping instructions for first Bicep exercise - PowerShell](../../shared/includes/bicep-exercise-deploy-powershell.md)]

### Deploy the template to Azure by using Azure PowerShell

In the Visual Studio Code terminal, deploy the template to Azure by running the following Azure PowerShell command. This process can take a couple of minutes to complete, and then you'll have a successful deployment.

```azurepowershell
New-AzResourceGroupDeployment -TemplateFile main.bicep -location westeurope
```

::: zone-end

You're prompted to enter the values for `sqlServerAdministratorLogin` and `sqlServerAdministratorPassword` parameters when you execute the deployment.

> [!TIP]
> When you enter the secure parameters, the values you choose must follow certain rules:
> 
> - `sqlServerAdministratorLogin` must not be an easily guessable login name such as `admin` or `root`. It can contain only alphanumeric characters and must start with a letter.
> - `sqlServerAdministratorPassword` must be at least eight characters long and include lowercase letters, uppercase letters, numbers, and symbols. For more information about password complexity, see the [SQL Azure password policy](/sql/relational-databases/security/password-policy#password-complexity).
>
> If the parameter values don't meet the requirements, Azure SQL won't deploy your server instance.
> 
> Also, *be sure to note the login and password that you enter*. You'll use them again shortly.

You'll see `Running...` in the terminal. Because you haven't specified a value for the `environmentName` parameter, the default value of `Development` is used.

Wait for deployment to finish.

## Verify the deployment

Use the Azure portal to inspect the resources that you deploy and to inspect the results of each deployment.

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true), and make sure you're in the sandbox subscription by doing the following:

   a. Select your avatar at the upper right.  
   b. Select **Switch directory**. In the list, select the **Microsoft Learn Sandbox** directory.

1. On the left pane, select **Resource groups**.

1. Select **<rgn>[sandbox resource group name]</rgn>**.

1. In the **Overview** section, you can see that one deployment has succeeded. You can also see that a SQL server instance and a SQL database are deployed, but the storage account for auditing isn't deployed. 
 
   > [!NOTE]
   > The storage account with a name beginning with `cloudshell` is unrelated to your deployment and was created by the Learn sandbox.

    :::image type="content" source="../media/3-development-deployment.png" alt-text="Screenshot of the Azure portal resource group overview pane, with a section displaying a successful deployment." border="true":::

1. Next to **Deployments**, select **1 Succeeded** to see the details of the deployment.

    :::image type="content" source="../media/3-deployment-succeeded.png" alt-text="Screenshot of the Azure portal resource group overview pane, displaying additional details of the successful deployment." border="true":::

1. Select the deployment called **main** to see what resources were deployed, and then select **Deployment details** to expand it. 
 
   In this case, one SQL server instance and one SQL database are deployed. Notice that the storage account and auditing settings aren't on the list of resources.

    :::image type="content" source="../media/3-development-deployment-details.png" alt-text="Screenshot of the Azure portal resource group overview pane for the specific deployment, with a SQL server and database resource listed." border="true":::

1. Leave the page open in your browser. You'll check on deployments again later.

## Redeploy for the production environment

In the previous deployment, the default value for the `environmentName` parameter was used, which meant that it was set to `Development`. 

Now you'll explicitly set the parameter value to `Production`. You expect that, by making this change, the storage account for auditing purposes will be deployed, and auditing will be enabled on the SQL server instance.

### Deploy the template for the production environment

::: zone pivot="cli"

In the Visual Studio Code terminal, deploy the Bicep template to Azure by running the following code:

```azurecli
az deployment group create --template-file main.bicep --parameters environmentName=Production location=westeurope
```

::: zone-end

::: zone pivot="powershell"

In the Visual Studio Code terminal, deploy the template to Azure by running the following Azure PowerShell command:

```azurepowershell
New-AzResourceGroupDeployment -TemplateFile main.bicep -environmentName Production location=westeurope
```

::: zone-end

> [!CAUTION]
> Be sure to use the same login and password that you used previously, or else the deployment won't finish successfully.

You see `Running...` in the terminal. After minute or two, the deployment should finish successfully.

### Verify the redeployment

To complete this exercise, verify that the redeployment has finished successfully and that auditing has been enabled.

1. Return to the Azure portal, and go to your resource group. If you already have the resource group open, select **Refresh**. 
   
   You see that an additional storage account has been deployed for auditing purposes.

    :::image type="content" source="../media/3-production-deployment.png" alt-text="Screenshot of the Azure portal resource group overview pane, showing that a storage account is deployed for auditing." border="true":::

1. Select your SQL server instance (look for the resource with type **Microsoft.Sql/servers**) and then, under **Security**, select **Auditing**. Verify that auditing has been enabled for this SQL server instance.

    :::image type="content" source="../media/3-sql-auditing.png" alt-text="Screenshot of the Azure portal interface for the SQL server instance, showing that the auditing configuration is enabled." border="true":::
