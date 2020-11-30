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

## What's in a typical VM deployment

When you deploy a VM, keep in mind that there are several resources that need to be deployed along with it in order for the VM to work.

Here's a brief summary of the types of resources that typically need to be deployed along with a VM:

- **Microsoft.Storage/storageAccounts**. A storage account provides disk space for the OS and files.
- **Microsoft.Network/publicIPAddresses**. A public IP address enables you to connect to the VM from the internet.
- **Microsoft.Network/networkSecurityGroups**. A network security group contains rules for handling inbound and outbound traffic to your virtual network.
- **Microsoft.Network/virtualNetworks**. Your VM needs to be placed in a virtual network. This resource requires the network security group to be deployed before it.
- **Microsoft.Network/networkInterfaces**. This resource depends on two other resources: the public IP address and the virtual network.
- **Microsoft.Compute/virtualMachines**. The virtual machine is the primary resource you want to deploy. It's dependent on two different resources: the storage account and the network interfaces.

## Deploy a Linux VM

Here, you download an ARM template from a GitHub repository that we provide for you. The template provisions a Linux VM and all of the resources necessary to run it.

1. Run the following `curl` command to download the ARM template:

    ```bash
    curl -O 'https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-vm-simple-linux/azuredeploy.json'
    ```

1. Run the command `ConvertTo-SecureString` and assign the results to a PowerShell variable `$secure`:

   ```powershell
    $secure = "insecurepassword123!" | ConvertTo-SecureString -AsPlainText -Force
   ```

   Now you have an encrypted version of your password that you can pass the deployment script next.

1. Run the command `New-AzResourceGroupDeployment` to deploy the template:

    ```powershell
    New-AzResourceGroupDeployment `
    -TemplateFile "./azuredeploy.json" `
    -adminUsername "azureuser" `
    -vmName "vm1" `
    -adminPasswordOrKey $secure
    ```

    The command can take a few minutes to run. While the command runs, you can [examine the Bash script](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-vm-simple-linux/azuredeploy.json?azure-portal=true) from a separate browser tab if you'd like.

    Note the resource dependencies by searching for the `dependsOn` key. For example, the virtual machine resource depends on the network interface:

    ```json
    "type": "Microsoft.Compute/virtualMachines",
    "apiVersion": "2020-06-01",
    "name": "[parameters('vmName')]",
    "location": "[parameters('location')]",
    "dependsOn": [
      "[resourceId('Microsoft.Network/networkInterfaces/', variables('networkInterfaceName'))]"
    ],
    ```

## Verify deployment

Verify that the VM is provisioned and is connectable over SSH. To do so:

1. Run the following command PowerShell query:

   ```powershell
   invoke-expression (Get-AzResourceGroupDeployment -Name azuredeploy -ResourceGroupName <rgn>your resource group</rgn>).outputs.sshCommand.value
   ```

   Your output is similar to:

   ```output
   ssh azureuser@simplelinuxvm-a33zb3sc332ue.westus.cloudapp.azure.com
   ```
  
1. Run the SSH command from the previous step:

   ```bash
   ssh azureuser@simplelinuxvm-a33zb3sc332ue.westus.cloudapp.azure.com
   ```

   When prompted, enter *yes* to continue connecting. Then enter the administrator password, *insecurepassword123!*.

    > [!IMPORTANT]
    > In practice, keep passwords safe. Or use public key authentication, which is typically more secure than using passwords.

1. From your SSH connection to the VM, run `hostname` to print the VM's hostname:

    ```bash
    hostname
    ```

    You see the VM's internal hostname, *vm1*:

    ```output
    vm1
    ```

1. Run `exit` to leave your SSH session.

    ```bash
    exit
    ```

Congratulations, you've successfully deployed a Linux VM by using an ARM template. A VM is a common resource type that includes dependent resources.
