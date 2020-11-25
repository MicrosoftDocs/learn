Here you will deploy an ARM template, with a copy construct, using Azure CLI.

## Exercise overview

Here's an overview of the steps you are about to carry out:

> [!NOTE]
> If you already have a working Sandbox where you've done steps 1-3, then there's no need to repeat them.

1. **Sign in to Azure**. You will be able to sign in using Visual Studio Code and using the integrated terminal.

1. **Set the active subscription**. This can be accomplished by invoking a Azure CLI command.

1. **Set default resource group**. This can be accomplished by invoking a Azure CLI command. The reason for setting these default values on subscription and resource group is to ensure the resources are created in the correct place.

1. **Carry out the deployment**. This step involves using the command **az deployment group create** with a URL to a template as an argument.

## Deploy multiple resources of the same type

Now that you have setup your subscription in the Visual Studio Code terminal, you are ready to deploy the ARM template to Azure.

1. Create a file named *copy.json* and give it the following content:

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
   az deployment group create \
     --template-file "copy.json" \
     --parameters storageAccountName=tailwindsa$RANDOM storageCount=2
   ```

## Verify the deployment

Although the output shows the 

1. BLAH

    ```azurecli
    az deployment group show \
      --name copy \
      --query "properties.outputResources[].id" \
      --output tsv
    ```

    ```output
    /subscriptions/4b328dc1-56b1-4031-89b0-c0898204f8a5/resourceGroups/<rgn>resource group name</rgn>/providers/Microsoft.Storage/storageAccounts/tailwindsa9820
    /subscriptions/4b328dc1-56b1-4031-89b0-c0898204f8a5/resourceGroups/<rgn>resource group name</rgn>/providers/Microsoft.Storage/storageAccounts/tailwindsa9821
    ```

    By using the `copy` construct you've managed to create two instances of a storage account. The naming is a combination of the input parameter `storageAccountName` and the index of the loop.

    In this example:

    * **tailwindsa982** is the base name that was generated for the storage account (`tailwindsa$RANDOM`).
    * **tailwindsa9820** (the base name plus "0") is the first storage account.
    * **tailwindsa9821** (the base name plus "1") is the second storage account.

[!include[](../../../../includes/azure-sandbox-cleanup.md)]
