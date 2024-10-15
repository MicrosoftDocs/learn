---
Azure Files offers two industry-standard file system protocols for mounting Azure file shares: the Server Message Block (SMB) protocol and the Network File System (NFS) protocol. Azure file shares don't support both the SMB and NFS protocols on the same file share, although you can create SMB and NFS Azure file shares within the same storage account.

## Types of Azure file shares

Azure also offers two types of file shares: standard and premium. There are key differences between premium and standard file shares:

- The premium tier stores data on modern solid-state drives (SSDs), while the standard tier uses hard disk drives (HDDs).

- Standard file shares can be used with SMB and REST protocols only, while premium file shares can be used with SMB, NFS, and REST protocols.

- You can easily switch between hot, cool, and transaction optimized tiers of standard file shares, but you can't switch from premium file shares to any of the standard tiers.

## Creating Azure SMB file shares

There are two important settings that you need to be aware of when creating and configuring SMB Azure file shares.

- **Open port 445**. Azure Files uses the SMB protocol. SMB communicates over TCP port 445. Be sure port 445 is open. Also, make sure your firewall isn't blocking TCP port 445 from the client machine. If you can't unblock port 445, then a VPN or ExpressRoute connection from on-premises to your Azure network is required, with Azure Files exposed on your internal network using private endpoints.

- **Enable secure transfer**. The `Secure transfer required` setting enhances the security of your storage account by limiting requests to your storage account from secure connections only. Consider the scenario where you use REST APIs to access your storage account. If you attempt to connect, and secure transfer required is enabled, you must connect by using HTTPS. If you try to connect to your account by using HTTP, and secure transfer required is enabled, the connection is rejected.

## Mount an SMB Azure file share on Windows

Azure file shares can be seamlessly used in Windows and Windows Server. You can connect to your Azure file share with Windows or Windows Server in the Azure portal. Specify the **Drive** where you want to mount the share, and choose the **Authentication method**. The system supplies you with PowerShell commands to run when you're ready to work with the file share. This video shows you how to mount the SMB file share on Windows. 

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=c057ece1-3ba7-409b-8cee-5492a4ad4ee4]

## Mount SMB Azure file share on Linux

You can also connect to Azure file shares from Linux machines. From your virtual machine page, select **Connect**. SMB Azure file shares can be mounted in Linux distributions by using the CIFS kernel client. File mounting can be done on-demand with the `mount` command or on-boot (persistent) by creating an entry in /etc/fstab.
