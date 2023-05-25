Once you have your Azure NetApp Files configuration established, it is easy to connection to your Azure VMware Solution VMs, whether you are using NFS or SMB file shares. 

The following diagram shows a connection through Azure ExpressRoute to an Azure VMware Solution private cloud. ExpressRoute is used to connect private clouds to on-premises environments. The connection requires a virtual network (VNet) with an ExpressRoute circuit to on-premises in your subscription. The Azure VMware Solution environment accesses the Azure NetApp Files share mounted on Azure VMware Solution VMs.

:::image type="content" source="../media/4-azure-netapp-files-topology.png" alt-text="Diagram depicting the topology of Azure NetApp Files." lightbox="../media/4-azure-netapp-files-topology.png":::

## Map NFS

If you are mounting an NFS share, add an entry to the `/etc/fstab` file on the host. For example: `$ANFIP:/$FILEPATH /$MOUNTPOINT nfs bg,rw,hard,noatime,nolock,rsize=65536,wsize=65536,vers=3,tcp,_netdev 0 0`

- `$ANFIP` is the IP address of the Azure NetApp Files volume found in the volume properties menu.
- `$FILEPATH` is the export path of the Azure NetApp Files volume.
- `$MOUNTPOINT` is the directory created on the Linux host used to mount the NFS export.

## Map SMB

Before you mount an SMB share, you must first create an [Active Directory connection](/azure/azure-netapp-files/create-active-directory-connections). When you have created the Active Directory connection in Azure NetApp Files, you can select the AD connection when creating the SMB volume.  
