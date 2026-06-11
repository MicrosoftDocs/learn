Azure NetApp Files supports creating volumes using NFS (NFSv3 or NFSv4.1), SMB3, or dual protocol (NFSv3 and SMB, or NFSv4.1 and SMB). A volume's capacity consumption counts against its pool's provisioned capacity.

Here you'll see how to create an SMB3 volume.

Before you begin:

- You must have already set up a capacity pool. See [Create a capacity pool](https://learn.microsoft.com/azure/azure-netapp-files/azure-netapp-files-set-up-capacity-pool).
- A subnet must be delegated to Azure NetApp Files. See [Delegate a subnet to Azure NetApp Files](https://learn.microsoft.com/azure/azure-netapp-files/azure-netapp-files-delegate-subnet).

### Configure Active Directory connections

Before creating an SMB volume, you need to create an Active Directory connection. If  Active Directory connections aren't configured for Azure NetApp files, refer to [Create and manage Active Directory connections](https://learn.microsoft.com/azure/azure-netapp-files/create-active-directory-connections) to learn more.
