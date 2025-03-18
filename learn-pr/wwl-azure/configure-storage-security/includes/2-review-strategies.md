Administrators use different strategies to ensure their data is secure. Common approaches include encryption, authentication, authorization, and user access control with credentials, file permissions, and private signatures. Azure Storage offers a suite of security capabilities based on common strategies to help you secure your data.

### Things to know about Azure Storage security strategies

Let's look at some characteristics of Azure Storage security.

- **Encryption at rest**. Storage Service Encryption (SSE) with a 256-bit Advanced Encryption Standard (AES) cipher encrypts all data written to Azure Storage. When you read data from Azure Storage, Azure Storage decrypts the data before returning it. This process incurs no extra charges and doesn't degrade performance. It can't be disabled.

- **Authentication**. Microsoft Entra ID and role-based access control (RBAC) are supported for Azure Storage for both resource management operations and data operations.
    - Assign RBAC roles scoped to an Azure storage account to security principals, and use Microsoft Entra ID to authorize resource management operations like key management.
    - Microsoft Entra integration is supported for data operations on Azure Blob Storage and Azure Queue Storage.

- **Encryption in transit**. Keep your data secure by enabling transport-level security between Azure and the client. Always use HTTPS to secure communication over the public internet. When you call the REST APIs to access objects in storage accounts, you can enforce the use of HTTPS by requiring secure transfer for the storage account. After you enable secure transfer, connections that use HTTP will be refused. This flag will also enforce secure transfer over SMB by requiring SMB 3.0 for all file share mounts.

- **Disk encryption**. For virtual machines (VMs), Azure lets you encrypt virtual hard disks (VHDs) by using Azure Disk Encryption. This encryption uses BitLocker for Windows images, and uses dm-crypt for Linux. Azure Key Vault stores the keys automatically to help you control and manage the disk-encryption keys and secrets. So even if someone gets access to the VHD image and downloads it, they can't access the data on the VHD.

- **Shared access signatures**. Delegated access to the data objects in Azure Storage can be granted by using a shared access signature (SAS).

- **Authorization**. Every request made against a secured resource in Blob Storage, Azure Files, Queue Storage, or Azure Cosmos DB (Azure Table Storage) must be authorized. Authorization ensures that resources in your storage account are accessible only when you want them to be, and to only those users or applications whom you grant access.

### Things to consider when using authorization security

Review the following strategies for authorizing requests to Azure Storage. Think about what security strategies would work for your Azure Storage.

| Authorization strategy | Description |
| --- | --- |
| **Microsoft Entra ID** | Microsoft Entra ID is Microsoft's cloud-based identity and access management service. With Microsoft Entra ID, you can assign fine-grained access to users, groups, or applications by using role-based access control. |
| **Shared Key** | Shared Key authorization relies on your Azure storage account access keys and other parameters to produce an encrypted signature string. The string is passed on the request in the Authorization header. |
| **Shared access signatures** | A SAS delegates access to a particular resource in your Azure storage account with specified permissions and for a specified time interval. |
| **Anonymous access to containers and blobs** | You can optionally make blob resources public at the container or blob level. A public container or blob is accessible to any user for anonymous read access. Read requests to public containers and blobs don't require authorization.
