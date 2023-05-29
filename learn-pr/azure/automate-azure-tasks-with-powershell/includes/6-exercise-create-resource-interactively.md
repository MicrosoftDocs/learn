Recall our original scenario: creating VMs to test our CRM software. When a new build is available, we want to spin up a new VM so we can test the full install experience from a clean image. When we're finished, we want to delete the VM.

Let's try the commands you would use to create a VM.

## Create a Linux VM with Azure PowerShell

Because we're using the Azure sandbox, you won't have to create a resource group. Instead, use the resource group **<rgn>[sandbox resource group name]</rgn>**. In addition, be aware of the location restrictions.

Let's create a new Azure VM with PowerShell.

1. Use the `New-AzVm` cmdlet to create a VM.
    - Use the resource group **<rgn>[sandbox resource group name]</rgn>**.
    - Give the VM a name. Typically, you want to use something meaningful that identifies the purposes of the VM, location, and (if there's more than one) instance number. We'll use "testvm-eus-01" for "Test VM in East US, instance 1". Come up with your own name based on where you'll place the VM.
    - Select a location close to you from the following list, available in the Azure sandbox. Make sure to change the value in the following example command if you're using copy and paste.

        [!include[](../../../includes/azure-sandbox-regions-note.md)]

    - Use "Canonical:0001-com-ubuntu-server-focal:20_04-lts:latest" for the image. This image is Ubuntu Linux.
    - Use the `Get-Credential` cmdlet and feed the results into the `Credential` parameter.
      > [!IMPORTANT]
      > See the [Linux VM FAQ](/azure/virtual-machines/linux/faq#what-are-the-username-requirements-when-creating-a-vm) for username and password limitations. Passwords must be 12 - 123 characters in length, and meet three of the following four complexity requirements:

      > - Have lowercase characters
      > - Have uppercase characters
      > - Have a digit
      > - Have a special character (Regex match [\W_])

    - Add the `-OpenPorts` parameter and pass "22" as the port. This port will let us SSH into the machine.
    - Create a public IP address name. You'll use this name to create and find your static IP address to sign in to the machine.

    ```powershell
    New-AzVm -ResourceGroupName <rgn>[sandbox resource group name]</rgn> -Name "testvm-eus-01" -Credential (Get-Credential) -Location "eastus" -Image Canonical:0001-com-ubuntu-server-focal:20_04-lts:latest -OpenPorts 22 -PublicIpAddressName "testvm-01"
    ```

    [!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

1. Create a username and password, then press `Enter`. PowerShell will start creating your VM.

1. The VM creation takes a few minutes to complete. After completion, you can query it and assign the VM object to a variable (`$vm`).

    ```powershell
    $vm = (Get-AzVM -Name "testvm-eus-01" -ResourceGroupName <rgn>[sandbox resource group name]</rgn>)
    ```

1. Query the value to dump out the information about the VM.

    ```powershell
    $vm
    ```

    You should see something like the following output:

    ```powershell
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
    ```

1. You can reach into complex objects through a dot (".") notation. For example, to see the properties in the `VMSize` object associated with the HardwareProfile section, run the following command:

    ```powershell
    $vm.HardwareProfile
    ```

1. Or, to get information on one of the disks, run the following command:

    ```powershell
    $vm.StorageProfile.OsDisk
    ```

1. You can even pass the VM object into other cmdlets. For example, running the following command will show you all available sizes for your VM:

    ```powershell
    $vm | Get-AzVMSize
    ```

1. Now, run the following command to get your public IP address:

    ```powershell
    Get-AzPublicIpAddress -ResourceGroupName <rgn>[sandbox resource group name]</rgn> -Name "testvm-01"
    ```

1. With the IP address, you can connect to the VM with SSH. For example, if you used the username "bob", and the IP address is "205.22.16.5", running this command would connect to the Linux machine:

    ```powershell
    ssh bob@205.22.16.5
    ```

    Sign out by entering `exit`.

## Delete a VM

To try out some more commands, let's delete the VM. We'll shut it down first:

```powershell
Stop-AzVM -Name $vm.Name -ResourceGroupName $vm.ResourceGroupName
```

Now, let's delete the VM by running the `Remove-AzVM` cmdlet:

```powershell
Remove-AzVM -Name $vm.Name -ResourceGroupName $vm.ResourceGroupName
```

Run this command to list all the resources in your resource group:

```powershell
Get-AzResource -ResourceGroupName $vm.ResourceGroupName | Format-Table
```

You should see a bunch of resources (disks, virtual networks, and so on) that all still exist.

```Output
Microsoft.Compute/disks
Microsoft.Network/networkInterfaces
Microsoft.Network/networkSecurityGroups
Microsoft.Network/publicIPAddresses
Microsoft.Network/virtualNetworks
```

The `Remove-AzVM` command *just deletes the VM*. It doesn't clean up any of the other resources. At this point, we'd likely just delete the resource group itself and be done with it. However, let's run through the exercise to clean it up manually. You should see a pattern in the commands.

1. Delete the network interface:

    ```powershell
    $vm | Remove-AzNetworkInterface –Force
    ```

1. Delete the managed OS disks:

    ```powershell
    Get-AzDisk -ResourceGroupName $vm.ResourceGroupName -DiskName $vm.StorageProfile.OSDisk.Name | Remove-AzDisk -Force
    ```

1. Next, delete the virtual network:

    ```powershell
    Get-AzVirtualNetwork -ResourceGroupName $vm.ResourceGroupName | Remove-AzVirtualNetwork -Force
    ```

1. Delete the network security group:

    ```powershell
    Get-AzNetworkSecurityGroup -ResourceGroupName $vm.ResourceGroupName | Remove-AzNetworkSecurityGroup -Force
    ```

1. And finally, delete the public IP address:

    ```powershell
    Get-AzPublicIpAddress -ResourceGroupName $vm.ResourceGroupName | Remove-AzPublicIpAddress -Force
    ```

We should have caught all the created resources. Check the resource group just to be sure. We performed many manual commands here, but a better approach would have been to write a *script*. Then we could reuse this logic later to create or delete a VM. Let's look at scripting with PowerShell.
