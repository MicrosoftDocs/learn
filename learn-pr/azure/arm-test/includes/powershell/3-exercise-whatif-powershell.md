> [!NOTE]
> The first time you activate a sandbox and accept the terms, your Microsoft account is associated with a new Azure directory named Microsoft Learn Sandbox. You're added to a special subscription named Concierge Subscription.

Here you will deploy an ARM template using PowerShell and the Az module. You will after deployment use the *what-if* tool to see what how a new deployment file could affect the existing deployment.

## Prerequisites

Before installing the required PowerShell module, make sure you have PowerShell Core (6.x or 7.x)

- **Upgrade to/Install latest PowerShell**. If you have Windows PowerShell 5.x or earlier or PowerShell Core 6.2.3 or earlier, [install the latest version of PowerShell](https://docs.microsoft.com/powershell/azure/install-az-ps?view=azps-4.4.0) You can't install the required module on Windows PowerShell 5.x or earlier.

- **Install the Az Module**. To use *what-if* in PowerShell, you must have version **4.2 or later of the Az module**.

### Verify installation

To verify the PowerShell version you can use the following command in a PowerShell session:

```powershell
(Get-Host).Version
```

You should see a similar output:

```powershell
> (Get-Host).Version

Major  Minor  Build  Revision PSSemVerPreReleaseLabel    PSSemVerBuildLabel
-----  -----  -----  -------- -----------------------    ------------------
7      1      0      -1       preview.5

>
```

### Install/Update module

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

## Deploy the first ARM Template

You will be able to deploy your ARM Template by carrying out the following steps:

1. **Sign in to Azure**. You will be able to sign in using Visual Studio Code and using the integrated terminal.
1. **Set the active subscription**. This task can be accomplished by invoking a PowerShell cmdlet.
1. **Set default resource group**. Also this task can be carried out by invoking a PowerShell cmdlet. The reason for setting these default values on subscription and resource group is to ensure the resources are created in the correct place.
1. **Carry out the deployment**. This step involves using the cmdlet **New-AzResourceGroupDeployment** with a URL to a template as an argument.

### Sign in to Azure

You can sign into your Azure account from the terminal. If you are on Windows, the terminal will default to PowerShell. On other OSs, you can use the command line executable `pwsh` to launch a PowerShell shell from the terminal.

1. **Open the integrated terminal in Visual Studio Code**. Be sure you are signing in to the same account that activated the sandbox.
    1. If you have a non-Windows OS, type `pwsh` to ensure the PowerShell shell is running.

1. **Sign in to Azure**. Run the following command (it will open a browser that allows you to sign in to your account).

    ```powershell
    Connect-AzAccount
    ```

   Once logged in, you see a list of the subscriptions associated with this account in the terminal, if you activated the sandbox.

### Set the active subscription

1. **Get the subscription ID**. The command will list your subscriptions and their IDs. The subscription ID is the second column. Look for Concierge Subscription and copy the second column. It will look something like *cf49fbbc-217c-4eb6-9eb5-a6a6c68295a0*.

    ```powershell
    Get-AzSubscription
    ```

1. **Change your active subscription to the Concierge Subscription**. Be sure to substitute *{Your subscription ID}* with the ID of the Concierge Subscription you just got in the last command.

    ```powershell
    $subscription = Get-AzSubscription -SubscriptionId {Your subscription ID}
    Set-AzContext $subscription
    ```

### Set default resource group

1. **Set the default resource group**. You need to set the resource group created for you in the sandbox as the default resource group. You will accomplish this task in two steps:

   1. **Get the resource group name**. Type the following command.

      ```powershell
      Get-AzResourceGroup
      ```

   1. **Set the default name**. Use the name of the resource name provided by the last command in this command. (It will look like something like **learn-a73131a1-b618-48b8-af70-21af7ca420c4**).

      ```powershell
      Set-AzDefault -ResourceGroupName {Resource Group Name}
      ```

      > [!NOTE]
      > Normally, when you use a PowerShell or an Azure CLI command to deploy a template you need to specify the target **resource group** name.  In the exercise in this module we are bypassing this requirement by setting the context of our deployment by specifying our sandbox resource group name in the step below by using the **[Set-AzDefault](https://docs.microsoft.com/powershell/module/az.accounts/set-azdefault?view=azps-4.5.0)** Powershell command.

### Deploy the first template to Azure

Now that you have setup your subscription in the Visual Studio Code (Visual Studio Code) terminal, you are ready to deploy the ARM template to Azure. The ARM template doesn't have any resources yet, so you won't see any resources being created. However, you'll see a successful deployment.

1. **Deploy the template**. Use the following PowerShell AZ module commands in the terminal.

    ```powershell
    New-AzResourceGroupDeployment `
    -TemplateUri "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/azure-resource-manager/what-if/what-if-before.json"
    ```

    You'll see the text **Running...** in the terminal. When the command finishes, the results of the above command should be something like the following

    ```powershell
    > New-AzResourceGroupDeployment `
    >> -TemplateUri "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/azure-resource-manager/what-if/what-if-before.json"

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

1. **Verify the deployment in the portal**. To validate that your deployment has been created and sent to Azure you can navigate to the Azure portal, [Azure portal](https://portal.azure.com?azure-portal=true), make sure you are in the sandbox subscription.

   1. Select your avatar in the upper right corner of the page.
   1. Choose **Switch directory**. In the list, choose the **Microsoft Learn Sandbox** directory.
   1. On the left side panel, choose *Resource groups*.
   1. Select <rgn>[sandbox resource group name]</rgn>.
   1. In the *Overview*, you see one deployment succeeded.
   1. Select *1 Succeeded* to see the details of the deployment.

   :::image type="content" source="../../media/3-portal-deployment-success.png" alt-text="Azure portal interface for the deployments with the one deployment listed and a succeeded status." border="true":::

1. **Inspect deployment details**. Click the *what-if-before* deployment to see what resources were deployed. In this case, one VNet (address space 10.0.0.0/16) with two subnets have been deployed.

   :::image type="content" source="../../media/3-portal-deployment-details.png" alt-text="Azure portal interface for the specific deployment with no resources listed." border="true":::

   :::image type="content" source="../../media/3-portal-deployment-details-2.png" alt-text="Azure portal interface for the specific deployment with VNet resource listed." border="true":::

Leave the page open in your browser. You will check on deployments again later.

## Deploy the modified template in the same environment

Now that you've deployed the template, you're ready to test the *what-if* operation. This time you will deploy a template that changes the virtual network you deployed in un the first part.

The differences in the second template are:

- **Tag removed**. The original tag was removed.
- **Subnet removed**. A subnet has been removed.
- **Prefix changed**. Address prefix has changed.

1. **Perform the *what-if* operation**. Use the following PowerShell command, note how you are calling the same cmdlet when deploying but you use *-Whatif* as an argument.

    ```powershell
    New-AzResourceGroupDeployment `
      -Whatif `
      -TemplateUri "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/azure-resource-manager/what-if/what-if-after.json"
    ```

    The what-if output appears similar to:

    ```powershell
    > New-AzResourceGroupDeployment `
    >>   -Whatif `
    >>   -TemplateUri "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/azure-resource-manager/what-if/what-if-after.json"

    Note: As What-If is currently in preview, the result may contain false positive predictions (noise).
    You can help us improve the accuracy of the result by opening an issue here: https://aka.ms/WhatIfIssues.

    Resource and property changes are indicated with these symbols:
      - Delete
      + Create
      ~ Modify
      * Ignore

    The deployment will update the following scope:

    Scope: /subscriptions/03821083-c843-496d-b555-65106b80c178/resourceGroups/learn-2c05151d-0776-4ba4-b522-2543d030b66c

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

   You'll notice that the result is color coded in addition to a "prefix"

      - Purple and "~" for any modifications
      - Green and "+" for new resources to be created
      - Orange and "-" for deletion.

## Deploy using the Complete mode and confirmation option

In these next steps, you will deploy an empty template over your existing environment.

1. **Run the deployment in complete mode**. Type the following PowerShell command:

    ```powershell
    New-AzResourceGroupDeployment `
    -Mode Complete `
    -Confirm `
    -TemplateUri "https://raw.githubusercontent.com/Azure/azure-docs-json-samples/master/empty-template/azuredeploy.json"
    ```

    The output will be similar to the below.

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

1. **Confirm deployment**. Type **A** for "[A] Yes to All", to execute and clean out your environment. Once it completes, it will display the following results:

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

1. **Verify deployment**. Navigate back to the open browser you used earlier, and verify that there were two successful deployments.

    - The first one you deployed.
    - The complete one that removed all resources, and the VNet is no longer there.

   :::image type="content" source="../../media/3-portal-deployment-complete-details.png" alt-text="Azure portal interface for the complete deployment with VNet resource no longer listed." border="true":::
