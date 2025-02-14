In this exercise, you store your Azure storage account name expression in an Azure Resource Manager (ARM) template variable. Then, you use that variable to specify the name of the storage account to create. 

In this exercise, we use the [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools). Be sure to install this extension in Visual Studio Code.

## Add a variable

Add a variable to store your storage account name expression in one place in the template.

1. In Visual Studio Code, in the **azuredeploy.json** file, place your cursor between the braces in the variables block ```"variables":{}``` and press <kbd>Enter</kbd>.
1. Type **var** inside the braces. You see a list of related snippets. Select **arm-variable**:

   :::image type="content" source="../media/5-arm-variable.png" alt-text="Screenshot of Visual Studio Code that shows the snippets for Azure Resource Manager template variables." border="true":::

1. Your variables section looks like this code:

    ```json
    "variables": {"variable1": "value"},
    ```

1. Change the name of the variable to **uniqueStorageName**, and change the value to **"[toLower(concat(parameters('storagePrefix'),uniqueString(resourceGroup().id)))]"**. Your variables section looks like this code:

    ```json
    "variables": {
        "uniqueStorageName": "[toLower(concat(parameters('storagePrefix'),uniqueString(resourceGroup().id)))]"
      },
    ```

    Notice that you're using the ```storagePrefix``` parameter in the expression instead of a literal string. Otherwise, this expression is the same as the one you learned about in the previous unit.

1. Use the variable in the resources section. Change the values of the ```name:``` and ```displayName``` attributes to **"[variables('uniqueStorageName')]"**

1. The entire file looks like this example:

    [!code-json[](code/variable.json?highlight=26-28,30,33-35)]

## Optionally, deploy the template

The updated template doesn't have any changes to the resource you deployed, so deploying this template doesn't make any changes to your Azure environment.

::: zone pivot="cli"

If you want to deploy the template to see it succeed, use the following Azure CLI commands. Be sure to use the same `storagePrefix` parameter value that you used in the last deployment.

```azurecli
templateFile="azuredeploy.json"
today=$(date +"%d-%b-%Y")
DeploymentName="addVariable-"$today

az deployment group create \
  --name $DeploymentName \
  --template-file $templateFile \
  --parameters storagePrefix={your-Prefix}
```

::: zone-end

::: zone pivot="powershell"

If you want to deploy the template to see it succeed, use the following Azure PowerShell commands. Be sure to use the same `storagePrefix` parameter value that you used in the last deployment.

```azurepowershell
$templateFile = "azuredeploy.json"
$today=Get-Date -Format "MM-dd-yyyy"
$deploymentName="addVariable-"+"$today"
New-AzResourceGroupDeployment `
  -Name $deploymentName `
  -TemplateFile $templateFile `
  -storagePrefix {your-Prefix}
```

::: zone-end
