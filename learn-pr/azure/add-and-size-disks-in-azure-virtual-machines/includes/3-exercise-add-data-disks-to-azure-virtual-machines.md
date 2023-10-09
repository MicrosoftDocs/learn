Your law firm is expanding its case load, and you've been tasked with creating a new Linux web server to store critical documents from a variety of sources: clients, other law firms, and law-enforcement offices. The web server lets you upload documents and store them on disk.

> [!TIP]
> This exercise uses Linux as the example, but the basic process of creating VMs and adding disks is the same for Windows. The primary difference would be in partitioning and formatting the disk. On Windows, you can connect to your VM over Remote Desktop and use the built-in Disk Management tools or deploy a PowerShell script that's similar to the Bash script you'll use here.

Your goal here is to create a Linux VM and attach a new virtual hard disk (VHD) named **uploadDataDisk1** to store the `/uploads` directory.

## Set Azure CLI default values

The Azure CLI lets you set default values so you don't have to repeat them each time you run a command.

You'll specify the default Azure location, or region. This is the location where your Azure VM will be placed.

Ideally, this location would be close to your clients. In this case, select the closest region to you from the locations available to the Azure sandbox.

[!include[](../../../includes/azure-sandbox-regions-first-mention-note.md)]

1. Run `az configure` to set the default location you want to use. Replace **eastus** with the location chosen in the step above.

    ```azurecli
    az configure --defaults location=eastus
    ```

    [!include[](../../../includes/azure-cloudshell-copy-paste-tip.md)]

1. Set the default resource group name to the pre-configured resource group created for you through the Azure sandbox: **<rgn>[sandbox resource group]</rgn>**

    ```azurecli
    az configure --defaults group="<rgn>[sandbox Resource Group]</rgn>"
    ```

## Create a Linux VM

Here, you'll create a Linux VM to host your web server.

1. Run this `az vm create` command to create an Ubuntu Linux VM.

    ```azurecli
    az vm create \
      --name support-web-vm01 \
      --image Canonical:UbuntuServer:16.04-LTS:latest \
      --size Standard_DS1_v2 \
      --admin-username azureuser \
      --generate-ssh-keys
    ```

    * The VM's name is **support-web-vm01**.
    * Its size is **Standard_DS1_v2**.
    * The admin username is **azureuser**. In practice, this name can be whatever you like.
    * The `--generate-ssh-keys` argument generates an SSH keypair for you, allowing you to connect to your VM over SSH.

    The VM takes a few minutes to deploy. When the VM is ready, you see information about it in JSON format. Here's an example:

    ```json
    {
      "fqdns": "",
      "id": "/subscriptions/00000000-0000-0000-0000-000000000000/resourceGroups/680469d8-edB7-42ec-b118-cd80d51741e7/providers/Microsoft.Compute/virtualMachines/support-web-vm01",
      "location": "eastus",
      "macAddress": "00-0D-3A-10-63-0A",
      "powerState": "VM running",
      "privateIpAddress": "10.0.0.4",
      "publicIpAddress": "104.211.38.211",
      "resourceGroup": "680469d8-edB7-42ec-b118-cd80d51741e7",
      "zones": ""
    }
    ```

    > [!NOTE]
    > In this lesson, you're using this VM to learn how to manage disks. In practice, you might also install web server and other software and then run `az vm open-port` to make the ports you need available to the outside world.

## Add an empty data disk to your VM

Here, you'll create an empty data disk and attach it to your VM. Your data disk will initially be 64 GB in size. Later, you'll mount this disk to the `/uploads` directory on your VM.

> [!TIP]
> For learning purposes, you're creating the VM and data disk as separate steps. In practice, you can specify the `--data-disk-sizes-gb` argument to the `az vm create` command to add data disks when the VM is created.

1. Run the following `az vm disk attach` command to add a new empty disk to the VM.

    ```azurecli
    az vm disk attach \
      --vm-name support-web-vm01 \
      --name uploadDataDisk1 \
      --size-gb 64 \
      --sku Premium_LRS \
      --new
    ```

    This command:

    * Names the disk **uploadDataDisk1**.
    * Sets its size to be 64 GB.
    * Specifies to use premium storage with local redundancy.

To use the disk, you'll need to partition and format it. You'll do that next.

## Initialize and format your data disk

Your empty data drive needs to be initialized and formatted. The process to do that is the same as for a physical disk.

