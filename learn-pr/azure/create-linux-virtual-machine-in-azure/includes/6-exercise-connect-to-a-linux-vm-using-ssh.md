We have our Linux VM deployed and running, but it's not configured to do any work. Let's connect to it with SSH and configure Apache, so we have a running web server.

## Connect to the VM with SSH

To connect to an Azure VM with an SSH client, you will need:

- SSH client software (present on most modern operating systems)
- The public IP address of the VM (or private if the VM is configured to connect to your network)

### Get the public IP address

1. In the [Azure portal](https://portal.azure.com/triplecrownlabs.onmicrosoft.com?azure-portal=true), ensure the **Overview** panel for the virtual machine that you created earlier is open. You can find the VM under **All Resources** if you need to open it. The overview panel has a lot of information about the VM.

    - You can see whether the VM is running
    - Stop or restart it
    - Get the public IP address to connect to the VM
    - See the activity of the CPU, disk, and network

1. Click the **Connect** button at the top of the pane.

1. In the **Connect to virtual machine** blade, note the **IP address** and **Port number** settings. On the **SSH** tab, you will also find the command you need to execute locally to connect to the VM. Copy this to the clipboard.

## Connect with SSH

1. Paste the command line you got from the SSH tab into Azure Cloud Shell. It should look something like this; however, it will have a different IP address (and perhaps a different username if you didn't use **jim**!):

    ```bash
    ssh jim@137.117.101.249
    ```

1. This command will open a Secure Shell connection and place you at a traditional shell command prompt for Linux.

1. Try executing a few Linux commands
    - `ls -la /` to show the root of the disk
    - `ps -l` to show all the running processes
    - `dmesg` to list all the kernel messages
    - `lsblk` to list all the block devices - here you will see your drives

The more interesting thing to observe in the list of drives is what is _missing_. Notice that our **Data** drive (`sdc`) is present but not mounted into the file system. Azure added a VHD but didn't initialize it.

## Initialize data disks

Any additional drives you create from scratch will need to be initialized and formatted. The process for doing this is identical to a physical disk:

1. First, identify the disk. We did that above. You could also use `dmesg | grep SCSI`, which will list all the messages from the kernel for SCSI devices.

1. Once you know the drive (`sdc`) you need to initialize, you can use `fdisk` to do that. You will need to run the command with `sudo` and supply the disk you want to partition. We can use the following command to create a new primary partition:

    ```bash
    (echo n; echo p; echo 1; echo ; echo ; echo w) | sudo fdisk /dev/sdc
    ```

1. Next, we need to write a file system to the partition with the `mkfs` command.

    ```bash
    sudo mkfs -t ext4 /dev/sdc1
    ```

1. Finally, we need to mount the drive to the file system. Let's assume we will have a `data` folder. Let's create the mount point folder and mount the drive.

    ```bash
    sudo mkdir /data & sudo mount /dev/sdc1 /data
    ```

    > [!TIP]
    > We initialized the disk and mounted it. If you are interested in more details on this process go through the **Add and size disks in Azure virtual machines** module. This task is covered in more detail there.

## Install software onto the VM

As you can see, SSH allows you to work with the Linux VM just like a local computer. You can administer this VM as you would any other Linux computer: installing software, configuring roles, adjusting features, and other everyday tasks. Let's focus on installing software for a moment.

You have several options to install software onto the VM. First, as mentioned, you can use `scp` to copy local files from your machine to the VM. This lets you copy over data or custom applications you want to run.

You can also install software through Secure Shell. Azure machines are, by default, internet connected. You can use standard commands to install popular software packages directly from standard repositories. Let's use this approach to install Apache.

### Install the Apache web server

Apache is available within Ubuntu's default software repositories, so we will install it using conventional package management tools:

1. Start by updating the local package index to reflect the latest upstream changes:

    ```bash
    sudo apt-get update
    ```
    
1. Next, install Apache:

    ```bash
    sudo apt-get install apache2 -y
    ```

1. It should start automatically - we can check the status using `systemctl`:

    ```bash
    sudo systemctl status apache2 --no-pager
    ```

    This should return something like:

    ```output
    apache2.service - The Apache HTTP Server
       Loaded: loaded (/lib/systemd/system/apache2.service; enabled; vendor preset: enabled)
      Drop-In: /lib/systemd/system/apache2.service.d
               └─apache2-systemd.conf
       Active: active (running) since Mon 2018-09-03 21:00:03 UTC; 1min 34s ago
     Main PID: 11156 (apache2)
        Tasks: 55 (limit: 4915)
       CGroup: /system.slice/apache2.service
               ├─11156 /usr/sbin/apache2 -k start
               ├─11158 /usr/sbin/apache2 -k start
               └─11159 /usr/sbin/apache2 -k start

    test-web-eus-vm1 systemd[1]: Starting The Apache HTTP Server...
    test-web-eus-vm1 apachectl[11129]: AH00558: apache2: Could not reliably determine the server's fully qua
    test-web-eus-vm1 systemd[1]: Started The Apache HTTP Server.
    ```
    > [!NOTE]
    > It's trivial to execute commands like this, however it's a manual process - if we always need to install some software, you might consider automating the process using scripting.
    
1. Finally, we can try retrieving the default page through the public IP address. However, even though the web server is running on the VM, you won't get a valid connection or response. Do you know why?

We need to perform one more step to be able to interact with the web server. Our virtual network is blocking the inbound request - this is the default behavior. We can change that through configuration. Let's look at that next.