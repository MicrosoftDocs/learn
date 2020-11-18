Here you will deploy an ARM template, with a condition construct, using Azure CLI.

## Exercise overview

Here's an overview of the steps you are about to carry out:

> [!NOTE]
> If you already have a working Sandbox where you've done steps 1-3, then there's no need to repeat them.

1. **Sign in to Azure**. You will be able to sign in using Visual Studio Code and using the integrated terminal.

1. **Set the active subscription**. This can be accomplished by invoking a Azure CLI command.

1. **Set default resource group**. This can be accomplished by invoking a Azure CLI command. The reason for setting these default values on subscription and resource group is to ensure the resources are created in the correct place.

1. **Carry out the deployment**. This step involves using the command **az deployment group create** with a URL to a template as an argument.

## Conditionally deploy a resource

Now that you have setup your subscription in the Visual Studio Code (Visual Studio Code) terminal, you are ready to deploy the ARM template to Azure. The ARM template doesn't have any resources yet, so you won't see any resources being created. However, you'll see a successful deployment.

1. Create a file `conditionally-deploy.json` and give it the following content:

   ```json
   {
     "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
     "contentVersion": "1.0.0.0",
     "parameters": {
     "environment": {
       "type": "string",
       "defaultValue": "dev",
       "allowedValues": [
         "dev",
         "staging",
         "production"
       ],
       "metadata": {
         "description": "a value that represents the different environments"
       }
     },
     "storageAccountName": {
       "type": "string",
       "metadata": {
         "description": "a name for the account"
       }
     }
    },
    "functions": [],
    "variables": {},
   "resources": [
     {
      "condition": "[equals(parameters('environment'),'production')]",
      "name": "[parameters('storageAccountName')]",
      "type": "Microsoft.Storage/storageAccounts",
      "apiVersion": "2019-06-01",
      "tags": {
        "displayName": "[parameters('storageAccountName')]"
      },
      "location": "[resourceGroup().location]",
      "kind": "StorageV2",
      "sku": {
        "name": "Premium_LRS",
        "tier": "Premium"
      }
     }
   ],
   "outputs": {}
   }
   ```

   In the above template you have two parameters `environment` and `storageAccountName`. `environment` is used in the `condition` construct and `storageAccountName` is something you need to provide at deploy time.

1. Run `az deployment group create` to deploy the template:

   ```azurecli
   az deployment group create \
      --template-uri "conditionally-deploy.json" \
      --parameters storageAccountName={type a name environment=staging
   ```

   The terminal output will show ```Running...```. When that finishes, the results of the above command will be something similar to the below output:

   ```output
   {
      "id": "/subscriptions/00000000-1111-2222-333-4444444444444/resourceGroups/learn-2c05151d-0776-4ba4-b522-2543d030b66c/providers/Microsoft.Resources/deployments/conditional-deployment",
      "location": null,
      "name": "what-if-before",
      "properties": {
        "correlationId": "26078ea9-518b-43f7-923c-dd8cbf7d1f0e",
        "debugSetting": null,
        "dependencies": [],
        "duration": "PT10.5969509S",
        "mode": "Incremental",
        "onErrorDeployment": null,
            "id": "/subscriptions/00000000-1111-2222-3333-444455556666777/resourceGroups/learn-2c05151d-0776-4ba4-b522-2543d030b66c/providers/Microsoft.Network/virtualNetworks/vnet-001",
            "resourceGroup": "learn-2c05151d-0776-4ba4-b522-2543d030b66c"
          }
        ],
        "outputs": null,
        "parameters": {},
        "parametersLink": null,
        "providers": [
          {
            "id": null,
            "namespace": "Microsoft.Network",
            "registrationPolicy": null,
            "registrationState": null,
            "resourceTypes": [
              {
                "aliases": null,
                "apiVersions": null,
                "capabilities": null,
                "locations": [
                  "westus"
                ],
                "properties": null,
                "resourceType": "virtualNetworks"
              }
            ]
          }
        ],
        "provisioningState": "Succeeded",
        "template": null,
        "templateHash": "1122925147183376254",
        "templateLink": {
          "contentVersion": "1.0.0.0",
          "uri": "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/azure-resource-manager/what-if/what-if-before.json"
        },
        "timestamp": "2020-08-18T17:21:40.064344+00:00"
      },
      "resourceGroup": "learn-2c05151d-0776-4ba4-b522-2543d030b66c",
      "type": "Microsoft.Resources/deployments"
   }
   ```

  The above output says the deployment succeeded, but was the resource deployed? Let's verify what actually took place next.

## Verify the deployment

After the deployment has finished you will verify that the `condition` construct has worked as intended. You passed the value `staging` to the `environment` parameter and based on how you formulated the `condition` construct, the resource should not have been deployed.  Let's verify that everything has worked as intended.

1. Run the command `az storage account check-name`

   ```azurecli
    az storage account check-name --name {chosen name for storage account}
   ```

   ```output
   {
     "message": null,
     "nameAvailable": true,
     "reason": null
   }
   ```

   You will see an output similar to the above response. Part of the message states **"nameAvailable": true**, the name should not be available if it managed to create a storage account. Your resource has therefore not been deployed, your `condition` construct has done its job.

## Deploy the resource

To deploy the resource you need to pass a parameter value to the `environment` variable that ensures the `condition` construct evaluates to true. Let's quickly look at the `condition` construct and remind ourselves what it looks like:

```json
"condition": "[equals(parameters('environment'),'production')]"
```

Based on the statement above, it needs you to pass the value `production`. Let's do a new attempt of deploying, this time with a new value to the `environment` variable.

1. Run `az deployment group create` to deploy the template:

   ```azurecli
   az deployment group create \
      --template-uri "conditionally-deploy.json"
      --storageAccountName={type a name}
      --environment=prod
   ```

1. Run the command `az storage account check-name`

   ```azurecli
    az storage account check-name --name {chosen name for storage account}
   ```

   This time around you will get a different output. Instead of an error message it indicates that the storage account name is taken, because the reason was created this time:

   ```output
   {
     "message": "The storage account named {name of your storage account} is already taken.",
     "nameAvailable": false,
     "reason": "AlreadyExists"
   }
   ```
