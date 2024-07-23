[!INCLUDE [Sandbox explanation](../../includes/azure-template-exercise-sandbox-subscription.md)]

You're starting to work on your R&D team's requests, and you decide to start by building an Azure Cosmos DB database for the toy drone's test data. In this exercise, you create the Azure Cosmos DB account and two child resources, one by using the `parent` property and the other as a nested resource.

During the process, you:

> [!div class="checklist"]
> * Create a Bicep file that deploys a Cosmos DB account.
> * Add a database and container, which are child resources of the Cosmos DB account.
> * Deploy the template and verify the deployment.

[!INCLUDE [Install the Bicep extension for Visual Studio Code](../../includes/azure-template-bicep-exercise-vscode-extension.md)]

## Create a Bicep template that contains an Azure Cosmos DB account

First, you create a new Bicep template with an Azure Cosmos DB account. To do so:

1. Open Visual Studio Code.

1. Create a new file called *main.bicep*.

1. Save the empty file so that Visual Studio Code loads the Bicep tooling.

   You can either select **File** > **Save As** or press <kbd>Ctrl+S</kbd> in Windows (<kbd>⌘+S</kbd> on macOS). Be sure to remember where you saved the file. For example, you might want to create a *scripts* folder to save it in.

1. Add the following content to the file. It's a good idea to enter it manually rather than copy and paste it. That way, you can see how the tooling helps you write your Bicep files.

   ```bicep
   param cosmosDBAccountName string = 'toyrnd-${uniqueString(resourceGroup().id)}'
   param location string = resourceGroup().location
   
   resource cosmosDBAccount 'Microsoft.DocumentDB/databaseAccounts@2020-04-01' = {
     name: cosmosDBAccountName
     location: location
     properties: {
       databaseAccountOfferType: 'Standard'
       locations: [
         {
           locationName: location
         }
       ]
     }
   }
   ```

   > [!TIP]
   > Bicep is strict about where you put line breaks, so be sure to add line breaks only where shown here.

   This Bicep template deploys an Azure Cosmos DB account that is the parent resource you build upon in the next section.

1. Save the changes to the file.

## Add a database

Next, you create the database, which is a child resource of the Azure Cosmos DB account.

1. At the top of the file, between the two existing parameters, add the following parameter:

   ```bicep
   param cosmosDBDatabaseThroughput int = 400
   ```

1. Under the parameter declarations, add the following variable:

   ```bicep
   var cosmosDBDatabaseName = 'FlightTests'
   ```

1. Add the following resource definition at the bottom of the file, below the Azure Cosmos DB account resource definition.

   ```bicep
   resource cosmosDBDatabase 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2020-04-01' = {
     parent: cosmosDBAccount
     name: cosmosDBDatabaseName
     properties: {
       resource: {
         id: cosmosDBDatabaseName
       }
       options: {
         throughput: cosmosDBDatabaseThroughput
       }
     }
   }
   ```

   Notice that this code deploys the database, which is a child resource, by using the `parent` property. Also notice that the code uses the fully qualified resource type, with the API version specified  explicitly.

1. Save the changes to the file.

## Add a container

Now you add another child resource. This time, you add it as a nested resource instead of using the `parent` property.

1. Near the top of the file, below the `cosmosDBDatabaseName` variable definition, add the following variables:

   ```bicep
   var cosmosDBContainerName = 'FlightTests'
   var cosmosDBContainerPartitionKey = '/droneId'
   ```

1. Near the bottom of the file, within the database resource definition and before its closing brace (`}`), add the following nested resource definition:

   ```bicep
   resource container 'containers' = {
     name: cosmosDBContainerName
     properties: {
       resource: {
         id: cosmosDBContainerName
         partitionKey: {
           kind: 'Hash'
           paths: [
             cosmosDBContainerPartitionKey
           ]
         }
       }
       options: {}
     }
   }
   ```

   Notice that you used a short resource type, `containers`, because Bicep understands that it belongs under the parent resource type. Bicep knows that the fully qualified resource type is `Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers`. You didn't't specify an API version, so Bicep uses the version from the parent resource, `2020-04-01`.

   After you're finished, your complete Bicep template should look like this example:

   :::code language="bicep" source="code/4-complete.bicep" :::

1. Save the changes to the file.

## Deploy the template to Azure

::: zone pivot="cli"

[!INCLUDE [Bootstrapping instructions for first Bicep exercise - CLI](../../includes/azure-template-bicep-exercise-sandbox-deploy-cli.md)]

### Deploy the template to Azure

Run the following code from the terminal in Visual Studio Code to deploy the Bicep template to Azure. This operation can take a minute or two to complete, before you see a successful deployment.

```azurecli
az deployment group create --template-file main.bicep
```

::: zone-end

::: zone pivot="powershell"

[!INCLUDE [Bootstrapping instructions for first Bicep exercise - PowerShell](../../includes/azure-template-bicep-exercise-sandbox-deploy-powershell.md)]

### Deploy the template to Azure

Deploy the template to Azure by using the following Azure PowerShell command in the terminal. This operation can take a minute or two to complete, before you see a successful deployment.

```azurepowershell
New-AzResourceGroupDeployment -TemplateFile main.bicep
```

::: zone-end

## Verify the deployment

1. Go to the [Azure portal](https://portal.azure.com?azure-portal=true) and make sure you're in the sandbox subscription:

   1. Select your avatar in the upper-right corner of the page.

   1. Select **Switch directory**. In the list, choose the **Microsoft Learn Sandbox** directory.

1. On the home page, select **Resource groups**. The **Resource groups** pane appears.

1. Select **<rgn>[sandbox resource group name]</rgn>**.

1. In **Overview**, you can see that one deployment succeeded.

    :::image type="content" source="../media/4-deployment-succeeded.png" alt-text="Screenshot of the Azure portal interface for the resource group overview, with the deployments section showing that one succeeded." border="true":::

1. Select **1 Succeeded** to see the details of the deployment.

    :::image type="content" source="../media/4-deployment.png" alt-text="Screenshot of the Azure portal interface for the deployments, with the one deployment listed and a succeeded status." border="true":::

1. Select the deployment called **main** to see what resources were deployed, and then select **Deployment details** to expand it. In this case, there's a Cosmos DB account, database, and container listed.

    :::image type="content" source="../media/4-deployment-details.png" alt-text="Screenshot of the Azure portal interface for the specific deployment, with three Cosmos DB resources listed." border="true":::

1. Leave the page open in your browser, so you can check on deployments again later.