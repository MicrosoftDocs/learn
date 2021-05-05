[!INCLUDE [Sandbox explanation](../../shared/includes/bicep-sandbox-subscription.md)]

You're starting to work on your R&D team's requests, and you decide to start by building the Cosmos DB database for the toy drone's test data. In this exercise, you'll create a Cosmos DB account, and you'll create two child resources - one by using the `parent` property, and one as a nested resource.

This exercise uses [the Bicep extension for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-bicep). Be sure to install this extension in Visual Studio Code.

## Create a Bicep template that contains a Cosmos DB account

First, you will create a new Bicep template with a Cosmos DB account.

1. Open Visual Studio Code, and create a new file called *main.bicep*. Save the empty file so that Visual Studio Code loads the Bicep tooling. You can select File > Save, or use the <kbd>Ctrl+S</kbd> keyboard shortcut (<kbd>⌘+S</kbd> on macOS). Make sure you remember where you save the file - for example, you might want to create a **scripts** folder to save it in.

1. Add the following content to the file. It's a good idea to type this in yourself instead of copying and pasting, so that you can see how the tooling helps you to write your Bicep files.

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
   > Bicep is strict about where you put line breaks, so make sure you don't put line breaks in different places than what's listed here.

   This Bicep template deploys a Cosmos DB account. This will be the parent resource that we'll build upon shortly.

1. Save the changes to the file.

## Add a database

Next, you will create the database, which is a child resource of the Cosmos DB account.

1. At the top of the file, between the two existing parameters, add the following parameter:

   ```bicep
   param cosmosDBDatabaseThroughput int = 400
   ```

1. Under the parameter declarations, add the following variable:

   ```bicep
   var cosmosDBDatabaseName = 'FlightTests'
   ```

1. Add the following resource definition at the bottom of the file, below the Cosmos DB account resource definition.

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

   Notice that this deploys the database, which is a child resource, by using the `parent` property. Also notice that you have used the fully qualified resource type, and you've specified the API version explicitly.

1. Save the changes to the file.

## Add a container

Now you will add another child resource. This time, you'll add it as a nested resource instead of using the `parent` property.

1. Near the top of the file, underneath the `cosmosDBDatabaseName` variable definition, add the following variables:

   ```bicep
   var cosmosDBContainerName = 'FlightTests'
   var cosmosDBContainerPartitionKey = '/droneId'
   ```

1. Near the bottom of the file, within the database resource definition and before its closing `}` brace, add the following nested resource definition: 

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

   Notice that you have used a short resource type - `containers` - since Bicep understands that this belongs under the parent resource type. Bicep knows that the fully qualified resource type is `Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers`. Also note that you haven't specified an API version, so Bicep will use the version from the parent resource - `2020-04-01`.

   After you're finished, your complete Bicep template should look like this:

   :::code language="bicep" source="code/4-complete.bicep" :::

1. Save the changes to the file.

## Deploy the template to Azure

::: zone pivot="cli"

[!INCLUDE [Bootstrapping instructions for first Bicep exercise - CLI](../../shared/includes/bicep-exercise-deploy-cli.md)]

### Deploy the template to Azure

Run the following code from the terminal in Visual Studio Code to deploy the Bicep template to Azure. This can take a minute or two to complete, and then you'll see a successful deployment.

```azurecli
az deployment group create --template-file main.bicep
```

You'll see `Running...` in the terminal.

::: zone-end

::: zone pivot="powershell"

[!INCLUDE [Bootstrapping instructions for first Bicep exercise - PowerShell](../../shared/includes/bicep-exercise-deploy-powershell.md)]

### Deploy the template to Azure

Deploy the template to Azure by using the following Azure PowerShell command in the terminal. This can take a minute or two to complete, and then you'll see a successful deployment. 

```azurepowershell
New-AzResourceGroupDeployment -TemplateFile main.bicep
```

::: zone-end
