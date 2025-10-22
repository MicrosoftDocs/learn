In this exercise, you create an expression by using Azure Resource Manager (ARM) template functions. The expression creates a unique name for each resource group by combining a prefix input with a hash of the resource group ID. It results in Azure storage account names like `dev2hu6sbtr5` and `staging5his8hgr67`.

In this exercise, you use the [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools).

[!INCLUDE[](../../../includes/azure-optional-exercise-subscription-note.md)]

[!INCLUDE[](../../../includes/azure-optional-exercise-create-resource-group-note.md)]

> [!NOTE]
> Throughout this exercise, replace **myResourceGroupName** in the examples with the name of an existing resource group, or the name of the resource group that you created for this exercise.

## Create the ARM template file

In the previous module, you created an ARM template that deployed a storage account. You added parameters and an output to this file. Here, you start with that file, but the output is removed to reduce the overhead.

1. Open Visual Studio Code and create a file called **azuredeploy.json**. If you have this file from the previous module, you can use that file.

1. Replace the contents of the file with the following code:

    [!code-json[](code/starter.json)]

1. If you didn't complete the previous module, take a moment to review this file. Note the ```storageName``` parameter is used to pass in a unique name for the storage account.

## Create an expression to set a unique storage account name

Instead of passing in the name of the storage account, change the parameter to take a prefix for the storage account name. This parameter is passed to the ```concat``` function in your expression.

1. In the `parameters` section, change ```storageName``` to **storagePrefix**.

1. Change value of the ```maxLength:``` attribute of the `storagePrefix` parameter to **11**. The maximum length for a storage account name is 24 characters, so you want to be sure the added hash from the function you create doesn't cause the name to be longer than 24.

1. Create the expression to set the unique storage account name. In the `resources` section, change the values of the ```name:``` and ```displayName:``` attributes from ```"[parameters('storageName')]"``` to **"[toLower(concat(parameters('storagePrefix'),uniqueString(resourceGroup().id)))]"**. You learned about this expression in the previous unit. The file should now look like this file:

    [!code-json[](code/function.json?highlight=8,28,32)]

## Deploy the ARM template to Azure

::: zone pivot="cli"

To deploy this template to Azure, you need to sign in to your Azure account from the Visual Studio Code terminal. Be sure you have the [Azure CLI](/cli/azure/install-azure-cli?azure-portal=true&view=azure-cli-latest&preserve-view=true) tools installed.

1. From the **Terminal** menu, select **New Terminal**.

1. If the drop-down menu on the right side of the terminal window says **bash**, you have the right shell to work from. You can skip to the next section.

      :::image type="content" source="../media/3-bash.png" alt-text="A screenshot that shows the Visual Studio Code terminal window with bash in the drop-down menu." border="true":::

1. If you don't have the right shell, select the downarrow, and then select **Git Bash**.

      :::image type="content" source="../media/3-select-shell.png" alt-text="Screenshot that shows the select shell list in the Visual Studio Code terminal window." border="true":::

### Sign in to Azure

1. From the terminal in Visual Studio Code, run the following command to sign in to Azure. Running this command opens a browser that allows you to sign in to your account:

    ```azurecli
    az login
    ```

In the browser window that opens, sign in to your account. After you sign in, a list of the subscriptions associated with this account displays in the terminal. The default subscription is marked with an asterisk (*). If you have multiple subscriptions, select the subscription you want to use for this exercise.

### Create and set the default resource group

```azurecli
az group create --name <resource-group-name> --location <location>
```

Replace **\<resource-group-name>** with a unique name for your resource group. Replace **\<location>** with the Azure region closest to you. For example, use eastus for East US.

By setting the default resource group, you can omit that parameter from the Azure CLI commands in this exercise. To set the resource group, run the following command.

```azurecli
az configure --defaults group="myResourceGroupName"
```

Replace **myResourceGroupName** with the resource group name.

### Deploy the template to Azure

You learned about the deployment commands in the previous module. Here, we're using the Azure CLI ```az deployment group create``` command.

