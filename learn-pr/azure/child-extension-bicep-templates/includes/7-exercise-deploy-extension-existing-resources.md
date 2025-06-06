Now that you finished creating the database for your R&D team to use, you need to ensure that access to the database is logged. You have an existing Log Analytics workspace that you want these logs to be sent to. You also need to send the logs from the R&D team's storage account to the same Log Analytics workspace. In this exercise, you update your Bicep file to meet these requirements.

During the process, you'll:

> [!div class="checklist"]
> * Create a Log Analytics workspace.
> * Update your Bicep file to add diagnostic settings to your Azure Cosmos DB account.
> * Create a storage account.
> * In your Bicep file, update the diagnostic settings for the storage account.
> * Deploy your template and verify the result.

## Create a Log Analytics workspace

::: zone pivot="cli"

Create a Log Analytics workspace to simulate having an existing one in your organization. Use the Azure CLI instead of Bicep.

In the terminal, run the following Azure CLI command:

```azurecli
az monitor log-analytics workspace create \
  --workspace-name ToyLogs \
  --location eastus
```

::: zone-end

::: zone pivot="powershell"

Create a Log Analytics workspace to simulate having an existing one in your organization. Use Azure PowerShell instead of Bicep.

In the terminal, run the following Azure PowerShell command:

```azurepowershell
New-AzOperationalInsightsWorkspace `
  -Name ToyLogs `
  -Location eastus
```

::: zone-end

> [!NOTE]
> In this example, you deploy the Log Analytics workspace into the same subscription and resource group as your other resources. In many situations, you'll store Log Analytics workspaces in resource groups that aren't the same as the ones your application resources are in. Bicep can still reference them.

## Add diagnostics settings for Azure Cosmos DB

Your R&D team needs to log all requests to the Azure Cosmos DB account. You decide to use [Azure Monitor integration for Azure Cosmos DB](/azure/cosmos-db/cosmosdb-monitor-resource-logs) to collect the *DataPlaneRequests* log, which contains information about requests to Azure Cosmos DB.

Now that you created your simulated preexisting Log Analytics workspace, you can reference it from within your Bicep template as an existing resource. You can use it as the destination for the Azure Cosmos DB logs.

To add diagnostics settings, use the following steps:

1. In Visual Studio Code, open the *main.bicep* file in the editor. Below the existing variable definitions, add the following code:

   :::code language="bicep" source="code/7-complete.bicep" range="9-10" :::

1. At the bottom of the file, below the resource definitions, add the following code:

   :::code language="bicep" source="code/7-complete.bicep" range="55-57" :::

   Notice that this resource definition uses the `existing` keyword, and that you're intentionally omitting other properties that you'd normally specify if you were deploying the Log Analytics workspace through this Bicep template.

1. Below the code you just added, add the following code:

   :::code language="bicep" source="code/7-complete.bicep" range="59-71" :::

   Notice that this code deploys an extension resource. It uses the `scope` keyword to inform Bicep that the resource should be attached to the Azure Cosmos DB account. The code also uses the `id` property of the existing `logAnalyticsWorkspace` resource so that Azure knows where to send the Azure Cosmos DB logs.

## Create a storage account for toy design documents

::: zone pivot="cli"

Create an Azure storage account to simulate one that your R&D team already created in your organization. Use the Azure CLI instead of Bicep.

In the terminal, run the following Azure CLI command. Replace `{storageaccountname}` with a name that's likely to be unique. The name must be all lowercase, contain 24 or fewer characters, and have no spaces or special characters. Note the name. You'll need it later.

```azurecli
az storage account create \
  --name {storageaccountname} \
  --location eastus
```

::: zone-end

::: zone pivot="powershell"

Create an Azure storage account to simulate one that your R&D team already created in your organization. Use Azure PowerShell instead of Bicep.

In the terminal, run the following Azure PowerShell command. Replace `{storageaccountname}` with a name that's likely to be unique. The name must be all lowercase, contain 24 or fewer characters, and have no spaces or special characters.

```azurepowershell
New-AzStorageAccount `
  -Name {storageaccountname} `
  -Location eastus `
  -SkuName Standard_LRS
