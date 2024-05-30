Creating administration scripts is a powerful way to optimize your workflow. You can automate common, repetitive tasks. Once a script is verified, it runs consistently, which likely reduces errors. In the previous exercise, we created a VM, added a data disk, and changed cache settings, all through the Azure portal. What if we needed to repeat these tasks across many VMs, in many regions? We can do that with Azure PowerShell.

> [!TIP]
> We cover Azure PowerShell in detail in the **[Automate Azure Tasks with PowerShell](/training/modules/automate-azure-tasks-with-powershell/)** module. Make sure to check that module out for more details on installing, configuring, and using PowerShell.

## What is Azure PowerShell?

Azure PowerShell is a cross-platform command-line tool to connect to your Azure subscription and manage resources. It's combination of two things: **PowerShell**, which provides the command-line tool support; and the **Az** PowerShell module, which provides the commands (referred to as "cmdlets") to work with Azure.

Azure PowerShell has cmdlets to manipulate most aspects of Azure resources. You can work with resource groups, storage, virtual machines, Microsoft Entra ID, containers, machine learning, and so on. We cover all these details in other training modules.

### PowerShell cmdlets for managing Azure disk caching

Azure PowerShell has specific cmdlets to help manage VMs and disks.

|Command  | Description |
|---------|-------------|
| `Get-AzVM`         | Gets the properties of a virtual machine.       |
| `Update-AzVM`      | Updates the state of an Azure virtual machine.  |
| `New-AzDiskConfig` | Creates a configurable disk object.             |
| `Add-AzVMDataDisk` | Adds a data disk to a virtual machine.          |

With these commands, we can do all the tasks we did in the Azure portal. Let's try it out on our VM.
