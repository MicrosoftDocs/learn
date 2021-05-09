For your toy company, you need to deploy multiple Azure SQL Server resources to support new toy launch. You need to follow requirement, that each country where toy is launched, needs dedicated Azure SQL Server deployed in same country or compliant Azure region. In this exercise you will create flexible Bicep template, which will enable you to specify locations where Azure SQL Server is deployed by using parameters.

During exercise, you'll:

> [!div class="checklist"]
> * Create a Bicep template with copy loop to deploy Azure SQL Servers resources as specified by parameter value.
> * Deploy Bicep template and verify deployment of Azure SQL Server resources.
> * Modify parameter values to add additional location, redeploy template and verify new Azure SQL Server resource deployed.

This exercise uses [the Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep). Be sure to install this extension in Visual Studio Code.

## Create a Bicep template that contains resources to deploy Azure SQL Database with copy loop

1. Open Visual Studio Code, and create a new file called *database-loop.bicep*. Save the empty file so that Visual Studio Code loads the Bicep tooling. You can select File > Save, or use the <kbd>Ctrl+S</kbd> keyboard shortcut (<kbd>⌘+S</kbd> on macOS). Make sure you remember where you save the file - for example, you might want to create a **scripts** folder to save it in.
1. Add the following content into the file.
  
   ```bicep
    param administratorLogin string = 'dbadmin'
    param administratorLoginPassword string = 'DBPa$$w0rd!'
   
    param sqlLocations array = [
        'westeurope'
        'eastus2'
    ]
    
    resource sqlServerResources 'Microsoft.Sql/servers@2020-11-01-preview' = [for sqlLocation in sqlLocations: {
        name: 'sql-${sqlLocation}-${uniqueString(resourceGroup().id)}'
        location: sqlLocation
        properties: {
        administratorLogin: administratorLogin
        administratorLoginPassword: administratorLoginPassword
        }
    }]
   ```
    
    Notice that within Bicep definition for Azure SQL Server in line 9 you used copy loop with ```for``` keyword that iterates through parameter ```sqlLocations``` array.

1. Save the changes to the file.

## Deploy the Bicep template to Azure

::: zone pivot="cli"

Run the following code from the terminal in Visual Studio Code to deploy the Bicep template to Azure. This can take couple of minutes to complete, and then you'll see a successful deployment.

```azurecli
az deployment group create --template-file database-loop.bicep
```

::: zone-end

::: zone pivot="powershell"

Deploy the template to Azure by using the following Azure PowerShell command in the terminal. This can take couple of minutes to complete, and then you'll see a successful deployment.

```azurepowershell
New-AzResourceGroupDeployment -TemplateFile database-loop.bicep
```

::: zone-end

You'll see ```Running...``` in the terminal. As you didn't specify any parameter value, the default value for ```sqlLocations``` parameter will be used. Wait for deployment to finish.

## Verify the deployment

After deployment is finished, you want to verify that new Azure SQL Servers are deployed and they are located in correct Azure regions.

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true) and make sure you're in the sandbox subscription.

1. Select **<rgn>[sandbox resource group name]</rgn>**.

1. Verify that new Azure SQL Servers deployed are located in regions you specified in parameter ```sqlLocations``` default value.

    :::image type="content" source="../media/5-loop-deployment.png" alt-text="Screenshot of the Azure portal interface for the specific deployment, with SQL servers in different locations." border="true":::

1. Leave the page open in your browser. You'll check on deployments again later.

## Update and redeploy the template to Azure with additional location for Azure SQL Servers

You deployed Azure SQL Server in two initial locations. Now you have requirement to deploy additional Azure SQL Server in East Asia region. You need to update your template and redeploy it.

1. Return to Visual Studio Code and in the *database-loop.bicep* file add location for ```eastasia``` to default values of parameter ```sqlLocations```.

   ```bicep
    param sqlLocations array = [
        'westeurope'
        'eastus2'
        'eastasia'
    ]
    ```

1. Save the changes to the file.

1. Redeploy template by running following code from the terminal in Visual Studio Code and wait for deployment to finish.

::: zone pivot="cli"

```azurecli
az deployment group create --template-file database-loop.bicep
```

::: zone-end

::: zone pivot="powershell"

```azurepowershell
New-AzResourceGroupDeployment -TemplateFile database-loop.bicep
```

::: zone-end

## Verify the redeployment

With redeployment of updated Bicep template finished you want to verify that additional Azure SQL Server was created in location ```East Asia```.

1. Return to the [Azure portal](https://portal.azure.com?azure-portal=true) and select **<rgn>[sandbox resource group name]</rgn>** Resource Group. If required, click refresh in Resource Group menu to see newly deployed resources.

1. Verify new Azure SQL Server is deployed in new location.

    :::image type="content" source="../media/5-loop-redeployment.png" alt-text="Screenshot of the Azure portal interface for the specific deployment, with SQL servers in additional location." border="true":::

