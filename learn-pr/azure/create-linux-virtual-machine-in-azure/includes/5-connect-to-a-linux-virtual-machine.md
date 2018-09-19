Now that we have a Linux VM in Azure, the next thing you’ll want to do is configure it for the tasks we want to move to Azure.

Unless you’ve set up a site-to-site VPN to Azure, your Azure VMs won’t be accessible from your local network. If you’re just getting started with Azure, it’s unlikely that you have a working site-to-site VPN. So how can you connect to the virtual machine?

## Azure VM IP addresses

As we saw a moment ago, Azure VMs communicate on a virtual network. They can also have an optional public IP address assigned to them. With a public IP, we can interact with the VM over the Internet. Alternatively, we can set up a virtual private network (VPN) that connects our on-premises network to Azure - letting us securely connect to the VM without exposing a public IP. This approach is covered in another module and is fully documented if you are interested in exploring that option.

One thing to be aware of with public IP addresses in Azure is they are often dynamically allocated. That means the IP address can change over time - for VMs, this happens when the VM is restarted. You can pay more to assign static addresses if you want to connect directly to an IP address instead of a name and need to ensure that the IP address will not change.

## Connect to an Azure Linux VM with SSH

Connecting to a VM in Azure using SSH is straightforward. In the Azure portal, open the properties of your VM, and at the top, click **Connect**. This will show you the IP addresses assigned to the VM along with all the login details for SSH. 

![Screenshot of the Azure portal showing the Connect to a virtual machine blade configured to connect via SSH to the newly created Linux VM.](../media/5-connect-ssh.png)

With these details, we can use the following command to get into our Linux VM:

```bash
ssh jim@137.117.101.249
```

The first time we connect, SSH will ask us about authenticating against an unknown host. SSH is telling you that you've never connected to this server before. If that's true, then it's perfectly normal, and you can respond with **yes** to save the fingerprint of the server in the known host file:

```output
The authenticity of host '137.117.101.249 (137.117.101.249)' can't be established.
ECDSA key fingerprint is SHA256:w1h08h4ie1iMq7ibIVSQM/PhcXFV7O7EEhjEqhPYMWY.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added '137.117.101.249' (ECDSA) to the list of known hosts.
```

## Transferring files to the VM

Another common task is to copy local files or data from one server to another. In our case, we'll eventually want to copy our website data up to our Azure VM. With Linux VMs and SSH, we can use the `scp` command. The command is similar to copying local files with `cp`, except you'll have to specify the remote user and host in your command.

For example, to copy `somefile.txt` from our current directory to `~/folder` on a Linux machine with the IP address `192.168.1.25`, you can type:

```bash
scp somefile.txt someuser@192.168.1.25:~/folder/
```

This will authenticate as `someuser` on the remote system, prompting for a password, or using your SSH private key. That user will need to have write permissions to `~/folder/` on the destination server.

> [!WARNING]
> `scp` will do local file copies if you don't get the command line quite right. The most common missing piece is the destination folder.

Let's try using SSH to connect to our running Linux VM.