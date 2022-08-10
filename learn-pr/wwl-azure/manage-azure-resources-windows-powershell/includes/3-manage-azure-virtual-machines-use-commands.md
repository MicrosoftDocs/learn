Besides using Windows PowerShell to create new Azure VMs, you can also use PowerShell commands to manage, modify, and remove Azure VMs and the resources related to Azure VMs. This topic covers some of the most common tasks for managing and modifying Azure VMs with PowerShell.

## Modifying VM sizes

The VM size determines the amount of compute resources such as CPU, GPU, and memory that are made available to the VM. You should create VMs using a VM size that's appropriate for the workload. If a workload increases, you can also resize existing VMs.

To review a list of VM sizes available in a particular region, use the **Get-AzVMSize** command. For example:

```powershell
Get-AzVMSize -Location "EastUS"
```

After a VM has been deployed, you can resize it to increase or decrease resource allocation. Before resizing a VM, check if the size you want is available on the current VM cluster. The **Get-AzVMSize** command returns a list of sizes:

```powershell
Get-AzVMSize -ResourceGroupName "myResourceGroup" -VMName "myVM"
```

If your preferred size is available, you can resize the VM from a powered-on state; however, it's rebooted during the operation. The following example depicts how to change VM size to the **Standard_DS3_v2** size profile:

```powershell
$vm = Get-AzVM -ResourceGroupName "myResourceGroupVM" -VMName "myVM"
$vm.HardwareProfile.VmSize = "Standard_DS3_v2"
Update-AzVM -VM $vm -ResourceGroupName "myResourceGroup"
```

## Management tasks

During the lifecycle of a VM, you might want to run management tasks such as starting, stopping, or deleting a VM. Additionally, you might want to create scripts to automate repetitive or complex tasks. You can use Azure PowerShell to perform many common management tasks by using the command line or scripts.

To stop and deallocate a VM with **Stop-AzVM**, you can run the following command:

  ```powershell
  Stop-AzVM -ResourceGroupName "myResourceGroup" -Name "myVM" -Force
  ```

To start a VM, you can run the following command:

  ```powershell
  Start-AzVM -ResourceGroupName "myResourceGroup" -Name "myVM"
  ```

If you want to delete everything inside of a resource group, including VMs, you can run the following command:

  ```powershell
  Remove-AzResourceGroup -Name "myResourceGroupVM" -Force
  ```

## Adding disks to Azure VMs

When you create an Azure VM, two disks are automatically attached to the VM:

- Operating system disk. These disks can be sized up to 4 terabytes and host the VM's operating system.
- Temporary disk. These disks use a solid-state drive that's located on the same Azure host as the VM. Temporary disks are highly performant and might be used for operations such as temporary data processing.

You can add additional data disks for installing applications and storing data. You should use data disks in any situation that requires durable and responsive data storage. The size of the VM determines how many data disks can be attached to it.

To add a data disk to an Azure VM after you create it, you need to define disk configuration by using the **New-AzDiskConfig** command. You then need to use the **New-AzDisk** and **Add-AzVMDataDisk** commands to add a new disk to the VM, as the following example depicts:

```powershell
$diskConfig = New-AzDiskConfig -Location "EastUS" -CreateOption Empty -DiskSizeGB 128
$dataDisk = New-AzDisk -ResourceGroupName "myResourceGroupDisk" -DiskName "myDataDisk" -Disk $diskConfig

$vm = Get-AzVM -ResourceGroupName "myResourceGroupDisk" -Name "myVM"
$vm = Add-AzVMDataDisk -VM $vm -Name "myDataDisk" -CreateOption Attach -ManagedDiskId $dataDisk.Id -Lun 1

Update-AzVM -ResourceGroupName "myResourceGroupDisk" -VM $vm

```
