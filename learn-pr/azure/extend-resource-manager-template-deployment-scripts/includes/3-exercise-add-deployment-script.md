[!INCLUDE [BYO subscription explanation](../../../includes/azure-exercise-subscription-prerequisite.md)]

As part of your team's application-deployment process, you need to create a storage account and stage a file in blob storage for the application to read. Up to this point, you've been manually copying the file every time a new environment has been set up. You decide to use a deployment script to automate this step as part of your environment-creation process.

In this exercise, you'll take an existing Azure Resource Manager (ARM) template and add a new deployment script.

During the process, you'll:

> [!div class="checklist"]
> * Create a starting template.
> * Add the prerequisites for deployment scripts including a user-assigned managed identity and role assignment.
> * Add a deployment script.
> * Deploy the template, and verify the outcome.

::: zone pivot="jsoncli,jsonpowershell"

[!INCLUDE [Install the JSON ARM template extension for Visual Studio Code](../../includes/azure-template-json-exercise-vscode-extension.md)]

::: zone-end

::: zone pivot="biceppowershell,bicepcli"

[!INCLUDE [Install the Bicep extension for Visual Studio Code](../../includes/azure-template-bicep-exercise-vscode-extension.md)]

::: zone-end

## Create the starting template

You start with an existing template that your team has been using. The template creates the storage account, sets up blob services and requires HTTPS, and creates the blob container for your configuration files.

::: zone pivot="jsoncli,jsonpowershell"

1. Open Visual Studio Code.

1. Create a new file called *azuredeploy.json*.

1. Save the empty file so that Visual Studio Code loads the ARM template tooling.

   You can either select **File** > **Save As** or select <kbd>Ctrl+S</kbd> in Windows (<kbd>⌘+S</kbd> on macOS). Be sure to remember where you've saved the file. For example, you might want to create a *scripts* folder in which to save it.

1. Copy the following starting template into *azuredeploy.json*.

    :::code language="json" source="code/3-starting-template.json" :::

1. Save the template.

::: zone-end

::: zone pivot="bicepcli,biceppowershell"

1. Open Visual Studio Code.

1. Create a new file called *main.bicep*.

1. Save the empty file so that Visual Studio Code loads the Bicep tooling. 

   You can either select **File** > **Save As** or select <kbd>Ctrl+S</kbd> in Windows (<kbd>⌘+S</kbd> on macOS). Be sure to remember where you've saved the file. For example, you might want to create a *scripts* folder to save it in.

1. Copy the following starting template into *main.bicep*.

    :::code language="bicep" source="code/3-starting-template.bicep" :::

1. Save the template.

::: zone-end

## Add a user-assigned managed identity

Next, you need to create a user-assigned managed identity. Given the infrastructure-as-code approach, you can create the identity in the template.

::: zone pivot="jsoncli,jsonpowershell"

1. Edit the `variables` section of *azuredeploy.json* to include:

    :::code language="json" source="code/3-template-with-deploymentscript.json" range="9" :::

1. Edit the `resources` section of *azuredeploy.json* to include:

    :::code language="json" source="code/3-template-with-deploymentscript.json" range="61-65,107" :::

1. Save the template.

::: zone-end

::: zone pivot="bicepcli,biceppowershell"

1. Under the variable definitions in *main.bicep*, add:

    :::code language="bicep" source="code/3-template-with-deploymentscript.bicep" range="3" :::

1. Under the resource definitions, add:

    :::code language="bicep" source="code/3-template-with-deploymentscript.bicep" range="44-47" :::

1. Save the template.

::: zone-end

## Set the contributor role for the managed identity

Now that you have a managed identity defined, you can assign it a role with rights to the resource group. You'll assign it [the *Contributor* role](/azure/role-based-access-control/built-in-roles#contributor). You identify a role by its role definition ID, which is a GUID. The *Contributor* role is built into Azure so the role definition ID is documented.

