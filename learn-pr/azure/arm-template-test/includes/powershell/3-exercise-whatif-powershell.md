Here you'll deploy an ARM template by using PowerShell and the Az module. After deployment, you'll use the what-if tool to see how a new deployment file might affect the existing deployment.

## Prerequisites

Before you install the required PowerShell module, make sure you have PowerShell Core (6.x or 7.x).

- **Upgrade to or install latest PowerShell version**. If you have Windows PowerShell 5.x or earlier or PowerShell Core 6.2.3 or earlier, [install the latest version of PowerShell](https://docs.microsoft.com/powershell/azure/install-az-ps?view=azps-4.4.0&azure-portal=true) You can't install the required module on Windows PowerShell 5.x or earlier.

- **Install the Az module**. To use what-if in PowerShell, you must have version 4.2 or later of the Az module.

## Verify installation

Run `$PSVersionTable.PSVersion` to verify the PowerShell version:

```powershell
$PSVersionTable.PSVersion
```

The output resembles this:

```powershell
Major  Minor  Patch  PreReleaseLabel BuildLabel
-----  -----  -----  --------------- ----------
7      0      3
```

## Install or update the module

There are potentially two different paths here.

> [!NOTE]
> To avoid using PowerShell in an *elevated mode*, you can use the argument `-Scope CurrentUser` to install or update modules for your user.

- **You didn't install the module previously**. Install this module by using the following command:

   ```powershell
   Install-Module -Name Az -Force -Scope CurrentUser
   ```

- **You need to update a pre-existing module**. If you have an older version of the Az module and you need to update it, use the following command:

   ```powershell
   Update-Module -Name Az -Scope CurrentUser
   ```

## Deploy the first ARM template

Here's an overview of the steps you're about to carry out:

- **Sign in to Azure**. You can sign in by using Visual Studio Code and using the integrated terminal.
- **Set the active subscription**. You can accomplish this task by using a PowerShell cmdlet.
- **Set the default resource group**. You can also accomplish this task by using a PowerShell cmdlet. The reason for setting these default values on a subscription and resource group is to ensure that the resources are created in the correct place.
- **Carry out the deployment**. This step involves using the cmdlet **New-AzResourceGroupDeployment** with a URL to a template as an argument.

## Sign in to Azure

You can sign in to your Azure account from the terminal. If you're on Windows, the terminal will default to PowerShell. On other operating systems, you can use the command-line executable `pwsh` to open a PowerShell shell from the terminal.

1. Open the integrated terminal in Visual Studio Code. Be sure you're signing in to the same account that activated the sandbox.

   > [!IMPORTANT]
   > If you have a non-Windows OS, enter `pwsh` to ensure that the PowerShell shell is running.

1. Run `Connect-AzAccount`.

    ```powershell
    Connect-AzAccount
    ```

    It will open a browser that allows you to sign in to your account.

After you're signed in, you see a list in JSON format. The list contains subscriptions associated with this account in the terminal, if you activated the sandbox.

## Set the active subscription

The command you're about to run will list your subscriptions and their IDs. The subscription ID is the second column.

1. Run `Get-AzSubscription` to get the subscription ID for the Concierge Subscription.

    ```powershell
    Get-AzSubscription
    ```

    Look for the Concierge Subscription and copy the second column. It will look something like **cf49fbbc-217c-4eb6-9eb5-a6a6c68295a0**.

1. Run `Set-AzContext` to change your active subscription to the Concierge Subscription.

   > [!NOTE]
   > Be sure to substitute *{Your subscription ID}* with the ID of the Concierge Subscription that you got in the last command.

    ```powershell
    $subscription = Get-AzSubscription -SubscriptionId {Your subscription ID}
    Set-AzContext $subscription
    ```

### Set the default resource group

You need to set the resource group created for you in the sandbox as the default resource group. You accomplish this task in two steps:

   1. Run `Get-AzResourceGroup` to get the resource group name.

      ```powershell
      Get-AzResourceGroup
      ```

   1. Run `Set-AzDefault` to set the default resource group.

      ```powershell
      Set-AzDefault -ResourceGroupName <rgn>resource group name</rgn>
      ```

      In this command, use the name of the resource name provided by the last command. It will look like something like **learn-a73131a1-b618-48b8-af70-21af7ca420c4**.

      > [!NOTE]
      > Normally, when you use a PowerShell or an Azure CLI command to deploy a template, you need to specify the target *resource group* name. In the exercise in this module, we're bypassing this requirement by setting the context of our deployment by specifying our sandbox resource group name in the next step through the [Set-AzDefault](https://docs.microsoft.com/powershell/module/az.accounts/set-azdefault?view=azps-4.5.0) PowerShell command.

## Deploy the first template to Azure

Now that you've set up your subscription in the Visual Studio Code terminal, you are ready to deploy the ARM template to Azure. The ARM template doesn't have any resources yet, so you won't see any resources being created. However, you'll see a successful deployment.

1. Run `New-AzResourceGroupDeployment` to deploy the template.

    ```powershell
    New-AzResourceGroupDeployment `
    -TemplateUri "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/azure-resource-manager/what-if/what-if-before.json"
    ```

    You'll see the text **Running...** in the terminal. When the command finishes, the results of the preceding command should be something like the following:

    ```powershell
    DeploymentName          : what-if-before
    ResourceGroupName       : learn-2c05151d-0776-4ba4-b522-2543d030b66c
    ProvisioningState       : Succeeded
    Timestamp               : 2020-08-18 4:10:21 p.m.
    Mode                    : Incremental
    TemplateLink            :
                              Uri            : https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/azure-resource-manager/what-if/what-if-before.json
                              ContentVersion : 1.0.0.0

    Parameters              :
    Outputs                 :
    DeploymentDebugLogLevel :


    >
    ```

## Verify the deployment in the portal

To validate that your deployment has been created and sent to Azure, you go to the [Azure portal](https://portal.azure.com?azure-portal=true) and make sure you're in the sandbox subscription:

   1. Select your avatar in the upper corner of the page.
   1. Select **Switch directory**. In the list, select the **Microsoft Learn Sandbox** directory.
   1. Select **Resource groups**.
   1. Select <rgn>[sandbox resource group name]</rgn>.
   1. In **Overview**, you see that one deployment succeeded.
   1. Select **1 Succeeded** to see the details of the deployment.

      :::image type="content" source="../../media/3-portal-deployment-success.png" alt-text="Azure portal interface for the deployments with the one deployment listed and a succeeded status." border="true":::

   1. Select the **what-if-before** deployment to see what resources were deployed. In this case, one virtual network (address space 10.0.0.0/16) with two subnets has been deployed.

      :::image type="content" source="../../media/3-portal-deployment-details.png" alt-text="Azure portal interface for the specific deployment with no resources listed." border="true":::

      :::image type="content" source="../../media/3-portal-deployment-details-2.png" alt-text="Azure portal interface for the specific deployment with one virtual network resource listed." border="true":::

      Leave the page open in your browser. You'll check on deployments again later.

## Deploy the modified template in the same environment

Now that you've deployed the template, you're ready to test the what-if operation. This time, you'll deploy a template that changes the virtual network that you deployed in the first part.

The differences in the second template are:

- **Tag removed**. The original tag was removed.
- **Subnet removed**. A subnet has been removed.
- **Prefix changed**. The address prefix has changed.

Run `New-AzResourceGroupDeployment` with the `-WhatIf` flag to perform the what-if operation.

```powershell
New-AzResourceGroupDeployment `
  -Whatif `
  -TemplateUri "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/azure-resource-manager/what-if/what-if-after.json"
```

The what-if output is similar to:

```output
Note: As What-If is currently in preview, the result may contain false positive predictions (noise).
You can help us improve the accuracy of the result by opening an issue here: https://aka.ms/WhatIfIssues.

Resource and property changes are indicated with these symbols:
  - Delete
  + Create
  ~ Modify
  * Ignore

The deployment will update the following scope:

Scope: /subscriptions/11112222-3333-4444-5555-1111222233334444/resourceGroups/learn-2c05151d-0776-4ba4-b522-2543d030b66c

    ~ Microsoft.Network/virtualNetworks/vnet-001 [2018-10-01]
      - tags.Owner: "Team A"
[
  - 0: "10.0.0.0/16"
  + 0: "10.0.0.0/15"
  ]
[
  - 0:

      name:                     "subnet001"
      properties.addressPrefix: "10.0.0.0/24"

  ]

* Microsoft.Storage/storageAccounts/cloudshell666004860

Resource changes: 1 to modify, 1 to ignore.

>
```

You'll notice that the result is color coded in addition to having a prefix:

- Purple and **~** for any modifications
- Green and **+** for new resources to be created
- Orange and **-** for deletions

## Deploy by using complete mode and the confirmation option

In these next steps, you'll deploy an empty template over your existing environment.

> [!WARNING]
> Doing this in real life *will remove* anything you have in the cloud. The following code is interesting as an intellectual experiment, but be careful about using this mode. At minimum, use the `-Confirm` flag so you can stop this operation if you don't like the proposed changes.

1. Run `New-AzResourceGroupDeployment` with the `-Mode Complete` flag to run the deployment in complete mode:

    ```powershell
    New-AzResourceGroupDeployment `
    -Mode Complete `
    -Confirm `
    -TemplateUri "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/empty-template/azuredeploy.json"
    ```

    The output will be similar to the following text:

    ```powershell
    > New-AzResourceGroupDeployment `
    >> -Mode Complete `
    >> -Confirm `
    >> -TemplateUri "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/empty-template/azuredeploy.json"

    Note: As What-If is currently in preview, the result may contain false positive predictions (noise).
    You can help us improve the accuracy of the result by opening an issue here: https://aka.ms/WhatIfIssues.

    Resource and property changes are indicated with this symbol:
      - Delete

    The deployment will update the following scope:

    Scope: /subscriptions/03821083-c843-496d-b555-65106b80c178/resourceGroups/learn-2c05151d-0776-4ba4-b522-2543d030b66c

      - Microsoft.Network/virtualNetworks/vnet-001

          id:              "/subscriptions/03821083-c843-496d-b555-65106b80c178/resourceGroups/learn-2c05151d-0776-4ba4-b522-2543d030b66c/providers/Microsoft.Network/virtualNetworks/vnet-001"
          location:        "westus"
          name:            "vnet-001"
          tags.CostCenter: "12345"
          tags.Owner:      "Team A"
          type:            "Microsoft.Network/virtualNetworks"

      - Microsoft.Storage/storageAccounts/cloudshell666004860

          id:
    "/subscriptions/03821083-c843-496d-b555-65106b80c178/resourceGroups/learn-2c05151d-0776-4ba4-b522-2543d030b66c/providers/Microsoft.Storage/storageAccounts/cloudshell666004860"
          kind:                   "Storage"
          location:               "eastus"
          name:                   "cloudshell666004860"
          sku.name:               "Standard_GRS"
          sku.tier:               "Standard"
          tags.ms-resource-usage: "azure-cloud-shell"
          tags.x-created-by:      "freelearning"
          type:                   "Microsoft.Storage/storageAccounts"

    Resource changes: 2 to delete.

    Are you sure you want to execute the deployment?
    [Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"):
    ```

1. Enter **A** for **[A] Yes to All**, to execute the deployment and clean out your environment. When the deployment finishes, it will display the following results:

    ```output
    Are you sure you want to execute the deployment?
    [Y] Yes  [A] Yes to All  [N] No  [L] No to All  [S] Suspend  [?] Help (default is "Y"): A

    DeploymentName          : azuredeploy
    ResourceGroupName       : learn-2c05151d-0776-4ba4-b522-2543d030b66c
    ProvisioningState       : Succeeded
    Timestamp               : 2020-08-18 4:23:23 p.m.
    Mode                    : Complete
    TemplateLink            :
                              Uri            : https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/empty-template/azuredeploy.json
                              ContentVersion : 1.0.0.0

    Parameters              :
    Outputs                 :
    DeploymentDebugLogLevel :


    >
    ```

## Verify deployment

Go back to the open browser that you used earlier, and verify that there were two successful deployments:

- The first one that you deployed
- The complete one that removed all resources, so the virtual network is no longer there

:::image type="content" source="../../media/3-portal-deployment-complete-details.png" alt-text="Azure portal interface for the complete deployment with the virtual network resource no longer listed." border="true":::
