> [!NOTE]
> This exercise requires an Azure subscription. If you don't have an Azure subscription, you can get a [free subscription](https://azure.microsoft.com/free/?azure-portal=true).

As part of your team's application deployment process, you need to create a storage account and stage a file in blob storage for the application to read. Up to this point, you've been manually copying the file every time a new environment has been set up. You decide to use a deployment script to automate this step as part of your environment creation process.

In this exercise, you'll take an existing Azure Resource Manager (ARM) template and add a `deploymentScripts` resource to run an Azure PowerShell script. The script will deploy a file to the newly created storage account.

This exercise uses [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools). Be sure to install this extension in Visual Studio Code.

## Create the starting template

You start with an existing template that your team has been using. The template creates the storage account, sets up blob services and requires HTTPS, and creates the blob container for your configuration files.

::: zone pivot="jsoncli,jsonpowershell"

1. Open Visual Studio Code, and create a new file called *azuredeploy.json*.
1. Copy the following starting template into *azuredeploy.json*.

    :::code language="json" source="code/3-starting-template.json" :::

1. Save the template.

::: zone-end

::: zone pivot="bicepcli,biceppowershell"

1. Open Visual Studio Code, and create a new file called *main.bicep*.
1. Copy the following starting template into *main.bicep*.

    :::code language="plaintext" source="code/3-starting-template.bicep" :::

1. Save the template.

::: zone-end

## Add a user-assigned managed service identity

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

    :::code language="plaintext" source="code/3-template-with-deploymentscript.bicep" range="3" :::

1. Under the resource definitions, add:

    :::code language="plaintext" source="code/3-template-with-deploymentscript.bicep" range="44-47" :::

1. Save the template.

::: zone-end

## Set the contributor role for the managed service identity

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

    :::code language="plaintext" source="code/3-template-with-deploymentscript.bicep" range="4-5" :::

1. Under the resource definitions, add:

    :::code language="plaintext" source="code/3-template-with-deploymentscript.bicep" range="49-56" :::

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

    :::code language="plaintext" source="code/3-template-with-deploymentscript.bicep" range="6" :::

1. Under the resource definitions, add:

    :::code language="plaintext" source="code/3-template-with-deploymentscript.bicep" range="58-67, 80-84" :::

1. Add a `properties` section to the resource to define the script and the other required values.

    :::code language="plaintext" source="code/3-template-with-deploymentscript.bicep" range="68-79" :::

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

:::code language="plaintext" source="code/3-template-with-deploymentscript.bicep" range="86":::

::: zone-end

## Verify your template

Your template should look like:

::: zone pivot="jsoncli,jsonpowershell"

:::code language="json" source="code/3-template-with-deploymentscript.json" highlight="9-12, 61-107, 109-114" :::

::: zone-end

::: zone pivot="bicepcli,biceppowershell"

:::code language="plaintext" source="code/3-template-with-deploymentscript.bicep" highlight="3-6, 44-86" :::

::: zone-end

If it doesn't, either copy the example or adjust your template to match the example.

## Deploy the template

::: zone pivot="jsoncli,bicepcli"

To deploy this template to Azure, you need to sign in to your Azure account from the Visual Studio Code terminal. Be sure you have the [Azure CLI](/cli/azure/install-azure-cli?view=azure-cli-latest&preserve-view=true) tools installed, and sign in with the same account that you used to activate the sandbox.

1. Open a terminal window by using the **Terminal** menu.
1. If the drop-down menu on the right of the terminal window says **bash**, you have the right shell to work from and you can skip to the next section.

      :::image type="content" source="../media/3-bash.png" alt-text="The Visual Studio Code terminal window with bash on the drop-down menu." border="true":::

1. If not, select the drop-down menu and choose **Select Default Shell**.
1. Select **bash**.

      :::image type="content" source="../media/3-select-shell.png" alt-text="The Visual Studio Code terminal window showing the drop-down menu for selecting the shell." border="true":::

