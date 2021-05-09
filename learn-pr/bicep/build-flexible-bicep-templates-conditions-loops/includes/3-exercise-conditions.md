<!-- 1. Topic sentence(s) --------------------------------------------------------------------------------

    Goal: remind the learner of the core idea(s) from the preceding learning-content unit (without mentioning the details of the exercise or the scenario)

    Heading: do not add an H1 or H2 title here, an auto-generated H1 will appear above this content

    Example: "A storage account represents a collection of settings that implement a business policy."

    [Exercise introduction guidance](https://review.docs.microsoft.com/learn-docs/docs/id-guidance-introductions?branch=master#rule-use-the-standard-exercise-unit-introduction-format)
-->
[!INCLUDE [Sandbox explanation](../../shared/includes/bicep-sandbox-subscription.md)]

For your toy company, you need to deploy resources to different type of environments. You want to use parameters and conditions to control what gets deployed to different environments. In this exercise, you'll create an Azure SQL database. You will add auditing settings to ensure auditing is enabled only when deploying to 'Production' environment. For auditing you need a storage account which you will deploy conditionally only when deploying to 'Production' environment.

During the process, you'll:

> [!div class="checklist"]
> * Create a template that defines an Azure SQL Server with Database and storage account for auditing which is deployed with conditions.
> * Provision your infrastructure as 'Development' environment and verify the result.
> * Redeploy infrastructure with changed parameter as 'Production' environment and observe changes.

This exercise uses [the Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep). Be sure to install this extension in Visual Studio Code.

## Create a Bicep template that contains resources to deploy Azure SQL Database

1. Open Visual Studio Code, and create a new file called *database.bicep*. Save the empty file so that Visual Studio Code loads the Bicep tooling. You can select File > Save, or use the <kbd>Ctrl+S</kbd> keyboard shortcut (<kbd>⌘+S</kbd> on macOS). Make sure you remember where you save the file - for example, you might want to create a **scripts** folder to save it in.

1. Add the following content into the file.

   ```bicep
    @allowed([
      'Development'
      'Production'
    ])
    param environment string = 'Development'
    param administratorLogin string = 'dbadmin'
    param administratorLoginPassword string = 'DBPa$$w0rd!'
    
    var location = resourceGroup().location
    
    resource server 'Microsoft.Sql/servers@2020-11-01-preview' = {
      name: 'toylaunchsql${uniqueString(resourceGroup().id)}'
      location: location
      properties: {
        administratorLogin: administratorLogin
        administratorLoginPassword: administratorLoginPassword
      }
      identity: {
        type: 'SystemAssigned'
      }
    }
    
    resource sqlDB 'Microsoft.Sql/servers/databases@2020-11-01-preview' = {
      name: '${server.name}/toylaunchdb'
      location: location
      sku: {
        name: 'Standard'
        tier: 'Standard'
      }
    }
    
    resource auditStorage 'Microsoft.Storage/storageAccounts@2021-02-01' = if (environment == 'Production') {
      name: 'toyaudit${uniqueString(resourceGroup().id)}'
      location: location
      sku: {
        name: 'Standard_LRS'
      }
      kind: 'StorageV2'  
    }
    
    resource sqlDBAudit 'Microsoft.Sql/servers/auditingSettings@2020-11-01-preview' = if (environment == 'Production') {
      name: '${server.name}/default'
      properties: {
        state: 'Enabled'
        storageEndpoint: ((environment == 'Production') ? (reference(auditStorage.id, auditStorage.apiVersion).primaryEndpoints.blob):'')
        storageAccountAccessKey: ((environment == 'Production') ? (listKeys(auditStorage.id, auditStorage.apiVersion).keys[0].value):'')
      }
    }
   ```

    Notice that within Bicep definition for storage account in line 32 you used condition to deploy resource only when environment parameter equals 'Production'. This is achieved by using ```if``` keyword followed by condition. Condition is also used to deploy Azure SQL Server auditing settings in line 71.

1. Save the changes to the file.

## Deploy the Bicep template to Azure

::: zone pivot="cli"

[!INCLUDE [Bootstrapping instructions for first Bicep exercise - CLI](../../shared/includes/bicep-exercise-deploy-cli.md)]

### Deploy the template to Azure

Run the following code from the terminal in Visual Studio Code to deploy the Bicep template to Azure. This can take couple of minutes to complete, and then you'll see a successful deployment.

```azurecli
az deployment group create --template-file database.bicep
```

::: zone-end

::: zone pivot="powershell"

[!INCLUDE [Bootstrapping instructions for first Bicep exercise - PowerShell](../../shared/includes/bicep-exercise-deploy-powershell.md)]

### Deploy the template to Azure

Deploy the template to Azure by using the following Azure PowerShell command in the terminal. This can take couple of minutes to complete, and then you'll see a successful deployment.

```azurepowershell
New-AzResourceGroupDeployment -TemplateFile database.bicep
```

::: zone-end

You'll see ```Running...``` in the terminal. As you didn't specify any parameter value, the default value 'Development' will be used for environment parameter value. Wait for deployment to finish.

## Verify the deployment

The first time you deploy a Bicep template, you might want to use the Azure portal to verify that the deployment has finished successfully and to inspect the results.

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true) and make sure you're in the sandbox subscription:

   1. Select your avatar in the upper-right corner of the page.
   1. Select **Switch directory**. In the list, choose the **Microsoft Learn Sandbox** directory.