- Deploy the template by using Azure CLI commands in the Visual Studio Code terminal. Remember to replace `{your-prefix}` with a different string. For example, you could use **storage**.

    ```azurecli
    templateFile="azuredeploy.json"
    today=$(date +"%d-%b-%Y")
    DeploymentName="addfunction-"$today

    az deployment group create \
      --name $DeploymentName \
      --template-file $templateFile \
      --parameters storagePrefix={your-prefix}
    ```

    In the first section of this code, you set Azure CLI variables for the path to the template file that you want to deploy and the name of the deployment. You then used the ```az deployment group create``` command to deploy the template to Azure.

    You should see the message `Running...` in the terminal.

::: zone-end

::: zone pivot="powershell"

To deploy this template to Azure, you need to sign in to your Azure account from the Visual Studio Code terminal. Be sure you have the [Azure PowerShell](/powershell/azure/install-az-ps?azure-portal=true&view=azps-4.3.0&preserve-view=true) tools installed.

1. From the **Terminal** menu, select **New Terminal**.

1. If the drop-down menu on the right side of the terminal window says **pwsh**, you have the right shell to work from. You can skip to the next section.

      :::image type="content" source="../media/3-pwsh.png" alt-text="A screenshot that shows the Visual Studio Code terminal window with pwsh in the drop-down menu." border="true":::

1. If you don't have the right shell, select the down arrow and then select **PowerShell** in the drop-down menu.

      :::image type="content" source="../media/3-select-shell-powershell.png" alt-text="Screenshot that shows the select shell list in the Visual Studio Code terminal window." border="true":::

### Sign in to Azure by using Azure PowerShell

1. From the terminal in Visual Studio Code, run the following command to sign in to Azure.

    ```azurepowershell
    Connect-AzAccount
    ```

    In the browser window that opens (the browser window could be opened behind the current window, minimize the current window to see it), sign in to your account. After you sign in, a list of the subscriptions associated with this account displays in the terminal. The default subscription is marked with an asterisk (*). If you have multiple subscriptions, select the subscription you want to use for this exercise.

### Create and set the default resource group

```azurepowershell
New-AzResourceGroup -Name <ResourceGroupName> -Location <Location>
```

Replace with a unique name for your resource group. Replace with the Azure region closest to you. For example, use eastus for East US.

By setting the default resource group, you can omit that parameter from the Azure CLI commands in this exercise. To set the resource group, run the following command.

```azurepowershell
Set-AzDefault -ResourceGroupName [resource group name]
```

replace *[resource group name]* with your resource group name.

### Deploy the template to Azure

Deploy the template by using Azure PowerShell commands in the Visual Studio Code terminal. Remember to replace `{your-prefix}` with a different string. For example, you could use **storage**.

  ```azurepowershell
  $templateFile = "azuredeploy.json"
  $today=Get-Date -Format "MM-dd-yyyy"
  $deploymentName="addfunction-"+"$today"
  New-AzResourceGroupDeployment `
    -Name $deploymentName `
    -TemplateFile $templateFile `
    -storagePrefix {your-prefix}
  ```

In the first section of this code, you set Azure PowerShell variables for the path to the template file that you want to deploy and the name of the deployment. You then used the ```New-AzResourceGroupDeployment``` command to deploy the template to Azure.

::: zone-end

### Check your deployment

When the deployment finishes, go to the [Azure portal](https://portal.azure.com?azure-portal=true) and make sure you're in the correct subscription. To check the subscription, select your avatar in the upper-right corner of the page. Select **Switch directory**. In the list, select the appropriate directory.

1. In the left pane, select **Resource groups**.

1. Select **myResourceGroupName**.

1. In the **Overview** section, you see that one deployment succeeded:

    :::image type="content" source="../media/3-deployment-succeeded.png" alt-text="Screenshot of the Azure portal that shows the resource group overview. The Deployments section shows that one deployment succeeded." border="true":::

1. Select **1 Succeeded** to see the details of the deployment:

     :::image type="content" source="../media/3-add-function.png" alt-text="Screenshot of the Azure portal that shows deployments. One deployment is listed and has a status of Succeeded." border="true":::

1. Select **addfunction** to see what resources were deployed:

    :::image type="content" source="../media/3-unique-storage-deploy.png" alt-text="Screenshot of the Azure portal that shows that the storage account deployed." border="true":::

1. Leave the page open in your browser so you can check on deployments again later in the module.
