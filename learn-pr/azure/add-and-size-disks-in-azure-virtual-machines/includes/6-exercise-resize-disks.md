Let's say you underestimated how large some of the uploaded files are and that your upload disk is running out of space. You decide to double the space from 64 GB to 128 GB.

Here, you practice the process you learned about in the previous units.

## Resize the data disk

To resize a disk, you need the ID or name of the disk. In this case, you already know the name, **uploadDataDisk1**. But in case you didn't, or someone else created the disk, you can run `az disk list` to find the name.

1. Run the `az disk list` command to print the list of the managed disks in the resource group. This list might include other disks if you have multiple VMs in the same resource group.

    ```azurecli
    az disk list \
      --query '[*].{Name:name,Gb:diskSizeGb,Tier:sku.tier}' \
      --output table
    ```

    You see the disk named **uploadDataDisk1**.

    ```output
    Name                                                        Tier
    ----------------------------------------------------------  -------
    support-web-vm01_OsDisk_1_a7c59897dfda42dfab2edf4933e713a6  Premium
    uploadDataDisk1                                             Premium
    ```

1. Run the following `az vm deallocate` command to stop and deallocate your VM. This command doesn't delete your VM, but puts it in a state where you can modify the virtual disks.

    ```azurecli
    az vm deallocate --name support-web-vm01
    ```

1. Run the `az disk update` command to resize the disk to 128 GB.

    ```azurecli
    az disk update --name uploadDataDisk1 --size-gb 128
    ```

1. Run the `az vm start` command to restart the VM.

    ```azurecli
    az vm start --name support-web-vm01
    ```

    But we aren't finished yet. The operating system on the VM can't use the extra space yet. We handle this situation in the next section.

## Expand the disk partition

The final step is to tell the OS about the available space. Just like the partitioning and format steps you did earlier, this process is identical to the one you follow to expand a physical on-premises disk.

1. Although you can reserve a fixed public IP address for your VM, by default your VM receives a new public IP address when the VM is deallocated and restarted. Run the following `az vm show` command to update your Bash variable with your VM's new public IP address.

    ```azurecli
    ipaddress=$(az vm show --name support-web-vm01 -d --query [publicIps] -o tsv)
    ```

1. As you did earlier, run `lsblk` on your VM over SSH to understand its current state.

    ```bash
    ssh azureuser@$ipaddress lsblk
    ```

    You can see that disk `sdc/sdc1` still has a size of 64 GB.

    ```output
    NAME    MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
    sdb       8:16   0    7G  0 disk 
    └─sdb1    8:17   0    7G  0 part /mnt
    sdc       8:32   0  128G  0 disk 
    └─sdc1    8:33   0   64G  0 part /uploads
    sda       8:0    0   30G  0 disk 
    ├─sda14   8:14   0    4M  0 part 
    ├─sda15   8:15   0  106M  0 part /boot/efi
    └─sda1    8:1    0 29.9G  0 part /
    ```

1. Similar to what you did previously to initialize your disk, run the following `az vm extension set` command to tell the OS on the VM about the newly available space by executing a premade Bash script we create to help you along.

    ```azurecli
    az vm extension set \
      --vm-name support-web-vm01 \
      --name customScript \
      --publisher Microsoft.Azure.Extensions \
      --settings '{"fileUris":["https://raw.githubusercontent.com/MicrosoftDocs/mslearn-add-and-size-disks-in-azure-virtual-machines/master/resize-data-disk.sh"]}' \
      --protected-settings '{"commandToExecute": "./resize-data-disk.sh"}'
    ```

    While the command runs, you can [examine the Bash script](https://raw.githubusercontent.com/MicrosoftDocs/mslearn-add-and-size-disks-in-azure-virtual-machines/master/resize-data-disk.sh?azure-portal=true) from a separate browser tab if you'd like.

    To summarize, the script:

    * Unmounts the disk `/dev/sdc1`.
    * Resizes partition 1 to be 128 GB.
    * Verifies partition consistency.
    * Resizes the filesystem.
    * Remounts the drive `/dev/sdc1` back to the mount point `/uploads`.

1. To verify the configuration, run `lsblk` on your VM over SSH a second time.

    ```bash
    ssh azureuser@$ipaddress lsblk
    ```

    This time, you see that disk `sdc/sdc1` is expanded to accommodate the increased size of your disk.

    ```output
    NAME    MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
    sdb       8:16   0     7G  0 disk 
    └─sdb1    8:17   0     7G  0 part /mnt
    sdc       8:32   0   128G  0 disk 
    └─sdc1    8:33   0 119.2G  0 part /uploads
    sda       8:0    0    30G  0 disk 
    ├─sda14   8:14   0     4M  0 part 
    ├─sda15   8:15   0   106M  0 part /boot/efi
    └─sda1    8:1    0  29.9G  0 part /
    ```

1. As a final verification step, run the operating system's `df` utility on your VM over SSH to prove that the OS can see it correctly.

    ```bash
    ssh azureuser@$ipaddress df -h
    ```

    You see that the drive's size is 128 GB.

    ```output
    Filesystem      Size  Used Avail Use% Mounted on
    udev            1.7G     0  1.7G   0% /dev
    tmpfs           345M  9.3M  335M   3% /run
    /dev/sda1        29G  1.9G   28G   7% /
    tmpfs           1.7G     0  1.7G   0% /dev/shm
    tmpfs           5.0M     0  5.0M   0% /run/lock
    tmpfs           1.7G     0  1.7G   0% /sys/fs/cgroup
    /dev/sda15      105M  3.2M  102M   3% /boot/efi
    /dev/sdb1       6.8G   16M  6.4G   1% /mnt
    /dev/sdc1       118G   60M  112G   1% /uploads
    tmpfs           345M     0  345M   0% /run/user/1000
    ```
