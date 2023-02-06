
In this exercise you will learn how to use Visual Studio Code, and the Azure Resource Manager  Tools extension, to create and edit Azure Resource Manager templates.

* Create an Azure Resource Manager template
* Add an Azure resource to the template
* Add parameters to the template
* Create a parameter file
* Deploy the template
* Clean up resources

## Prerequisites

* An **Azure account** with an active subscription. If you don't already have one, you can sign up for a free trial at [https://azure.com/free](https://azure.com/free).
* [Visual Studio Code](https://code.visualstudio.com/) with the [Azure Resource Manager  Tools](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools) installed.
* [Azure CLI](/cli/azure/) installed locally

## Create an Azure Resource Manager template

1. Create and open a new file named *azuredeploy.json* with Visual Studio Code. 

1. Enter **arm** in the *azuredeploy.json* file and select **arm!** from the autocomplete options. This will insert a snippet with the basic building blocks for an Azure resource group deployment.

    :::image type="content" source="../media/template-start.png" alt-text="Selecting the arm! snippet from the autocomplete options.":::    

    Your file should contain something similar to the example below.

    ```json
    {
        "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
        "contentVersion": "1.0.0.0",
        "parameters": {},
        "functions": [],
        "variables": {},
        "resources": [],
        "outputs": {}
    }
    ```

## Add an Azure resource to the template

In this section you will add a snippet to support the creation of an Azure storage account to the template.

Place the cursor in the template `resources` block, type in `storage`, and select the **arm-storage** snippet.

:::image type="content" source="../media/template-storage.png" alt-text="Selecting the arm-storage snippet.":::

The `resources` block should look similar to the example below.

```json
"resources": [{
    "name": "storageaccount1",
    "type": "Microsoft.Storage/storageAccounts",
    "apiVersion": "2019-06-01",
    "tags": {
        "displayName": "storageaccount1"
    },
    "location": "[resourceGroup().location]",
    "kind": "StorageV2",
    "sku": {
        "name": "Premium_LRS",
        "tier": "Premium"
    }
}],
```

## Add parameters to the template

Now you will create and use a parameter to specify the storage account name.

Place your cursor in the parameters block, add a carriage return, type `"`, and then select the `new-parameter` snippet. This action adds a generic parameter to the template.

:::image type="content" source="../media/template-parameter.png" alt-text="Selecting the new-parameter snippet.":::

Make the following changes to the new parameter you just added:

1. Update the name of the parameter to `storageAccountName` and the description to `Storage Account Name`.

1. Azure storage account names have a minimum length of 3 characters and a maximum of 24. Add both `minLength` and `maxLength` to the parameter and provide appropriate values.

The `parameters` block should look similar to the example below.

```json
"parameters": {
    "storageAccountName": {
        "type": "string",
        "metadata": {
            "description": "Storage Account Name"
        },
        "minLength": 3,
        "maxLength": 24
    }
},
```

Follow the steps below to update the name property of the storage resource to use the parameter.

1. In the `resources` block, delete the current default name which is `storageaccount1` in the examples above. Leave the quotes (`""`) around the name in place.

1. Enter a square bracket `[`, which produces a list of Azure Resource Manager template functions. Select **parameters** from the list.

1. Add `()` at the end of **parameters** and select **storageAccountName** from the pop-up. If the list of parameters does not show up automatically you can enter a single quote `'` inside of the round brackets to display the list.

The resources block of the template should now be similar to the example below.

```json
"resources": [{
    "name": "[parameters('storageAccountName')]",
    "type": "Microsoft.Storage/storageAccounts",
    "apiVersion": "2019-06-01",
    "tags": {
        "displayName": "storageaccount1"
    },
    "location": "[resourceGroup().location]",
    "kind": "StorageV2",
    "sku": {
        "name": "Premium_LRS",
        "tier": "Premium"
    }
}],
```

## Create a parameter file

An Azure Resource Manager template parameter file allows you to store environment-specific parameter values and pass these values in as a group at deployment time. This is useful if you want to have values specific to a test or production environment, for example. The extension makes it easy to create a parameter file that is mapped to your existing template. Follow the steps below to create a parameter file.

1. With the *azuredeploy.json* file in focus open the **Command Palette**  by selecting **View > Command Palette** from the menu bar.

1. In the **Command Palette** enter "**parameter**" in the search bar and select **Azure Resource Manager Tools:Select/Create Parameter File**.

    :::image type="content" source="../media/template-parameter-file.png" alt-text="Select Azure Resource Manager Tools:Select/Create Parameter File from the Command Palette":::

1. A new dialog box will open at the top of the editor. From those options select **New**, then select **All Parameters**. Accept the default name for the new file.

1. Edit the `value` parameter and type in a name that meets the naming requirements. The *azuredeploy.parameters.json* file should be similar to the example below.

    ```json
    {
        "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentParameters.json#",
        "contentVersion": "1.0.0.0",
        "parameters": {
            "storageAccountName": {
                "value": "az204storageacctarm" 
            }
        }
    }
    ``` 

## Deploy the template

It's time to deploy the template. Follow the steps below, in the VS Code terminal, to connect to Azure and deploy the new storage account resource.

1. Connect to Azure by using the `az login` command.

    ```bash
    az login
    ```

1. Create a resource group to contain the new resource. Replace `<myLocation>` with a region near you.

    ```bash
    az group create --name az204-arm-rg --location <myLocation>
    ```

1. Use the `az deployment group create` command to deploy your template. The deployment will take a few minutes to complete, progress will be shown in the terminal.

    ```bash
    az  deployment group create --resource-group az204-arm-rg --template-file azuredeploy.json --parameters azuredeploy.parameters.json
    ```

1. You can verify the deployment by running the command below. Replace `<myStorageAccount>` with the name you used earlier.

    ```bash
    az storage account show --resource-group az204-arm-rg --name <myStorageAccount>
    ```

## Clean up resources

When the Azure resources are no longer needed use the Azure CLI command below to delete the resource group.

```bash
az group delete --name az204-arm-rg --no-wait
```
