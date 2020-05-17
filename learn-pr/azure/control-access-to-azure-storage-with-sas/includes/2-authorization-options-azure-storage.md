Shared access signature (SAS) provides a secure way of granting access to resources for clients. But it's not the only way to give access. In some situations, other options might be a better choice for your organization.

Before you enhance your company's patient diagnostic image web app, you'd like to understand all the options. Your company could make use of more than just the SAS method of authentication.

In this unit, you'll look at the different ways to authenticate access to files stored in Azure Storage.

## Accessing Azure Storage

Files stored in Azure Storage are accessed by clients over HTTP/HTTPS. Azure needs to check each client's request has the authorization to access the stored data. There are four options available for blob storage.

- Public access
- Azure Active Directory
- Shared key
- Shared access signature (SAS)

![Diagram showing the four methods of authentication, public access, Azure AD, Shared key, and SAS](../media/2-access-options.png)

### Public access

Public access is also known as anonymous client access. This option grants anyone read access to files stored in blob storage. You just need the URL to a file to view it. You grant anonymous access for blobs only, or on a container and its blobs. When you grant access for blobs only, they're individually accessible but you can't browse other blobs in the container. If you grant anonymous access on the container, all blobs are accessible and you can enumerate the container.

The advantages of this approach are that you don't need to share keys with clients who require access to your files. You also don't need to manage SAS.

Anonymous access is controlled at the container level, not individual blobs. If you want to secure some files and not others, you'll need to segregate them into different blob containers.

### Azure Active Directory

You use this form of authentication if you're running an app with managed identities or using security principals. Use the Azure AD option to securely access Azure Storage without storing any credentials in your code.

Authorization takes a two-step approach. First, you authenticate a security principal that returns an OAuth 2.0 token if successful. This token is then passed to the Azure Storage service to enable authorization to the requested resource.

### Shared key

Azure Storage will create two 512-bit access keys for every storage account that's created. You share these keys to grant clients access to the storage account. These keys grant anyone with access the equivalent of root access to your storage.

Microsoft recommends managing your storage keys with Azure Key Vault. It's then easy to rotate keys on a regular schedule to keep your storage account secure.

### Shared access signature (SAS)

SAS lets you grant granular access to files in Azure Storage. This control includes the level of access. For example, read only, or read and write. You also set the expiration time, after which the SAS no longer enables the client to access the chosen resources.

There are three types of SAS:

- **User delegation SAS**. Secured with Azure AD credentials, and can only be used on Blob storage.
- **Service SAS**. Secured with a storage account key. Service SAS is only used on one service at a time, like Blob storage, Queue storage, Table storage, or Azure Files.
- **Account SAS**. Secured with a storage account key. Account SAS has the same controls as a service SAS but can also control access to service level operations, like Get Service Stats.

You create an SAS in an ad-hoc way. Specify all the options of the SAS that can include start time, expiry time, and permissions.

If you're creating a service SAS, there's another option to associate it with a stored access policy. Five SASs can be associated to a stored access policy at a time. You then control the access and expiration at the stored access policy level. You'd take this approach to gain greater control, to change the expiration, or revoke a SAS. The only way to revoke or change an ad-hoc SAS is to change the storage account keys.