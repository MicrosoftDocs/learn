Our law firm is expanding it's case load and you have been tasked with putting up a new Linux web server to store critical documents from a variety of sources - clients, other law firms, and law enforcement offices. Our server can accept uploads and needs to store them on disk.

> [!TIP]
> This exercise uses Linux as the example, but the basic process of creating VMs and adding disks is the same for Windows. The primary difference would be in partitioning and formatting the disk - that would be done in a Remote Desktop session using the built-in Disk Management tools.

The goal of the exercise is to create a Linux virtual machine (VM) and attach a new virtual hard disk (VHD) named "uploadDataDisk1" to store the "uploads" directory.

[!include[](../../../includes/azure-sandbox-activate.md)]

## Create a Linux VM

Let's create a Linux VM to host our web server using the Azure CLI.

1. Start by setting some defaults for this session. The first thing you need to decide is the _location_ to place the VM. Ideally this would be close to your clients. In this case, select the closest region from the locations available to the Azure Sandbox.

    [!include[](../../../includes/azure-sandbox-regions-first-mention-note.md)]

1. Use the `az configure` command to set the default location you want to use. Replace "eastus" with the location.

    ```azurecli
    az configure --defaults location=eastus
    ```

    [!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

1. Set the default resource group value to the pre-configured resource group created for the Azure Sandbox: **<rgn>[Sandbox resource group]</rgn>**

    ```azurecli
    az configure --defaults group="<rgn>[Sandbox Resource Group]</rgn>"
    ```

1. Next, use the `vm create` command to create a new Ubuntu Linux VM.
    - Name it "support-web-vm01".
    - Set the **size** to _Standard_DS2_v2_.
    - Set the **admin-username** to "azureuser" (or whatever you prefer).
    - Generate SSH keys with the `--generate-ssh-keys` parameter.

    ```azurecli
    az vm create --name support-web-vm01 \
        --image UbuntuLTS \
        --size Standard_DS2_v2 \
        --admin-username azureuser \
        --generate-ssh-keys
    ```
    
    > [!TIP]
    > Creating your VM and deploying it in Azure can take a few minutes. You can watch the progress in the Cloud Shell.
    
1. This will result in a JSON block with the details about the created VM.

    ```json
    {
        "fqdns": "",
        "id": "/subscriptions/xxx/resourceGroups/<rgn>[Sandbox resource group]</rgn>/providers/Microsoft.Compute/virtualMachines/support-web-vm01",
        "location": "eastus",
        "macAddress": "00-0D-3A-18-DE-B4",
        "powerState": "VM running",
        "privateIpAddress": "10.0.0.4",
        "publicIpAddress": "40.76.193.249",
        "resourceGroup": "<rgn>[Sandbox resource group]</rgn>",
        "zones": ""
    }
    ```
    Note of the **publicIpAddress** in your output. This is how we can access the VM remotely.

    > [!NOTE]
    > We are using this VM to learn how to manage disks. If we were truly going to use it as a web server, we'd want to open up additional ports with the `az vm open-port` command, and install web server software. These tasks are outside the scope of this module, but you can go through the **Manage virtual machines with the Azure CLI** module to learn how to do these steps. 

## Add an empty data disk to our VM

We're going to name the disk that stores the "uploads" directory for your web server "uploadDataDisk1". 

> [!TIP]
> You can add data disks when the VM is created using the `--data-disk-sizes-gb` parameter on the `vm create` command.

1. Add a new empty disk to the server with the `vm disk attach` command.
    - Name it "uploadDataDisk1"
    - Set it to be 64 GB.
    - Set the **sku** to "_Premium_LRS_" so we use premium storage with local redundancy.

    ```azurecli
    az vm disk attach \
        --vm-name support-web-vm01 \
        --disk uploadDataDisk1 \
        --size-gb 64 \
        --sku Premium_LRS \
        --new
    ```
    
We've now defined a disk named "uploadDataDisk1" . To use the disk, we'll need to partition and format it.

## Initialize data disks

Any additional drives you create from scratch will need to be initialized and formatted. The process for doing this is identical to a physical disk:

1. First, SSH into the Linux server using the public IP address you got back from the original VM creation response. If you don't have that, you can use the following command to get the IP address:

    ```azurecli
    az vm list-ip-addresses -n support-web-vm01
    ```

1. Use SSH with the public IP and the username you created.

    ```bash
    ssh azureuser@40.76.193.249
    ```

1. Next, identify the disk with the `lsblk` command to list all the block devices - here you will see your drives.

    ```bash
    lsblk
    ```

    ```output
    NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
    sdb      8:16   0   14G  0 disk
    └─sdb1   8:17   0   14G  0 part /mnt
    sr0     11:0    1  628K  0 rom
    sdc      8:32   0   64G  0 disk
    sda      8:0    0   30G  0 disk
    └─sda1   8:1    0   30G  0 part /
    ```

Look for the 64 GB drive we created - here you can see it's **sdc** and it's not mounted - this is because it's not been initialized.

1. Once you know the drive (**sdc**) you need to initialize, you can use `fdisk` to do that. You will need to run the command with `sudo` and supply the disk you want to partition:

    ```bash
    sudo fdisk /dev/sdc
    ```

1. Use the <kbd>n</kbd> command to add a new partition. In this example, we also choose <kbd>p</kbd> for a primary partition and accept the rest of the default values. The output will be similar to the following example:   

    ```output
    Device does not contain a recognized partition table.
    Created a new DOS disklabel with disk identifier 0x3b44089f.
    
    Command (m for help): n
    Partition type
       p   primary (0 primary, 0 extended, 4 free)
       e   extended (container for logical partitions)
    Select (default p): p
    Partition number (1-4, default 1): 1
    First sector (2048-268435455, default 2048):
    Last sector, +sectors or +size{K,M,G,T,P} ...
    Created a new partition 1 of type 'Linux' and of size 64 GiB.    
    ```

1. Print the partition table with the <kbd>p</kbd> command. It should look something like this:

    ```output
    Disk /dev/sdc: 64 GiB ...
    Units: sectors of 1 * 512 = 512 bytes
    Sector size (logical/physical): 512 bytes / 4096 bytes
    I/O size (minimum/optimal): 4096 bytes / 4096 bytes
    Disklabel type: dos
    Disk identifier: 0x3b44089f
    
    Device     Boot Start ... Size Id Type
    /dev/sdc1        2048 ... 64G 83 Linux
    ```

1. Write the changes with the <kbd>w<kbd> command. This will exit the tool.

1. Next, we need to write a file system to the partition with the `mkfs` command. We will need to specify the file system type and device name that we got from the `fdisk` output:
    - Pass `-t ext4` to create an _ext4_ filesystem.
    - The device name is `/dev/sdc`.

    ```bash
    sudo mkfs -t ext4 /dev/sdc1
    ```
    
    This command will take a minute or so to complete.

    ```output
    mke2fs 1.42.13 (17-May-2015)
    Discarding device blocks: done
    Creating filesystem with 16777088 4k blocks and 4194304 inodes
    ...
    Allocating group tables: done
    Writing inode tables: done
    Creating journal (32768 blocks): done
    Writing superblocks and filesystem accounting information: done
    ```
    
1. Next, create a directory we will use as our mount point. Let's assume we will have a `uploads` folder:

    ```bash
    sudo mkdir /uploads
    ```
1. Finally, use `mount` to attach the disk to the mount point:

    ```bash
    sudo mount /dev/sdc1 /uploads
    ```
    You should be able to use `lsblk` to see the mounted drive now:
    
    ```output
    NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
    sdb      8:16   0   14G  0 disk
    └─sdb1   8:17   0   14G  0 part /mnt
    sr0     11:0    1  628K  0 rom
    sdc      8:32   0   64G  0 disk
    └─sdc1   8:33   0   64G  0 part /uploads
    sda      8:0    0   30G  0 disk
    └─sda1   8:1    0   30G  0 part /
    ```
    
### Mounting the drive automatically

To ensure that the drive is mounted automatically after a reboot, it must be added to the `/etc/fstab` file. It is also highly recommended that the UUID (universally unique identifier) is used in `/etc/fstab` to refer to the drive rather than just the device name (such as `/dev/sdc1`). If the OS detects a disk error during boot, using the UUID avoids the incorrect disk being mounted to a given location. Remaining data disks would then be assigned those same device IDs. To find the UUID of the new drive, use the `blkid` utility:

```bash
sudo -i blkid
```

It will return something like:

```output
/dev/sda1: UUID="36a59c42-c04c-4632-b83f-7015abd10358" TYPE="ext4"
/dev/sdb1: UUID="21092a62-79d4-4d8c-91de-4dd4e8b97d83" TYPE="ext4"
/dev/sdc1: UUID="e311c905-e0d9-43ab-af63-7f4ee4ef108e" TYPE="ext4"
```

1. Copy the UUID for the `/dev/sdc1` drive and open the `/etc/fstab` file in a text editor:

    ```bash
    sudo vi /etc/fstab
    ```

> [!WARNING]
> Improperly editing the `/etc/fstab` file could result in an unbootable system. If unsure, refer to the distribution's documentation for information on how to properly edit this file. It is also recommended that a backup of the file is created before editing when you are working with production systems.

1. Press <kbd>G</kbd> to move to the last line in the file.

1. Press <kbd>I</kbd> to enter INSERT mode. It should indicate the mode at the bottom of the screen.

1. Press the <kbd>END</kbd> key to move to the end of the line. Alternatively, you can use the arrow keys. Press <kbd>ENTER</kbd> to move to a new line.

1. Type the following line into the editor. The values can be space or tab separated. Check the documentation for more information on each of the columns:

    ```output
    UUID=<uuid-goes-here>    /uploads    ext4    defaults,nofail    1    2
    ```
1. Press **ESC**, then type **:w!** to write the file and **:q** to quit the editor.

1. Finally, let's check to make sure the entry is correct by asking the OS to refresh the mount points:

    ```bash
    sudo mount -a
    ```

    If it returns an error, edit the file to find the problem.

> [!TIP]
> Some Linux kernels support TRIM to discard unused blocks on disks. This feature is available on Azure disks and can save you money if you create large files and then delete them. Learn how to [turn this feature on](https://docs.microsoft.com/azure/virtual-machines/linux/attach-disk-portal#trimunmap-support-for-linux-in-azure) in our documentation.

Now that you've seen how easy it is to add disks to your VMs, let's explore a bit more about the types of disks you might create. In particular the choice between Standard and Premium storage.