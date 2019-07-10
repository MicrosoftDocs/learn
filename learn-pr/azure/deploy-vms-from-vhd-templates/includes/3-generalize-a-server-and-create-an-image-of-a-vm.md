You've learnt about Azure images, how you can use a generalized image to build pre-configured virtual machines, and how you can use a specialized image as a snapshot of a virtual machine at a particular point in time.

In the sample scenario, you need to create generalized images for a variety of virtual machines. Some of these virtual machines will run Windows, while others require Linux.

In this unit, you'll learn how to customize an image, and then generalize this image so you can use it to deploy virtual machines. You can create virtual machines running Windows and Linux, but the tools and techniques to use to build a generalized image vary according to the operating system.

## Generalize a virtual machine

::: zone pivot="windows"

If you're building a Windows image, you can use the **sysprep** utility to prepare a virtual machine for generalization. Sysprep removes server-specific information from the image, such as the hostname, user sign-in information, and logs. Sysprep also removes any machine-specific identifiers used internally by Windows.

> [!IMPORTANT]
> Running **sysprep** is a destructive process, and you cannot easily reverse its effects. Backup your virtual machine first.

To generalize a Windows VM, follow these steps:

- Sign in into the Windows virtual machine.
- Open a command prompt as an administrator.
- Browse to the directory *\windows\system32\sysprep*.
- Run **sysprep.exe**.
- In the System Preparation Tool dialog box, select the following settings, and then click **OK**.

    | Property  | Value  |
    |---|---|
    | System Cleanup Action | Enter System Out-of-Box Experience (OOBE) |
    | Generalize | Check  |
    | Shutdown Options | Shutdown |

    ![Image of the Sysprep dialog box](../media/3-sysprep.png)

After the virtual machine has been shut down, you must deallocate while it's in this *clean* state. If you're using PowerShell, run the following command:

```powershell
Stop-AzVM -ResourceGroupName <resource group> -Name <virtual machine name> -Force
```

If you're running the Azure CLI, use the following command instead:

```azurecli
az vm deallocate \
    --resource-group <resource group> \
    --name <virtual machine name>
```

::: zone-end

::: zone pivot="linux"

If you're building a Linux image, you use the **waagent** tool to prepare a virtual machine for generalization. The **waagent** tool performs a number of tasks, including deleting the most recently created user account, removing public SSH keys, resetting the host name and other machine-specific details, and cleaning log files.

To generalize a Linux virtual machine, sign into the machine, and run the following command:

```bash
waagent -deprovision+user
```

You'll receive a series of warning messages similar to the following (in this example, *azureuser* is the name of the user account created when the virtual machine was built):

```text
WARNING! The waagent service will be stopped.
WARNING! Cached DHCP leases will be deleted.
WARNING! root password will be disabled. You will not be able to login as root.
WARNING! /etc/resolv.conf will be deleted.
WARNING! azureuser account and entire home directory will be deleted.
```

You should then disconnect from the virtual machine:

Finally, you must deallocate and generalize the virtual machine while it's in this *clean* state. If you're using PowerShell, run the following series of commands:

```powershell
Stop-AzVM -ResourceGroupName <resource group> `
    -Name <virtual machine name> `
    -Force

Set-AzVM -ResourceGroupName <resource group> `
    -Name <virtual machine name> `
    -Generalize
```

If you're using the Azure CLI, use the following commands to deallocate and generalize a virtual machine:

```azurecli
az vm deallocate \
    --resource-group <resource group> \
    --name <virtual machine name>

az vm generalize \
    --resource-group <resource group> \
    --name <virtual machine name>
```

::: zone-end

## Create an image from a generalized virtual machine

Once you have generalized the virtual machine, you can create an image. The image will include all of the disks associated with the virtual machine. You can create an image from the generalized virtual machine using the Azure portal, the Azure CLI, or PowerShell.

To create an image in the Azure portal, go to the page for the virtual machine, and select **Capture**:

![Image of the virtual machine page in the Azure portal](../media/3-virtual-machine.png)

