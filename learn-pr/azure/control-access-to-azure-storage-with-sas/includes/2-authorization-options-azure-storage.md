Before you enhance your company's patient diagnostic image web app, you'd like to understand all the options for secure access. A shared access signature (SAS) provides a secure way of granting access to resources for clients. But it's not the only way to grant access. In some situations, other options might offer better choices for your organization.

Your company could make use of more than just the SAS method of authentication.

In this unit, you look at the different ways to authenticate access to files stored in Azure Storage.

## Access Azure Storage

Clients access files stored in Azure Storage over HTTP/HTTPS. Azure checks each client request for authorization to access the stored data. Four options are available for accessing blob storage:

- Public access
- Azure Active Directory (Azure AD)
- Shared key
- Shared access signature (SAS)

### Public access

Public access is also known as anonymous public read access for containers and blobs.

There are two separate settings that affect public access:

- **The Storage Account.** Configure the storage account to allow public access by setting the *AllowBlobPublicAccess* property. When set to true, Blob data is available for public access only if the container's public access setting is also set.

- **The Container.** You can enable anonymous access only if anonymous access has been allowed for the storage account. A container has two possible settings for public access: *Public read access for blobs*, or *public read access for a container and its blobs*. Anonymous access is controlled at the container level, not for individual blobs. So, if you want to secure some of the files, you need to put them in a separate container that doesn't permit public read access.

 Both storage account and container settings are required to enable anonymous public access. The advantages of this approach are that you don't need to share keys with clients who need access to your files. You also don't need to manage a SAS.

### Azure Active Directory

Use the Azure AD option to securely access Azure Storage without storing any credentials in your code. AD authorization takes a two-step approach. First, you authenticate a security principal that returns an OAuth 2.0 token if successful. This token is then passed to Azure Storage to enable authorization to the requested resource.

Use this form of authentication if you're running an app with managed identities or using security principals.

### Shared key

Azure Storage creates two 512-bit access keys for every storage account that's created. You share these keys to grant clients access to the storage account. These keys grant anyone with access the equivalent of root access to your storage.

We recommend that you manage storage keys with Azure Key Vault because it's easy to rotate keys on a regular schedule to keep your storage account secure.

### Shared access signature

A SAS lets you grant granular access to files in Azure Storage, such as read-only or read-write access, expiration time, after which the SAS no longer enables the client to access the chosen resources. A shared access signature is a key that grants permission to a storage resource, and should be protected in the same manner as an account key.

Azure Storage supports three types of shared access signatures:

- **User delegation SAS**: Can only be used for Blob storage and is secured with Azure AD credentials.
- **Service SAS**: A service SAS is secured using a storage account key. A service SAS delegates access to a resource in any one of four Azure Storage services: Blob, Queue, Table, or File. 
- **Account SAS**: An account SAS is secured with a storage account key. An account SAS has the same controls as a service SAS, but can also control access to service-level operations, such as Get Service Stats.

You can create a SAS ad-hoc by specifying all the options you need to control, including start time, expiration time, and permissions.

If you plan to create a service SAS, there's also an option to associate it with a stored access policy. A stored access policy can be associated with up to five active SASs. You can control access and expiration at the stored access policy level. This approach is good if you need to have granular control to change the expiration, or to revoke a SAS. The only way to revoke or change an ad-hoc SAS is to change the storage account keys.
