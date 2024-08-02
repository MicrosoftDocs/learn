Azure Virtual Desktop licensing allows you to apply a license to any Windows or Windows Server virtual machine that is registered as a session host in a host pool receiving user connections.

> [!NOTE]
> The license does not apply to virtual machines are running as file share servers or domain controllers.

There are a few ways to use the Azure Virtual Desktop license:

 -  You can create a host pool and its session host virtual machines using the [Azure Marketplace offering](../media/ea72a84e). Virtual machines created this way automatically have the license applied.
 -  You can create a host pool and its session host virtual machines using the [GitHub Azure Resource Manager template](../media/907da5bc). Virtual machines created this way automatically have the license applied.
 -  You can apply a license to an existing session host virtual machine. Follow the instructions in [Create a host pool with PowerShell](../media/bd0ef4a6) to create a host pool and associated virtual machines.

## Apply a Windows license to a session host virtual machine

Run the following PowerShell cmdlet to apply the Windows license:

```PowerShell
$vm = Get-AzVM -ResourceGroup <resourceGroupName> -Name <vmName>
$vm.LicenseType = "Windows_Client"
Update-AzVM -ResourceGroupName <resourceGroupName> -VM $vm



```

## Verify your session host virtual machine is utilizing the licensing benefit

After deploying the virtual machine, run this cmdlet to verify the license type:

```PowerShell
Get-AzVM -ResourceGroupName <resourceGroupName> -Name <vmName>



```

A session host virtual machine with the applied Windows license will show you something like this:

```PowerShell
Type                    : Microsoft.Compute/virtualMachines
Location                : westus
LicenseType              : Windows_Client



```

Virtual machines without the applied Windows license will show you something like this:

```PowerShell
Type                    : Microsoft.Compute/virtualMachines
Location                : westus
LicenseType              :



```

Run the following cmdlet to see a list of all session host virtual machines that have the Windows license applied in your Azure subscription:

```PowerShell
$vms = Get-AzVM
$vms | Where-Object {$_.LicenseType -like "Windows_Client"} | Select-Object ResourceGroupName, Name, LicenseType



```