On the **Create image** page that follows, give your image a name and specify a resource group in which to store the image. You can optionally remove the virtual machine once the image has been created. Additionally, you can create resilient images that are backed by zone-redundant storage. This feature provides increased availability for your images. You can select **On** for **Zone resiliency** to enable this feature.

![Screenshot of the Create Image page in the Azure portal](../media/3-create-image.png)

> [!IMPORTANT]
> When you create a virtual machine image in this way, the original virtual machine becomes unusable. You cannot restart it. Instead, you must create a new virtual machine from the image, as described later in this unit.

If you're using PowerShell or the Azure CLI, you can create a virtual machine image from a generalized and deallocated virtual machine using the following commands. In both examples, the image will be created in the same resource group as the original virtual machine:

```powershell
# PowerShell

$vm = Get-AzVM -ResourceGroupName <resource group> `
    -Name <generalized virtual machine>

$image = New-AzImageConfig -SourceVirtualMachineId `
    $vm.ID -Location<virtual machine location>

New-AzImage -Image $image `
    -ImageName <image name> `
    -ResourceGroupName <resource group>
```

```azurecli
# Azure CLI

az image create \
    --name <image name> \
    --resource-group <resource group> \
    --source <generalized virtual machine>
```

For more information, visit [Create a managed image of a generalized VM in Azure](https://docs.microsoft.com/azure/virtual-machines/windows/capture-image-resource).

## Create a new virtual machine from a generalized image

You can build a new virtual machine using your generalized image. The simplest way to do this is to use the Azure portal. Go to the page for your image, and select **+ Create VM**. You'll then be prompted for the machine-specific details, such as the virtual machine name, user account, virtual machine size, network ports to open, and so on.

Alternatively, you can use the PowerShell `New-AzVm` command, or the Azure CLI `az vm create` command. The examples below illustrate the syntax:

```powershell
# PowerShell

New-AzVm `
    -ResourceGroupName <resource group> `
    -Name <new virtual machine name> `
    -ImageName <image name> `
    -Location <location of image> `
```

```azurecli
# Azure CLI

az vm create \
    --resource-group <resource group> \
    --name <new virtual machine name> \
    --image <image name> \
    --location <location of image>
```

For more information, see [Create a VM from a managed image](https://docs.microsoft.com/azure/virtual-machines/windows/create-vm-generalized-managed).

## Create a snapshot of a VHD

A virtual machine image contains an image of every VHD in the virtual machine. You can also create separate snapshot images of a VHD at any time. A snapshot is a read-only copy of a VHD. You can use a snapshot to restore a VHD to the state it was in when the snapshot was taken. You can take a set of snapshots of the VHDs for a virtual machine to create a *golden image* of the virtual machine.

> [!IMPORTANT]
> If you taking a golden image of a virtual machine that spans several VHDs, you must ensure that the virtual machine is quiescent, and that you take a snapshot of every VHD. Failure to do this can result in inconsistencies if you need to restore the virtual machine from these snapshots.
> 
> Additionally, don't confuse the snapshots taken for a golden image with those that you can schedule using the virtual machine backup facility. A virtual machine backup is intended to help you recover from a hardware or software failure. A golden image is typically used to provide a set of VHDs from which you can roll out a new set of virtual machines to a given state, or restore a system to a specified state.

Unlike creating an image of a virtual machine, capturing a snapshot of a VHD is a non-destructive process, and you can continue running virtual machines using the VHD afterwards.

To create a snapshot of a VHD using the Azure portal:

- Click **+ Create a resource**, and in the **Search the Marketplace** box enter **Snapshot**.
- On the **Create snapshot** page, provide a name, resource group, and location for the snapshot, and specify the source disk to copy. The source disk must be a managed disk.

  ![Screenshot of the Create Snapshot page in the Azure portal](../media/3-create-snapshot.png)

To create a VHD snapshot with PowerShell, run the following commands. These commands locate the operating system disk for the virtual machine and copy it. If you want to take a snapshot of one of the data disks, replace the **SourceUri** argument in the second command with `$vm.StorageProfile.DataDisks[*n*].ManagedDisk.Id`, where *n* is the data disk number (0 for the first data disk, 1, for the second, and so on):

```powershell
$vm = get-azvm -ResourceGroupName <resource group> `
    -Name <virtual machine name>

$snapshot =  New-AzSnapshotConfig `
    -SourceUri $vm.StorageProfile.OsDisk.ManagedDisk.Id  `
    -Location <virtual machine location> ` 
    -CreateOption copy

New-AzSnapshot -Snapshot $snapshot `
    -SnapshotName <snapshot name> `
    -ResourceGroupName <resource group>
```

If you're using the Azure CLI, you can create a VHD snapshot with the following command. In this example, the named VHD must be in the resource group specified by the `--resource-group` flag:

```azurecli
az snapshot create \
    --resource-group <resource-group> \
    --name <snapshot name> \
    --source <virtual hard disk>
```

After you've created a snapshot, you can export it for safekeeping. In the Azure portal, go to the page for the newly created snapshot, and select Export. You can generate a temporary, secure URL from where you can download the snapshot as a VHD file.

![Screenshot of the Snapshot page in the Azure portal](../media/3-export-snapshot.png)

## Create a virtual machine from VHD snapshots

Rebuilding a virtual machine from a set of VHD snapshots is a two-step process:

1. For each snapshot, create a new managed disk. Specify the snapshot as the source of the managed disk. You can do this in the Azure portal, as shown in the following image:

  ![Screenshot of the Create Manage Disk page in the Azure portal](../media/3-managed-disk.png)

  You can also create a managed disk from a snapshot the Azure CLI with the `az disk create ... --source <snapshot name>` command, or from PowerShell by using the following series of commands:

  ```powershell
  $snapshot = Get-AzSnapshot `
      -ResourceGroupName <snapshot resource group> `
      -SnapshotName <snapshot name>
  
  $diskConfig = New-AzDiskConfig `
      -DiskSizeGB 30 `
      -AccountType Standard_LRS `
      -Location $snapshot.Location `
      -SourceResourceId $snapshot.Id `
      -CreateOption Copy

   New-AzureRmDisk `
      -Disk $diskConfig `
      -ResourceGroupName <managed disk resource group> `
      -DiskName <managed disk name>
  ```

2. Create the new virtual machine using these disks. You can use the PowerShell `New-AzVm` command, or the Azure CLI `az vm create` command for this task. The code snippets below show some examples. These examples assume that you've created three VHDs; one disk containing the operating system (Linux in this case) and two data disks, from snapshots:

  ```powershell
  # PowerShell

  $osdisk = Get-AzDisk `
      -ResourceGroupName <managed disk resource group> `
      -DiskName <operating system disk>

  $datadisk1 = Get-AzDisk `
      -ResourceGroupName <managed disk resource group> `
      -DiskName <data disk 1>

  $datadisk2 = Get-AzDisk `
      -ResourceGroupName <managed disk resource group> `
      -DiskName <data disk 2>

  $vm = New-AzVMConfig `
      -VMName <new virtual machine name> `
      -VMSize <virtual achine size>

  $vm = Set-AzVMOSDisk `
      -CreateOption Attach `
      -VM $vm `
      -ManagedDiskId $osdisk.Id

  $vm = Add-AzVMDataDisk `
    -CreateOption Attach -Lun 0 `
    -VM $vm `
    -ManagedDiskId $datadisk1.Id

  $vm = Add-AzVMDataDisk `
    -CreateOption Attach -Lun 1 `
    -VM $vm `
    -ManagedDiskId $datadisk2.Id

  New-AzVm `
    -VM $vm `
    -ResourceGroupName <resource group> `
    -Location <location of managed disks> `
    <additional network configuration parameters - not shown>
  ```

  ```azurecli
  # Azure CLI

  az vm create \
      --resource-group <resource group> \
      --name <new virtual machine name> \
      --os-type linux \
      --attach-os-disk <operating system disk> \
      --attach-data-disks <data disk 1> \
      --attach-data-disks <data disk 2>
  ```
