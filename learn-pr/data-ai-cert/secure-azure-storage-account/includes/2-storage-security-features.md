::: zone pivot="video"

>[!VIDEO https://learn-video.azurefd.net/vod/player?id=8b086fe5-e8f7-4c63-96f0-9c460ff3c714]

> [!TIP]
> See the **Text and images** tab for more details!

::: zone-end

::: zone pivot="text"

Contoso relies heavily on massive amounts of data in Azure Storage. Their many applications rely on blobs, unstructured table storage, Azure Data Lake, and Server Message Block (SMB)-based file shares.

After Contoso's competitor has a data breach, Contoso tasks the network administrator to check the organization's data security. As Contoso's data consultant, you assure the network administrator that Azure Storage accounts provide several high-level security benefits for the data in the cloud:

- Protect the data at rest
- Protect the data in transit
- Support browser cross-domain access
- Control who can access data
- Audit storage access

## Encryption at rest

All data written to Azure Storage is automatically encrypted by Storage Service Encryption (SSE) with a 256-bit Advanced Encryption Standard (AES) cipher, and is FIPS 140-2 compliant. SSE automatically encrypts data when writing it to Azure Storage. When you read data from Azure Storage, Azure Storage decrypts the data before returning it. This process incurs no additional charges and doesn't degrade performance. It can't be disabled.

For virtual machines (VMs), Azure lets you encrypt virtual hard disks (VHDs) by using Azure Disk Encryption. This encryption uses BitLocker for Windows images, and uses dm-crypt for Linux.

Azure Disk Encryption integrates with Azure Key Vault to help you control and manage the disk-encryption keys and secrets. So even if someone gets access to the VHD image and downloads it, they can't access the data on the VHD.

## Encryption in transit

Keep your data secure by enabling *transport-level security* between Azure and the client. Always use *HTTPS* to secure communication over the public internet. When you call the REST APIs to access objects in storage accounts, you can enforce the use of HTTPS by requiring [secure transfer](/azure/storage/common/storage-require-secure-transfer) for the storage account. When secure transfer is required, Azure Storage rejects requests that use HTTP. Connections to an Azure file share over SMB without encryption also fail. The **Secure transfer required** property is enabled by default when you create a storage account.

## CORS support

Contoso stores several website asset types in Azure Storage. These types include images and videos. To secure browser apps, Contoso locks GET requests down to specific domains.

Azure Storage supports cross-domain access through cross-origin resource sharing (CORS). CORS uses HTTP headers so that a web application at one domain can access resources from a server at a different domain. By using CORS, web apps ensure that they load only authorized content from authorized sources.

CORS is disabled by default. To enable it, add CORS rules to the service properties of each storage service (Blob, File, Queue, or Table) that you want to expose. The rules specify the allowed origins, methods, and headers.

## Role-based access control

To access data in a storage account, the client makes a request over HTTP or HTTPS. Every request to a secure resource must be authorized. The service ensures that the client has the permissions required to access the data. You can choose from several access options. Microsoft recommends role-based access with Microsoft Entra ID.

Azure Storage supports Microsoft Entra ID and role-based access control (RBAC) for both resource management and data operations. For security principals, you can assign RBAC roles that are scoped to the storage account. You can use Microsoft Entra ID to authorize resource management operations, such as configuration. Microsoft Entra ID is supported for data operations on Blob, File, Queue, and Table storage.

You can assign RBAC roles to a security principal or a managed identity for Azure resources that are scoped to a subscription, a resource group, a storage account, or an individual container or queue.

> [!TIP]
> For optimal security, Microsoft recommends using Microsoft Entra ID with managed identities to authorize requests against blob, queue, table, and file data whenever possible. Authorization with Microsoft Entra ID and managed identities provides superior security and ease of use over Shared Key authorization.

## Auditing access

Auditing is another part of controlling access. You can audit Azure Storage access by using Azure Storage logs in Azure Monitor. These resource logs record requests to the storage account, and you can search them for specific requests. You can filter based on the authentication mechanism, the success of the operation, or the resource that was accessed.

The older Storage Analytics logs are still supported, but Microsoft recommends Azure Monitor logs instead.

::: zone-end
