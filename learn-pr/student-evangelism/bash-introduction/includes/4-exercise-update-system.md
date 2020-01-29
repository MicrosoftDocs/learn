In your new job, you have logged in to one of the company's servers for the first time. It's your responsibility to maintain this server and keep it running. The operating system almost certainly needs updating. Let's practice by updating the Linux virtual machine that you created in Azure.

1. Begin by connecting to the VM with an `ssh` command from Cloud Shell if you aren't connected already. Here's the command again:

    ```bash
    ssh azureuser@IP_ADDRESS
    ```

    If you don't have your VM's public IP address handy, you can get it by running an `az vm list-ip-addresses` command in Cloud Shell.

1. `apt` is the default Ubuntu Linux command for installing and removing programs, and yes, you will need to run it with `sudo`. Execute the following command to determine what, if anything, needs updating:

    ```bash
    sudo apt update
    ```

    The output should look something like this:

    ```
    Hit:1 http://azure.archive.ubuntu.com/ubuntu bionic InRelease
    Get:2 http://azure.archive.ubuntu.com/ubuntu bionic-updates InRelease [88.7 kB]
    Hit:3 http://azure.archive.ubuntu.com/ubuntu bionic-backports InRelease
    Get:4 http://security.ubuntu.com/ubuntu bionic-security InRelease [88.7 kB]
    Get:5 http://azure.archive.ubuntu.com/ubuntu bionic-updates/main amd64 Packages [644 kB]
    Get:6 http://azure.archive.ubuntu.com/ubuntu bionic-updates/universe amd64 Packages [954 kB]
    Fetched 1775 kB in 1s (2201 kB/s)
    Reading package lists... Done
    Building dependency tree
    Reading state information... Done
    27 packages can be upgraded. Run 'apt list --upgradable' to see them.
    ```

    As the output suggests, you can use an `apt list --upgradeable` command for a precise list of the items that need updating.

1. Now use this command to perform the upgrade and automatically answer "yes" to prompts:

    ```bash
    sudo apt upgrade -y
    ```

    You may still be notified that certain services need to be restarted and prompted to answer yes or no. If so, answer "yes" and allow the upgrade to proceed. Then wait for the upgrade to finish.

1. Following a system update, you probably need to reboot the server. (You can avoid the need to do this by installing [Ubuntu LivePatch](https://ubuntu.com/livepatch), but that's a topic for another day.) Before you restart the server, let's get rid of any old packages that are hanging around after the upgrade:

    ```bash
    sudo apt autoremove
    ```

1. That done, you're ready to reboot the server. To reboot immediately, do this:

    ```bash
    sudo shutdown now -r
    ```

    To reboot later — after, say, 30 minutes — use the command:

    ```bash
    sudo shutdown -r +30
    ```
    
    What about at a given time? You can do that too.
    
    ```bash
    sudo shutdown -r 15:00
    ```

After rebooting the VM, you will need to reconnect to it. Use the same `ssh` command you used earlier to log in. The IP address should not change. And this time, you will connect to a fully patched and ready-to-go server.