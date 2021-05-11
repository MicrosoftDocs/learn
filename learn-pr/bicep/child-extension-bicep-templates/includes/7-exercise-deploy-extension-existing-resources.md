Now that you've finished creating the database for your R&D team to use, you need to ensure that access to the database is logged. You have an existing Log Analytics workspace that you want these logs to be sent to. You also need to send the logs from the R&D team's storage account to the same Log Analytics workspace. 

## Create a Log Analytics workspace

::: zone pivot="cli"

Create a Log Analytics workspace to simulate having one already created in your organization. Use the Azure CLI instead of Bicep.

In the terminal, run the following Azure CLI command:

```azurecli
az monitor log-analytics workspace create \
  --workspace-name ToyLogs \
  --location eastus
```

::: zone-end

::: zone pivot="powershell"

Create a Log Analytics workspace to simulate having one already created in your organization. Use Azure PowerShell instead of Bicep.

In the terminal, run the following Azure PowerShell command:

```azurepowershell
New-AzOperationalInsightsWorkspace `
  -Name ToyLogs `
  -Location eastus `
  -Sku Standard
```

::: zone-end

> [!NOTE]
> In this example, you're deploying the Log Analytics workspace into the same subscription and resource group as your other resources. In many situations, you'll store Log Analytics workspaces in resource groups that aren't the same as your application resources. Bicep can still reference them.

## Add diagnostics settings for Azure Cosmos DB

Your R&D team needs to log all requests to the Azure Cosmos DB account. You decide to use the [Azure Monitor integration for Azure Cosmos DB](/azure/cosmos-db/cosmosdb-monitor-resource-logs) to collect the *DataPlaneRequests* log, which contains information about requests to Azure Cosmos DB.

Now that you've created your simulated pre-existing Log Analytics workspace, you can reference it from within your Bicep template as an existing resource. You can use it as the destination for the Azure Cosmos DB logs.

To add diagnostics settings, do the following:

1. In Visual Studio Code, open the *main.bicep* file and then, below the existing variable definitions, add the following code:

   ```bicep
   var logAnalyticsWorkspaceName = 'ToyLogs'
   var cosmosDBAccountDiagnosticSettingsNames = 'route-logs-to-log-analytics'
   ```

1. At the bottom of the file, below the resource definitions, add the following code:

   ```bicep
   resource logAnalyticsWorkspace 'Microsoft.OperationalInsights/workspaces@2020-03-01-preview' existing = {
     name: logAnalyticsWorkspaceName
   }
   ```

   Notice that this resource definition uses the `existing` keyword, and that you're purposely omitting other properties that you'd normally specify if you were deploying the Log Analytics workspace through this Bicep template.

1. Below the code you just added, add the following code:

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

   Notice that this code deploys an extension resource. It uses the `scope` keyword to tell Bicep that the resource should be attached to the Azure Cosmos DB account. The code also uses the `id` property of the `logAnalyticsWorkspace` existing resource so that Azure understands where to send the Azure Cosmos DB logs.

## Create a storage account for toy design documents

::: zone pivot="cli"

Create an Azure storage account to simulate your R&D team already having created one in your organization. Use the Azure CLI instead of Bicep.

In the terminal, run the following Azure CLI command. Replace `{storage-account-name}` with a name that's likely to be unique. The name must be all lowercase, contain 24 or fewer characters, and have no special characters. Keep a note of the name for later use.

```azurecli
az storage account create \
  --name {storage-account-name} \
  --location eastus
```

::: zone-end

::: zone pivot="powershell"

Create an Azure storage account to simulate your R&D team's already having created one in your organization. Use Azure PowerShell instead of Bicep.

In the terminal, run the following Azure PowerShell command. Replace `{storage-account-name}` with a name that's likely to be unique. The name must be all lowercase, contain 24 or fewer characters, and have no special characters.

```azurepowershell
New-AzStorageAccount `
  -Name {storage-account-name} `
  -Location eastus `
  -SkuName Standard_LRS
```

::: zone-end

## Add diagnostics settings for storage account

Your R&D team wants you to log all successful requests to the storage account they've created. You decide to use the [Azure Storage integration with Azure Monitor logs](/azure/storage/blobs/monitor-blob-storage) to achieve this. You decide to log all read, write, and delete activities within blob storage on the R&D team's storage account.

You need to update your Bicep template to reference the storage account you created in the previous step.

1. Near the top of the *main.bicep* file, below the parameter definitions, add the following parameter definition:

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

1. At the bottom of the file, below the storage account definition you've just added, add the following:

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

In the terminal, run the following Azure CLI command. Replace `{storage-account-name}` with the name of the storage account you created earlier in this exercise.

```azurecli
az deployment group create \
  --template-file main.bicep \
  --parameters storageAccountName={storage-account-name}
```

::: zone-end

::: zone pivot="powershell"

In the terminal, run the following Azure PowerShell command. Replace `{storage-account-name}` with the name of the storage account you created earlier in this exercise.

```azurepowershell
New-AzResourceGroupDeployment `
  -TemplateFile main.bicep `
  -storageAccountName {storage-account-name}
```

::: zone-end
