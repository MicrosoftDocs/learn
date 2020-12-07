## Create the ARM template

Here, you create an ARM template that defines a storage account resource.

The template also defines two parameters:

* `environment`: the name of the current environment.
* `storageAccountName`: the name for the storage account.

`environment` can have one of three values: "dev", "staging", or "production". The condition provisions the storage account only when `environment` equals "production".

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

Here you will deploy an ARM template, with a condition construct, using PowerShell and the Az module.

## Provision the Dev environment

Here, you deploy the ARM template to the _Dev_ environment. You do so by setting the `environment` template parameter to "dev".

Because the condition provisions the storage account only when `environment` equals "production", you expect the template to not provision the storage account. In other words, you expect a deployment that contains zero resources.

1. Create a PowerShell variable that holds the storage account name.

    ```PowerShell
    $STORAGE_ACCT_NAME="tailwindsa"+ (Get-Random -COUNT 1 -Maximum 9999999 ))
    ```

    Storage account names must be unique. The `Get-Random` part ensures that the storage account name ends in a random series of numbers.

1. Run the following `New-AzResourceGroupDeployment` command to deploy the template to the _Dev_ environment:

    ```powershell
    New-AzResourceGroupDeployment `
      -TemplateFile "./condition.json" `
      -storageAccountName $STORAGE_ACCT_NAME `
      -environment dev
    ```

## Verify the deployment to Dev

Remember, you expect the template to have not provisioned the storage account.

To verify this fact, you run the `Get-AzStorageAccount` command to check whether the storage account name is already in use.

1. Run the command `Get-AzStorageAccount`:

   ```powershell
   Get-AzStorageAccount -Name $STORAGE_ACCT_NAME -ResourceGroupName <rgn>sandbox resource group</rgn>
   ```

   You will see an output similar to the below response. Your resource has not been deployed, your `condition` construct has done its job:

   ```output
   Get-AzStorageAccount: The Resource 'Microsoft.Storage/storageAccounts/{the name you chose for storage account}' under resource group '<rgn>name of resource group</rgn>' was not found. For more details please go to https://aka.ms/ARMResourceNotFoundFix
   ```

## Provision the Production environment

Here, you deploy the ARM template to the _Production_ environment, similar to how you did for the _Dev_ environment.

As a refresher, here's what the condition looks like in your template:

```json
"condition": "[equals(parameters('environment'),'production')]"
```

To trigger this condition, you set the `environment` template parameter to "production".

Run the following `New-AzResourceGroupDeployment` command to deploy the template to the _Production_ environment:

```powershell
New-AzResourceGroupDeployment `
  -TemplateFile "./condition.json" `
  -storageAccountName $STORAGE_ACCT_NAME `
  -environment production
```

## Verify the deployment to Production

This time, you expect the template to have provisioned the storage account.

To verify this fact, you run the `Get-AzStorageAccount` command again to verify that the storage account name is in use.

1. Run the following `Get-AzStorageAccount` command:

   ```powershell
   Get-AzStorageAccount -Name $STORAGE_ACCT_NAME -ResourceGroupName <rgn>sandbox resource group</rgn>
   ```

   This time around you will get a different output. Instead of an error message it shows this table output that shows information about your storage account resource:

   Your output resembles this:

   ```output
   StorageAccountName     ResourceGroupName              PrimaryLocation  SkuName        Kind      AccessTier CreationTime        ProvisioningStat
                                                                                                                    e
   ------------------     -----------------              ---------------  -------        ----      ---------- ------------        ----------------
   {your storage account} <rgn>your resource group</rgn> northeurope      Standard_RAGRS StorageV2 Hot        18/01/2020 20:34:35 Succeeded
   ```
  
   These values tell you that the storage account has been provisioned as you expect.

Although this is a basic example, you see how to deploy based on a condition.

In practice, your _Dev_, _Staging_, and _Production_ environments would contain additional Azure resources to support your compute, networking, and storage needs. Each environment would likely be managed through its own resource group so that it can be provisioned and treated as a single unit.
