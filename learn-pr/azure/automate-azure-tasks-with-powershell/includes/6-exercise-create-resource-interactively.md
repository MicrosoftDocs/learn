<!-- markdownlint-disable MD041 -->

In the original scenario, you must create virtual machines (VMs) to test your Customer Relationship
Management (CRM) software. When a new build is available, you want to spin up a new VM to test the
entire installation experience from a clean image. Once testing is complete, you can delete the VM.

Let's try the commands to create a VM.

## Create a Linux VM with Azure PowerShell

Since you're using the Azure sandbox, you don't need to create a resource group. Instead, use the
existing sandbox resource group **<rgn>[sandbox resource group name]</rgn>**. Be aware of the
location restrictions.

Here's how to create a new Azure VM with Azure PowerShell:

1. Use the `New-AzVM` cmdlet to create the VM.
   - Specify the sandbox resource group: **<rgn>[sandbox resource group name]</rgn>**.
   - Name the VM, following your organization's naming standards.
   - Choose a location close to you from the list of available Azure sandbox locations.

     [!include[](../../../includes/azure-sandbox-regions-note.md)]

   - Use the Ubuntu Linux image: `Canonical:0001-com-ubuntu-server-jammy:22_04-lts:latest`.
   - Use the `Get-Credential` cmdlet to set the VM administrator credentials.

   - Add the **OpenPorts** parameter with port `22` for SSH access.
   - Create a public IP address name for SSH sign-in.

   ```azurepowershell
   $azVmParams             = @{
       ResourceGroupName   = '<rgn>[sandbox resource group name]</rgn>'
       Name                = 'testvm-eus-01'
       Credential          = (Get-Credential)
       Location            = 'eastus'
       Image               = 'Canonical:0001-com-ubuntu-server-jammy:22_04-lts:latest'
       OpenPorts           = 22
       PublicIpAddressName = 'testvm-eus-01'
   }
   New-AzVm @azVmParams
   ```

   [!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

1. Enter Credentials:

   When prompted, enter a username and password, following the guidelines: passwords must be 12-123
   characters long and meet three of the following four complexity requirements: lowercase
   characters, uppercase characters, digits, and special characters (Regex match [\W_]). For more
   information, see
   [Linux VM FAQ](/azure/virtual-machines/linux/faq#what-are-the-username-requirements-when-creating-a-vm-).

1. Wait for the VM creation:

   The VM creation process takes a few minutes to finish.

1. Query the VM:

   When complete, query the VM and assign the VM object to a variable (`$vm`).

   ```azurepowershell
   $vm = Get-AzVM -Name testvm-eus-01 -ResourceGroupName <rgn>[sandbox resource group name]</rgn>
   ```

1. View information about the VM:

   To view information about the VM, display the contents of the variable.

   ```powershell
   $vm
   ```

   Example output:

   ```Output
   ResourceGroupName : <rgn>[sandbox resource group name]</rgn>
   Id                : /subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/<rgn>[sandbox resource group name]</rgn>/providers/Microsoft.Compute/virtualMachines/testvm-eus-01
   VmId              : 00000000-0000-0000-0000-000000000000
   Name              : testvm-eus-01
   Type              : Microsoft.Compute/virtualMachines
   Location          : eastus
   Tags              : {}
   HardwareProfile   : {VmSize}
   NetworkProfile    : {NetworkInterfaces}
   OSProfile         : {ComputerName, AdminUsername, LinuxConfiguration, Secrets}
   ProvisioningState : Succeeded
   StorageProfile    : {ImageReference, OsDisk, DataDisks}
   ...
   ```

1. Inspect VM properties:

   You can inspect complex objects through a dot (`.`) notation. For example, to see the properties
   in the `VMSize` object associated with the **HardwareProfile** section, run the following
   command:

   ```azurepowershell
   $vm.HardwareProfile
   ```

   Or, to get information on one of the disks, run the following command:

   ```azurepowershell
   $vm.StorageProfile.OsDisk
   ```

1. Get available VM sizes:

   Pass the VM object into other cmdlets to get available sizes:

   ```azurepowershell
   $vm | Get-AzVMSize
   ```

1. Get the public IP address:

   Retrieve the public IP address to connect to the VM and store it in a variable.

   ```azurepowershell
   $ip = Get-AzPublicIpAddress -ResourceGroupName <rgn>[sandbox resource group name]</rgn> -Name testvm-eus-01
   ```

1. Connect to the VM:

   Connect to the VM with SSH using the IP address from the variable. For example, if the username
   is `bob`, use the following command:

   ```powershell
   ssh bob@$($ip.IpAddress)
   ```

   Sign out by typing <kbd>exit</kbd>.

## Delete a VM

To try more commands, let's delete the VM. Follow these steps:

1. Shut down the VM:

   Run the following command:

   ```azurepowershell
   Stop-AzVM -Name $vm.Name -ResourceGroupName $vm.ResourceGroupName
   ```

    Enter <kbd>Y</kbd> and press <kbd>Enter</kbd> when prompted to continue.

1. Delete the VM:

   Once the VM stops, delete it by running the `Remove-AzVM` cmdlet.

   ```azurepowershell
   Remove-AzVM -Name $vm.Name -ResourceGroupName $vm.ResourceGroupName
   ```

   Enter <kbd>Y</kbd> and press <kbd>Enter</kbd> when prompted to continue.

1. List all resources in the resource group:

   Use the `Get-AzResource` cmdlet to list all the resources in the resource group. The results are
   piped to `Select-Object` to return specific properties:

   ```azurepowershell
   Get-AzResource -ResourceGroupName $vm.ResourceGroupName | 
       Select-Object -Property Name, ResourceType, ResourceGroupName
   ```

   You should see several resources, including disks, virtual networks, etc., that still exist:

   ```Output
   Name                    ResourceType                            ResourceGroupName
   ----                    ------------                            -----------------
   cloudshell              Microsoft.Storage/storageAccounts       <rgn>[sandbox resource group name]</rgn>
   testvm-eus-01           Microsoft.Network/virtualNetworks       <rgn>[sandbox resource group name]</rgn>
   testvm-eus-01           Microsoft.Network/publicIPAddresses     <rgn>[sandbox resource group name]</rgn>
   testvm-eus-01           Microsoft.Network/networkSecurityGroups <rgn>[sandbox resource group name]</rgn>
   testvm-eus-01           Microsoft.Network/networkInterfaces     <rgn>[sandbox resource group name]</rgn>
   testvm-eus-01_OsDisk_1  Microsoft.Compute/disks                 <rgn>[sandbox resource group name]</rgn>
   ```

   The `Remove-AzVM` command only deletes the VM. It doesn't clean up any of the other resources. To
   manually clean them up, follow these steps:

1. Delete the virtual network:

   ```azurepowershell
   Get-AzVirtualNetwork -ResourceGroupName $vm.ResourceGroupName |
       Remove-AzVirtualNetwork
   ```

   Enter <kbd>Y</kbd> and press <kbd>Enter</kbd> when prompted to continue.

1. Delete the public IP address:

   ```azurepowershell
   Get-AzPublicIpAddress -ResourceGroupName $vm.ResourceGroupName |
       Remove-AzPublicIpAddress
   ```

   Enter <kbd>Y</kbd> and press <kbd>Enter</kbd> when prompted to continue.

1. Delete the network security group:

   ```azurepowershell
   Get-AzNetworkSecurityGroup -ResourceGroupName $vm.ResourceGroupName |
       Remove-AzNetworkSecurityGroup
   ```

   Enter <kbd>Y</kbd> and press <kbd>Enter</kbd> when prompted to continue.

1. Delete the network interface:

   ```azurepowershell
   Get-AzNetworkInterface -ResourceGroupName $vm.ResourceGroupName -Name $vm.Name |
       Remove-AzNetworkInterface
   ```

   Enter <kbd>Y</kbd> and press <kbd>Enter</kbd> when prompted to continue.

1. Delete the managed OS disks:

   ```azurepowershell
   Get-AzDisk -ResourceGroupName $vm.ResourceGroupName -DiskName $vm.StorageProfile.OSDisk.Name |
       Remove-AzDisk
   ```

   Enter <kbd>Y</kbd> and press <kbd>Enter</kbd> when prompted to continue.

1. Verify all resources were removed:

   Check the resource group to ensure all resources are removed:

   ```azurepowershell
   Get-AzResource -ResourceGroupName $vm.ResourceGroupName | 
       Select-Object -Property Name, ResourceType, ResourceGroupName
   ```

While you executed these commands interactively, a better approach is to write a PowerShell script.
Scripts allow you to reuse the logic for creating or deleting a VM in the future

Next, let's look at how to automate these tasks using a PowerShell script.