The role assignment also needs a GUID name. You can use the [`guid`](/azure/azure-resource-manager/templates/template-functions-string#guid) function to create a GUID that's unique to the resource group and role name.

::: zone pivot="jsoncli,jsonpowershell"

1. Edit the `variables` section of *azuredeploy.json* to include:

    :::code language="json" source="code/3-template-with-deploymentscript.json" range="10-11" :::

1. Edit the `resources` section of *azuredeploy.json* to include:

    :::code language="json" source="code/3-template-with-deploymentscript.json" range="67-77,107" :::

1. Save the template.

::: zone-end

::: zone pivot="bicepcli,biceppowershell"

1. Under the variable definitions in *main.bicep*, add:

    :::code language="bicep" source="code/3-template-with-deploymentscript.bicep" range="4-5" :::

1. Under the resource definitions, add:

    :::code language="bicep" source="code/3-template-with-deploymentscript.bicep" range="49-56" :::

1. Save the template.

::: zone-end

## Create the deployment script

Now, you have all the prerequisites for the deployment script. You'll start with the common values that the deployment script needs. There are two dependencies, the role assignment and the blob storage container. Your script needs both of those to exist before it can run.

::: zone pivot="jsoncli,jsonpowershell"

1. Edit the `variables` section of *azuredeploy.json* to include:

    :::code language="json" source="code/3-template-with-deploymentscript.json" range="12" :::

1. Edit the `resources` section of *azuredeploy.json* to include:

    :::code language="json" source="code/3-template-with-deploymentscript.json" range="79-93,106-107" :::

1. Add a `properties` section to the resource to define the script and the other required values.

    :::code language="json" source="code/3-template-with-deploymentscript.json" range="95-106" :::

1. Save the template.

::: zone-end

::: zone pivot="bicepcli,biceppowershell"

1. Under the variable definitions in *main.bicep*, add:

    :::code language="bicep" source="code/3-template-with-deploymentscript.bicep" range="6" :::

1. Under the resource definitions, add:

    :::code language="bicep" source="code/3-template-with-deploymentscript.bicep" range="58-67, 80-84" :::

1. Add a `properties` section to the resource to define the script and the other required values.

    :::code language="bicep" source="code/3-template-with-deploymentscript.bicep" range="68-79" :::

1. Save the template.

::: zone-end

## Add a template output

Now that you have a deployment script uploading a file into Azure Blob Storage, you might need to reference that file location in later automation. (Perhaps you'll run a test to validate that the file is where you think it should be.)

::: zone pivot="jsoncli,jsonpowershell"

After the `resources` section of the ARM template, add an output that references the URI for the file as reported by the deployment script.

:::code language="json" source="code/3-template-with-deploymentscript.json" range="109-114":::

::: zone-end

::: zone pivot="bicepcli,biceppowershell"

At the bottom of the file, after the resource definitions, add an output that references the URI for the file as reported by the deployment script.

:::code language="bicep" source="code/3-template-with-deploymentscript.bicep" range="86":::

::: zone-end

## Verify your template

Your template should look like:

::: zone pivot="jsoncli,jsonpowershell"

:::code language="json" source="code/3-template-with-deploymentscript.json" highlight="9-12, 61-107, 109-114" :::

::: zone-end

::: zone pivot="bicepcli,biceppowershell"

:::code language="bicep" source="code/3-template-with-deploymentscript.bicep" highlight="3-6, 44-86" :::

::: zone-end

If it doesn't, either copy the example or adjust your template to match the example.

## Deploy the template

::: zone pivot="jsoncli"

[!include[](../../includes/azure-template-json-exercise-nosandbox-deploy-cli.md)]

::: zone-end

::: zone pivot="bicepcli"

[!include[](../../includes/azure-template-bicep-exercise-nosandbox-deploy-cli.md)]

::: zone-end

::: zone pivot="jsonpowershell"

[!include[](../../includes/azure-template-json-exercise-nosandbox-deploy-powershell.md)]

::: zone-end

::: zone pivot="biceppowershell"

[!include[](../../includes/azure-template-bicep-exercise-nosandbox-deploy-powershell.md)]

::: zone-end

Next, you need to create a resource group to contain the resources that you'll create as part of this exercise. By using a new resource group, you'll make cleaning up after the exercise much easier.

From the terminal in Visual Studio Code, run this command to create the resource group for this exercise:

::: zone pivot="jsoncli,bicepcli"

### Create a resource group for the exercise

```azurecli
resourceGroupName="learndeploymentscript_exercise_1"
az group create --location eastus --name $resourceGroupName
```

::: zone-end

::: zone pivot="jsonpowershell,biceppowershell"

```azurepowershell
$resourceGroupName = 'learndeploymentscript_exercise_1'
New-AzResourceGroup -Location eastus -Name $resourceGroupName
```

::: zone-end

> [!NOTE]
> If you use a different name for your resource group, you'll need to make sure you update the script. Later in this module, you'll see how to avoid hard-coding resource group names in your scripts.

### Deploy the template to Azure

::: zone pivot="jsoncli"

The following code deploys the ARM template to Azure. You'll see a successful deployment.

Deploy the template by using Azure CLI commands in the Visual Studio Code terminal.

```azurecli
templateFile="azuredeploy.json"
today=$(date +"%d-%b-%Y")
deploymentName="deploymentscript-"$today

az deployment group create \
    --resource-group $resourceGroupName \
    --name $deploymentName \
    --template-file $templateFile
```

::: zone-end

::: zone pivot="bicepcli"

The following code deploys the ARM template to Azure. You'll see a successful deployment.

Deploy the template by using Azure CLI commands in the Visual Studio Code terminal.

```azurecli
templateFile="main.bicep"
today=$(date +"%d-%b-%Y")
deploymentName="deploymentscript-"$today

az deployment group create \
    --resource-group $resourceGroupName \
    --name $deploymentName \
    --template-file $templateFile
```

::: zone-end

::: zone pivot="jsonpowershell"

The following code deploys the template to Azure. You'll see a successful deployment.

Deploy the template by using Azure PowerShell commands in the terminal.

```azurepowershell
$templateFile = 'azuredeploy.json'
$today = Get-Date -Format 'MM-dd-yyyy'
$deploymentName = "deploymentscript-$today"
New-AzResourceGroupDeployment `
  -ResourceGroupName $resourceGroupName `
  -Name $deploymentName `
  -TemplateFile $templateFile
```

::: zone-end

::: zone pivot="biceppowershell"

The following code deploys the template to Azure. You'll see a successful deployment.

Deploy the template by using Azure PowerShell commands in the terminal.

```azurepowershell
$templateFile = 'main.bicep'
$today = Get-Date -Format 'MM-dd-yyyy'
$deploymentName = "deploymentscript-$today"
New-AzResourceGroupDeployment `
  -ResourceGroupName $resourceGroupName `
  -Name $deploymentName `
  -TemplateFile $templateFile
```

::: zone-end

### Review the result of your template

After the deployment is complete, you'll be given a URL that points to the file that your deployment script copied into blob storage.

::: zone pivot="jsoncli,bicepcli"

1. Retrieve that file by using the URL output from the template deployment to confirm that the deployment script worked properly.

    ```azurecli
    uri=$(az deployment group show --resource-group $resourceGroupName --name $deploymentName --query 'properties.outputs.fileUri.value' --output tsv)
    curl $uri
    ```

    The command returns the following code.

    ```json
    {
      "environment": "production",
      "hostname": "tailwindtraders.com",
      "Logging": {
        "LogLevel": {
          "Default": "Debug"
        }
      },
      "ApplicationInsights": {
        "InstrumentationKey": ""
      },
      "AllowedHosts": "*",
      "CosmosDb": {
        "Host": "",
        "Key": "",
        "Database": "Products"
      }
    }
    ```

1. You can also review the logs (and other details about the deployment) from the Azure portal or by using the following command.

    ```azurecli
    az deployment-scripts show-log --resource-group $resourceGroupName --name CopyConfigScript
    ```

::: zone-end

::: zone pivot="jsonpowershell,biceppowershell"

1. Retrieve that file by using the URL output from the template deployment to confirm that the deployment script worked properly.

    ```azurepowershell
    $fileUri = (Get-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -Name $deploymentName).Outputs.fileUri.Value
    Invoke-RestMethod $fileUri
    ```

    The command returns the following code.

    ```azurepowershell
    environment         : production
    hostname            : tailwindtraders.com
    Logging             : @{LogLevel=}
    ApplicationInsights : @{InstrumentationKey=}
    AllowedHosts        : *
    CosmosDb            : @{Host=; Key=; Database=Products}
    ```

1. You can also review the logs (and other details about the deployment) from the Azure portal or by using the following command line.

    ```azurepowershell
    Get-AzDeploymentScriptLog -ResourceGroupName $resourceGroupName -Name CopyConfigScript
    ```

::: zone-end

### Clean up the resource group

Now that you've successfully deployed an ARM template with a deployment script, you can remove the resource group that contains all the resources and role assignments you've created.

::: zone pivot="jsoncli,bicepcli"

```azurecli
az group delete --name $resourceGroupName
```

::: zone-end

::: zone pivot="jsonpowershell,biceppowershell"

```azurepowershell
Remove-AzResourceGroup -Name $resourceGroupName
```

::: zone-end
