---
Azure Files offers two industry-standard file system protocols for mounting Azure file shares: the Server Message Block (SMB) protocol and the Network File System (NFS) protocol. Azure file shares don't support both the SMB and NFS protocols on the same file share, although you can create SMB and NFS Azure file shares within the same storage account.

## Types of Azure file shares

Azure Files supports two storage tiers: premium and standard. Standard file shares are created in general purpose (GPv2) storage accounts, while premium file shares are created in FileStorage storage accounts. The two storage tiers have the attributes described in the following table.

| Storage tier | Performance | Storage account type | Redundancy options | Billing model | Use cases |
| --- | --- | --- | --- | --- | --- |
| **Premium** | SSD-backed, consistent low latency | FileStorage | LRS, ZRS | Provisioned (pay for capacity reserved) | High-performance workloads requiring low latency |
| **Transaction Optimized** | HDD-backed, standard performance | General-purpose v2 (GPv2) | LRS, GRS, RA-GRS, ZRS, GZRS, RA-GZRS | Pay-as-you-go | High-transaction workloads, frequently accessed data |
| **Hot** | HDD-backed, standard performance | General-purpose v2 (GPv2) | LRS, GRS, RA-GRS, ZRS, GZRS, RA-GZRS | Pay-as-you-go | General-purpose team shares and collaborative workloads |
| **Cool** | HDD-backed, standard performance | General-purpose v2 (GPv2) | LRS, GRS, RA-GRS, ZRS, GZRS, RA-GZRS | Pay-as-you-go | Cost-efficient online archive and backup scenarios |

> [!NOTE]
> Transaction Optimized, Hot, and Cool are all Standard (HDD-based) tiers with different pricing structures optimized for specific access patterns. Premium tier uses SSD storage with provisioned billing (you pay for the capacity you reserve), while Standard tiers use pay-as-you-go billing.


## Types of authentication

There are three main authentications methods that Azure Files supports.

| Authentication method | Description |
| --- | --- |
| Identity-based authentication over SMB | [SMB identity-based authentication](/azure/storage/files/storage-files-active-directory-overview#supported-authentication-scenarios) supports three Active Directory sources: On-premises AD DS, Microsoft Entra Domain Services, and Microsoft Entra Kerberos. Once your Active Directory source is selected, assign Azure RBAC roles to users who need access to the file share. |
| Access key | An access key is an older and less flexible option. An Azure storage account has two access keys that can be used when making a request to the storage account, including to Azure Files. Access keys are static and provide full control access to Azure Files. Access keys should be secured and not shared with users, because they bypass all access control restrictions. A best practice is to avoid sharing storage account keys and use identity-based authentication whenever possible. |
| A Shared Access Signature (SAS) token | SAS is a dynamically generated Uniform Resource Identifier (URI) that's based on the storage access key. SAS provides restricted access rights to an Azure storage account. Restrictions include allowed permissions, start and expiry time, allowed IP addresses from where requests can be sent, and allowed protocols. With Azure Files, a SAS token is only used to provide REST API access from code.|

## Creating SMB Azure file shares (classic)

Classic Azure file shares live inside a storage account, so they follow the same limits as that account. You can choose between two storage tiers: SSD (premium) and HDD (standard).

SSD file shares are great when you need fast, consistent performance with low latency—usually in the single digit milliseconds. HDD shares are more budget friendly and work well for general purpose storage.

If you need SMB access, make sure to create your file share inside a storage account. SMB file shares let you pick from several access tiers, including transaction optimized, hot, and cool.

:::image type="content" source="../media/configure-classic-files.png" alt-text="Screenshot of creating a file share showing access tier choices.":::

> [!NOTE]
> When connecting over SMB, don’t forget that traffic uses port 445. Many ISPs block port 445 outbound, which is the most common connectivity issue when mounting Azure file shares from on-premises environments. 

> [!Important]
> [File shares (preview)](/azure/storage/files/create-file-share) are now generally available that don't require an Azure storage account. This option provides simplified management for scenarios where you only need file shares without other storage services. 


