In this exercise, you add tags to help organize and track your Microsoft Azure resources. You also use an Azure Resource Manager (ARM) template parameter file to allow for different parameter configurations for each deployment.

This exercise uses the [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools). Be sure to install this extension in Visual Studio Code.

## Create a tag to track the resource deployment environment and project

First, you create a parameter to use as a resource tag in your template.

1. In Visual Studio Code, in the **azuredeploy.json** file, place your cursor after the closing brace for the `storageSKU` parameter. Add a comma and press <kbd>Enter</kbd>.
1. Type **par**. You see a list of related snippets.
1. Select **arm-param**. Remember, this action adds a generic parameter to the template. It looks like this code:

    ```json
    "parameter1": {
        "type": "string",
        "metadata": {
            "description": "description"
        }
    ```

1. Change `parameter1` to **resourceTags** and change the value of ```"type":``` to **object**. Remember that parameters can have string, secureString, int, bool, object, secureObject, and array data types. A link to example syntax for these parameter types is in the summary of this module.
1. Add an attribute called **defaultValue:** and set the value to **{"Environment": "Dev", "Project": "Tutorial"}**.

   The parameter block should look like this code:

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

1. Use this parameter to tag your storage account resource. Change the ```tags:``` attribute in the resource definition:

    ```json
    "tags": "[parameters('resourceTags')]",
    ```

1. Your file should look like this file:

    [!code-json[](code/tags.json?highlight=24-29,40)]

1. Save the file.

## Deploy the ARM template with updated tags

::: zone pivot="cli"

- Deploy the updated ARM template to Azure. Be sure to use the same `storagePrefix` that you used before.

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

- Deploy the updated ARM template to Azure. Be sure to use the same `storagePrefix` that you used before.

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

1. In Azure, select the <rgn>[sandbox resource group name]</rgn> resource group, then select the storage account you deployed.
1. Notice the **Environment : Dev** and **Project : Tutorial** tags:

    :::image type="content" source="../media/7-tags.png" alt-text="Screenshot of the Azure portal that shows the selected tags in the Storage account Overview page." border="true":::

## Use a parameter file

There are currently three parameters to fill in each time you deploy this template. Each user of the template can create a file to hold their parameter values. Here, you create a parameter file to use with your template.

1. In Visual Studio Code, create another file. Call it **azuredeploy.parameters.dev.json**.
1. In this file, you add the values for the template parameters that you want to have input into the template for the development environment. Change a tag value to see that the deployment makes a change. For example, you could change `projectName` to **Learn**:

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

1. Be sure to replace `{unique-prefix}` with your unique prefix.
1. Save the file.

## Deploy the template with the parameter file

In this section, you deploy the ARM template, specifying which parameter file to use.

::: zone pivot="cli"

1. In the Visual Studio Code terminal, run these Azure CLI commands:

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

1. Check Azure to ensure that the deployment was successful and that the tag value changed:

    :::image type="content" source="../media/7-new-tags.png" alt-text="Screenshot of the Azure portal that shows the updated tag values in the Storage account Overview page." border="true":::

1. As a challenge, create a parameter file for the production environment. Change the parameter file path when you run the command to deploy to the production environment.

::: zone-end

::: zone pivot="powershell"

1. In the Visual Studio Code terminal, run these Azure PowerShell commands:

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

1. Check Azure to ensure that the deployment was successful and that the tag value changed:

    :::image type="content" source="../media/7-new-tags.png" alt-text="Screenshot of the Azure portal that shows the updated tag values in the Storage account Overview page." border="true":::

1. As a challenge, create a parameter file for the production environment. Change the parameter file path when you run the command to deploy to the production environment.

::: zone-end
