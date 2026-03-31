Azure Storage automatically encrypts all data in a storage account at the service level using 256-bit AES encryption, which is one of the strongest block ciphers available, and is FIPS 140-2 compliant. Customers who require higher levels of assurance that their data is secure can also enable 256-bit AES encryption at the Azure Storage infrastructure level for **double encryption**. 

Double encryption of Azure Storage data provides defense-in-depth protection against scenarios where one of the encryption algorithms or keys may be compromised. This dual-layer approach aligns with Zero Trust security principles by assuming that any single layer of protection could potentially fail. In such scenarios, the additional layer of encryption continues to protect your data.

Infrastructure encryption can be enabled for the entire storage account, or for an encryption scope within an account. When infrastructure encryption is enabled for a storage account or an encryption scope, data is encrypted twice — once at the service level and once at the infrastructure level — with two different encryption algorithms and two different keys.

Service-level encryption supports the use of either Microsoft-managed keys or customer-managed keys with Azure Key Vault or Key Vault Managed Hardware Security Model (HSM). Infrastructure-level encryption relies on Microsoft-managed keys and always uses a separate key.

To doubly encrypt your data, you must first create a storage account or an encryption scope that is configured for infrastructure encryption.

> [!IMPORTANT]
> Infrastructure encryption is recommended for scenarios where doubly encrypting data is necessary for compliance requirements. For most other scenarios, Azure Storage encryption provides a sufficiently powerful encryption algorithm, and there's unlikely to be a significant performance or security benefit to using infrastructure encryption. Evaluate your specific compliance and regulatory requirements before enabling this feature.

## Create an account with infrastructure encryption enabled

To enable infrastructure encryption for a storage account, you must configure it at the time you create the account. **Infrastructure encryption can't be enabled or disabled after the account has been created**, so carefully evaluate your compliance requirements before deployment. The storage account must be of type general-purpose v2 or premium block blob.

To use the Azure portal to create a storage account with infrastructure encryption enabled, follow these steps:

1. In the [Azure portal](https://portal.azure.com/), navigate to the **Storage accounts** page.
2. Choose the **Add** button to add a new general-purpose v2 or premium block blob storage account.
3. On the **Encryption** tab, locate **Enable infrastructure encryption**, and select **Enabled**.
4. Select **Review + create** to finish creating the storage account.
    
    :::image type="content" source="../media/create-account-infrastructure-encryption-page-b7269a77.png" alt-text="Screenshot showing how to create an account with infrastructure encryption enabled.":::
    

To verify that infrastructure encryption is enabled for a storage account with the Azure portal, follow these steps:

1. Navigate to your storage account in the [Azure portal](https://portal.azure.com/).
2. Under **Settings**, choose **Encryption**.
    
    :::image type="content" source="../media/verify-infrastructure-encryption-page-c9ecb274.png" alt-text="Screenshot showing how to verify that infrastructure encryption is enabled for a storage account.":::

> [!NOTE]
> Azure Policy provides a built-in policy definition to require that infrastructure encryption be enabled for storage accounts. You can use this policy to enforce infrastructure encryption across your organization for compliance purposes.

## Create an encryption scope with infrastructure encryption enabled

If infrastructure encryption is enabled for an account, then any encryption scope created on that account automatically uses infrastructure encryption. If infrastructure encryption isn't enabled at the account level, then you have the option to enable it for an encryption scope at the time that you create the scope. The infrastructure encryption setting for an encryption scope can't be changed after the scope is created.

## Best practices for implementing infrastructure encryption

When deciding whether to implement infrastructure encryption for Azure Storage, consider these recommendations:

- **Evaluate compliance requirements first** - Infrastructure encryption is primarily designed for organizations with strict compliance requirements that mandate multiple layers of encryption. Review your regulatory obligations (such as HIPAA, PCI-DSS, FedRAMP) before enabling this feature.

- **Understand the permanence of the decision** - Infrastructure encryption must be enabled at account creation and cannot be disabled later. Plan carefully before deployment, as you'll need to create a new storage account and migrate data if you need to change this setting.

- **Consider performance implications** - While the performance impact is generally minimal, double encryption does add computational overhead. Test your workload performance before deploying to production if you have high-throughput requirements.

- **Use with customer-managed keys for maximum control** - Combine infrastructure encryption with customer-managed keys (CMK) at the service level for the highest level of encryption control. This provides defense-in-depth with different keys at each layer.

- **Implement Azure Policy for governance** - Use the built-in Azure Policy to enforce infrastructure encryption across all new storage accounts in your organization. This ensures consistent security posture and prevents accidental creation of non-compliant storage accounts.

- **Document your encryption architecture** - Maintain clear documentation of which storage accounts use infrastructure encryption, why it was enabled, and any associated compliance requirements. This is essential for audits and security reviews.

- **Use encryption scopes for granular control** - If only certain data requires double encryption, consider using encryption scopes instead of enabling infrastructure encryption for the entire account. This provides flexibility while meeting specific compliance needs.

- **Plan for disaster recovery** - Ensure your disaster recovery and backup strategies account for infrastructure encryption settings. Remember that restored or replicated storage accounts must be configured with infrastructure encryption at creation time.

- **Monitor encryption status** - Regularly audit your storage accounts to verify that infrastructure encryption is enabled where required. Use Azure Monitor, Azure Security Center, or Azure Policy compliance reports for ongoing validation.

- **Balance security and cost** - Infrastructure encryption adds a small computational overhead but no additional storage cost. However, the inability to disable it later means you should ensure the feature aligns with your long-term security strategy.

- **Test migration procedures** - Since infrastructure encryption can't be changed after creation, establish and test procedures for migrating data between storage accounts if encryption requirements change.

- **Combine with other security features** - Use infrastructure encryption as part of a comprehensive security strategy that includes network security (private endpoints, firewalls), access controls (Azure RBAC, SAS tokens), and monitoring (Azure Monitor, Microsoft Defender for Storage).
