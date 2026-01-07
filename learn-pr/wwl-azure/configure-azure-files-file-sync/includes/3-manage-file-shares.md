---
Azure Files offers two industry-standard file system protocols for mounting Azure file shares: the Server Message Block (SMB) protocol and the Network File System (NFS) protocol. Azure file shares don't support both the SMB and NFS protocols on the same file share, although you can create SMB and NFS Azure file shares within the same storage account.

## Types of Azure file shares

Azure Files supports two storage tiers: premium and standard. Standard file shares are created in general purpose (GPv2) storage accounts, while premium file shares are created in FileStorage storage accounts. The two storage tiers have the attributes described in the following table.

| Storage tier | Description|
| --- | ---|
| Premium | Premium file shares store data on solid-state drives (SSDs), and are available only in the FileStorage storage account kind. They provide consistent high performance and low latency, and are available in LRS redundancy, with ZRS available in some regions. Not available in all Azure regions. |
| Standard | Standard file shares store data on hard disk drives (HDDs) and deploy in the general-purpose version 2 (GPv2) storage account type. Provide performance for workloads such as general-purpose file shares and dev/test environments. Standard file shares are available for LRS, ZRS, GRS, and GZRS, in all Azure regions.  |

## Types of authentication

There are three main authentications methods that Azure Files supports.

| Authentication method | Description |
| --- | --- |
| Identity-based authentication over SMB | Provides the same seamless single sign-on (SSO) experience when accessing Azure file shares as accessing on-premises file shares. 
| Access key | An access key is an older and less flexible option. An Azure storage account has two access keys that can be used when making a request to the storage account, including to Azure Files. Access keys are static and provide full control access to Azure Files. Access keys should be secured and not shared with users, because they bypass all access control restrictions. A best practice is to avoid sharing storage account keys and use identity-based authentication whenever possible. |
| A Shared Access Signature (SAS) token | SAS is a dynamically generated Uniform Resource Identifier (URI) that's based on the storage access key. SAS provides restricted access rights to an Azure storage account. Restrictions include allowed permissions, start and expiry time, allowed IP addresses from where requests can be sent, and allowed protocols. With Azure Files, a SAS token is only used to provide REST API access from code.|

## Creating SMB Azure file shares (classic)

Classic Azure file shares live inside a storage account, so they follow the same limits as that account. You can choose between two storage tiers: SSD (premium) and HDD (standard).

SSD file shares are great when you need fast, consistent performance with low latency—usually in the single digit milliseconds. HDD shares are more budget friendly and work well for general purpose storage.

If you need SMB access, make sure to create your file share inside a storage account. SMB file shares let you pick from several access tiers, including transaction optimized, hot, and cool.

:::image type="content" source="../media/configure-classic-files.png" alt-text="Screenshot of creating a file share showing access tier choices.":::

When connecting over SMB, don’t forget that traffic uses port 445. Azure provides ready to use scripts for Windows and Linux to help you connect quickly.

> [!Important]
> [File shares (preview)](/azure/storage/files/create-file-share) are a new top‑level Azure resource that don’t require an Azure storage account. 


