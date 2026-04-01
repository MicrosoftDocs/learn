
Azure Key Vault is a cloud service for securely storing and accessing secrets. A secret is anything that you want to tightly control access to, such as API keys, passwords, certificates, or cryptographic keys.

Azure Key Vault helps solve the following problems:

- **Secrets management**. Use Key Vault to securely store and tightly control access to tokens, passwords, certificates, API keys, and other secrets.
- **Key management**. You can use Key Vault as a key management solution. Key Vault makes it easier to create and control the encryption keys used to encrypt your data.
- **Certificate management**. Key Vault lets you provision, manage, and deploy your public and private TLS/SSL certificates for use with Azure and internally connected resources.

Azure Key Vault offers two service tiers, described later in this unit.

### Why use Key Vault?

**Centralize application secrets**. Centralizing storage of application secrets in Azure Key Vault allows you to control their distribution and greatly reduces the chances that secrets may be accidentally leaked. When application developers use Key Vault, they no longer need to store security information as part of the code in their application. Instead, the application retrieves the information it needs at runtime using a unique identifier—with no custom code required to protect the secret.

**Securely store secrets and keys**. Access to a key vault requires proper authentication and authorization before a caller (user or application) can get access. Authentication establishes the identity of the caller, while authorization determines the operations that they're allowed to perform.

Authentication is done via Microsoft Entra ID. Authorization may be done via Azure role-based access control (Azure RBAC) or Key Vault access policy.

Azure Key Vault is designed so that Microsoft doesn't see or extract your data.

**Monitor access and use**. Azure Key Vault supports logging so you can monitor how and when your secrets and keys are accessed. You can route these logs to your preferred monitoring or storage solution for analysis and retention. This visibility helps you detect unauthorized access attempts, support compliance audits, and investigate security incidents.

**Simplified administration of application secrets**. Azure Key Vault simplifies the administration that would typically be required to secure your application secrets, including:

- Replicating the contents of your Key Vault within a region and to a secondary region. Data replication ensures high availability and takes away the need of any action from the administrator to trigger the failover.
- Providing standard management options through the Azure portal.
- Automating certain tasks on certificates that you purchase from Public Certificate Authorities (CAs), such as enrollment and renewal.

:::image type="content" source="../media/azure-key-vault-inline.png" lightbox="../media/azure-key-vault-expanded.png" alt-text="Diagram showing a representation of Azure Key Vault, an Azure developer receiving a key vault object identifier as a URI, and a security admin that obtains usage logging for keys.":::

In addition, Azure Key Vaults allow you to segregate application secrets. Applications may access only the vault that they're allowed to access, and they can be limited to only perform specific operations. You can create an Azure Key Vault per application and restrict the secrets stored in a Key Vault to a specific application and team of developers.

## Key Vault and Zero Trust

Zero Trust is a security strategy based on three principles: verify explicitly, use least privilege access, and assume breach. Azure Key Vault directly supports the least privilege access principle. By centralizing the storage of secrets and keys, Key Vault enables you to grant applications and users access only to the specific secrets they need—nothing more. This limits the blast radius if credentials are ever compromised.

Authentication to Key Vault is handled by Microsoft Entra ID, which verifies the identity of every caller. Authorization is then determined by Azure role-based access control (Azure RBAC) or Key Vault access policies, giving you granular control over who can access or manage secrets. Azure Key Vault is designed so that Microsoft doesn't see or extract your data—your secrets, keys, and certificates are for your use only.

## Integration with Azure services

Azure Key Vault integrates with a wide range of Azure services, making it the natural choice for managing secrets across your environment:

- **Azure Disk Encryption**: Stores the encryption keys used to encrypt virtual machine disks.
- **Azure SQL Database and SQL Server**: Stores and manages the encryption keys used to protect data stored in databases.
- **Azure App Service**: Applications retrieve connection strings, API keys, and other configuration secrets from Key Vault at runtime—without storing them in application code or configuration files. This eliminates a common source of accidental credential exposure.
- **Certificate management**: Key Vault provisions, manages, and automatically renews public and private TLS/SSL certificates from public certificate authorities (CAs). This reduces the operational burden of certificate lifecycle management and lowers the risk of certificate-related outages.

## Key Vault service tiers

Azure Key Vault offers two service tiers to meet different security and compliance requirements:

- **Standard tier**: Encrypts with software-based key protection. Suitable for most typical business scenarios.
- **Premium tier**: Offers hardware security module (HSM)-protected keys. An HSM is a dedicated hardware device that generates and stores cryptographic keys in a tamper-resistant environment—keys never leave the HSM boundary. The Premium tier is designed for organizations with stringent compliance requirements, such as those in financial services or government sectors.

Both tiers provide the same core capabilities—secrets management, key management, and certificate management—with the difference being the level of hardware protection applied to cryptographic keys.