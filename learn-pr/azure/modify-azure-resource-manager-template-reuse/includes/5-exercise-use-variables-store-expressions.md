In this exercise, you store your Azure Storage Account name expression in an Azure Resource Manager (ARM) template variable and use that variable to specify the name of the Storage Account to create. 

This exercise uses the [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools). Be sure to install this extension in Visual Studio Code.

## Add a variable

Here, you add a variable to store your Storage Account name expression in one place in the template.

1. In the *azuredeploy.json* file in Visual Studio Code, place your curser between the curly braces in the variables block. ```"variables":{},``` Press <kbd>Enter</kbd>.
1. Type **var**** in the curly braces. You see a list of related snippets. Choose arm-variable.

  :::image type="content" source="../media/5-arm-variable.png" alt-text="Visual Studio Code showing the snippets for Azure Resource Manager template variables." border="true":::

1. Your variables section will look like this.

    ```json
    "variables": {"variable1": "value"},
    ```

1. Change the name of the variable to **uniqueResourceName**, and change the value to **"[toLower(concat(parameters('storagePrefix'),uniqueString(resourceGroup().id)))]"** Your variables section will look like this:

    ```json
    "variables": {
        "uniqueStorageName": "[toLower(concat(parameters('storagePrefix'),uniqueString(resourceGroup().id)))]"
      },
    ```

    Notice that you are using the ```storagePrefix``` parameter in the expression instead of a literal string. Otherwise, this is the same expression you learned about in the previous unit.

1. Use the variable in the resources section. Change the values of the ```name:``` and ```displayName``` attributes to **"[variables('uniqueStorageName')]"**

1. The entire file will look like this:

    [!code-json[](code/variable.json?highlight=26-28,30,33)]

## Optionally, deploy the template

The updated template doesn't have any changes to the resource you deployed, so deploying this template won't make any changes to your Azure environment. 

::: zone pivot="cli"

However, if you would like to deploy this template to see it succeed, use the Azure CLI commands below. Be sure to use the same *storagePrefix* parameter value you used in the last deployment.

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

However, if you would like to deploy this template to see it succeed, use the Azure PowerShell commands below. Be sure to use the same *storagePrefix* parameter value you used in the last deployment.

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
