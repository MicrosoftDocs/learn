Contoso relies heavily on massive amounts of data stored in Azure Storage. In their many applications, they rely on blobs, unstructured table storage, Azure Data Lake, and SMB-based file shares. One of their competitors had a data breach, and the network admin was tasked with ensuring the same thing won't happen to them. As their consulting, you've assured them that Azure Storage accounts provide several high-level security benefits that ensure the data secured in the cloud.

- Protecting the data at "rest"
- Protecting the data in "transit"
- Supporting browser cross-domain access
- Controlling who can access data
- Auditing requests

## Encryption at rest

First, all data written to Azure Storage is automatically encrypted using Storage Service Encryption (SSE) with a 256-bit AES cipher. SSE automatically encrypts your data when writing it to Azure Storage. When you read data from Azure Storage, it is decrypted by Azure Storage before being returned. There no additional charges, nor any performance degradation and the feature cannot be disabled.

For VMs, Azure provides the ability to encrypt virtual hard disks (VHDs) with Azure Disk Encryption. This uses BitLocker for Windows images, and DM-Crypt for Linux. The keys are stored in an Azure Key Vault automatically to help you control and manage the disk-encryption keys and secrets. This ensures that even if someone obtains access to the VHD image and downloads it, they still won't be able to access the data contained in it.

## Encryption in transit

You can ensure your data remains secured by enabling _transport-level security_ between Azure and the client. The first recommendation is to always use **HTTPS** to ensure secure communication over the public Internet. You can enforce the use of HTTPS when calling the REST APIs to access objects in storage accounts by enabling [Secure transfer required](https://docs.microsoft.com/azure/storage/storage-require-secure-transfer) for the storage account. Connections using HTTP will be refused once this is enabled. This flag will also enforce secure transfer over SMB by enforcing SMB 3.0 be used for all file share mounts.

## CORS support

Contoso stores several website asset types in Azure Storage including images and videos. To keep their browser apps secure, they lock GET requests down to specific domains. Azure Storage supports cross-domain access through Cross-Origin Resource Sharing (CORS). CORS uses HTTP headers to let a web application running at one domain access resources from a server at a different domain. By using CORS, web apps can ensure they only load authorized content from authorized sources. The CORS support is an optional flag you can enable on Storage accounts to add all the appropriate headers when retrieving resources from the account through HTTP GET requests.

## Role-based access control

To access data in a storage account, the client makes a request over HTTP/HTTPS. Every request to a secure resource must be authorized, so that the service ensures that the client has the permissions required to access the data. There are several options available, the first one (and arguably the most flexible) is _role-based access_.

Azure Storage supports Azure Active Directory (Azure AD) and Role-Based Access Control (RBAC) for both resource management and data operations. You can assign RBAC roles scoped to the storage account to security principals and use Azure AD to authorize _resource management operations_ such as configuration. In addition, Azure AD is supported for _data operations_ on Blob and Queue services. 

You can assign RBAC roles scoped to a subscription, resource group, storage account, or an individual container or queue to a security principal or a managed identity for Azure resources.

## Auditing access

Audit is the other half of controlling access. Azure Storage access can be audited using a built-in service: Storage Analytics. Every operation is logged in real-time and you can search the storage analytics logs for specific requests. You can filter based on the authentication mechanism used, whether the operation was successful, or by the resource being accessed.
