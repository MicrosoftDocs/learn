Shared access signatures are a secure way of granting access to resources for clients. However, it's not the only way to grant access. In some situations, other options might be a better choice for your organization.

Before you enhance your company's patient diagnostic image web app, you'd like to understand all the options. Your company could make use of more than just the SAS method of authentication.

In this unit, you'll look at the different ways to authenticate access to files stored in Azure Storage.

## Accessing Azure Storage

![Diagram showing the four methods of authentication, public access, Azure AD, Shared key, and SAS](../media/2-access-options.png)

Files stored in Azure Storage are accessed by clients over HTTP/HTTPS. Azure needs to check each clients request has the authorization to access the stored data. There are four options available for blob storage.

- Public access
- Azure Active Directory
- Shared key
- Shared Access Signature (SAS)

### Public access

Also known as anonymous client access. This option grants anyone read access to files stored in blob storage. All you need is the URL to a file and you able view it. You can grant anonymous access for blobs only, or on a container and its blobs. When you grant it for blobs only, blobs are individually accessible but you can't browse other blobs in the container. If you grant anonymous access on the container, all blobs are accessible and you can enumerate the container.

The advantages of this approach are that you don't need to share keys with clients who need access to your files. You also don't need to manage SAS.

Anonymous access is controlled at the container level, not individual blobs. So if you have a requirement to secure some files and not others you'll need to segregate those files into different blob containers.

### Azure Active Directory

You can use this form of authentication if you can run your app with managed identities or using security principals. Using the Azure AD option you can securely access Azure Storage without storing any credentials in your code.

Authorization takes a two-step approach. First a security principal needs to be authenticated which will return an OAuth 2.0 token if successful. This token can then be passed to the Azure Storage service to enable authorization to the requested resource.

### Shared key

Azure Storage will create two 512-bit access keys for every storage account that is created. You can share these keys to grant clients access to the storage account. These keys grant anyone who has access the equivalent of root access to your storage.

Microsoft recommends managing your storage keys with Azure Key Vault. This makes it easy to rotate keys on a regular schedule to keep your storage account secure.

### Shared Access Signature (SAS)

SAS lets you grant granular access to files in Azure Storage. This control includes the level of access. For example read only, or read and write. You also set the expiration time, after which the SAS will no longer enable the client to access the chosen resources.

There are three types of SAS:

- User delegation SAS - secured with Azure AD credentials. Can only be used on blob storage.
- Service SAS - secured with a storage account key. Can only be used on one service at a time, Blob storage, Queue storage, Table storage, or Azure Files.
- Account SAS - secured with a storage account key. Same controls as a service SAS but can also control access to service level operations, like Get Service Stats.

When you create a SAS, you do it in an ad-hoc way. In that you specify all the options of the SAS which can includes start time, expiry time, and permissions.

If you're creating a service SAS you have another option to associate it with a stored access policy, five SAS can be associated to a stored access policy at a time. You then control the access and expiration at the stored access policy level. You'd take this approach to give you greater control as it enables you to change the expiration or revoke a SAS. The only way to revoke or change an ad-hoc SAS os to change the storage account keys.