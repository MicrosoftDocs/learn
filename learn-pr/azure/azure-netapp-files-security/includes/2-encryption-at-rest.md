
Data at-rest in Azure NetApp Files can be encrypted in two ways:

- Single encryption uses software-based encryption for Azure NetApp Files volumes.
- Double encryption adds hardware-level encryption at the physical storage device layer.

## Single encryption and customer-managed keys 

Single encryption uses software-based encryption for Azure NetApp Files volumes.

Customer-managed keys is a security feature that allows organizations to take control of their keys and manage them independently from the cloud service provider. Customer-managed keys for Azure NetApp Files volume encryption enable you to use your own keys rather than a platform-managed key when creating a new volume. With customer-managed keys, you can fully manage the relationship between a key's life cycle, key usage permissions, and auditing operations on keys.

Customer-managed keys in Azure NetApp Files enhances data protection in the following ways.

- **Enhanced data security:** By using customer-managed keys, you can strengthen the security of your organization's data stored in Azure NetApp Files. With customer-managed keys, the keys are generated, managed, and stored within the organization’s own infrastructure, reducing the risk of unauthorized access to sensitive information. This approach offers an extra layer of protection against data breaches and insider threats.
- **Compliance and regulatory requirements:** Many industries and regions have stringent data protection regulations that require organizations to maintain control over their keys. Using customer-managed keys allows you to meet these compliance requirements by keeping the keys in your possession, providing an auditable trail of key management, which is essential for regulatory compliance audits.
- **Protection against unauthorized access:** Customer-managed keys offer organizations protection against unauthorized access to their data. Even if a breach or unauthorized access occurs in the cloud environment, the encrypted data remains inaccessible without the corresponding keys. This protection minimizes the risk of data exposure, helping maintain the confidentiality of sensitive information.
- **Trust and confidence:** Customer-managed keys provide a sense of trust and confidence in the security of your data. By having exclusive control over the keys, you can keep your data protected, fostering trust with customers, partners, and stakeholders.

The following diagram demonstrates how customer-managed keys work with Azure NetApp Files:

:::image type="content" source="../media/2-customer-managed-keys-diagram.png" alt-text="Diagram of customer-managed keys." lightbox="../media/2-customer-managed-keys-diagram.png":::


1. Azure NetApp Files grants permissions to encryption keys to a managed identity. The managed identity is either a user-assigned managed identity that you create and manage or a system-assigned managed identity associated with the NetApp account.
1. You configure encryption with a customer-managed key for the NetApp account.
1. You use the managed identity to which the Azure Key Vault admin granted permissions in step 1 to authenticate access to Azure Key Vault via Microsoft Entra ID.
1. Azure NetApp Files wraps the account encryption key with the customer-managed key in Azure Key Vault.

    Customer-managed keys have no performance impact on Azure NetApp Files. The only difference from platform-managed keys is how the key is managed.
1. For read/write operations, Azure NetApp Files sends requests to Azure Key Vault to unwrap the account encryption key to perform encryption and decryption operations.

## Double encryption

Double encryption adds hardware-level encryption at the physical storage device layer.

Azure NetApp Files double encryption at rest provides two levels of encryption protection: a hardware-based encryption layer (encrypted SSD drives) and a software-encryption layer. The hardware-based encryption layer resides at the physical storage level, using FIPS 140-2 certified drives. The software-based encryption layer is at the volume level, completing the second level of encryption protection

By default, Azure NetApp Files capacity pools use single encryption at rest. When you create a capacity pool, you have the option to use double encryption at rest for the volumes in the capacity pool. You can do so by selecting double as the encryption type for the capacity pool that you're creating.

When you create a volume in a double-encryption capacity pool, the default key management (the encryption key source field) is Microsoft-managed key (also called a platform-managed key). The other choice is a customer-managed key. Using customer-managed keys requires additional preparation of the Azure Key Vault.

:::image type="content" source="../media/2-double-encryption.png" alt-text="Screenshot of create volume menu with double encryption." lightbox="../media/2-double-encryption.png":::