1. On the left-side panel, select **Resource groups**.

1. Select **<rgn>[sandbox resource group name]</rgn>**.

1. In **Overview**, you can see that one deployment succeeded. You can see that SQL Server and SQL Database are deployed, however storage account for auditing is not deployed, as default value for environment 'Development' was used. Note that storage account with name beginning with 'cloudshell' is not related to your deployment and was existing before deployment start already.

    :::image type="content" source="../media/3-development-deployment.png" alt-text="Screenshot of the Azure portal interface for the resource group overview, with the deployments section showing that one succeeded." border="true":::

1. Select **1 Succeeded** to see the details of the deployment.

    :::image type="content" source="../media/3-deployment-succeeded.png" alt-text="Screenshot of the Azure portal interface for the deployments, with the one deployment listed and a succeeded status." border="true":::

1. Select the deployment called **database** to see what resources were deployed, and then select **Deployment details** to expand it. In this case, there's one SQL Server and one SQL Database deployed.

    :::image type="content" source="../media/3-development-deployment-details.png" alt-text="Screenshot of the Azure portal interface for the specific deployment, with SQL server and database resource listed." border="true":::

1. Leave the page open in your browser. You'll check on deployments again later.

::: zone pivot="cli"

You can also verify the deployment from the command line. To do so, run the following Azure CLI command:

```azurecli
az deployment group list --output table
```

::: zone-end

::: zone pivot="powershell"

You can also verify the deployment from the command line. To do so, run the following Azure PowerShell command:

```azurepowershell
Get-AzResourceGroupDeployment -ResourceGroupName <rgn>[sandbox resource group name]</rgn> | Format-Table
```

::: zone-end

## Deploy the template to Azure with 'Production' environment type

In previous deployment you didn't specify any parameter value, therefore default values were used. Next you want to change parameter environment with value ```Production```. You expect that by modifying parameter value to 'Production' storage account for auditing purposes will be deployed. Also SQL Server should be configured with auditing enabled.

### Deploy the template with specified environment parameter value

::: zone pivot="cli"

Run the following code from the terminal in Visual Studio Code to deploy the Bicep template to Azure. This can take couple of minutes to complete.

```azurecli
az deployment group create --template-file database.bicep --parameters environment='Production'
```

::: zone-end

::: zone pivot="powershell"

Deploy the template to Azure by using the following Azure PowerShell command in the terminal. This can take couple of minutes to complete, and then you'll see a successful deployment.

```azurepowershell
New-AzResourceGroupDeployment -TemplateFile database.bicep -environment Production
```

::: zone-end

You'll see ```Running...``` in the terminal. After minute or two you should get successful deployment result.

> [!NOTE]
   > You may run into error that storage account with specified name already exists. This can occur as storage account names must be globally unique. To avoid this error modify name of storage account in line 33 of Bicep template to something unique and run deployment again.

### Check your deployment

1. Return to the Azure portal. Go to your resource group. You'll see that additional storage account for auditing purposes has been deployed.

    :::image type="content" source="../media/3-production-deployment.png" alt-text="Screenshot of the Azure portal interface for the deployments, with the additional storage account for auditing deployed." border="true":::

1. Select SQL Server **toylaunchsql** in resource group and select **Auditing** under Security group in left menu. You can verify that auditing has been enabled for this SQL server.

    :::image type="content" source="../media/3-sql-auditing.png" alt-text="Screenshot of the Azure portal interface for the SQL server, with auditing configuration enabled." border="true":::