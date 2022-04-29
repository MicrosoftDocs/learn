Azure Storage provides a layered security model. This model enables you to secure and control the level of access to your storage accounts. In this unit, we’ll cover some best practices for storage security. 

:::image type="content" source="../media/storage-security.png" alt-text="Firewall policies, customer-managed keys, and endpoints.":::


### Grant limited access to Azure Storage resources 

The [Azure security baseline for Azure Storage baseline](/security/benchmark/azure/baselines/storage-security-baseline#data-protection) provides a comprehensive list of ways to secure your Azure storage. 

### Use Shared Access Signatures

One of the most common ways is to use a [Shared Access Signature](/azure/storage/common/storage-sas-overview). A SAS provides secure delegated access to resources in your storage account. With a SAS, you have granular control over how a client can access your data. For example:

A [shared access signature](/azure/storage/common/storage-sas-overview) (SAS) provides secure delegated access to resources in your storage account. With a SAS, you have granular control over how a client can access your data. For example:

- What resources the client may access.

- What permissions they have to those resources.

- How long the SAS is valid.

### Enable firewall policies and rules

- [Configure firewall rules](/azure/storage/common/storage-network-security?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json&tabs=azure-portal) to limit access to your storage account. Requests can be limited to specific IP addresses or ranges, or to a list of subnets in an Azure virtual network. The Azure storage firewall provides access control for the public endpoint of your storage account. You can also use the firewall to block all access through the public endpoint when using private endpoints. Your storage firewall configuration also enables select trusted Azure platform services to access the storage account securely.

### Restrict network access using service endpoints

Use [virtual network service endpoints](/azure/virtual-network/virtual-network-service-endpoints-overview) to provide direct connection to your Azure storage. 

:::image type="content" source="../media/storage-endpoints.png" alt-text="A virtual machine uses an endpoint to access a storage account.":::



Service endpoints provide several advantages. 

- Allows you to secure Azure storage accounts to your virtual networks.

- Provides optimal routing by always keeping traffic destined to Azure Storage on the Azure backbone network.

- Service Endpoints enable private IP addresses in the VNet to reach the service endpoint. A public IP address isn’t needed.

- Enables on-premises networks to access resources using NAT IP addresses. 

### Determine when to use private endpoints

A [private endpoint](/azure/storage/common/storage-private-endpoints) is a special network interface for an Azure service in your virtual network. When you create a private endpoint for your storage account, it provides secure connectivity between clients on your VNet and your storage.

 

:::image type="content" source="../media/private-links.png" alt-text="A private endpoint uses a private link to storage accounts.":::



### Enable secure transfer

You can configure your storage account to accept requests from secure connections. This is done by setting the [Secure transfer required](/azure/storage/common/storage-require-secure-transfer) property for the storage account. When you require secure transfer, any requests originating from non-secure connections are rejected. Microsoft recommends that you always require secure transfer for all your storage accounts.

### Use customer-managed encryption keys

Data in your storage account is automatically encrypted. Azure Storage encryption offers two options for managing encryption keys at the level of the storage account:

- **Microsoft-managed keys.** By default, Microsoft manages the keys used to encrypt your storage account.

- **Customer-managed keys.** You can optionally choose to manage encryption keys for your storage account. [Customer-managed keys](/azure/storage/common/storage-encryption-key-model-get?toc=%2Fazure%2Fstorage%2Fblobs%2Ftoc.json&tabs=portal) must be stored in Azure Key Vault. When you bring-your-own-key (BYOK), you gain full control over who can use the encryption keys and who can access the encrypted data.