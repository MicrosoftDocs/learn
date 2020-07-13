Here, you add tags to help organize and track your Microsoft Azure resources, and use an Azure Resource Manager (ARM) template parameter file to allow for different parameter configurations per deployment.

This exercise uses the [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools). Be sure to install this extension in Visual Studio Code.

## Create a tag to track the resource deployment environment and project

Here, you create a parameter to use as a resource tag in your template.

1. In the *azuredeploy.json* file in Visual Studio Code, place your curser after the closing curly brace for the storageSKU parameter. Add a comma and press the <kbd>Enter</kbd> key.
1. Type **par**. You see a list of related snippets.
1. 1. Choose *arm-param*. Recall, this adds a generic parameter to the template. It will look like this:

    ```json
    "parameter1": {
        "type": "string",
        "metadata": {
            "description": "description"
        }
    ```

1. Change *parameter1* to **resourceTags** and change the value of ```"type":``` to be **object**. Recall that parameters can be string, secureString, int, bool, object, secureObject, and array data types. A link to example syntax for these parameter types is in the summary of this module.
1. Add an attribute called **defaultValue:** and set the value to be **{"Environment": "Dev", "Project": "Tutorial"}**.
1. The parameter block should look like this:

    ```json
    "parameters": {
        "storagePrefix": {
            "type": "string",
            "minLength": 3,
            "maxLength": 11
        },
        "storageSKU": {
            "type": "string",
            "defaultValue": "Standard_LRS",
            "allowedValues": [
                "Standard_LRS",
                "Standard_GRS",
                "Standard_RAGRS",
                "Standard_ZRS",
                "Premium_LRS",
                "Premium_ZRS",
                "Standard_GZRS",
                "Standard_RAGZRS"
            ]
        },
        "resourceTags": {
        "type": "object",
        "defaultValue": {
            "Environment": "Dev",
            "Project": "Tutorial"
            }
        }
    },
    ```

1. Use this parameter to tag your Storage Account resource. Change the ```tags:``` attribute in the resource definition.

    ```json
    "tags": "[parameters('resourceTags')]",
    ```

1. Your file should look like this:

    [!code-json[](code/tags.json?highlight=24-29,40)]

1. Save the file.

## Deploy the ARM template with updated tags

::: zone pivot="cli"

1. Deploy the updated ARM template to Azure. Be sure to use the same *storagePrefix* you used before.

    ```azurecli
    templateFile="azuredeploy.json"
    today=$(date +"%d-%b-%Y")
    DeploymentName="updateTags-"$today

    az deployment group create \
        --name $DeploymentName \
        --template-file $templateFile \
        --parameters storagePrefix={your-Prefix} storageSKU=Standard_LRS
    ```

::: zone-end

::: zone pivot="powershell"

1. Deploy the updated ARM template to Azure. Be sure to use the same *storagePrefix* you used before.

    ```azurepowershell
    $templateFile = "azuredeploy.json"
    $today=Get-Date -Format "MM-dd-yyyy"
    $deploymentName="updateTags-"+"$today"
    New-AzResourceGroupDeployment `
      -Name $deploymentName `
      -TemplateFile $templateFile `
      -storagePrefix {your storagePrefix} `
      -storageSKU Standard_LRS
    ```

::: zone-end

### Verify that the new tags are in the deployment

1. In Azure, select the <rgn>[sandbox resource group name]</rgn> resource group and then select the Storage Account you deployed.
1. You see the *Environment:Dev* and *Project:Tutorial* tags.

    :::image type="content" source="../media/7-tags.png" alt-text="Azure portal interface for the Storage Account showing tags of Environment:Dev and Project:Tutorial." border="true":::

## Use a parameter file

Currently, there are three parameters to fill in each time you deploy this template. Each user of the template can create a file to hold their parameter values. Here, you create a parameter file to use with your template.

1. In Visual Studio Code, create another file and call it **azuredeploy.parameters.dev.json**.
1. In this file, you put the values for the template parameters that you would like to have input into the template for the *development* environment. Change a tag value, for example *projectName* to **Learn**, to see that the deployment made a change.

    ```json
    {
      "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
      "contentVersion": "1.0.0.0",
      "parameters": {
        "storagePrefix": {
          "value": "{unique-prefix}"
        },
        "storageSKU": {
          "value": "Standard_LRS"
        },
        "resourceTags": {
          "value": {
            "Environment": "Dev",
            "Project": "Learn"
          }
        }
      }
    }
    ```

1. Be sure to substitute *{unique prefix}* with your unique prefix.
1. Save the file.

## Deploy with the parameter file

Here, you deploy the ARM template specifying what parameter file to use.

::: zone pivot="cli"

1. In the Visual Studio Code terminal, run the following Azure CLI commands.

    ```azurecli
    templateFile="azuredeploy.json"
    devParameterFile="azuredeploy.parameters.dev.json"
    today=$(date +"%d-%b-%Y")
    DeploymentName="addParameterFile-"$today

    az deployment group create \
      --name $DeploymentName \
      --template-file $templateFile \
      --parameters $devParameterFile
    ```

1. Check Azure to see that the deployment was successful and that the tag value changed.

    :::image type="content" source="../media/7-new-tags.png" alt-text="Azure portal interface for the Storage Account showing tags of Environment:Dev and Project:Learn." border="true":::

1. As a challenge, create a parameter file for the *Production* environment and change the parameter file path when you run the command to deploy to the *Production* environment.

::: zone-end

::: zone pivot="powershell"

1. In the Visual Studio Code terminal, run the following Azure PowerShell commands.

    ```azurepowershell
    $templateFile = "azuredeploy.json"
    $parameterFile="azuredeploy.parameters.dev.json"
    $today=Get-Date -Format "MM-dd-yyyy"
    $deploymentName="addParameterFile-"+"$today"
    New-AzResourceGroupDeployment `
      -Name $deploymentName `
      -TemplateFile $templateFile `
      -TemplateParameterFile $parameterFile
    ```

1. Check Azure to see that the deployment was successful and that the tag value changed.

    :::image type="content" source="../media/7-new-tags.png" alt-text="Azure portal interface for the Storage Account showing tags of Environment:Dev and Project:Learn." border="true":::

1. As a challenge, create a parameter file for the *Production* environment and change the parameter file path when you run the command to deploy to the *Production* environment.

::: zone-end
