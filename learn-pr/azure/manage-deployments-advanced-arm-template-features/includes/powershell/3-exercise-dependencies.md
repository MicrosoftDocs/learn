## Prerequisites

Before installing the required PowerShell module, make sure you have PowerShell Core (6.x or 7.x)

- **Upgrade to/Install latest PowerShell**. If you have Windows PowerShell 5.x or earlier or PowerShell Core 6.2.3 or earlier, [install the latest version of PowerShell](https://docs.microsoft.com/powershell/azure/install-az-ps?view=azps-4.4.0&azure-portal=true) You can't install the required module on Windows PowerShell 5.x or earlier.

- **Install the Az Module**. To use *what-if* in PowerShell, you must have version **4.2 or later of the Az module**.

   > [!NOTE]
   > The Az module is a PowerShell module dedicated to managing cloud resources on Azure. It's needed for the upcoming exercises in this module. 

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

- **You don't have the module installed previously**. Install this module using the following command:

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

You can sign into your Azure account from either the terminal (running `pwsh`), or from Visual Studio Code, using the extension. Below instruction shows how to sign in using the PowerShell extension in Visual Studio Code.

1. In Visual Studio Code, open up the command palette, select **PowerShell: Show integrated console** . Be sure you are signing in to the same account that activated the sandbox.

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

Run `Set-AzDefault` to set the default Resource Group.

```powershell
Set-AzDefault -ResourceGroupName <rgn>resource group name</rgn>
```

> [!NOTE]
> Normally, when you use PowerShell to deploy resource on Azure, you need to specify a resource group. You are bypassing this requirement by setting the context of your deployment, using **Set-AzDefault**.

## Deploy a VM with dependencies

When you deploy a virtual machine, you should be aware that is has quite a few resources that needs to be deployed with it for it to work, it's not just a virtual machine resource.

The following resource types needs to be deployed as you deploy a VM:

- **Microsoft.Storage/storageAccounts**. You will need a storage account.

- **Microsoft.Network/publicIPAddresses**. Your VM will need a public IP.

- **Microsoft.Network/networkSecurityGroups**. A network security group contains rules for handling inbound and outbound traffic to your virtual network.

- **Microsoft.Network/virtualNetworks**. Your VM needs to be placed in a virtual network. This resource has a dependency. It expects the network security group to be deployed before it.

- **Microsoft.Network/networkInterfaces**. This resource depends on two other resources public IP addresses and virtual networks.

- **Microsoft.Compute/virtualMachines**. This is the primary resource you are looking to deploy. It in turn is dependent on two different resources namely a storage account and network interfaces.

Fortunately there's a template you can grab that contains all the above resources.

1. Run `wget` to grab the Azure template file:

   `wget https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-vm-simple-windows/azuredeploy.json`

   and save it to a local file `azuredeploy.json`

1. Run the command `New-AzResourceGroupDeployment`:

    ```powershell
    $location = Read-Host -Prompt "Enter a location (i.e. centralus)"
    $vmName = Read-Host -Prompt "Enter a name for your VM"
    $adminUsername = Read-Host -Prompt "Enter an admin user name";
    $adminPassword = Read-Host -Prompt "Enter an admin password";

    New-AzResourceGroupDeployment `
    -ResourceGroupName <rgn>resource group name</rgn> `
    -TemplateFile "./azuredeploy.json" `
    -adminUsername $adminUsername `
    -vmName $vmName `
    -adminPassword $adminPassword
    ```

### Verify deployment

1. Go to the [Azure portal](https://portal.azure.com/learn.docs.microsoft.com?azure-portal=true).
1. Select **Resource groups** > **\<rgn>your resource group\</rgn>** > **{what you named the VM}**.
1. Select **Connect** at the top.

1. Select **Download RDP File**, and then follow the instructions to sign in to the virtual machine by using the password that you used upon deployment.

Congratulations, you've managed to deploy a VM containing dependencies.
