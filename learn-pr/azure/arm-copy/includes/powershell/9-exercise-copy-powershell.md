Here you will deploy an ARM template, with a copy construct, using PowerShell.

## Prerequisites

Before installing the required PowerShell module, make sure you have PowerShell Core (6.x or 7.x)

- **Upgrade to/Install latest PowerShell**. If you have Windows PowerShell 5.x or earlier or PowerShell Core 6.2.3 or earlier, [install the latest version of PowerShell](https://docs.microsoft.com/powershell/azure/install-az-ps?view=azps-4.4.0&azure-portal=true) You can't install the required module on Windows PowerShell 5.x or earlier.

- **Install the Az Module**. To use *what-if* in PowerShell, you must have version **4.2 or later of the Az module**.

## Verify installation

Run `$PSVersionTable.PSVersion` to verify the PowerShell version:

```powershell
$PSVersionTable.PSVersion
```

You should see a similar output:

```powershell
Major  Minor  Build  Revision PSSemVerPreReleaseLabel    PSSemVerBuildLabel
7      1      0      -1       preview.5

>
```

## Install or update module

There are potentially two different paths here:

> [!NOTE]
> In order to avoid using PowerShell in an *elevated mode* you can use the argument `-Scope CurrentUser` to install or update modules on your user.

- **You DON'T have the module installed previously**. Install this module use the following command:

   ```powershell
   Install-Module -Name Az -Force -Scope CurrentUser
   ```

- **You need to update a pre-existing module**. If you have an older version of the **Az Module**, and need to update it, use the following command:

   ```powershell
   Update-Module -Name Az -Scope CurrentUser
   ```

## Exercise overview

Here's an overview of the steps you are about to carry out:

- **Sign in to Azure**. You will be able to sign in using Visual Studio Code and using the integrated terminal.
- **Set the active subscription**. This task can be accomplished by invoking a PowerShell cmdlet.
- **Set default resource group**. Also this task can be carried out by invoking a PowerShell cmdlet. The reason for setting these default values on subscription and resource group is to ensure the resources are created in the correct place.
- **Carry out the deployment**. This step involves using the cmdlet **New-AzResourceGroupDeployment** with a URL to a template as an argument.

## Sign in to Azure

You can sign into your Azure account from the terminal. If you are on Windows, the terminal will default to PowerShell. On other OSs, you can use the command line executable `pwsh` to launch a PowerShell shell from the terminal.

1. Open the integrated terminal in Visual Studio Code. Be sure you are signing in to the same account that activated the sandbox.

   > [!IMPORTANT]
   > If you have a non-Windows OS, type `pwsh` to ensure the PowerShell shell is running.

1. Run `Connect-AzAccount` to sign in to your account.

    ```powershell
    Connect-AzAccount
    ```

    (it will open a browser that allows you to sign in to your account)

   Once you are logged in, you see a list, in JSON format. The list contains subscriptions associated with this account in the terminal, if you activated the sandbox.

## Set the active subscription

The command you are about to run will list your subscriptions and their IDs. The subscription ID is the second column.

1. Run `Get-AzSubscription` to get a hold of the subscription ID for the Concierge Subscription.

    ```powershell
    Get-AzSubscription
    ```

    Look for Concierge Subscription and copy the second column. It will look something like *cf49fbbc-217c-4eb6-9eb5-a6a6c68295a0*.

1. Run `Set-AzContext` to change your active subscription to the Concierge Subscription.

   > [!NOTE]
   > Be sure to substitute *{Your subscription ID}* with the ID of the Concierge Subscription you just got in the last command.

    ```powershell
    $subscription = Get-AzSubscription -SubscriptionId {Your subscription ID}
    Set-AzContext $subscription
    ```

### Set default resource group

You need to set the resource group created for you in the sandbox as the default resource group. You will accomplish this task in two steps:

   1. Run `Get-AzResourceGroup` to get the resource group name.

      ```powershell
      Get-AzResourceGroup
      ```

   1. Run `Set-AzDefault` to set the default Resource Group.

      ```powershell
      Set-AzDefault -ResourceGroupName <rgn>resource group name</rgn>
      ```

       Use the name of the resource name provided by the last command in this command. (It will look like something like **learn-a73131a1-b618-48b8-af70-21af7ca420c4**).

      > [!NOTE]
      > Normally, when you use a PowerShell or an Azure CLI command to deploy a template you need to specify the target **resource group** name.  In the exercise in this module we are bypassing this requirement by setting the context of our deployment by specifying our sandbox resource group name in the step below by using the **[Set-AzDefault](https://docs.microsoft.com/powershell/module/az.accounts/set-azdefault?view=azps-4.5.0)** PowerShell command.

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

    Congrats!
