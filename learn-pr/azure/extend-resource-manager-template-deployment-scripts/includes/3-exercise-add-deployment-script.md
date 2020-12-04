> [!NOTE]
> This exercise requires an Azure subscription. If you do not have an Azure subscription, you can get a [free Azure subscription](https://azure.microsoft.com/free/?azure-portal=true).

As part of your team's application deployment process, you need to create a storage account and stage a file in blob storage for the application to read. Up to this point, you've been manually copying the file every time a new environment has been set up. You decide to use a deployment script to automate this step as part of your environment creation process.

In this exercise, you will take an existing Azure Resource Manager (ARM) template and add a `deploymentScripts` resource to run an Azure PowerShell script to deploy a file to the newly created storage account.

This exercise uses [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools). Be sure to install this extension in Visual Studio Code.

## Create the starting template

You start with an existing template your team has been using that creates the storage account, sets up blob services and requires HTTPS, and creates the blob container for your configuration files.

1. Open Visual Studio Code, and create a new file called *azuredeploy.json*.
1. Copy the starting template below into *azuredeploy.json*.

    :::code language="json" source="code/starting-template.json" :::

1. Save the template.

## Add a user-assigned managed service identity

Next, you need to create a user-assigned managed identity. Given the infrastructure-as-code approach, you can create the identity in the template.

1. Edit the `variables` section of *azuredeploy.json* to include:

    :::code language="json" source="code/template-with-deploymentscript.json" range="9" :::

1. Edit the `resources` section of *azuredeploy.json* to include:

    :::code language="json" source="code/template-with-deploymentscript.json" range="60-64,106" :::

1. Save the template.

## Set the contributor role for the managed service identity

Now that you have a managed service identity defined, you can assign it a role with rights to the resource group. The role assignment needs a GUID name, so you can use the [`guid`](https://docs.microsoft.com/azure/azure-resource-manager/templates/template-functions-string#guid) function to create a GUID that's unique to the resource group and role name.

1. Edit the `variables` section of *azuredeploy.json* to include:

    :::code language="json" source="code/template-with-deploymentscript.json" range="10" :::

1. Edit the `resources` section of *azuredeploy.json* to include:

    :::code language="json" source="code/template-with-deploymentscript.json" range="66-76,106" :::

1. Save the template.

## Create the deployment script

Now, you have all the prerequisites for the deployment script. You'll start with the common values the deployment script requires. There are two dependencies, the role assignment and the blob storage container. Your script will need both of those to exist before it can run.

1. Edit the `variables` section of *azuredeploy.json* to include:

    :::code language="json" source="code/template-with-deploymentscript.json" range="11" :::

1. Edit the `resources` section of *azuredeploy.json* to include:

    :::code language="json" source="code/template-with-deploymentscript.json" range="78-92,105-106" :::

1. Add a `properties` section to the resource to define our script and the other required values.

    :::code language="json" source="code/template-with-deploymentscript.json" range="94-105" :::

1. Save the template.

## Add a template output

Now that you have a deployment script uploading a file into Azure blob storage, you may need to reference that file location in later automation (perhaps a test to validate the file is where you think it should be?).

1. After the `resources` section of the ARM template, add an output that references the URI for file as reported by the deployment script.

    :::code language="json" source="code/template-with-deploymentscript.json" range="108-113":::

## Verify your template

Your template should look like:

:::code language="json" source="code/template-with-deploymentscript.json" highlight="9-11, 60-106, 108-113" :::

If it does not, either copy the example or adjust your template to match the example.

## Deploy the template

::: zone pivot="cli"
To deploy this template to Azure, you need to sign in to your Azure account from the Visual Studio Code terminal. Be sure you have the [Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest) tools installed, and sign in with the same account you used to activate the sandbox.

1. Open a terminal window by using the **Terminal** menu.
1. If the drop-down menu on the right of the terminal window says **bash**, you have the right shell to work from and you can skip to the next section.

      :::image type="content" source="../media/3-bash.png" alt-text="The Visual Studio Code terminal window with bash in the drop-down." border="true":::

1. If not, select the drop-down and choose **Select Default Shell**.
1. Select **bash**.

      :::image type="content" source="../media/3-select-shell.png" alt-text="The Visual Studio Code terminal window showing the select shell drop-down." border="true":::

1. Select the **+** in the terminal to create a new terminal with *bash* as the shell.

### Sign in to Azure

1. From the terminal in Visual Studio Code, run this command to sign in to Azure. A browser opens so you can sign in to your account.

    ```azurecli
    az login
    ```

1. After you've signed in, you see a list of the subscriptions associated with this account in the terminal. Find the subscription you would like to use for this exercise.  If you missed the list from the login, you can use the following snippet to list your subscriptions again.

    ```azurecli
    az account list --output tsv
    ```

1. Set the default subscription for all of the Azure CLI commands you run in this session.

    ```azurecli
    az account set --subscription "Your Subscription Name or ID"
    ```

### Create a resource group for the exercise

Next, you need to create a resource group to contain the resources you will create as part of this exercise. By using a new resource group, cleaning up after the exercise will be much easier.

1. From the terminal in Visual Studio Code, run this command to create the resource group for this exercise.

```azurecli
resourceGroupName="learndeploymentscript_exercise_1"
az group create --location eastus --name $resourceGroupName
```

### Deploy the template to Azure

The following code deploys the ARM template to Azure. You will see a successful deployment.

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

### Review the result of your template

Once the deployment is complete, you will be given a URL that points to the file your deployment script copied into blob storage.

1. Retrieve that file using the URL output from the template deployment to confirm our deployment script worked properly.

```azurecli
uri=$(az deployment group show --resource-group $resourceGroupName --name $deploymentName --query 'properties.outputs.fileUri.value' --output tsv)
curl $uri
```

You should see the following returned from the above command.

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

1. You can also review the logs (and other details about the deployment) from the Azure portal or with the following command line.

```azurecli
az deployment-scripts show-log --resource-group $resourceGroupName --name CopyConfigScript
```

### Clean up the resource group

Now that you've successfully deployed an ARM template with a deployment script, you can remove the resource group that contains all the resources and role assignments you've created.

```azurecli
az group delete --name $resourceGroupName
```

::: zone-end

::: zone pivot="powershell"

To deploy this template to Azure, you need to sign in to your Azure account from the Visual Studio Code terminal. Be sure you have [installed Azure PowerShell](https://docs.microsoft.com/powershell/azure/install-az-ps?view=azps-4.3.0&azure-portal=true), and sign in to the same account that activated the sandbox.

1. Open a terminal window by using the **Terminal** menu.
1. If the drop-down menu on the right of the terminal window says **pwsh**, you have the right shell to work from and you can skip to the next section.

      :::image type="content" source="../media/3-pwsh.png" alt-text="The Visual Studio Code terminal window with pwsh in the drop-down." border="true":::

1. If not, select the drop-down and choose **Select Default Shell**.
1. Select **pwsh**.

      :::image type="content" source="../media/3-select-shell.png" alt-text="The Visual Studio Code terminal window showing the select shell drop-down." border="true":::

1. Select the **+** in the terminal to create a new terminal with *pwsh* as the shell.

### Sign in to Azure by using Azure PowerShell

1. From the terminal in Visual Studio Code, run the following command to sign in to Azure. A browser opens so you can sign in to your account. Use the code in the prompt.

    ```azurepowershell
    Connect-AzAccount
    ```

1. Get the subscription ID of the subscription you would like to use for this exercise. The command will list your subscriptions and their IDs. The subscription ID is the second column. Copy the second column. It will look something like *cf49fbbc-217c-4eb6-9eb5-a6a6c68295a0*

    ```azurepowershell
    Get-AzSubscription
    ```

1. Set the default subscription for all of the Azure PowerShell commands you run in this session.

    ```azurepowershell
    Set-AzContext -SubscriptionId {Your subscription ID}
    ```

### Create a resource group for the exercise

Next, you need to create a resource group to contain the resources you will create as part of this exercise. By using a new resource group, cleaning up after the exercise will be much easier.

1. From the terminal in Visual Studio Code, run this command to create the resource group for this exercise.

```azurepowershell
$ResourceGroupName="learndeploymentscript_exercise_1"
New-AzResourceGroup -Location eastus -Name $ResourceGroupName
```

### Deploy the template to Azure

The following code deploys the template to Azure. You will see a successful deployment.

Deploy the template by using Azure PowerShell commands in the terminal.

```azurepowershell
$TemplateFile = "azuredeploy.json"
$Today=Get-Date -Format "MM-dd-yyyy"
$DeploymentName="deploymentscript-"+"$Today"
New-AzResourceGroupDeployment `
  -ResourceGroupName $ResourceGroupName `
  -Name $DeploymentName `
  -TemplateFile $TemplateFile
```

### Review the result of your template

Once the deployment is complete, you will be given a URL that points to the file your deployment script copied into blob storage.

1. Retrieve that file using the URL output from the template deployment to confirm our deployment script worked properly.

```azurepowershell
$FileUri = Get-AzResourceGroupDeployment -ResourceGroupName $ResourceGroupName -Name $DeploymentName).Outputs.fileUri.Value
Invoke-RestMethod $FileUri
```

You should see the following returned from the above command.

```azurepowershell
environment         : production
hostname            : tailwindtraders.com
Logging             : @{LogLevel=}
ApplicationInsights : @{InstrumentationKey=}
AllowedHosts        : *
CosmosDb            : @{Host=; Key=; Database=Products}
```

1. You can also review the logs (and other details about the deployment) from the Azure portal or with the following command line.

```azurepowershell
Get-AzDeploymentScriptLog -ResourceGroupName $ResourceGroupName -Name CopyConfigScript
```

### Clean up the resource group

Now that you've successfully deployed an ARM template with a deployment script, you can remove the resource group that contains all the resources and role assignments you've created.

```azurepowershell
Remove-AzResourceGroup -Name $ResourceGroupName
```

::: zone-end
