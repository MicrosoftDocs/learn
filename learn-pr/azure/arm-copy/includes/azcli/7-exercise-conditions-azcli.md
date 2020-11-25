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

Now that you have setup your subscription in the Visual Studio Code terminal, you are ready to deploy the ARM template to Azure. The ARM template doesn't have any resources yet, so you won't see any resources being created. However, you'll see a successful deployment.

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
      --template-file "./conditionally-deploy.json" \
      --parameters storageAccountName="tailwindsa$RANDOM" environment="staging"
   ```

## Verify the deployment

After the deployment has finished you will verify that the `condition` construct has worked as intended. You passed the value `staging` to the `environment` parameter and based on how you formulated the `condition` construct, the resource should not have been deployed. Let's verify that everything has worked as intended.

1. BLAH

    ```azurecli
    az deployment group list --output table
    ```

1. BLAH

    ```azurecli
    az deployment group show \
      --name conditionally-deploy
    ```

1. BLAH

    ```azurecli
    STORAGE_ACCT_NAME=$(az deployment group show \
      --name conditionally-deploy \
      --query "properties.parameters.storageAccountName.value" \
      --output tsv)
    ```

1. BLAH

    ```azurecli
    echo $STORAGE_ACCT_NAME
    ```

    ```output
    tailwindsa32115
    ```

1. Run the command `az storage account check-name`

   ```azurecli
   az storage account check-name --name $STORAGE_ACCT_NAME
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

To deploy the resource, you need to pass a parameter value to the `environment` variable that ensures the `condition` construct evaluates to true. Let's quickly look at the `condition` construct and remind ourselves what it looks like:

```json
"condition": "[equals(parameters('environment'),'production')]"
```

Based on the statement above, it needs you to pass the value `production`. Let's do a new attempt of deploying, this time with a new value to the `environment` variable.

1. Run `az deployment group create` to deploy the template:

    ```azurecli
    az deployment group create \
      --template-file "./conditionally-deploy.json" \
      --parameters storageAccountName="$STORAGE_ACCT_NAME" environment="production"
    ```

## Verify the deployment again

1. Run the command `az storage account check-name`

    ```azurecli
    az storage account check-name --name $STORAGE_ACCT_NAME
    ```

   This time around you get different output. Instead of an error message, it indicates that the storage account name is taken, because the reason was created this time:

   ```output
   {
     "message": "The storage account named tailwindsa15817 is already taken.",
     "nameAvailable": false,
     "reason": "AlreadyExists"
   }
   ```

