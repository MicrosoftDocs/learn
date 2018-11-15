Let's say you underestimated how large some of the uploaded files would be and that your upload disk is running out of space. You decide to double the space from 64 GB to 128 GB.

Here you'll practice the process you learned about in the previous units.

## Resize the data disk

To resize a disk, you need the ID or name of the disk. In this case, you already know the name, **uploadDataDisk1**. But in case you didn't remember that, or it was created by someone else, you can run `az disk list` to find the name.

1. Run `az disk list` to print the list of the managed disks in the resource group. This list might include other disks if you have multiple VMs in the same resource group.

    ```azurecli
    az disk list \
      --query '[*].{Name:name,Gb:diskSizeGb,Tier:accountType}' \
      --output table
    ```

    You see the disk named **uploadDataDisk1**.

    ```output
    Name                                                        Gb
    ----------------------------------------------------------  ----
    support-web-vm01_OsDisk_1_141859cb21d64b85b9db3f70f0f5e851  30
    uploadDataDisk1                                             64
    ```

1. Run the following `az vm deallocate` command to stop and de-allocate your VM. This does not delete your VM, but puts it in a state where you can modify the virtual disks.

    ```azurecli
    az vm deallocate --name support-web-vm01
    ```

1. Run `az disk update` to resize the disk to 128 GB.

    ```azurecli
    az disk update --name uploadDataDisk1 --size-gb 128
    ```

1. Run `az vm start` to restart the VM.

    ```azurecli
    az vm start --name support-web-vm01
    ```

    But we aren't finished yet. The operating system on the VM cannot use the extra space yet. This is done in the next section.

## Expand the disk partition

The final step is to tell the OS about the available space. Just like the partitioning and format steps you did earlier, this process is identical to the one you'd follow to expand a physical, on-premises, disk.

1. Although you can reserve a fixed public IP address for your VM, by default your VM receives a new public IP address when it is de-allocated and restarted. Run the following `az vm show` command to update your Bash variable with your VM's new public IP address.

    ```azurecli
    ipaddress=$(az vm show --name support-web-vm01 -d --query [publicIps] --o tsv)
    ```

1. As you did earlier, run `lsblk` on your VM over SSH to understand its current state.

    ```bash
    ssh azureuser@$ipaddress lsblk
    ```

    You can see that disk `sdc/sdc1` still has a size of 64 GB.

    ```output
    NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
    sdb      8:16   0   14G  0 disk 
    └─sdb1   8:17   0   14G  0 part /mnt
    sdc      8:32   0  128G  0 disk 
    └─sdc1   8:33   0   64G  0 part /uploads
    sda      8:0    0   30G  0 disk 
    └─sda1   8:1    0   30G  0 part /
    ```

1. Similar to what you did previously to initialize your disk, run this `az vm extension set` command to tell the OS on the VM about the newly available space by executing a pre-made Bash script we create to help you along.

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
    NAME   MAJ:MIN RM   SIZE RO TYPE MOUNTPOINT
    sdb      8:16   0    14G  0 disk 
    └─sdb1   8:17   0    14G  0 part /mnt
    sdc      8:32   0   128G  0 disk 
    └─sdc1   8:33   0 119.2G  0 part /uploads
    sda      8:0    0    30G  0 disk 
    └─sda1   8:1    0    30G  0 part /
    ```

1. As a final verification step, run the operating system's `df` utility on your VM over SSH to prove that the OS can see it correctly.

    ```bash
    ssh azureuser@$ipaddress df -h
    ```

    You see that the drive's size is 128 GB.

    ```output
    Filesystem      Size  Used Avail Use% Mounted on
    udev            3.4G     0  3.4G   0% /dev
    tmpfs           697M  8.6M  689M   2% /run
    /dev/sda1        30G  1.4G   28G   5% /
    tmpfs           3.5G     0  3.5G   0% /dev/shm
    tmpfs           5.0M     0  5.0M   0% /run/lock
    tmpfs           3.5G     0  3.5G   0% /sys/fs/cgroup
    /dev/sdb1        14G   35M   13G   1% /mnt
    /dev/sdc1        63G   52M   60G   1% /uploads
    tmpfs           697M     0  697M   0% /run/user/1000
    ```