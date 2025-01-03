Before users at Contoso can access Azure Files, they must first authenticate, and anonymous access isn't supported. As lead system engineer, you need to know the authentications methods that Azure Files supports, described in the following table.

|Authentication method|Description|
|------------------------------------------------------------|------------------------------------------------------------|
|Identity-based authentication over SMB| Preferable when accessing Azure Files, it provides the same seamless single sign-on (SSO) experience when accessing Azure file shares as accessing on-premises file shares. Identity-based authentication supports Kerberos authentication that uses identities from Microsoft Entra ID (formerly Azure AD) or AD DS.|
|Access key| An access key is an older and less flexible option. An Azure storage account has two access keys that can be used when making a request to the storage account, including to Azure Files. Access keys are static and provide full control access to Azure Files. Access keys should be secured and not shared with users, because they bypass all access control restrictions. A best practice is to avoid sharing storage account keys and use identity-based authentication whenever possible.|
|A Shared Access Signature (SAS) token| SAS is a dynamically generated Uniform Resource Identifier (URI) that's based on the storage access key. SAS provides restricted access rights to an Azure storage account. Restrictions include allowed permissions, start and expiry time, allowed IP addresses from where requests can be sent, and allowed protocols. With Azure Files, a SAS token is only used to provide REST API access from code.|

### Use identity-based authentication

You can enable identity-based authentication on Azure storage accounts. The first step is to set up your Active Directory (AD) source for the storage account. For Windows, you can choose from the following three AD sources:

- On-premises AD DS
- Microsoft Entra Domain Services (formerly Azure Active Directory Domain Services)
- Microsoft Entra Kerberos (for hybrid identities only)

In order to use AD DS or Microsoft Entra Kerberos, you must ensure that the on-premises AD DS is syncing with Microsoft Entra ID via either Microsoft Entra Connect or Microsoft Entra Connect cloud sync.

After you enable identity-based authentication for a storage account, users can access files on the Azure file share with their sign-in credentials. When a user tries to access data in Azure Files, the request is sent to either AD DS or Microsoft Entra ID for authentication, depending on the AD source you selected. If authentication succeeds, the AD source returns a Kerberos token. The user then sends a request that includes the Kerberos token, and the Azure file share uses that token to authorize the request.

### Configure Azure file share permissions

If you've enabled identity-based authentication, you can use Azure role-based access control (RBAC) to control access rights (or, *permissions*) to Azure file shares. The following table lists the built-in roles for Azure Files.

|Azure RBAC role|Description|
|------------------------------------------------|------------------------------------------------------------|
|Storage File Data SMB Share Contributor|Users in this role have read, write, and delete access in Azure file shares over SMB.|
|Storage File Data SMB Share Elevated Contributor|Users in this role have read, write, delete, and modify NTFS permission access in Azure file shares over SMB. This role has full control permissions to the Azure file share.|
|Storage File Data SMB Share Reader|Users in this role have read access to the Azure file share over SMB.|
|Storage File Data Privileged Reader|Users in this role have full read access on all the data in the shares for all the configured storage accounts regardless of the file/directory level NTFS permissions that are set.|
|Storage File Data Privileged Contributor|Users in this role have full read, write, modify ACLs, and delete access on all the data in the shares for all the configured storage accounts regardless of the file/directory level NTFS permissions that are set.|

If needed, you can also create and use custom RBAC roles. However, RBAC roles grant access to a share only. To access files, a user must also have directory and file-level permissions.

Azure file shares enforce standard Windows file permissions at the folder and file level. You can mount the share and configure permissions over SMB in the same way as with on-premises file shares.

> [!IMPORTANT]
> Full administrative control of an Azure file share, including the ability to take ownership of a file, requires using the storage account key.

### Data encryption

All data that's stored in an Azure storage account (which includes the data on Azure file shares), is always encrypted at rest by using Storage Service Encryption (SSE). Data is encrypted as it's written in Azure data centers, and it's automatically decrypted when you access it. By default, data encrypts by using Microsoft managed keys, but you can choose to bring your own encryption key.

By default, all Azure storage accounts have encryption-in-transit enabled. This ensures that all data is encrypted when transferring from the Azure data center to your device. Unencrypted access by using SMB 2.1 and SMB 3.0 without encryption or HTTP isn't allowed by default, and clients aren't able to connect to Azure file shares without encryption. This can be configured for an Azure storage account and is effective for all storage account services.

### Creating Azure file shares

Azure Files deploys as part of an Azure storage account. Settings that you specify when creating an Azure storage account, such as location, replication, and connectivity method, also apply to Azure Files. Some Azure storage account settings, such as performance and account type, can limit options that are available for Azure Files. For example, if you want to use premium file shares, which use SSDs, you must select premium performance and the FileStorage account kind when creating the Azure storage account.

After an Azure storage account is in place, you can create an Azure file share by using the Azure portal, Azure PowerShell, Azure Command-Line Interface (Azure CLI), or REST API. You can also create an Azure storage account by using Windows Admin Center when you're deploying Azure File Sync.

To create a standard SMB Azure file share, use the following procedure. If you're creating a premium Azure file share, you must also specify provisioned capacity.

1. Sign in to the Azure portal and select the appropriate storage account.
1. In the service menu, under **Data storage**, select **File shares**.
1. In the details pane, on the toolbar, select **+ File share**.
1. In the **New file share** blade, enter the desired **Name** and select an **Access tier**.
1. Select **Review + create** and then select **Create**.
