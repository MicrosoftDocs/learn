You can provide direct access to Azure NetApp Files volume from your Azure VMware Solution (AVS) virtual machines (VMs) using NFS or SMB file shares. 

## Requirements 

To provide access, you need: 
- access to an Azure subscription with an Azure VMware Solution private cloud 
- a VNet connected to your AVS private cloud via an ExpressRoute gateway 
- a subnet delegated to the `Microsoft.NetApp/volumes` service 
- an Active Directory connection for Azure NetApp Files 
- an Azure NetApp Files capacity pool 
- a Linux VM running on Azure VMware Solution 
- a Windows VM running on Azure VMware Solution 

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

Once you've followed the mount commands, you've created and mapped an Azure NetApp Files NFS volume to a Linux VM.

## Map SMB volume to a Windows VM

Before you mount an SMB share, you must [create an Active Directory connection](/azure/azure-netapp-files/create-active-directory-connections). When you have created the Active Directory connection in Azure NetApp Files, you can select the AD connection when creating the SMB volume. 

1. Navigate to Azure NetApp Files in the Azure portal.
1. Select the **Volumes** menu then **+ Add Volume** to create a volume.
1. In the **Basics** tab, ensure the Virtual network selected is the VNet connected to your AVS private cloud.
1. In the **Protocol** tab, select SMB as the protocol type.
1. In the **Protocol** tab, select your Active Directory connection from the drop-down list.
1. In the **Review + create** tab, select **Create** to create the volume.
1. Select the **Volumes** menu. Select the volume you just created. 
1. Select **Mount instructions** to obtain the correct path to map the volume (e.g. \\anf.contoso.com/smbvol01) 
1. Log into the Windows VM.
1. Select the **Start** button then **Computer**.
1. Select **Map Network Drive**.
1. In the **Drive** list, select any available drive letter.
1. In the **Folder** box, enter the mount path for the volume.
1. Select **Finish**.

After selecting **Finish**, you've created and mapped an Azure NetApp Files SMB volume to a Windows VM.