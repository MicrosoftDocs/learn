## Create the ARM template

Here, you create an Azure Resource Manager (ARM) template that defines a storage account resource.

The template also defines two parameters:

* `environment`: the name of the current environment.
* `storageAccountName`: the name for the storage account.

`environment` can have one of three values: `dev`, `staging`, or `production`. The condition provisions the storage account only when `environment` equals `production`.

1. In Visual Studio Code, create a file named *condition.json* in the same directory that contains *azuredeploy.json*.
1. Add these contents to *condition.json*:

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
            "description": "a value that represents the current environment"
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

## Provision the Dev environment

Here, you deploy the ARM template to the Dev environment. You do so by setting the `environment` template parameter to `dev`.

Because the condition provisions the storage account only when `environment` equals `production`, you expect the template to not provision the storage account. In other words, you expect a deployment that contains zero resources.

1. Create a Bash variable that holds the storage account name.

    ```bash
    STORAGE_ACCT_NAME=tailwindsa$RANDOM
    ```

    Storage account names must be unique. The `$RANDOM` part ensures that the storage account name ends in a random series of numbers.

1. Run the following `az deployment group create` command to deploy the template to the Dev environment:

    ```azurecli
    az deployment group create \
      --template-file condition.json \
      --parameters storageAccountName=$STORAGE_ACCT_NAME environment=dev
    ```

## Verify the deployment to Dev

Remember, you expect the template to have not provisioned the storage account.

To verify this fact, you run the `az storage account check-name` command to check whether the storage account name is already in use.

Run the following `az storage account check-name` command:

```azurecli
az storage account check-name --name $STORAGE_ACCT_NAME
```

You see this:

```output
{
  "message": null,
  "nameAvailable": true,
  "reason": null
}
```

The value for `nameAvailable` is `true`, which means that the storage account name is still available and hasn't yet been provisioned. You expect this because you haven't yet deployed to the Production environment.

## Provision the Production environment

Here, you deploy the ARM template to the Production environment, similar to how you did for the _Dev_ environment.

As a refresher, here's what the condition looks like in your template:

```json
"condition": "[equals(parameters('environment'),'production')]"
```

To trigger this condition, you set the `environment` template parameter to `production`.

Run the following `az deployment group create` command to deploy the template to the Production environment:

```azurecli
az deployment group create \
  --template-file condition.json \
  --parameters storageAccountName=$STORAGE_ACCT_NAME environment=production
```

## Verify the deployment to Production

This time, you expect the template to have provisioned the storage account. 

To verify this fact, you run the `az storage account check-name` command again to verify that the storage account name is in use.

Run the following `az storage account check-name` command:

```azurecli
az storage account check-name --name $STORAGE_ACCT_NAME
```

Your output resembles this:

```output
{
  "message": "The storage account named tailwindsa32100 is already taken.",
  "nameAvailable": false,
  "reason": "AlreadyExists"
}
```

These values tell you that the storage account has been provisioned as you expect.

Although this is a basic example, you see how to deploy based on a condition.

In practice, your Dev, Staging, and Production environments would contain additional Azure resources to support your compute, networking, and storage needs. Each environment would likely be managed through its own resource group so that it can be provisioned and treated as a single unit.
