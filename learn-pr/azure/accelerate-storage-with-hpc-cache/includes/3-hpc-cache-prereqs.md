There are a few pre-requisites that need to be met prior to setting up your Azure HPC Cache.

## DNS and Network

Azure HPC Cache has two network requirements - a custom DNS server and a dedicated subnet.

### DNS

If you plan to use servers in your data center, then you’ll need to configure a DNS server so Azure resources can resolve your internal storage server names.

If you plan to use Azure-based storage like Azure NetApp Files or you plan to copy your data into Azure Blob, then you don’t need to configure this separate DNS server.

In the Azure Portal:

- Create the virtual network that will host the Azure HPC Cache.
- Create the DNS server.
- Add the DNS server to the cache's virtual network.

Follow these steps to add the DNS server to the virtual network in the Azure portal:

1. Open the virtual network in the Azure portal.
1. Choose DNS servers from the Settings menu in the sidebar.
1. Select Custom
1. Enter the DNS server's IP address in the field.

### Network

The cache needs to be in its own, dedicated subnet. The cache manages its own IP addresses to provide high availability. To ensure there are no IP address conflicts, the cache must be in its own subnet with a range of at least 64 IP addresses.

If you’re running multiple caches, each needs its own, dedicate subnet.

It’s highly recommended that a high-speed network connection like an ExpressRoute be in place between Azure and the data center where the storage is.

Different storage servers use different ports to access data. Use a tool like rpcinfo to identify what TCP and UDP ports are used on your storage server. Commonly used ports include 111, 2049, 4045, 4046, and 4047. Ensure firewall rules enable traffic from these ports to your internal network.

## Azure Permissions

The cache instance needs to be able to create virtual network interfaces (NICs). The user who creates the cache must have sufficient privileges in the subscription to create NICs.

## NFS Storage Permissions

The cache needs to have root permissions to perform the read, write, and metadata operations on storage. Configure your storage target to allow root access to the Azure HPC Cache.

- Confirm that no_root_squash is enabled otherwise root access from the cache will be blocked.
- Examine export policies to ensure there are no restrictions on root access.
- Make sure the cache has access to the lowest level of the export – parent directories, not subdirectories.
