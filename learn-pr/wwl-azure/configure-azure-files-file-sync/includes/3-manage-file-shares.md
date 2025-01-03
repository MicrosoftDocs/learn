---
Azure Files offers two industry-standard file system protocols for mounting Azure file shares: the Server Message Block (SMB) protocol and the Network File System (NFS) protocol. Azure file shares don't support both the SMB and NFS protocols on the same file share, although you can create SMB and NFS Azure file shares within the same storage account.

## Types of Azure file shares

Azure Files supports two storage tiers: premium and standard. Standard file shares are created in general purpose (GPv2) storage accounts, while premium file shares are created in FileStorage storage accounts. The two storage tiers have the attributes described in the following table.

| Storage tier | Description|
| --- | ---|
| Premium | Premium file shares store data on solid-state drives (SSDs), and are available only in the FileStorage storage account kind. They provide consistent high performance and low latency, and are available in LRS redundancy, with ZRS available in some regions. Not available in all Azure regions. |
| Standard | Standard file shares store data on hard disk drives (HDDs) and deploy in the general-purpose version 2 (GPv2) storage account type. Provide performance for workloads such as general-purpose file shares and dev/test environments. Standard file shares are available for LRS, ZRS, GRS, and GZRS, in all Azure regions.  |

## Types of authentication

Three are three main authentications methods that Azure Files supports.

| Authentication method | Description |
| --- | --- |
| Identity-based authentication over SMB | Provides the same seamless single sign-on (SSO) experience when accessing Azure file shares as accessing on-premises file shares. 
| Access key | An access key is an older and less flexible option. An Azure storage account has two access keys that can be used when making a request to the storage account, including to Azure Files. Access keys are static and provide full control access to Azure Files. Access keys should be secured and not shared with users, because they bypass all access control restrictions. A best practice is to avoid sharing storage account keys and use identity-based authentication whenever possible. |
| A Shared Access Signature (SAS) token | SAS is a dynamically generated Uniform Resource Identifier (URI) that's based on the storage access key. SAS provides restricted access rights to an Azure storage account. Restrictions include allowed permissions, start and expiry time, allowed IP addresses from where requests can be sent, and allowed protocols. With Azure Files, a SAS token is only used to provide REST API access from code.|





## Creating SMB Azure file shares

There are two important settings that you need to be aware of when creating and configuring SMB Azure file shares.

- **Open port 445**. SMB communicates over TCP port 445. Make sure port 445 is open. Also, make sure your firewall isn't blocking TCP port 445 from the client machine. If you can't unblock port 445, then a VPN or ExpressRoute connection from on-premises to your Azure network is required, with Azure Files exposed on your internal network using private endpoints.

- **Enable secure transfer**. The `Secure transfer required` setting enhances the security of your storage account by limiting requests to your storage account from secure connections only. Consider the scenario where you use REST APIs to access your storage account. If you attempt to connect, and secure transfer required is enabled, you must connect by using HTTPS. If you try to connect to your account by using HTTP, and secure transfer required is enabled, the connection is rejected.

## Mount an SMB Azure file share on Windows

You can use Azure file shares seamlessly in Windows and Windows Server. You can connect to your Azure file share with Windows or Windows Server in the Azure portal. Specify the **Drive** where you want to mount the share, and choose the **Authentication method**. The Azure portal supplies you with PowerShell commands to run when you're ready to work with the file share. This video shows you how to mount the SMB file share on Windows. 

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=c057ece1-3ba7-409b-8cee-5492a4ad4ee4]

## Mount SMB Azure file share on Linux

You can also connect to Azure file shares from Linux machines. From your virtual machine page, select **Connect**. SMB Azure file shares can be mounted in Linux distributions by using the CIFS kernel client. File mounting can be done on-demand with the `mount` command or on-boot (persistent) by creating an entry in /etc/fstab.

