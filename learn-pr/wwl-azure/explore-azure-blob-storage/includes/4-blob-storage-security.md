
Azure Storage provides a comprehensive set of security capabilities that together enable developers to build secure applications:

* All data (including metadata) written to Azure Storage is automatically encrypted using Storage Service Encryption (SSE).
* Azure Active Directory (Azure AD) and Role-Based Access Control (RBAC) are supported for Azure Storage for both resource management operations and data operations, as follows:
    * You can assign RBAC roles scoped to the storage account to security principals and use Azure AD to authorize resource management operations such as key management.
    * Azure AD integration is supported for blob and queue data operations. You can assign RBAC roles scoped to a subscription, resource group, storage account, or an individual container or queue to a security principal or a managed identity for Azure resources.
* Data can be secured in transit between an application and Azure by using Client-Side Encryption, HTTPS, or SMB 3.0.
* OS and data disks used by Azure virtual machines can be encrypted using Azure Disk Encryption.
* Delegated access to the data objects in Azure Storage can be granted using a shared access signature.

## Azure Storage encryption for data at rest

Azure Storage automatically encrypts your data when persisting it to the cloud. Encryption protects your data and helps you meet your organizational security and compliance commitments. Data in Azure Storage is encrypted and decrypted transparently using 256-bit AES encryption, one of the strongest block ciphers available, and is FIPS 140-2 compliant. Azure Storage encryption is similar to BitLocker encryption on Windows.

Azure Storage encryption is enabled for all new and existing storage accounts and cannot be disabled. Because your data is secured by default, you don't need to modify your code or applications to take advantage of Azure Storage encryption.

Storage accounts are encrypted regardless of their performance tier (standard or premium) or deployment model (Azure Resource Manager or classic). All Azure Storage redundancy options support encryption, and all copies of a storage account are encrypted. All Azure Storage resources are encrypted, including blobs, disks, files, queues, and tables. All object metadata is also encrypted.

Encryption does not affect Azure Storage performance. There is no additional cost for Azure Storage encryption.

### Encryption key management

You can rely on Microsoft-managed keys for the encryption of your storage account, or you can manage encryption with your own keys. If you choose to manage encryption with your own keys, you have two options:

* You can specify a *customer-managed* key to use for encrypting and decrypting all data in the storage account. A customer-managed key is used to encrypt all data in all services in your storage account.
* You can specify a *customer-provided* key on Blob storage operations. A client making a read or write request against Blob storage can include an encryption key on the request for granular control over how blob data is encrypted and decrypted.

The following table compares key management options for Azure Storage encryption.

|  | Microsoft-managed keys | Customer-managed keys | Customer-provided keys |
|--|--|--|--|
| Encryption/decryption operations | Azure | Azure | Azure |
| Azure Storage services supported | All | Blob storage, Azure Files | Blob storage |
| Key storage | Microsoft key store | Azure Key Vault | Azure Key Vault or any other key store |
| Key rotation responsibility | Microsoft | Customer | Customer |
| Key usage | Microsoft | Azure portal, Storage Resource Provider REST API, Azure Storage management libraries, PowerShell, CLI | Azure Storage REST API (Blob storage), Azure Storage client libraries |
| Key access | Microsoft only | Microsoft, Customer | Customer only |

