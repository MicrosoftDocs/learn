Recall our original scenario - creating VMs to test our CRM software. When a new build is available, we want to spin up a new VM so we can test the full install experience from a clean image. Then when we are finished, we want to delete the VM.

Let's try the commands you would use to create a VM.

## Create a Linux VM with Azure PowerShell

Since we are using the Azure sandbox, you won't have to create a Resource Group. Instead, use the Resource Group **<rgn>[sandbox resource group name]</rgn>**. In addition, be aware of the location restrictions.

Let's create a new Azure VM with PowerShell.

1. Use the `New-AzVm` cmdlet to create a VM.
    - Use the Resource Group **<rgn>[sandbox resource group name]</rgn>**.
    - Give the VM a name. Typically, you want to use something meaningful that identifies the purposes of the VM, location, and (if there is more than one) instance number. We'll use "testvm-eus-01" for "Test VM in East US, instance 1". Come up with your own name based on where you place the VM.
    - Select a location close to you from the following list available in the Azure sandbox. Make sure to change the value in the below example command if you are using copy and paste.

        [!include[](../../../includes/azure-sandbox-regions-note.md)]

    - Use "UbuntuLTS" for the image - this is Ubuntu Linux.
    - Use the `Get-Credential` cmdlet and feed the results into the `Credential` parameter.
      > [!IMPORTANT]
      > Please see the [Linux VM FAQ](https://docs.microsoft.com/azure/virtual-machines/linux/faq#what-are-the-username-requirements-when-creating-a-vm) for username and password limitations. Passwords must be 12 - 123 characters in length and meet 3 out of the following 4 complexity requirements:
      > - Have lower characters
      > - Have upper characters
      > - Have a digit
      > - Have a special character (Regex match [\W_])
    - Add the `-OpenPorts` parameter and pass "22" as the port - this will let us SSH into the machine.

    ```powershell
    New-AzVm -ResourceGroupName <rgn>[sandbox resource group name]</rgn> -Name "testvm-eus-01" -Credential (Get-Credential) -Location "East US" -Image UbuntuLTS -OpenPorts 22
    ```

    [!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

1. This will take a few minutes to complete. Once it does, you can query it and assign the VM object to a variable (`$vm`).

    ```powershell
    $vm = (Get-AzVM -Name "testvm-eus-01" -ResourceGroupName <rgn>[sandbox resource group name]</rgn>)
    ```

1. Then query the value to dump out the information about the VM:

    ```powershell
    $vm
    ```

    You should see something like:

    ```powershell
    ResourceGroupName : <rgn>[sandbox resource group name]</rgn>
    Id                : /subscriptions/xxxxxxxx-xxxx-aaaa-bbbb-cccccccccccc/resourceGroups/<rgn>[sandbox resource group name]</rgn>/providers/Microsoft.Compute/virtualMachines/testvm-eus-01
    VmId              : xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx
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

1. You can reach into complex objects through a dot (".") syntax. For example, to see the properties in the `VMSize` object associated with the HardwareProfile section you can type:

    ```powershell
    $vm.HardwareProfile
    ```

1. Or to get information on one of the disks:

    ```powershell
    $vm.StorageProfile.OsDisk
    ```

1. You can even pass the VM object into other cmdlets. For example, this will retrieve the public IP address of your VM:

    ```powershell
    $vm | Get-AzPublicIpAddress
    ```

1. With the IP address, you can connect to the VM with SSH. For example, if you used the username "bob", and the IP address is "205.22.16.5", then this command would connect to the Linux machine:

    ```powershell
    ssh bob@205.22.16.5
    ```

    Go ahead and log out by typing `exit`.

## Delete a VM

Just to try out some more commands, let's delete the VM. We'll shut it down first.

```powershell
Stop-AzVM -Name $vm.Name -ResourceGroup $vm.ResourceGroupName
```

Now, let's delete the VM with the `Remove-AzVM` cmdlet:

```powershell
Remove-AzVM -Name $vm.Name -ResourceGroup $vm.ResourceGroupName
```

Try this command to list all the resources in your resource group:

```powershell
Get-AzResource -ResourceGroupName $vm.ResourceGroupName | ft
```

You should see a bunch of resources (disks, virtual networks, etc.) that all still exist. 

```output
Microsoft.Compute/disks
Microsoft.Network/networkInterfaces
Microsoft.Network/networkSecurityGroups
Microsoft.Network/publicIPAddresses
Microsoft.Network/virtualNetworks
```

This is because the `Remove-AzVM` command _just deletes the VM_. It doesn't clean up any of the other resources! At this point, we'd likely just delete the Resource Group itself and be done with it. However, let's run through the exercise to clean it up manually. You should see a pattern in the commands.

1. Delete the Network Interface.

    ```powershell
    $vm | Remove-AzNetworkInterface –Force
    ```

1. Delete the managed OS disks and storage account

    ```powershell
    Get-AzDisk -ResourceGroupName $vm.ResourceGroupName -DiskName $vm.StorageProfile.OSDisk.Name | Remove-AzDisk -Force
    ```

1. Next, delete the virtual network.

    ```powershell
    Get-AzVirtualNetwork -ResourceGroup $vm.ResourceGroupName | Remove-AzVirtualNetwork -Force
    ```

1. Delete the network security group.

    ```powershell
    Get-AzNetworkSecurityGroup -ResourceGroup $vm.ResourceGroupName | Remove-AzNetworkSecurityGroup -Force
    ```

1. And finally, the public IP address.

    ```powershell
    Get-AzPublicIpAddress -ResourceGroup $vm.ResourceGroupName | Remove-AzPublicIpAddress -Force
    ```

We should have caught all the created resources; check the resource group just to be sure. We performed many manual commands here but a better approach would have been to write a _script_ so we could reuse this logic later to create or delete a VM. Let's look at scripting with PowerShell.