```

::: zone-end

## Add diagnostics settings for the storage account

Your R&D team wants you to log all successful requests to the storage account they created. You decide to use [Azure Storage integration with Azure Monitor logs](/azure/storage/blobs/monitor-blob-storage) to achieve this goal. You decide to log all read, write, and delete activities in blob storage on the R&D team's storage account.

You need to update your Bicep template to reference the storage account that you created in the previous step.

1. Near the top of the *main.bicep* file, below the parameter definitions, add the following parameter definition:

   :::code language="bicep" source="code/7-complete.bicep" range="4" :::

1. Under the variable definitions, add the following variable definition:

   :::code language="bicep" source="code/7-complete.bicep" range="11" :::

1. At the bottom of the file, under the resource definitions, add the following definition:

   :::code language="bicep" source="code/7-complete.bicep" range="73-79" :::

   Notice that both of these resources use the `existing` keyword.

1. At the bottom of the file, below the storage account definition that you added in the previous step, add the following code:

   :::code language="bicep" source="code/7-complete.bicep" range="81-101" :::

   Notice that this extension resource has its `scope` set to the nested existing resource. Bicep knows that it should attach the extension resource to the `blobServices` child resource.

1. Save the changes to the file.

## Verify your Bicep file

After you complete the preceding changes, your _main.bicep_ file should look like this example:

:::code language="bicep" source="code/7-complete.bicep" :::

If it doesn't look the same, either copy the example or adjust your template to match the example.

## Deploy the template to Azure

::: zone pivot="cli"

In the terminal, run the following Azure CLI command. Replace `{storageaccountname}` with the name of the storage account that you created earlier in this exercise.

```azurecli
az deployment group create \
  --name main \
  --template-file main.bicep \
  --parameters storageAccountName={storageaccountname}
```

::: zone-end

::: zone pivot="powershell"

In the terminal, run the following Azure PowerShell command. Replace `{storageaccountname}` with the name of the storage account that you created earlier in this exercise.

```azurepowershell
New-AzResourceGroupDeployment `
  -Name main `
  -TemplateFile main.bicep `
  -storageAccountName {storageaccountname}
```

::: zone-end

### Check your deployment

1. In your browser, go back to the Azure portal. Go to your resource group. Because the deployment used the same name as the first deployment, you still see one successful deployment.

1. Select the **1 Succeeded** link.

1. Select the deployment called **main**, and then select **Deployment details** to expand the list of deployed resources.

    :::image type="content" source="../media/7-deployment-details.png" alt-text="Screenshot of the Azure portal interface for the specific deployment. It shows the Azure Cosmos DB resources and two resources of type Microsoft.Insights/diagnosticSettings." border="true":::

   Notice that there are two resources listed that have a type of `Microsoft.Insights/diagnosticSettings`. These resources are the extension resources you deployed. One of the resources is attached to the storage account and the other is attached to the Azure Cosmos DB account. You can now verify that the Azure Cosmos DB diagnostic settings are configured correctly.

1. Select the Azure Cosmos DB account resource. The portal displays the Azure Cosmos DB account.

    :::image type="content" source="../media/7-deployment-details-cosmos-db-selected.png" alt-text="Screenshot of the Azure portal interface for the specific deployment, with the Azure Cosmos DB account highlighted." border="true":::

1. In the **Search** box at the top left, enter *Diagnostic settings*, and then select **Diagnostic settings**.

    :::image type="content" source="../media/7-cosmos-db-search.png" alt-text="Screenshot of the Azure portal interface for the Azure Cosmos DB account. Diagnostic settings is highlighted in the menu." border="true":::

1. The Azure portal might prompt you to enable full-text query support for logging. You don't need it for this exercise, so select **Not now**.

   :::image type="content" source="../media/7-cosmos-db-enable-full-text-query.png" alt-text="Screenshot of the prompt to enable full-text query." border="true":::

1. Notice that there's a diagnostic setting named **route-logs-to-log-analytics** that's configured to route the logs to the **ToyLogs** workspace.

    :::image type="content" source="../media/7-cosmos-db-diagnostic-settings.png" alt-text="Screenshot that shows the diagnostic settings." border="true":::

   If you want, you can also verify that the storage account has a similar diagnostic setting enabled for blob storage.
