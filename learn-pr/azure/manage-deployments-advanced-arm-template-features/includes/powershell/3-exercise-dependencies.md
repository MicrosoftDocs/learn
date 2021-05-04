## Setup

Here, you open Visual Studio Code, create a PowerShell session, and connect to the Azure subscription that's provided by the free Azure sandbox environment.

You need to perform these setup tasks one time during this module. You can refer back to these steps if you sign out or become disconnected in a later exercise.

### Open PowerShell in Visual Studio Code

1. Open Visual Studio Code.
1. Open a terminal window by using the **Terminal** menu.

1. If the drop-down menu on the right of the terminal window shows **pwsh**, you have the right shell to work from, and you can skip to the next section.

   :::image type="content" source="../../media/vscode-pwsh.png" alt-text="Screenshot of Terminal window, terminal type.":::

1. If not, select the drop-down and choose **Select Default Shell**.

1. Select **pwsh**.

   :::image type="content" source="../../media/vscode-select-shell.png" alt-text="Screenshot that shows selecting a shell from the drop-down menu.":::

1. Select the **+** in the terminal to create a new terminal with _pwsh_ as the shell.

### Sign in to Azure

1. Run `Connect-AzAccount` to sign in to your account.

    ```azurepowershell
    Connect-AzAccount
    ```

    A browser window appears.

1. Select the account that you used to activate the sandbox, and close the browser window when prompted.

### Set the active subscription

1. Run `Get-AzSubscription` to get the subscription ID for the sandbox environment.

    ```azurepowershell
    Get-AzSubscription
    ```

    Look for `Concierge Subscription`, and copy the second column. It will look something like **cf49fbbc-217c-4eb6-9eb5-a6a6c68295a0**.

1. Run `Set-AzContext` to change your active subscription to the Concierge Subscription.

   > [!NOTE]
   > Be sure to substitute *{Your subscription ID}* with the ID of the Concierge Subscription you just got in the last command.

    ```azurepowershell
    $subscription = Get-AzSubscription -SubscriptionId {Your subscription ID}
    Set-AzContext $subscription
    ```

### Set default resource group

Normally, when you run an Azure CLI command, you need to specify a resource group.

The sandbox provides a default resource group for you. To make the Azure CLI commands that follow easier to run, here you set the default resource group.

Run the `Set-AzDefault` cmdlet to set the default resource group.

```powershell
Set-AzDefault -ResourceGroupName <rgn>resource group name</rgn>
```

> [!NOTE]
> Normally, when you use PowerShell to deploy resource on Azure, you need to specify a resource group. You're bypassing this requirement by setting the context of your deployment, using `Set-AzDefault`.

## What's in a typical VM deployment

When you deploy a VM, keep in mind that there are several resources that need to be deployed along with it in order for the VM to work.

Here's a brief summary of the types of resources that typically need to be deployed along with a VM:

- **Microsoft.Storage/storageAccounts**. A storage account provides disk space for the operating system and files.
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

1. Run the `ConvertTo-SecureString` cmdlet, and assign the results to a PowerShell variable named `$secure`:

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

    The command can take a few minutes to run. While the command runs, you can [examine the ARM template](https://raw.githubusercontent.com/Azure/azure-quickstart-templates/master/101-vm-simple-linux/azuredeploy.json?azure-portal=true) from a separate browser tab if you'd like.

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

## Verify the deployment

Verify that the VM is provisioned and is connectable over SSH. To do so:
  
1. Run the `Invoke-Expression` command to connect to the VM over SSH:

   ```powershell
   Invoke-Expression (Get-AzResourceGroupDeployment -Name azuredeploy -ResourceGroupName <rgn>your resource group</rgn>).outputs.sshCommand.value
   ```

   When prompted, enter `yes` to continue connecting. Then enter the administrator password, `insecurepassword123!`.

    > [!IMPORTANT]
    > In practice, keep passwords safe. You can also use public key authentication, which is typically more secure than using passwords.

1. From your SSH connection to the VM, run `hostname` to print the VM's hostname:

    ```bash
    hostname
    ```

    You see the VM's internal hostname, `vm1`:

    ```output
    vm1
    ```

1. Run `exit` to leave your SSH session.

    ```bash
    exit
    ```

Congratulations, you've successfully deployed a Linux VM by using an ARM template. A VM is a common resource type that includes dependent resources.
