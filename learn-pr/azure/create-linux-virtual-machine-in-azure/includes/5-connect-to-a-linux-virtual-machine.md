You have created a Linux VM in Azure. The next thing you’ll do is configure it for the tasks we want to move to Azure.

Unless you’ve set up a site-to-site VPN to Azure, your Azure VMs won’t be accessible from your local network. If you’re just getting started with Azure, it’s unlikely that you have a working site-to-site VPN. So how can you connect to the virtual machine?

## Azure VM IP addresses

As we saw a moment ago, Azure VMs communicate on a virtual network. They can also have an optional public IP address assigned to them. With a public IP, we can interact with the VM over the Internet. Alternatively, we can set up a virtual private network (VPN) that connects our on-premises network to Azure - letting us securely connect to the VM without exposing a public IP. This approach is covered in another module and is fully documented if you are interested in exploring that option.

Public IP addresses in Azure are dynamically allocated by default. That means the IP address can change over time - for VMs the IP address assignment happens when the VM is restarted. You can pay more to assign static addresses, if you want to connect directly to an IP address and need to ensure that the IP address will not change.

Acknowledging these restrictions, and the alternatives described above, we will use the public IP address of the VM in this module.

## Connecting to the VM with SSH

To connect to the VM via SSH, you need:

- the public IP address of the VM
- the username of the local account on the VM
- a public key configured in that account
- access to the corresponding private key
- port 22 open on the VM

Previously, you generated an SSH key pair, and added the public key to the VM configuration, and ensured that port 22 was open.

In the next unit, you'll use this information to open a secure terminal on the VM using SSH.

Once the terminal is open, you have access to all of the standard Linux command-line tools.

Next, let's connect to the VM using SSH.