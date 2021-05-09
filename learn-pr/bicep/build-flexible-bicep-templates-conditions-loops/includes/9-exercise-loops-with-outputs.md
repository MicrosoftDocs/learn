For your toy company, you deployed Azure SQL Servers in regions where new toy is going to launch. After deployment you need to display properties, such as fully qualified domain name of each Azure SQL Server that was deployed with application developers. You will use output loops to display properties after successful deployment.

During exercise you'll:

> [!div class="checklist"]
> * Update existing Bicep template with adding output loop.
> * Deploy Bicep template and verify output.

This exercise uses [the Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep). Be sure to install this extension in Visual Studio Code.

## Update existing Bicep template with output loop

1. Open Visual Studio Code, and create a open file called *database-loop.bicep* that you created in one of previous exercises. 

1. Update file with output declaration, so you end up with file like example below.
  
   ```bicep
    param administratorLogin string = 'dbadmin'
    param administratorLoginPassword string = 'DBPa$$w0rd!'
    
    param sqlLocations array = [
        'westeurope'
        'eastus2'
        'eastasia'
    ]
    
    resource sqlServerResources 'Microsoft.Sql/servers@2020-11-01-preview' = [for sqlLocation in sqlLocations: {
        name: 'sql-${sqlLocation}-${uniqueString(resourceGroup().id)}'
        location: sqlLocation
        properties: {
            administratorLogin: administratorLogin
            administratorLoginPassword: administratorLoginPassword
        }
    }]
    
    output sqlInfo array = [for i in range(0, length(sqlLocations)): {
        name: sqlServerResources[i].name
        FQDN: sqlServerResources[i].properties.fullyQualifiedDomainName
    }]
   ```

    Notice that within Bicep definition for output in line 19 you used output loop with ```for``` keyword that iterates through parameter ```sqlLocations``` array. For each Azure SQL Server deployed you will provide output for SQL Server name and its fully qualified domain name.

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

You'll see ```Running...``` in the terminal. Wait for deployment to finish.

## Verify the deployment output

After deployment is finished, you want to verify that output that you declared in template is displayed. Check output of deployment command, it should include information with name and FQDN of all three SQL servers deployed.

  :::image type="content" source="../media/9-outloop-deployment.png" alt-text="Screenshot of the deployment outputs displaying Azure SQL Server properties." border="true":::
