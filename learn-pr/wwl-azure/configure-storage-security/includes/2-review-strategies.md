Administrators use different strategies to ensure their data is secure. Common approaches include encryption, authentication, authorization, and user access control with credentials, file permissions, and private signatures. Azure Storage offers a suite of security capabilities based on common strategies to help you secure your data.

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=f0ef7956-ecdf-43cb-82e5-d0f9cb34bf3c]

> [!NOTE] 
> The video refers to Active Directory, which is now branded as Microsoft Entra ID. 

### Things to know about Azure Storage security strategies

Let's look at some characteristics of Azure Storage security. As you go through this module, consider defense in depth. How can you apply storage security features to this concept? 

:::image type="content" source="../media/storage-defense.png" alt-text="Diagram showing storage defense in depth features." border="false":::

- **Encryption at rest**. Storage Service Encryption (SSE) with a 256-bit Advanced Encryption Standard (AES) cipher encrypts all data written to Azure Storage. When you read data from Azure Storage, Azure Storage decrypts the data before returning it. This process incurs no extra charges and doesn't degrade performance. Encryption at rest includes encrypting virtual hard disks (VHDs) with Azure Disk Encryption. This encryption uses BitLocker for Windows images, and uses dm-crypt for Linux. 

- **Encryption in transit**. You can configure your storage account to only accept requests from secure connections by setting the **Secure transfer required** property for the storage account. Existing accounts should explicitly disallow TLS 1.0 and 1.1 which are deprecated. 

- **Encryption models**. Azure supports various encryption models, including server-side encryption that uses service-managed keys, customer-managed keys in Key Vault, or customer-managed keys on customer-controlled hardware. With client-side encryption, you can manage and store keys on-premises or in another secure location.

- **Authorize requests**. For optimal security, Microsoft recommends using Microsoft Entra ID with managed identities to authorize requests against blob, queue, and table data, whenever possible. Authorization with Microsoft Entra ID and managed identities provides superior security and ease of use over Shared Key authorization.

- **RBAC**. RBAC ensures that resources in your storage account are accessible only when you want them to be, and to only those users or applications whom you grant access. Assign RBAC roles scoped to an Azure storage account.

- **Storage analytics**. Azure Storage Analytics performs logging for a storage account. You can use this data to trace requests, analyze usage trends, and diagnose issues with your storage account.

> [!TIP]
> The Microsoft [storage cloud security benchmark](/security/benchmark/azure/baselines/storage-security-baseline) provides recommendations on how you can secure your cloud storage solutions.

### Things to consider when using authorization security

Review the following strategies for authorizing requests to Azure Storage. Think about what security strategies would work for your Azure Storage.

| Authorization strategy | Description |
| --- | --- |
| **Microsoft Entra ID** | Microsoft Entra ID is Microsoft's cloud-based identity and access management service. With Microsoft Entra ID, you can assign fine-grained access to users, groups, or applications by using role-based access control. |
| **Shared Key** | Access is authorized with an account access key. The key can be the primary or secondary access key. To enforce Entra ID authorization, disable the Shared Key at the storage account level. |
| **Shared access signatures** | A SAS delegates access to a particular resource in your Azure storage account with specified permissions and for a specified time interval. |
| **Anonymous access to containers and blobs** | Anonymous public access is disabled by default on new storage accounts. Microsoft recommends keeping anonymous access disabled for accounts containing sensitive data. |
