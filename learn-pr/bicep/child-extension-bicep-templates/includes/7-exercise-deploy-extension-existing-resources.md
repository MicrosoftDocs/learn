Now that you have finished creating the database for your R&D team to use, you need to ensure that access to the database is logged. You have an existing Log Analytics workspace that you want these logs to be sent to. You also need to send the logs from the R&D team's storage account to the same Log Analytics workspace. 

## Create a Log Analytics workspace

::: zone pivot="cli"

You will create a Log Analytics workspace to simulate having one already created in your organization. You will create this using the Azure CLI instead of Bicep.

Run the following Azure CLI command in the terminal.

```azurecli
az monitor log-analytics workspace create \
  --workspace-name ToyLogs \
  --location eastus
```

::: zone-end

::: zone pivot="powershell"

You will create a Log Analytics workspace to simulate having one already created in your organization. You will create this using Azure PowerShell instead of Bicep.

Run the following Azure PowerShell command in the terminal.

```azurepowershell
New-AzOperationalInsightsWorkspace `
  -Name ToyLogs `
  -Location eastus `
  -Sku Standard
```

::: zone-end

> [!NOTE]
> In this example, we're deploying the Log Analytics workspace into the same subscription and resource group as our other resources. In many situations you'll store Log Analytics workspaces in different resource groups to your application resources. Bicep can still reference them.

## Add diagnostic settings for Cosmos DB

Your R&D team need to log all requests to the Cosmos DB account. You decide to use the [Azure Monitor integration for Cosmos DB](/azure/cosmos-db/cosmosdb-monitor-resource-logs) to collect the *DataPlaneRequests* log, which contains information about requests to Cosmos DB.

Now that you have your simulated pre-existing Log Analytics workspace, you can reference it from within your Bicep template as an existing resource. You can use it as the destination for the Cosmos DB logs.

1. In the *main.bicep* file in Visual Studio Code, add the following code below the existing variable definitions:

   ```bicep
   var logAnalyticsWorkspaceName = 'ToyLogs'
   var cosmosDBAccountDiagnosticSettingsNames = 'route-logs-to-log-analytics'
   ```

1. At the bottom of the file, add the following code below the resource definitions:

   ```bicep
   resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2020-03-01-preview' existing = {
     name: logAnalyticsWorkspaceName
   }
   ```

   Notice that this resource definition uses the `existing` keyword, and that you omit a lot of other properties that you'd normally have to specify if you were deploying the Log Analytics workspace through this Bicep template.

1. Below the code you just added, add the following:

   ```bicep
   resource cosmosDBAccountDiagnostics 'Microsoft.Insights/diagnosticSettings@2017-05-01-preview' = {
     scope: cosmosDBAccount
     name: cosmosDBAccountDiagnosticSettingsNames
     properties: {
       workspaceId: logAnalyticsWorkspace.id
       logs: [
         {
           category: 'DataPlaneRequests'
           enabled: true
         }
       ]
     }
   }
   ```

   Notice that this code deploys an extension resource. It uses the `scope` keyword to tell Bicep that the resource should be attached to the Cosmos DB account, and it uses the `id` property of the `logAnalyticsWorkspace` existing resource so Azure understands where to send the Cosmos DB logs.

## Create a storage account for toy design documents

::: zone pivot="cli"

You will create an Azure Storage account to simulate your R&D team having created one in your organization. You will create this using the Azure CLI instead of Bicep.

Run the following Azure CLI command in the terminal. Make sure to substitute `{storage-account-name}` for a name that's likely to be unique. Make sure the name is all lowercase, without any special characters, and fewer than 24 characters. Keep a note of the name as you will use it again soon.

```azurecli
az storage account create \
  --name {storage-account-name} \
  --location eastus
```

::: zone-end

::: zone pivot="powershell"

You will create an Azure Storage account to simulate your R&D team having created one in your organization. You will create this using the Azure PowerShell instead of Bicep.

Run the following Azure PowerShell command in the terminal. Make sure to substitute `{storage-account-name}` for a name that's likely to be unique. Make sure the name is all lowercase, without any special characters, and fewer than 24 characters.

```azurepowershell
New-AzStorageAccount `
  -Name {storage-account-name} `
  -Location eastus `
  -SkuName Standard_LRS
```

::: zone-end

## Add diagnostic settings for storage account

Your R&D team want you to log all successful requests to the storage account they created. You decide to use the [Azure Storage integration with Azure Monitor logs](/azure/storage/blobs/monitor-blob-storage) to achieve this. You decide to log all read, write, and delete activities within blob storage on the R&D team's storage account.

You need to update your Bicep template to reference the storage account you created in the previous step.

1. Near the top of the *main.bicep* file, underneath the parameter definitions, add the following parameter definition:

   ```bicep
   param storageAccountName string
   ```

1. Under the variable definitions, add the following variable definition:

   ```bicep
   var storageAccountBlobDiagnosticSettingsNames = 'route-logs-to-log-analytics'
   ```

1. At the bottom of the file, under the resource definitions, add the following:

   ```bicep
   resource storageAccount 'Microsoft.Storage/storageAccounts@2019-06-01' existing = {
     name: storageAccountName
   
     resource blobService 'blobServices' existing = {
       name: 'default'
     }
   }
   ```

   Notice that both of these resources use the `existing` keyword.

1. At the bottom of the file, under the storage account definition you just added, add the following:

   ```bicep
   resource storageAccountBlobDiagnostics 'Microsoft.Insights/diagnosticSettings@2017-05-01-preview' = {
     scope: storageAccount::blobService
     name: storageAccountBlobDiagnosticSettingsNames
     properties: {
       workspaceId: logAnalyticsWorkspace.id
       logs: [
         {
           category: 'StorageRead'
           enabled: true
         }
         {
           category: 'StorageWrite'
           enabled: true
         }
         {
           category: 'StorageDelete'
           enabled: true
         }
       ]
     }
   }
   ```

   Notice that this extension resource has its `scope` set to the nested existing resource. Bicep understands that it should attach the extension resource to the `blobServices` child resource.

   After you're finished, your complete Bicep template should look like this:

   :::code language="bicep" source="code/7-complete.bicep" :::

1. Save the changes to the file.

## Deploy the template to Azure

::: zone pivot="cli"

Run the following Azure CLI command in the terminal.. Make sure you replace `{storage-account-name}` with the name of the storage account you created earlier in this exercise.

```azurecli
az deployment group create \
  --template-file main.bicep \
  --parameters storageAccountName={storage-account-name}
```

::: zone-end

::: zone pivot="powershell"

Run the following Azure PowerShell command in the terminal. Make sure you replace `{storage-account-name}` with the name of the storage account you created earlier in this exercise.

```azurepowershell
New-AzResourceGroupDeployment `
  -TemplateFile main.bicep `
  -storageAccountName {storage-account-name}
```

::: zone-end
