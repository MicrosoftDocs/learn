<!-- markdownlint-disable MD041 -->

In interactive mode, PowerShell allows you to enter and run commands immediately.

In the Customer Relationship Management (CRM) example, the goal is to create three test
environments, each containing virtual machines (VMs). Use resource groups to ensure the VMs are
organized into separate environments:

- Unit testing
- Integration testing
- Acceptance testing

Since you only need to create the resource groups once, using PowerShell interactively for this task
is a reasonable choice.

When you run a command in PowerShell, it matches the command to a cmdlet and performs the requested
action.

## Example: How to create a resource group with Azure PowerShell

Let's perform a common task: creating a resource group. Resource groups help you manage related
resources collectively, and creating a new resource group is often one of the first tasks you
perform when starting a new Azure solution.

Here are the three steps you need to follow:

1. Connect to your Azure subscription.

1. Create the resource group.

1. Verify the resource group was successfully created.

Each step corresponds to a different Azure PowerShell command.

### Connect to Azure

When using a local installation of Azure PowerShell, you must authenticate before executing any
Azure PowerShell commands. The `Connect-AzAccount` cmdlet prompts you for your Azure credentials and
then connects to your Azure subscription.

To connect interactively, you don't need to specify any parameters:

```azurepowershell
Connect-AzAccount
```

This command opens a prompt for your Azure credentials and establishes a connection to your Azure
subscription.

### Work with subscriptions

If you're new to Azure, you only have a single subscription. However, if you've been using Azure for
a while, you might have multiple subscriptions. Azure PowerShell allows you to configure which
subscription your commands are executed against.

You can only be active in one subscription at a time. Use the `Get-AzContext` cmdlet to determine
which subscription is currently active. If it's not the correct one, you can switch subscriptions
using the `Set-AzContext` cmdlet.

1. Get a list of all your subscriptions:

   ```azurepowershell
   Get-AzSubscription
   ```

1. Check the current subscription you're logged into:

   ```azurepowershell
   Get-AzContext
   ```

1. Change your active subscription:

   ```azurepowershell
   Set-AzContext -Subscription '00000000-0000-0000-0000-000000000000'
   ```

   If you need to look up the Subscription ID, you can find it in the output of the
   `Get-AzSubscription` cmdlet.

### Create a resource group

When creating resources in Azure, you place them into a resource group for management purposes.

To create a resource group, use the `New-AzResourceGroup` cmdlet. You must specify a name and a
location, and the name must be unique within your subscription. The location determines where the
metadata for your resource group is stored, which can be important for compliance reasons. Use the
`Get-AzLocation` cmdlet to determine the available locations.

> [!NOTE]
> If you are working in an Azure sandbox, it creates the resource group for you. If you prefer to
> work in your own subscription, use the following command.

The syntax for creating a resource group is:

```azurepowershell
New-AzResourceGroup -Name <resource-group-name> -Location <location>
```

### List all resource groups

To retrieve a list of all resource groups in the active subscription, use the `Get-AzResourceGroup`
cmdlet.

```azurepowershell
Get-AzResourceGroup
```

For a more concise view, you can pipe the output to the `Format-Table` cmdlet:

```azurepowershell
Get-AzResourceGroup | Format-Table
```

You can also filter the output to show only a specific resource group:

```azurepowershell
Get-AzResourceGroup -Name <resource-group-name>
```

### Create an Azure Virtual Machine

Creating virtual machines (VMs) is a common task you can perform with Azure PowerShell.

The `New-AzVM` cmdlet is used to create a VM. This cmdlet has several parameters to handle the
extensive configuration settings for a VM. Most parameters have reasonable default values, so you
typically need to specify only five key items:

- **ResourceGroupName**: The resource group where the new VM is placed.
- **Name**: The name of the VM in Azure.
- **Location**: The geographic region where the VM is provisioned.
- **Credential**: An object containing the username and password for the VM administrator account.
  Use the `Get-Credential` cmdlet to prompt for a username and password and store them as a
  credential object.
- **Image**: The operating system image to use for the VM, typically a Linux distribution or Windows
  Server.

Here's an example:

```azurepowershell
$azVmParams = @{
    ResourceGroupName = '<resource-group-name>'
    Name              = '<machine-name>'
    Credential        = '<credentials-object>'
    Location          = '<location>'
    Image             = '<image-name>'
}
New-AzVM @azVmParams
```

You can supply these parameters as a hash table with splatting for the `New-AzVM` cmdlet, as shown
in the previous example. Alternatively, you could supply the parameters directly to the `New-AzVM`
cmdlet or use other cmdlets to configure the virtual machine, such as `Set-AzVMOperatingSystem`,
`Set-AzVMSourceImage`, `Add-AzVMNetworkInterface`, and `Set-AzVMOSDisk`.

For example, to supply the parameters directly to the `New-AzVM` cmdlet, use the following syntax:

```azurepowershell
New-AzVM -Name <vm-name> -ResourceGroupName <resource-group-name> -Credential (Get-Credential) ...
```

#### Example: Getting information for a VM

You can list the VMs in your subscription using the `Get-AzVM` command. This command also supports
retrieving a specific VM by specifying the **Name** parameter.

Store the results of `Get-AzVM` in a variable:

```azurepowershell
$vm = Get-AzVM -Name <vm-name> -ResourceGroupName <resource-group-name>
```

The contents of the `$vm` variable is an object you can interact with. For example, you can make
changes to this object and then push the changes to Azure using the `Update-AzVM` command:

```azurepowershell
$resourceGroupName = '<resource-group-name>'
$vm = Get-AzVM -Name <vm-name> -ResourceGroupName $resourceGroupName
$vm.HardwareProfile.vmSize = 'Standard_DS3_v2'

Update-AzVM -ResourceGroupName $resourceGroupName -VM $vm
```

Using PowerShell in interactive mode is appropriate for one-off tasks. For example, you can create
and manage resource groups interactively if they're only created once during the lifetime of a
project. Interactive mode is often quicker and easier than writing a script for tasks that are
executed only once.