1. Select the plus sign (**+**) in the terminal to create a new terminal with **bash** as the shell.

### Sign in to Azure

1. From the terminal in Visual Studio Code, run the following command. A browser then opens so you can sign in to your Azure account.

    ```azurecli
    az login
    ```

1. After you've signed in, you see a list of the subscriptions associated with this account in the terminal. Find the subscription that you want to use for this exercise. If you missed the list from the sign-in, you can use the following snippet to list your subscriptions again.

    ```azurecli
    az account list --output tsv
    ```

1. Set the default subscription for all of the Azure CLI commands that you run in this session.

    ```azurecli
    az account set --subscription "Your Subscription Name or ID"
    ```

### Create a resource group for the exercise

Next, you need to create a resource group to contain the resources that you'll create as part of this exercise. By using a new resource group, you'll make cleaning up after the exercise much easier.

From the terminal in Visual Studio Code, run this command to create the resource group for this exercise:

```azurecli
resourceGroupName="learndeploymentscript_exercise_1"
az group create --location eastus --name $resourceGroupName
```

> [!NOTE]
> If you use a different name for your resource group, you'll need to make sure you update the script. Later in this module you'll see how to avoid hard-coding resource group names in your scripts.

::: zone-end

::: zone pivot="jsonpowershell,biceppowershell"

To deploy this template to Azure, you need to sign in to your Azure account from the Visual Studio Code terminal. Be sure you have [Azure PowerShell](/powershell/azure/install-az-ps?view=azps-4.3.0&azure-portal=true&preserve-view=true) installed, and sign in to the same account that activated the sandbox.

1. Open a terminal window by using the **Terminal** menu.
1. If the drop-down menu on the right of the terminal window says **pwsh**, you have the right shell to work from and you can skip to the next section.

    :::image type="content" source="../media/3-pwsh.png" alt-text="The Visual Studio Code terminal window with p w s h on the drop-down menu." border="true":::

    If not, select the drop-down menu and choose **Select Default Shell**.

1. Select **pwsh**.

    :::image type="content" source="../media/3-select-shell.png" alt-text="The Visual Studio Code terminal window showing the drop-down list for selecting the default shell." border="true":::

1. Select **+** in the terminal to create a new terminal with **pwsh** as the shell.

### Sign in to Azure by using Azure PowerShell

1. From the terminal in Visual Studio Code, run the following command to sign in to Azure. A browser opens so you can sign in to your account. Use the code in the prompt.

    ```azurepowershell
    Connect-AzAccount
    ```

1. Get the ID of the subscription that you want to use for this exercise. The following command will list your subscriptions and their IDs. 

    ```azurepowershell
    Get-AzSubscription
    ```
    The subscription ID is the second column. Copy the second column. It looks something like *cf49fbbc-217c-4eb6-9eb5-a6a6c68295a0*. 

1. Set the default subscription for all of the Azure PowerShell commands that you run in this session.

    ```azurepowershell
    Set-AzContext -SubscriptionId {Your subscription ID}
    ```

### Create a resource group for the exercise

Next, you need to create a resource group to contain the resources you'll create as part of this exercise. By using a new resource group, you'll make cleaning up after the exercise much easier.

From the terminal in Visual Studio Code, run this command to create the resource group for this exercise:

```azurepowershell
$resourceGroupName = 'learndeploymentscript_exercise_1'
New-AzResourceGroup -Location eastus -Name $resourceGroupName
```

> [!NOTE]
> If you use a different name for your resource group, you'll need to make sure you update the script. Later in this module you'll see how to avoid hard-coding resource group names in your scripts.

::: zone-end

::: zone pivot="jsoncli"

### Deploy the template to Azure

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

### Deploy the template to Azure

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

### Deploy the template to Azure

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

### Deploy the template to Azure

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
    $fileUri = (Get-AzResourceGroupDeployment -ResourceGroupName $resourceGroupName -Name $reploymentName).Outputs.fileUri.Value
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
