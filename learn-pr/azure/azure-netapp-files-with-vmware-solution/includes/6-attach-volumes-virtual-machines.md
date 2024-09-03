You can provide direct access to Azure NetApp Files volume from your Azure VMware Solution (AVS) virtual machines (VMs) using Network File System (NFS) or Server Message Block (SMB) file shares.

## Requirements 

To provide access, you need the following resources:

- Access to an Azure subscription with an Azure VMware Solution private cloud.
- A VNet connected to your AVS private cloud via an ExpressRoute gateway.
- A subnet delegated to the `Microsoft.NetApp/volumes` service.
- An Active Directory connection for Azure NetApp Files.
- An Azure NetApp Files capacity pool.
- A Linux virtual machine (VM) running on Azure VMware Solution.
- A Windows VM running on Azure VMware Solution.

## Map NFS volume to a Linux VM 

1. Navigate to Azure NetApp Files in the Azure portal.
1. Select the **Volumes** menu then **+ Add Volume** to create a volume.
1. In the **Basics** tab, ensure the Virtual network selected is the VNet connected to your AVS private cloud.
1. In the **Protocol** tab, select NFSv3 as the protocol type.
1. In the **Review + create** tab, select **Create** to create the volume.
1. Navigate to Azure NetApp Files in the Azure portal. Select **Volumes**.
1. Select the volume created in the previous step.
1. Select **Mount instructions**. Make note of the commands needed to mount your volume.
1. Mount the Azure NetApp Files volume to your Linux VM. 
1. Connect to your Linux VM.
1. Use the mount commands provided in the Azure portal to mount your Azure NetApp Files volume.

Once you follow the mount commands, the creation and mapping of your Azure NetApp Files NFS volume to a Linux VM is completed.

## Map SMB volume to a Windows VM

Before you mount an SMB share, you must [create an Active Directory connection](/azure/azure-netapp-files/create-active-directory-connections). When you create the Active Directory connection in Azure NetApp Files, you can select the AD connection when creating the SMB volume.

1. Navigate to Azure NetApp Files in the Azure portal.
1. Select the **Volumes** menu then **+ Add Volume** to create a volume.
1. In the **Basics** tab, ensure the Virtual network selected is the VNet connected to your AVS private cloud.
1. In the **Protocol** tab, select SMB as the protocol type.
1. In the **Protocol** tab, select your Active Directory connection from the drop-down list.
1. In the **Review + create** tab, select **Create** to create the volume.
1. Select the **Volumes** menu. Select the volume you created. 
1. Select **Mount instructions** to obtain the correct path to map the volume (for example, `\\anf.contoso.com/smbvol01`). 
1. Log in to the Windows VM.
1. Select the **Start** button then **Computer**.
1. Select **Map Network Drive**.
1. In the **Drive** list, select any available drive letter.
1. In the **Folder** box, enter the mount path for the volume.
1. Select **Finish**.

After selecting **Finish**, the creation and mapping of your Azure NetApp Files SMB volume to a Windows VM is completed.