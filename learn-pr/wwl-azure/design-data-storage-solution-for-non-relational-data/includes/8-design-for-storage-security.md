

Azure Storage provides a layered security model that lets you secure and control the level of access to your storage accounts. The model consists of several storage security options, including firewall policies, customer-managed keys, and endpoints.

:::image type="content" source="../media/storage-security.png" alt-text="Diagram that shows storage security options, including firewall policies, customer-managed keys, and endpoints." border="false":::

### Things to know about storage security

Let's take a look at some best practices for storage security. Think about options can be used for the Tailwind Traders infrastructure.

- [Azure security baseline for Azure Storage](/security/benchmark/azure/baselines/storage-security-baseline) grants limited access to Azure Storage resources. Azure security baseline provides a comprehensive list of ways to secure your Azure storage. 

- [Shared access signatures](/azure/storage/common/storage-sas-overview) provide secure delegated access to resources in your storage account. With a SAS, you have granular control over how a client can access your data.

- [Firewall policies and rules](/azure/storage/common/storage-network-security) limit access to your storage account. Requests can be limited to specific IP addresses or ranges, or to a list of subnets in an Azure virtual network. The Azure Storage firewall provides access control for the public endpoint of your storage account.

- [Virtual network service endpoints](/azure/virtual-network/virtual-network-service-endpoints-overview) restrict network access and provide direct connection to your Azure storage. You can secure storage accounts to your virtual network, and enable private IP addresses in the virtual network to reach the service endpoint. With [private endpoints](/azure/storage/common/storage-private-endpoints), you can create a special network interface for an Azure service in your virtual network.

- [Secure transfer](/azure/storage/common/storage-require-secure-transfer) enables an Azure storage account to accept requests from secure connections. When you require secure transfer, any requests originating from non-secure connections are rejected. Microsoft recommends that you always require secure transfer for all your storage accounts.

- Data in your storage account is automatically encrypted. Azure Storage encryption offers two ways to manage encryption keys at the storage account level:

  - Microsoft-managed keys: By default, Microsoft manages the keys used to encrypt your storage account.

  - Customer-managed keys: You can optionally choose to manage encryption keys for your storage account. [Customer-managed keys](/azure/storage/common/storage-encryption-key-model-get) must be stored in Azure Key Vault.

### Things to consider when implementing storage security

You've reviewed some of the security options for Azure Storage. Take a few minutes to determine how you can configure security for Tailwind Traders.

- **Consider Azure security baseline options**. Review the comprehensive options provided by Azure security baseline provides to secure your Azure storage. Grant limited access to Azure Storage resources. 

- **Consider shared access signatures**. Specify what Tailwind Traders resources clients can access. Define the access permissions for resources. Configure how long the SAS remains valid.

- **Consider firewall policies and rules**. Limit requests to IP addresses or subnets in an Azure virtual network. Use the Azure Storage firewall to block all access through the public endpoint when using private endpoints. Select trusted Azure platform services to access the storage account securely.

- **Consider service endpoints**. Secure Azure storage accounts to your virtual networks by using service endpoints. You can provide optimal routing by always keeping traffic destined to Azure Storage on the Azure backbone network. Enable private IP addresses in the virtual network to reach the service endpoint without requiring a public IP address. Allow on-premises networks to access resources by using NAT IP addresses.

   :::image type="content" source="../media/storage-endpoints.png" alt-text="Diagram of a virtual machine that uses an endpoint to access an Azure storage account." border="false":::

- **Consider private endpoints**. Add private endpoints to create a special network interface for an Azure service in your virtual network. When you implement a private endpoint for your storage account, it provides secure connectivity between clients on your virtual network and your storage.

   :::image type="content" source="../media/private-links.png" alt-text="Diagram of a private endpoint that uses a private link to Azure storage accounts." border="false":::

- **Consider secure transfer**. (Microsoft recommended) Always require secure transfer for all your Azure storage accounts. In the Azure portal, choose **Enable secure transfer** for your storage accounts. The `Secure transfer required` property is enabled by default when an Azure storage account is created.

- **Consider customer-managed keys**. Manage encryption keys for your storage account by using customer-managed keys stored in Azure Key Vault. Customer-managed keys give you full control over access to your encryption keys and encrypted data.