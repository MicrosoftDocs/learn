In Azure, encryption keys can be either platform managed or customer managed.

Platform-managed keys (PMKs) are encryption keys that are generated, stored, and managed entirely by Azure. Customers do not interact with PMKs. The keys used for [Azure Data Encryption-at-Rest](https://learn.microsoft.com//azure/security/fundamentals/encryption-atrest), for instance, are PMKs by default.

Customer-managed keys (CMK), on the other hand, are those that can be read, created, deleted, updated, and/or administered by one or more customers. Keys stored in a customer-owned key vault or hardware security module (HSM) are CMKs. Bring Your Own Key (BYOK) is a CMK scenario in which a customer imports (brings) keys from an outside storage location into an Azure key management service (see the [Azure Key Vault: Bring your own key specification](https://learn.microsoft.com//azure/key-vault/keys/byok-specification)).

A specific kind of customer-managed key is the "key encryption key" (KEK). A KEK is a primary key that controls access to one or more encryption keys that are themselves encrypted.

Customer-managed keys can be stored on-premises or, more commonly, in a cloud key management service.

<!--[](https://learn.microsoft.com//azure/security/fundamentals/key-management#azure-key-management-services)-->

## Azure key management services

Azure offers several options for storing and managing your keys in the cloud, including Azure Key Vault, Azure Managed HSM, Dedicated HSM, and Payments HSM. These options differ in terms of their FIPS compliance level, management overhead, and intended applications.

**Azure Key Vault (Standard Tier)**: A FIPS 140-2 Level 1 validated multi-tenant cloud key management service that can also be used to store secrets and certificates. Keys stored in Azure Key Vault are software-protected and can be used for encryption-at-rest and custom applications. Key Vault provides a modern API and the widest breadth of regional deployments and integrations with Azure Services. For more information, see [About Azure Key Vault](https://learn.microsoft.com//azure/key-vault/general/overview).

**Azure Key Vault (Premium Tier)**: A FIPS 140-2 Level 2 validated multi-tenant HSM offering that can be used to store keys in a secure hardware boundary. Microsoft manages and operates the underlying HSM, and keys stored in Azure Key Vault Premium can be used for encryption-at-rest and custom applications. Key Vault Premium also provides a modern API and the widest breadth of regional deployments and integrations with Azure Services. For more information, see [About Azure Key Vault](https://learn.microsoft.com//azure/key-vault/general/overview).

**Azure Managed HSM**: A FIPS 140-2 Level 3 validated single-tenant HSM offering that gives customers full control of an HSM for encryption-at-rest, Keyless SSL, and custom applications. Customers receive a pool of three HSM partitions—together acting as one logical, highly available HSM appliance--fronted by a service that exposes crypto functionality through the Key Vault API. Microsoft handles the provisioning, patching, maintenance, and hardware failover of the HSMs, but doesn't have access to the keys themselves, because the service executes within Azure's Confidential Compute Infrastructure. Managed HSM is integrated with the Azure SQL, Azure Storage, and Azure Information Protection PaaS services and offers support for Keyless TLS with F5 and Nginx. For more information, see [What is Azure Key Vault Managed HSM?](https://learn.microsoft.com//azure/key-vault/managed-hsm/overview)

**Azure Dedicated HSM**: A FIPS 140-2 Level 3 validated bare metal HSM offering, that lets customers lease a general-purpose HSM appliance that resides in Microsoft datacenters. The customer has complete and total ownership over the HSM device and is responsible for patching and updating the firmware when required. Microsoft has no permissions on the device or access to the key material, and Dedicated HSM is not integrated with any Azure PaaS offerings. Customers can interact with the HSM using the PKCS#11, JCE/JCA, and KSP/CNG APIs. This offering is most useful for legacy lift-and-shift workloads, PKI, SSL Offloading and Keyless TLS (supported integrations include F5, Nginx, Apache, Palo Alto, IBM GW and more), OpenSSL applications, Oracle TDE, and Azure SQL TDE IaaS. For more information, see [What is Azure Key Vault Managed HSM?](https://learn.microsoft.com//azure/dedicated-hsm/overview)

**Azure Payments HSM**: A FIPS 140-2 Level 3, PCI HSM v3, validated bare metal offering that lets customers lease a payment HSM appliance in Microsoft datacenters for payments operations, including payment processing, payment credential issuing, securing keys and authentication data, and sensitive data protection. The service is PCI DSS and PCI 3DS compliant. Azure Payment HSM offers single-tenant HSMs for customers to have complete administrative control and exclusive access to the HSM. Once the HSM is allocated to a customer, Microsoft has no access to customer data. Likewise, when the HSM is no longer required, customer data is zeroized and erased as soon as the HSM is released, to ensure complete privacy and security is maintained. For more information, see [About Azure Payment HSM](https://learn.microsoft.com//azure/payment-hsm/overview).

For an overview of the types of secrets, keys and certificates you can work with in key vault, see [Azure Key Vault Keys, Secrets, and Certificates Overview](https://learn.microsoft.com//azure/key-vault/general/about-keys-secrets-certificates?source=recommendations)

## Best practices for using Key Vault

### Use separate key vaults

Our recommendation is to use a vault per application per environment (development, pre-production, and production), per region. This helps you not share secrets across environments and regions. It will also reduce the threat in case of a breach.

<!--[](https://learn.microsoft.com//azure/key-vault/general/best-practices#why-we-recommend-separate-key-vaults)-->

#### Why we recommend separate key vaults

Key vaults define security boundaries for stored secrets. Grouping secrets into the same vault increases the _blast radius_ of a security event because attacks might be able to access secrets across concerns. To mitigate access across concerns, consider what secrets a specific application _should_ have access to, and then separate your key vaults based on this delineation. Separating key vaults by application is the most common boundary. Security boundaries, however, can be more granular for large applications, for example, per group of related services.

<!--[](https://learn.microsoft.com//azure/key-vault/general/best-practices#control-access-to-your-vault)-->

### Control access to your vault

Encryption keys and secrets like certificates, connection strings, and passwords are sensitive and business critical. You need to secure access to your key vaults by allowing only authorized applications and users. [Azure Key Vault security features](https://learn.microsoft.com//azure/key-vault/general/security-features) provides an overview of the Key Vault access model. It explains authentication and authorization. It also describes how to secure access to your key vaults.

Suggestions for controlling access to your vault are as follows:

-   Lock down access to your subscription, resource group, and key vaults (role-based access control (RBAC)).
-   Create access policies for every vault.
-   Use the principle of least privilege access to grant access.
-   Turn on firewall and [virtual network service endpoints](https://learn.microsoft.com//azure/key-vault/general/overview-vnet-service-endpoints).

<!--[](https://learn.microsoft.com//azure/key-vault/general/best-practices#turn-on-data-protection-for-your-vault)-->

### Turn on data protection for your vault

Turn on purge protection to guard against malicious or accidental deletion of the secrets and key vault even after soft-delete is turned on.

For more information, see [Azure Key Vault soft-delete overview](https://learn.microsoft.com//azure/key-vault/general/soft-delete-overview)

<!--[](https://learn.microsoft.com//azure/key-vault/general/best-practices#turn-on-logging)-->

### Turn on logging

[Turn on logging](https://learn.microsoft.com//azure/key-vault/general/logging) for your vault. Also, [set up alerts](https://learn.microsoft.com//azure/key-vault/general/alert).

<!--[](https://learn.microsoft.com//azure/key-vault/general/best-practices#backup)-->

### Backup

Purge protection prevents malicious and accidental deletion of vault objects for up to 90 days. In scenarios when purge protection is not a possible option, we recommend backup vault objects, which can't be recreated from other sources like encryption keys generated within the vault.

For more information about backup, see [Azure Key Vault backup and restore](https://learn.microsoft.com//azure/key-vault/general/backup)

<!--[](https://learn.microsoft.com//azure/key-vault/general/best-practices#multitenant-solutions-and-key-vault)-->

### Multitenant solutions and Key Vault

A multitenant solution is built on an architecture where components are used to serve multiple customers or tenants. Multitenant solutions are often used to support software as a service (SaaS) solutions. If you're building a multitenant solution that includes Key Vault, review [Multitenancy and Azure Key Vault](https://learn.microsoft.com//azure/architecture/guide/multitenant/service/key-vault).