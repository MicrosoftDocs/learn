## Create the ARM template

Here, you create an Azure Resource Manager (ARM) template that defines a storage account resource. The template uses `copy` to create similar versions of the same resource a specified number of times.

1. In Visual Studio Code, create a file named *copy.json* in the same directory that contains *azuredeploy.json*.
1. Add these contents to *copy.json*:

    ```json
    {
      "$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
      "contentVersion": "1.0.0.0",
      "parameters": {
        "storageCount": {
          "type": "int",
          "defaultValue": 1,
          "metadata": {
            "description": "the number of storage accounts copies being deployed"
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

The `storageCount` parameter defines the number of copies to create.

Under `resources`, note the storage account resource. To make the storage account name unique, the template uses `copyIndex()` to append the current index to the storage account name.

The `copy` section reads the number of copies to make from the `storageCount` parameter.

## Deploy the template

Here, you deploy the template as you did previously. The deployment step provisions two similar storage accounts.

1. Create a PowerShell variable that holds the storage account name.

    ```powershell
    $STORAGE_ACCT_NAME="tailwindsa" + (Get-Random -Count 1)
    ```

1. Run the following `New-AzResourceGroupDeployment` command to deploy the template:

    ```powershell
    New-AzResourceGroupDeployment `
    -TemplateFile "./copy.json" `
    -storageAccountName $STORAGE_ACCT_NAME `
    -storageCount 2
    ```

    Here, you set `storageCount` to `2` to provision two storage accounts.

## Verify the deployment

Although the output shows that two storage accounts were created, here you run the `Get-AzResource` command to focus on the output resources.

Run the following `Get-AzResource` command to ensure the resources were deployed:

  ```powershell
  Get-AzResource -Name tailwindsa* -ResourceGroupName <rgn>resource group name</rgn> | Select-Object -Property Name,ResourceId
  ```

The `tailwindsa*` argument specifies to show just the identifiers matching the name prefix you gave the resources.

Your output resembles this:

  ```output
  Name                 ResourceId
  ----                 ----------
  tailwindsa1852777810 /subscriptions/11112222-3333-4444-5555-1111222233334444/resourceGroups/<rgn>resoure group</rgn>/providers/Microsoft.Storage/storageAccount…
  tailwindsa1852777811 /subscriptions/11112222-3333-4444-5555-1111222233334444/resourceGroups/<rgn>resoure group</rgn>/providers/Microsoft.Storage/storageAccount…
  ```

In this example:

* **tailwindsa185277781** is the base name that was generated for the storage account (`"tailwindsa" + Get-Random -Count 1`).
* **tailwindsa1852777810** (the base name plus "0") is the first storage account.
* **tailwindsa1852777811** (the base name plus "1") is the second storage account.

Great work! As your needs change, such as the performance tier you need, you can modify your resource definitions from a single location.

[!include[](../../../../includes/azure-sandbox-cleanup.md)]
