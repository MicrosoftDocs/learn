We underestimated how big some of the uploads would be and our upload disk is running out of space. You decide to double the space and upgrade it from 64 GB to 128 GB.

## Resize the data disk

To resize a disk, we need the ID or name of the disk. In this case we already know the name (uploadDataDisk1). But in case we didn't remember that, or it was created by someone else we can get a list of disks using the `az disk list` command.

1. Start by getting a list of the managed disks in the resource group; this might include other disks if you have multiple VMs in a single resource group. For our example, there should just be our web server.

    ```azurecli
    az disk list \
        --query '[*].{Name:name,Gb:diskSizeGb,Tier:accountType}' \
        --output table
    ```

1. Next, stop and deallocate the VM using `az vm deallocate`. 

    ```azurecli
    az vm deallocate --name support-web-vm01
    ```
1. Now we can resize the disk with the `az disk update` command.

    ```azurecli
    az disk update --name uploadDataDisk1 --size-gb 128
    ```
    
1. Once the resize operation has completed, restart the VM.

    ```azurecli
    az vm start --name support-web-vm01
    ```

## Expand the disk partition

The final step is to tell the OS about the available space. Just like the partitioning and format steps we did earlier, this process is identical for on-premise disk expansions. 

1. First, get the public IP address of your VM. Since it was rebooted, it has likely changed. Let's try a different approach this time and use `az vm show` with a filter to return the public IP address.

    > [!TIP]
    > IP addresses are dynamic by default. Azure DNS will automatically compensate for the IP change, or you can alter the behavior by using static IP addresses.

    ```azurecli
    az vm show --name support-web-vm01 -d --query [publicIps] --o tsv
    ```
    
1. SSH into the Linux machine. You will need to supply your correct IP address.

    ```bash
    ssh azureuser@40.76.193.249
    ```

1. Unmount the disk. Recall that it was `/dev/sdc1`.

    ```bash
    sudo umount /dev/sdc1
    ```

1. Launch `parted` in an elevated shell

    ```bash
    sudo parted /dev/sdc
    ```
    
1. Expand the partition with the `resizepart` command. Enter partition 1 and the new size (128GB).

    ```bash
    (parted) resizepart
    Partition number? 1
    End?  [64GB]? 128GB
    ```

    > [!WARNING]
    > Be careful about the size. Resizing the partition allows you to shrink a partition too, and that will likely result in data loss.
    
1. Exit the tool by typing `quit`.

1. The partition tool will automatically _remount_ the drive. So unmount it again so we can format it.

    ```bash
    sudo umount /dev/sdc1
    ```
    
1. Verify the partition consistency with `e2fsck`. This step is absolutely necessary but is a good idea any time you are changing sizes on a disk volume.

    ```bash
    sudo e2fsck -f /dev/sdc1
    ```

1. Resize the filesystem with `resize2fs`.

    ```bash
    sudo resize2fs /dev/sdc1
    ```

1. Finally, mount the drive back to the mount point.

    ```bash
    sudo mount /dev/sdc1 /uploads
    ```

To verify the OS disk has been resized, use `df -h`. It should now show that the drive is 128 GB.
