Azure stores your VHD images as page blobs in an Azure Storage account. With managed disks, Azure takes care of managing the storage on your behalf - it's one of the best reasons to choose managed disks.

When you create the VM, it chooses a size for the OS disk. The specific size is based on the image you select. On Linux, it's often around 30 GB, and on Windows about 127 GB.

You can add data disks to provide for additional storage space, but you may also wish to expand an existing disk - perhaps a legacy application cannot split its data across drives, or you are migrating a physical PC's drive to Azure and need a larger OS drive.

> [!NOTE]
> You can only resize a disk to a _larger_ size. Shrinking managed disks is not supported today.

Changing the size of the disk can also change the level of the disk (for example from P10 to P20). Keep this in mind - this can be beneficial for performance upgrades, but will also cost more as you move up the premium tiers.

## VM size vs. Disk size

The VM size you choose when you create your VM will determine how many resources it can allocate. For storage, the size will control the number of disks you can add to the VM and the max size of each disk. 

As mentioned in the previous unit, some VM sizes only support Standard storage drives - limiting the I/O performance.

If you find that you need more storage than what your VM size allows for, you can change the VM size. We cover that topic in the **Introduction to Azure Virtual Machines** module.

## Expanding a disk using the Azure CLI

> [!WARNING]
> Always make sure that you back up your data before performing disk resize operations!

Operations on VHDs cannot be performed with the VM running. The first step is to stop and deallocate the VM with `az vm deallocate` supplying the VM name and resource group name.

Deallocating a VM, unlike just _stopping_ a VM releases the associated computing resources and allows Azure to make configuration changes to the virtualized hardware.

```azurecli
az vm deallocate --resource-group <resource-group-name> --name <vm-name>
```

Next, to resize a disk, you use `az disk update`, passing the disk name, resource group name, and newly requested size. When you expand a managed disk, the specified size is mapped to the nearest managed disk size.

```azurecli
az disk update \
    --resource-group <resource-group-name> \
    --name <disk-name> \
    --size-gb 200
```

Finally, you start the VM again with `az vm start`:

```azurecli
az vm start --resource-group <resource-group-name> --name <vm-name>
```

## Expanding a disk using the Azure portal

Expanding a disk using the Azure portal is even easier.

1. Stop the VM using the **Stop** button in the toolbar on the **Overview** view of the VM.

1. Click **Disks** in the **Settings** section.

1. Select the data disk you want to resize.

    ![Screenshot showing the disks section of a VM with the VHD we want to edit highlighted](../media/5-portal-disks.png)

1. In the disk details, type a size _larger_ than the current size. You can also change from Premium to Standard (or vice-versa) here. These settings will adjust your performance as shown in the predicted IOPS section.

    ![Screenshot showing the VHD edit screen with the new size field highlighted](../media/5-resize-disk.png)

1. Click **Save** to save the changes.

1. Restart the VM.


### Expanding the partition

Just like adding a new data disk, an expanded disk won't add any usable space until you expand the partition and filesystem. This must be done using the OS tools available to the VM. 

On Windows, we would use the Disk Manager tool or the `diskpart` command line tool.

On Linux, you will use `parted` and `resize2fs`.

Let's try out some of these commands.