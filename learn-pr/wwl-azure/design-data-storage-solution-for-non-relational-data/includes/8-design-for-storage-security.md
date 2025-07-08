Azure Storage provides a layered security model that lets you secure and control the level of access to your storage accounts. The model consists of several storage security options, including firewall policies, customer-managed keys, and endpoints. This video from the Developers course highlights storage security features. 

> [!VIDEO https://learn-video.azurefd.net/vod/player?id=70edcdd1-7dab-478a-83ea-d07f4f883d67]

### Things to know about storage security

Let's take a look at some best practices for storage security. Think about options can be used for the Tailwind Traders infrastructure.

- [Azure security baseline for Azure Storage](/security/benchmark/azure/baselines/storage-security-baseline) grants limited access to Azure Storage resources. Azure security baseline provides a comprehensive list of ways to secure your Azure storage. 

- [Shared access signatures (SAS)](/azure/storage/common/storage-sas-overview) provide secure delegated access to resources in your storage account. With a SAS, you have granular control over how a client can access your data.

- [Firewall policies and rules](/azure/storage/common/storage-network-security) limit access to your storage account. Requests can be limited to specific IP addresses or ranges, or to a list of subnets in an Azure virtual network. The Azure Storage firewall provides access control for the public endpoint of your storage account.

- [Secure transfer](/azure/storage/common/storage-require-secure-transfer) enables an Azure storage account to accept requests from secure connections. When you require secure transfer, any requests originating from nonsecure connections are rejected. Microsoft recommends that you always require secure transfer for all your storage accounts.

- Data in your storage account is automatically encrypted. Azure Storage encryption offers two ways to manage encryption keys at the storage account level:

  - Microsoft-managed keys: By default, Microsoft manages the keys used to encrypt your storage account.

  - [Customer-managed keys](/azure/storage/common/storage-encryption-key-model-get): You can optionally choose to manage encryption keys for your storage account. These keys must be stored in Azure Key Vault.

### Things to consider when implementing storage security

You review some of the security options for Azure Storage. Take a few minutes to determine how you can configure security for Tailwind Traders.

- **Consider Azure security baseline options**. Review the comprehensive options provided by Azure security baseline provides to secure your Azure storage. Grant limited access to Azure Storage resources. 

- **Consider shared access signatures**. Specify what Tailwind Traders resources clients can access. Define the access permissions for resources. Configure how long the SAS remains valid.

- **Consider firewall policies and rules**. Limit requests to IP addresses or subnets in an Azure virtual network. Use the Azure Storage firewall to block all access through the public endpoint when using private endpoints. Select trusted Azure platform services to access the storage account securely.

- **Consider private endpoints**. Add private endpoints to create a special network interface for an Azure service in your virtual network. When you implement a private endpoint for your storage account, it provides secure connectivity between clients on your virtual network and your storage.

   :::image type="content" source="../media/private-links.png" alt-text="Diagram of a private endpoint that uses a private link to Azure storage accounts." border="false":::

- **Consider secure transfer**. (Microsoft recommended) Always require secure transfer for all your Azure storage accounts. In the Azure portal, choose **Enable secure transfer** for your storage accounts. The `Secure transfer required` property is enabled by default when an Azure storage account is created.

- **Consider customer-managed keys**. Manage encryption keys for your storage account by using customer-managed keys stored in Azure Key Vault. Customer-managed keys give you full control over access to your encryption keys and encrypted data.


> [!TIP]
> There is a lot more to learn about storage security in the [Plan and implement security for storage](/training/modules/security-storage/) training module. 