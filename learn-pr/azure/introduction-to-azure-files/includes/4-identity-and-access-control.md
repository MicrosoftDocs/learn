This section talks about how to authenticate users and provide access to Azure file shares. Azure Files supports identity-based authentication for customers accessing file shares over SMB. In addition, SMB users can also authenticate using a storage account key. NFS file shares rely on network-level authentication and are therefore only accessible via restricted networks. Using an NFS file share always requires some level of networking configuration. File share access over REST APIs uses shared access signatures and storage account keys for specific data management operations.

- **Identity-based authentication**: Customers can use identity-based access via the Kerberos authentication protocol. These sources act as a directory service that stores user account information such as usernames, passwords, contact information and so on. Azure Files integrates with common directory services to verify the user account details and enable successful authentication. For SMB, identity-based authentication is the most secure and recommended option. 

- **Storage account key**: A user with the storage account key can access Azure file shares with superuser permissions over SMB and REST. Storage account keys should ideally be used by super user administrators and not all users, as they bypass all access restrictions. For file shares used by enterprise customers, storage account keys aren't scalable or safe mechanisms for organization-wide access and are therefore not recommended. The recommended security best practice is to avoid sharing storage account keys and use identity-based authentication. 

- **Shared access signature**: Customers accessing over REST can use a shared access signature (SAS) to authenticate with Azure Files. Shared access signatures are used in specific scenarios where independent software vendors develop REST API applications and use Azure Files as a storage solution, or when internal partners need access over REST for data management operations. A shared access signature is a URI that grants restricted access rights to Azure Storage resources. You can provide a shared access signature to clients who should not be trusted with your storage account key but to whom you wish to delegate access to certain storage account resources.  

## Identity-based authentication

[Azure Files](/azure/storage/files/storage-files-introduction) supports identity-based authentication for SMB file shares using the Kerberos protocol. When an identity associated with a user or application running on a client attempts to access data in Azure file shares, the request is sent to the domain service to authenticate the identity. If authentication is successful, it returns a Kerberos token. The client sends a request that includes the Kerberos token, and Azure file shares use that token to authorize the request. Azure file shares only receive the Kerberos token, not access credentials.

Azure Files supports the following authentication methods for SMB file shares:

- **On-premises AD DS**: Enabling AD DS authentication for an Azure file share allows users to authenticate using their on-premises AD DS credentials. The on-premises AD DS must be synchronized to Azure AD using Azure AD Connect sync. Only hybrid users that exist in both on-premises AD DS and Azure AD can be authenticated and authorized for Azure file share access. The customer needs to set up their AD domain controllers and domain join their machines or VMs (virtual machines). The domain controllers can be hosted on premises or on VMs, but the clients need to have a line of sight to the domain controllers, either on an on-premises network or on the same virtual network (VNET). 

- **Azure AD DS**: For Azure AD DS authentication, customers should enable Azure AD DS and domain join the VMs they want to access file data from. The domain joined VMs must reside in the same VNET as Azure AD DS. However, customers don't need to create the identity in Azure AD DS to represent the storage account. This is performed by the enablement process in the background. In addition, all users that exist in Azure AD can be authenticated and authorized. The user can be cloud only or hybrid. The sync from Azure AD to Azure AD DS is managed by the platform without requiring any user configuration. 

- **Azure AD Kerberos for hybrid user identities**: Azure Files supports Azure AD Kerberos authentication for hybrid user identities, which are on-premises AD identities that are synced to the cloud. This configuration uses Azure AD to issue Kerberos tickets to access the file share over SMB. This means end users can access Azure file shares over the internet without requiring a line-of-sight to domain controllers from hybrid Azure AD-joined and Azure AD-joined VMs. In addition, with this capability, Azure Virtual Desktop customers can create an Azure file share to store user profile containers that can be accessed by hybrid user identities.

- **AD authentication for Linux clients**: Authentication for Linux clients is supported via AD DS or Azure AD DS.

## Common use cases for identity-based authentication

The following are some common scenarios for using identity-based authentication: 

- **Migrating from on-premises file servers to Azure Files**: Replacing on-premises file servers is a common IT transformation use case for many customers today. Using on-premises AD DS to enable a seamless migration to Azure files not only provides a good user experience, but also allows users to access the file share and data using their current credentials by domain joining their machines. 

- **Moving enterprise applications to the cloud**: As customers move their on-premises native applications to the cloud, identity-based authentication with Azure Files eliminates the need to change your authentication mechanisms to support cloud applications. 

- **Backup and disaster recovery**: Azure Files can act as the backup storage system for on-premises file servers. Configuring proper authentication will help enforce access controls during disaster recovery scenarios.
