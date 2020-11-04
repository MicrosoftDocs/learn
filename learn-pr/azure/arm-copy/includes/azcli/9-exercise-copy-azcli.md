Here you will deploy an ARM template, with a copy construct, using Azure CLI.

## Prerequisites

- **Install Visual Studio Code extension**. This exercise uses the [Azure Resource Manager Tools for Visual Studio Code](https://marketplace.visualstudio.com/items?itemName=msazurermtools.azurerm-vscode-tools?azure-portal=true). Be sure to install this extension in Visual Studio Code.

- **Install latest Azure CLI**. To use what-if in Azure CLI, you must have Azure CLI 2.5.0 or later. If needed, [install the latest version of Azure CLI](https://docs.microsoft.com/cli/azure/install-azure-cli?view=azure-cli-latest&azure-portal=true).

## Exercise overview

Here's an overview of the steps you are about to carry out:

- **Sign in to Azure**. You will be able to sign in using Visual Studio Code and using the integrated terminal.
- **Set the active subscription**. This can be accomplished by invoking a Azure CLI command.
- **Set default resource group**. This can be accomplished by invoking a Azure CLI command. The reason for setting these default values on subscription and resource group is to ensure the resources are created in the correct place.
- **Carry out the deployment**. This step involves using the command **az deployment group create** with a URL to a template as an argument.

## Sign in to Azure

1. Open the integrated terminal in Visual Studio Code. Be sure you are signing in to the same account that activated the sandbox.

1. Run `az login` to login from the Visual Studio Code terminal.

    ```azurecli
    az login
    ```

1. Select an appropriate user in the browser and close browser window when prompted.

   Once you are logged in, you see a list, in JSON format. The list contains subscriptions associated with this account in the terminal, if you activated the sandbox.

## Set the active subscription

Run `az account set` to set a specific subscription as active:

```azurecli
   az account set -s "Concierge Subscription"
```

This will set the active subscription to that of the *Concierge Subscription*.

> [!NOTE]
> if it fails, run `az account list --refresh --all` and then rerun the command

## Set the default resource group

You now need to set the resource group created for you in the sandbox as the default resource group.

1. Run `az group list` to get the resource group name.

   ```azurecli
   az group list -o table
   ```

1. Run `az configure` to set the default name.

   ```azurecli
   az configure --defaults group=<rgn>resource group name</rgn>
   ```

  Use the name of the resource name provided by the last command in this command. (It will look like something like **learn-a73131a1-b618-48b8-af70-21af7ca420c4**). Using the name, will allow you to omit that parameter from the rest of the Azure PowerShell commands in this exercise.

  > [!NOTE]
  > Normally, when you use an Azure CLI command to deploy a template you need to specify the target **resource group** name.  In the exercise in this module we are bypassing this requirement by setting the context of our deployment by specifying our sandbox resource group name in the step below by using the **az configure** Azure CLI command.

## Deploy multiple resources of the same type

Now that you have setup your subscription in the Visual Studio Code (Visual Studio Code) terminal, you are ready to deploy the ARM template to Azure.

1. Create a file `copy.json` and give it the following content:

   ```json
   {
     "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
     "contentVersion": "1.0.0.0",
     "parameters": {
     "storageCount": {
     "type": "int",
       "defaultValue": 1,
       "metadata": {
       "description": "the number of storage accounts being deployed"
     }
    },
    "storageAccountName": {
      "type": "string",
      "defaultValue": "storage",
      "metadata": {
        "description": "the name of the storage account"
      }
    }
   },
   "functions": [],
   "variables": {},
   "resources": [
    {
      "name": "[concat(parameters('storageAccountName'), copyIndex())]",
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
      },
      "copy": {
        "name": "storagecopy",
        "count": "[parameters('storageCount')]"
      }
     }
     ],
     "outputs": {}
   }
   ```

1. Run the command `az deployment group create`:

   ```azurecli
   az deployment group create --template-file "copy.json" \
   --resource-group=<rgn>Sandbox resource group</rgn> \
   --parameters storageAccountName={your chosen storage account name} storageCount=2
   ```

   You will see an output similar to the below:

   ```output
    {- Finished ..
      "id": "/subscriptions/11112222-3333-4444-5555-1111222233334444/resourceGroups/cambridge-resource-group/providers/Microsoft.Resources/deployments/copy",
      "location": null,
      "name": "copy",
      "properties": {
        "correlationId": "ac3d884d-7cb1-4ab6-8c05-447722c43c76",
        "debugSetting": null,
        "dependencies": [],
        "duration": "PT23.4286888S",
        "mode": "Incremental",
        "onErrorDeployment": null,
        "outputResources": [
          {
            "id": "/subscriptions/11112222-3333-4444-5555-1111222233334444/resourceGroups/cambridge-resource-group/providers/Microsoft.Storage/storageAccounts/{ your chosen storage account name }0",
            "resourceGroup": "<rgn>sandbox storage account</rgn>"
          },
          {
            "id": "/subscriptions/11112222-3333-4444-5555-1111222233334444/resourceGroups/cambridge-resource-group/providers/Microsoft.Storage/storageAccounts/{ your chosen storage account name }1",
            "resourceGroup": "<rgn>sandbox storage account</rgn>"
          }
        ],
        "outputs": {},
        "parameters": {
          "storageAccountName": {
            "type": "String",
            "value": "{your chosen storage account name}"
          },
          "storageCount": {
            "type": "Int",
            "value": 2
          }
        },
        "parametersLink": null,
        "providers": [
          {
            "id": null,
            "namespace": "Microsoft.Storage",
            "registrationPolicy": null,
            "registrationState": null,
            "resourceTypes": [
              {
                "aliases": null,
                "apiVersions": null,
                "capabilities": null,
                "locations": [
                  "northeurope"
                ],
                "properties": null,
                "resourceType": "storageAccounts"
              }
            ]
          }
        ],
        "provisioningState": "Succeeded",
        "template": null,
        "templateHash": "7860292668372410844",
        "templateLink": null,
        "timestamp": "2020-10-22T20:30:18.647980+00:00"
      },
      "resourceGroup": "cambridge-resource-group",
      "type": "Microsoft.Resources/deployments"
    }
    ```

    Part of the response above is of particular interest, namely this part:

    ```output
    "outputResources": [
      {
        "id": "/subscriptions/11112222-3333-4444-5555-1111222233334444/resourceGroups/cambridge-resource-group/providers/Microsoft.Storage/storageAccounts/{your storageAccountName}0",
        "resourceGroup": "<rgn>sandbox resource group</rgn>"
      },
      {
        "id": "/subscriptions/11112222-3333-4444-5555-1111222233334444/resourceGroups/cambridge-resource-group/providers/Microsoft.Storage/storageAccounts/{your storage Account name}1",
        "resourceGroup": "<rgn>sandbox resource group</rgn>"
      }
    ]
    ```

    By using the `copy` construct you've managed to create two instances of a storage account. The naming is a combination of the input parameter `storageAccountName` and the index of the loop.
