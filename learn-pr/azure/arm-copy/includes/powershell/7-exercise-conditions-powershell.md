Here you will deploy an ARM template, with a condition construct, using PowerShell and the Az module.

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

## Conditionally deploy a resource

Now that you have setup your subscription in the Visual Studio Code (Visual Studio Code) terminal, you are ready to deploy the ARM template to Azure.

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

1. Run `New-AzResourceGroupDeployment` to deploy the template.

    ```powershell
    $storageAccountName = Read-Host -Prompt "Enter a storage account name"
    $environment = 'staging'

    New-AzResourceGroupDeployment `
    -TemplateUri "conditionally-deploy.json" `
    -environment $environment `
    -storageAccountName $storageAccountName
    ```

    You'll see the text **Running...** in the terminal. When the command finishes, the results of the above command should be something like the following

    ```powershell
    DeploymentName          : conditionally-deploy
    ResourceGroupName       : learn-2c05151d-0776-4ba4-b522-2543d030b66c
    ProvisioningState       : Succeeded
    Timestamp               : 2020-10-22 4:10:21 p.m.
    Mode                    : Incremental
    TemplateLink            :
                              Uri            : conditionally-deploy.json
                              ContentVersion : 1.0.0.0

    Parameters              :
    Outputs                 :
    DeploymentDebugLogLevel :
    >
   ```

   The above output says the deployment succeeded, but was the resource deployed? Let's verify what actually took place next.

## Verify the deployment

After the deployment has finished you will verify that the `condition` construct has worked as intended. You passed the value `staging` to the `environment` parameter and based on how you formulated the `condition` construct, the resource should not have been deployed.  Let's verify that everything has worked as intended.

1. Run the command `Get-AzStorageAccount`:

   ```powershell
   Get-AzStorageAccount -Name {the name you chose for storage account} -ResourceGroupName <rgn>sandbox resource group</rgn>
   ```

   ```output
   Get-AzStorageAccount: The Resource 'Microsoft.Storage/storageAccounts/{the name you chose for storage account}' under resource group '<rgn>name of resource group</rgn>' was not found. For more details please go to https://aka.ms/ARMResourceNotFoundFix
   ```

   You will see an output similar to the above response. Your resource has not been deployed, your `condition` construct has done its job.

## Deploy the resource

To deploy the resource you need to pass a parameter value to the `environment` variable that ensures the `condition` construct evaluates to true. Let's quickly look at the `condition` construct and remind ourselves what it looks like:

```json
"condition": "[equals(parameters('environment'),'production')]"
```

Based on the statement above, it needs you to pass the value `production`. Let's do a new attempt of deploying, this time with a new value to the `environment` variable.

1. Run the command `New-AzResourceGroupDeployment`

   ```powershell
    $storageAccountName = Read-Host -Prompt "Enter a storage account name"
    $environment = 'prod'

    New-AzResourceGroupDeployment `
     -TemplateUri "conditionally-deploy.json" `
     -environment $environment `
     -storageAccountName $storageAccountName
   ```

1. Run the `Get-AzStorageAccount` in the terminal:

   ```powershell
   Get-AzStorageAccount -Name {the name you chose for storage account} -ResourceGroupName <rgn>sandbox resource group</rgn>
   ```

   This time around you will get a different output. Instead of an error message it shows this table output that shows information about your storage account resource:

   ```output
   StorageAccountName     ResourceGroupName              PrimaryLocation  SkuName        Kind      AccessTier CreationTime        ProvisioningStat
                                                                                                                    e
   ------------------     -----------------              ---------------  -------        ----      ---------- ------------        ----------------
   {your storage account} <rgn>your resource group</rgn> northeurope      Standard_RAGRS StorageV2 Hot        18/01/2020 20:34:35 Succeeded
   ```