For one-time tasks, you might manually connect to your VM over SSH and run the commands you need. To make the process more repeatable and less error-prone, you can use a Bash script (or a PowerShell script where available) that specifies the commands you need.

Using a script to automate the process has an added benefit: your script serves as documentation for how the process is performed. Others can read your script to understand how the system is configured. If you need to change the process, you can simply modify your script and test it on a temporary scratch VM before you deploy your change to production.

To automate the process in this lesson, you'll use the *Custom Script Extension*. The Custom Script Extension is an easy way to download and run scripts on your Azure VMs. It's just one of the many ways you can configure the system after your VM is up and running.

You can store your scripts in Azure storage, or in a public location such as GitHub. You can run scripts manually or as part of a more automated deployment. Here, you'll run an Azure CLI command to download a pre-made Bash script from GitHub and execute it on your VM.

For learning purposes, here you'll also run a few commands on your VM to verify that the VM is configured as you expect.

1. Run `az vm show` to get your VM's public IP address and save the IP address as a Bash variable.

    ```azurecli
    ipaddress=$(az vm show \
      --name support-web-vm01 \
      --show-details \
      --query [publicIps] \
      --output tsv)
    ```

1. Run the following `ssh` command to run the `lsblk` command on your VM over an SSH connection using the `ipaddress` variable data you just created. Recall that `azureuser` was the admin username we used when we created the VM. If you chose a different name, use that instead. Enter "yes" when prompted.

    ```bash
    ssh azureuser@$ipaddress lsblk
    ```

    The output of this command should look like the following.

    ```output
    NAME   MAJ:MIN RM  SIZE RO TYPE MOUNTPOINT
    sdb      8:16   0   14G  0 disk 
    └─sdb1   8:17   0   14G  0 part /mnt
    sr0     11:0    1  628K  0 rom  
    sdc      8:32   0   64G  0 disk 
    sda      8:0    0   30G  0 disk 
    └─sda1   8:1    0   30G  0 part /
    ```

    You see the 64 GB drive, `sdc`, that you just created. You see that it's not mounted. That's because it's hasn't yet been initialized.

1. Run the following `az vm extension set` command to run the pre-made Bash script on your VM.

    > [!WARNING]
    > The script modifies `/etc/fstab`. Improperly modifying the `/etc/fstab` file could result in an unbootable system. Always test configuration changes on a temporary scratch system before you deploy to production. Refer to your distribution's documentation to learn how to properly modify this file. In production, we also recommend that you create a backup of this file so you can restore the configuration if needed.

    ```azurecli
    az vm extension set \
      --vm-name support-web-vm01 \
      --name customScript \
      --publisher Microsoft.Azure.Extensions \
      --settings '{"fileUris":["https://raw.githubusercontent.com/MicrosoftDocs/mslearn-add-and-size-disks-in-azure-virtual-machines/master/add-data-disk.sh"]}' \
      --protected-settings '{"commandToExecute": "./add-data-disk.sh"}'
    ```

    While the command runs, you can [examine the Bash script](https://raw.githubusercontent.com/MicrosoftDocs/mslearn-add-and-size-disks-in-azure-virtual-machines/master/add-data-disk.sh?azure-portal=true) from a separate browser tab, if you'd like.

    To summarize, the script:

    * Partitions the drive `/dev/sdc`.
    * Creates an ext4 filesystem on the drive.
    * Creates the `/uploads` directory, which we use as our mount point.
    * Attaches the disk to the mount point.
    * Updates `/etc/fstab` so that the drive is mounted automatically after the system reboots.

1. To verify the configuration, run the same `ssh` command as you did previously to run the `lsblk` command on your VM over an SSH connection.

    ```bash
    ssh azureuser@$ipaddress lsblk
    ```

    You see that `sdc/sdc1` is partitioned and mounted to the `/uploads` directory as you expect.

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

> [!TIP]
> Some Linux kernels support TRIM to discard unused blocks on disks. This feature is available on Azure disks and can save you money if you create large files and then delete them. Learn how to [turn this feature on](/azure/virtual-machines/linux/attach-disk-portal#trimunmap-support-for-linux-in-azure) in the Azure documentation.

## Summary

Here, you created a data disk and attached it to your VM. You used the Custom Script Extension to run a pre-made Bash script on your VM to make the process more repeatable. The Bash script partitions, formats, and mounts your disk so that your web server can write to it.

Now that you've prepared the data disk on your VM, let's explore a bit more about the various types of disks you can create. Your primary decision is whether to choose Standard or Premium storage.