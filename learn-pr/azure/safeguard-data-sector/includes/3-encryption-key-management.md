Data encryption in the cloud is important to reduce risk and it's expected by government customers worldwide. End-to-end data encryption using advanced ciphers is a basic part of guaranteeing the confidentiality and integrity of customer data in the cloud. Azure helps customers protect their data through its entire lifecycle: at rest, in transit, or even in use. It also offers comprehensive encryption key management to help customers control their keys in the cloud.

## Data encryption at rest

Azure provides many options for [data encryption at rest](https://docs.microsoft.com/azure/security/fundamentals/encryption-atrest) to help customers safeguard their data and meet their compliance needs. These options include Microsoft-managed encryption keys and customer-managed encryption keys. The security process relies on multiple encryption keys and services such as Azure Key Vault and Azure Active Directory to ensure secure key access and centralized key management.

Detailed information about various [data encryption models](https://docs.microsoft.com/azure/security/fundamentals/encryption-models) and specifics on key management for a wide range of Azure platform services is available in [online documentation](https://docs.microsoft.com/azure/security/fundamentals/encryption-atrest).

## Data encryption in transit

Customer may choose from several options for [encrypting data in transit](https://docs.microsoft.com/azure/security/fundamentals/encryption-overview#encryption-of-data-in-transit), including:

* Transport Layer Security (TLS) to help protect data when it’s traveling between customers and Azure services.
* Azure Storage transactions can be forced to take place over HTTPS.
* In-transit encryption for VMs can use the Remote Desktop Protocol (RDP) to enable TLS protection for remote sessions to Windows and Linux VMs in Azure. Alternatively, the Secure Shell (SSH) can be used for encrypted connections to Linux VMs running in Azure.
* VPN encryption allows customers to use Azure VPN Gateway to send encrypted traffic between their Virtual Network (VNet) and their on-premises infrastructure across the public internet.
* Express Route enables customers to create private connections between their on-premises infrastructure and Azure with several data encryption options.

Data is protected as it moves between client systems and cloud services, regardless of the method clients use to connect. Customers should review Azure [best practices](https://docs.microsoft.com/azure/security/fundamentals/data-encryption-best-practices#protect-data-in-transit) for protecting data in transit. For key Azure services (for example, Azure SQL Database, SQL Managed Instance, and Azure Synapse Analytics), data encryption in transit is [enforced by default](https://docs.microsoft.com/azure/azure-sql/database/security-overview).

## Encryption key management

Proper protection and management of encryption keys is essential for data security. Azure Key Vault is a cloud service for securely storing and managing secrets. Key Vault service supports two types of containers:

* **[Vault:](https://docs.microsoft.com/azure/key-vault/general/overview)** supports secrets, encryption keys, and certificates that can be protected by either software or hardware security modules (HSMs). Vaults rely on **multi-tenant** HSMs that have FIPS 140-2 Level 2 validation. 
* **[Managed HSM:](https://docs.microsoft.com/azure/key-vault/managed-hsm/overview)** supports only encryption keys protected by HSMs. It provides a fully managed, highly available, **single-tenant** HSM as a service that uses FIPS 140-2 Level 3 validated HSMs.

:::row:::
:::column span="2":::
With Azure Key Vault, customers can import or generate encryption keys in HSMs that never leave the HSM protection boundary to support *bring your own key* (BYOK) scenarios, as shown in Figure 1. Keys generated inside the Azure Key Vault HSMs aren't exportable – there can be no cleartext version of the key outside the HSMs. This binding is enforced by the underlying HSMs. BYOK functionality is available in both [vault](https://docs.microsoft.com/azure/key-vault/keys/hsm-protected-keys) and [managed HSM](https://docs.microsoft.com/azure/key-vault/managed-hsm/hsm-protected-keys-byok) containers. Methods for transferring HSM-protected keys to Key Vault vary depending on the underlying HSM, as explained in online documentation.
:::column-end:::
:::column span="2":::
:::image type="complex" source="../media/PENDING.png" alt-text="Azure Key Vault support for *bring your own key* (BYOK).":::
Pending
:::image-end:::
:::column-end:::
:::row-end:::

Azure Key Vault is designed, deployed, and operated such that Microsoft and its agents do not see or extract customer keys.

To access encryption keys in Azure Key Vault HSMs (both in vault and managed HSM containers), all callers must be authenticated by Azure AD, which enforces tenant isolation and implements robust measures to prevent access by unauthorized parties, including Microsoft insiders. As described in [Azure Active Directory Data Security Considerations](https://aka.ms/AADDataWhitePaper), tenant isolation involves two primary elements:

* Preventing data leakage and access across tenants, which means that data belonging to Tenant A can't in any way be obtained by users in Tenant B without explicit authorization by Tenant A.
* Resource access isolation across tenants, which means that operations performed by Tenant A can't in any way impact access to resources for Tenant B.

Access to Azure AD by Microsoft personnel, contractors, and vendors is highly restricted. Whenever possible, human intervention is replaced by an automated, tool-based process, including routine functions such as deployment, debugging, diagnostic collection, and restarting services. See Insider data access section for more information on controls that are in place to restrict insider access to production systems and customer data, including the Just-in-Time (JIT) privileged access management system.

## Azure confidential computing

:::row:::
:::column span="2":::
[Azure confidential computing](https://azure.microsoft.com/solutions/confidential-compute/) is a set of data security capabilities that offers encryption of data while in use. This means that data can be processed in the cloud with the confidence that it's always under customer control. Confidential computing makes sure that when data is in the clear, which is needed for efficient data processing in memory, the data is protected inside a trusted execution environment (TEE, also known as an enclave), as depicted in Figure 2.
:::column-end:::
:::column span="2":::
:::image type="complex" source="../media/PENDING.png" alt-text="Trusted execution environment protection.":::
Pending
:::image-end:::
:::column-end:::
:::row-end:::

TEE means that there's no way to view data or the operations from outside the enclave and that only the application designer has access to TEE data. Access is denied to everyone else, including Azure administrators. TEE also helps ensure that only authorized code may access data. If the code is changed or tampered with, the operations are denied, and the environment is disabled. Azure provides a hardware-based TEE using [Intel Software Guard Extensions](https://software.intel.com/content/www/us/en/develop/topics/software-guard-extensions.html) (SGX) technology.

Next, we'll look at the controls that prevent data access by Microsoft engineers for service maintenance, customer support, or other scenarios.
