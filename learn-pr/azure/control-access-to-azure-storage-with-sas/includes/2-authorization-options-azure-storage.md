A shared access signature (SAS) provides a secure way of granting access to resources for clients. But it's not the only way to give access. In some situations, other options might be a better choice for your organization.

Before you enhance your company's patient diagnostic image web app, you'd like to understand all the options. Your company could make use of more than just the SAS method of authentication.

In this unit, you'll look at the different ways to authenticate access to files stored in Azure Storage.

## Access Azure Storage

Files stored in Azure Storage are accessed by clients over HTTP/HTTPS. Azure needs to check that each client's request has the authorization to access the stored data. Four options are available for blob storage:

- Public access
- Azure Active Directory (Azure AD)
- Shared key
- Shared access signature

![Diagram showing the four methods of authentication, public access, Azure AD, shared key, and SAS.](../media/2-access-options.png)

### Public access

Public access is also known as anonymous client access. This option grants anyone read access to files stored in blob storage. You just need the URL to a file to view it. You grant anonymous access for blobs only, or on a container and its blobs. When you grant access for blobs only, they're individually accessible but you can't browse other blobs in the container. If you grant anonymous access on the container, all blobs are accessible and you can enumerate the container.

The advantages of this approach are that you don't need to share keys with clients who require access to your files. You also don't need to manage a SAS.

Anonymous access is controlled at the container level, not individual blobs. If you want to secure some files and not others, you need to segregate them into different blob containers.

### Azure Active Directory

You use this form of authentication if you're running an app with managed identities or using security principals. Use the Azure AD option to securely access Azure Storage without storing any credentials in your code.

Authorization takes a two-step approach. First, you authenticate a security principal that returns an OAuth 2.0 token if successful. This token is then passed to Azure Storage to enable authorization to the requested resource.

### Shared key

Azure Storage creates two 512-bit access keys for every storage account that's created. You share these keys to grant clients access to the storage account. These keys grant anyone with access the equivalent of root access to your storage.

We recommend that you manage your storage keys with Azure Key Vault. It's then easy to rotate keys on a regular schedule to keep your storage account secure.

### Shared access signature

A SAS lets you grant granular access to files in Azure Storage. This control includes the level of access like read only or read and write. You also set the expiration time, after which the SAS no longer enables the client to access the chosen resources.

There are three types of shared access signatures:

- **User delegation SAS**: Secured with Azure AD credentials and can be used only on Azure Blob storage.
- **Service SAS**: Secured with a storage account key. A service SAS is used on only one service at a time, like Blob storage, Azure Queue storage, Azure Table storage, or Azure Files.
- **Account SAS**: Secured with a storage account key. The account SAS has the same controls as a service SAS but can also control access to service-level operations, like Get Service Stats.

You create a SAS in an ad-hoc way. Specify all the options of the SAS that can include start time, expiry time, and permissions.

If you plan to create a service SAS, there's another option to associate it with a stored access policy. Five SASs can be associated to a stored access policy at a time. You then control the access and expiration at the stored access policy level. You take this approach to gain greater control, change the expiration, or revoke a SAS. The only way to revoke or change an ad-hoc SAS is to change the storage account keys.