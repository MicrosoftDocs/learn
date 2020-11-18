Here you will deploy an ARM template, with a copy construct, using PowerShell.

## Exercise overview

Here's an overview of the steps you are about to carry out:

> [!NOTE]
> If you already have a working Sandbox where you've done steps 1-3, then there's no need to repeat them.

1. **Sign in to Azure**. You will be able to sign in using Visual Studio Code and using the integrated terminal.

1. **Set the active subscription**. This task can be accomplished by invoking a PowerShell cmdlet.

1. **Set default resource group**. Also this task can be carried out by invoking a PowerShell cmdlet. The reason for setting these default values on subscription and resource group is to ensure the resources are created in the correct place.

1. **Carry out the deployment**. This step involves using the cmdlet **New-AzResourceGroupDeployment** with a URL to a template as an argument.

## Deploy many resources, of the same type, using the copy construct

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
        "displayName": "[concat(parameters('storageAccountName'), copyIndex())]"
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

1. Run `New-AzResourceGroupDeployment` to deploy the template.

   ```powershell
   $storageAccountName = Read-Host -Prompt "Enter a storage account name"

   New-AzResourceGroupDeployment `
    -TemplateUri "copy.json" `
    -storageAccountName $storageAccountName
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

    Congratulations!
