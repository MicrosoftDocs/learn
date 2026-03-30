Applications and services require secrets, cryptographic keys, and certificates to authenticate, encrypt data, and establish trust. As a security architect, you design solutions that protect these sensitive assets throughout their lifecycle while enabling secure access for authorized workloads.

## Types of cryptographic assets

Understanding the different types of assets helps you design appropriate protection:

| Asset type | Purpose | Examples |
|---|---|---|
| **Secrets** | Application authentication and configuration | Connection strings, API keys, passwords, SAS tokens |
| **Keys** | Encryption and decryption operations | Symmetric keys for data encryption, asymmetric keys for signing and key wrapping |
| **Certificates** | Identity verification and trust establishment | TLS/SSL certificates, code signing certificates, authentication certificates |

Each type requires different protection mechanisms and lifecycle management approaches.

## Azure key management solutions

Azure provides multiple key management services with different security and compliance levels. Select the service that matches your requirements:

| Service | Key protection | FIPS compliance | Tenancy |
|---|---|---|---|
| **Key Vault Standard** | Software-protected | FIPS 140-2 Level 1 | Multitenant |
| **Key Vault Premium** | HSM-protected (Marvell LiquidSecurity) | FIPS 140-3 Level 3 | Multitenant |
| **Key Vault Managed HSM** | Single-tenant HSM | FIPS 140-3 Level 3 | Single-tenant |
| **Azure Cloud HSM** | Customer-owned HSM cluster | FIPS 140-3 Level 3 | Single-tenant |

For most enterprise scenarios, Key Vault Premium provides adequate protection with HSM-backed keys. Choose Managed HSM when you require key sovereignty, single-tenant HSM administration, or the highest crypto operations throughput. Azure Cloud HSM is the successor to Azure Dedicated HSM and supports PKCS#11, OpenSSL, and other industry-standard APIs for applications migrating from on-premises HSMs.

## Designing secret management

Secrets are the most common assets stored in Key Vault. Design your secret management approach with these considerations:

### Secret access patterns

- **Application access**: Use managed identities to authenticate applications to Key Vault without storing credentials.
- **User access**: Grant access through Microsoft Entra role-based access control (RBAC).
- **CI/CD access**: Use workload identity federation for deployment pipelines to avoid storing service principal secrets.

### Secret lifecycle management

- **Rotation**: Implement autorotation using Event Grid events and Azure Functions to update secrets and dependent services automatically. Key Vault supports rotation scenarios for resources with one or two sets of authentication credentials.
- **Expiration**: Set expiration dates on secrets and configure Event Grid notifications before secrets expire.
- **Versioning**: Key Vault automatically versions secrets. Configure applications to reference the latest version.

### Design considerations for secrets

- Store all application secrets in Key Vault rather than in code, configuration files, or environment variables.
- Use Key Vault references in App Service, Azure Functions, and Container Apps for direct integration without custom code.
- Don't use Key Vault for general application configuration data. Use Azure App Configuration for nonsensitive settings.
- Separate Key Vaults by application, region, and environment to limit the blast radius of a security event.

## Designing key management

Cryptographic keys require careful management to ensure data protection without operational disruption.

### Customer-managed keys (CMK)

Many Azure services support customer-managed keys for encryption at rest, including Azure Storage, Azure SQL Database, Azure Cosmos DB, and Azure Disk Encryption. Keys remain in Key Vault or Managed HSM while services request cryptographic operations, providing control over the key lifecycle and a full audit trail.

### Key lifecycle management

- **Autorotation**: Configure key rotation policies in Key Vault with configurable intervals (minimum seven days). Azure services using CMKs automatically adopt new key versions for new encryption operations while maintaining access to data encrypted with previous versions.
- **Bring your own key (BYOK)**: Import HSM-protected keys from on-premises HSMs into Key Vault Premium or Managed HSM for regulatory compliance scenarios.
- **Backup**: Back up keys that can't be regenerated from other sources. For most scenarios, Key Vault's built-in redundancy provides sufficient protection.

## Designing certificate management

Azure Key Vault simplifies certificate lifecycle management with integrated acquisition and renewal.

### Certificate sources

- **Key Vault-generated**: Create self-signed certificates or request certificates from integrated certificate authorities (DigiCert, GlobalSign).
- **Imported**: Import existing certificates in PFX or PEM format.

### Certificate lifecycle

- **Autorotation**: Configure automatic renewal at a specified percentage of the certificate lifetime (for example, 80%) or a set number of days before expiry. Key Vault handles renewal with integrated CAs or regenerates self-signed certificates.
- **Notifications**: Use Event Grid to receive configurable near-expiry alerts (by percentage of lifetime or days before expiry), expiration notifications, and renewal events.
- **Distribution**: Applications retrieve certificates from Key Vault at runtime using managed identities.

### Certificate design considerations

- Store certificates as Key Vault certificate objects, not as secrets. Certificate objects support autorotation, expiration tracking, and CA integration.
- Store private keys in Key Vault rather than on application servers.
- Plan for certificate rotation in applications that use certificate pinning.

## Data protection and recovery

Protect Key Vault assets against accidental or malicious deletion and plan for disaster recovery:

- **Soft delete**: Enabled by default, soft delete retains deleted vaults and objects for a configurable period (7-90 days, default 90). Once enabled, soft delete can't be disabled.
- **Purge protection**: Prevents permanent deletion of vaults and objects until the retention period elapses. No administrator role—including Microsoft—can override purge protection. Enable purge protection for all production vaults.
- **Availability and redundancy**: Key Vault automatically replicates data within the region and to a paired region (where available), providing built-in disaster recovery without customer configuration.
- **Backup**: Use manual backups only when required for compliance or for objects that can't be recreated from other sources. Key Vault's built-in redundancy and soft delete are sufficient for most scenarios.

## Access control design

Control who and what can access Key Vault assets, aligned with Zero Trust principles.

### RBAC versus access policies

| Model | Recommendation | Granularity |
|---|---|---|
| **Azure RBAC** | Recommended for all new deployments | Per-secret, per-key, per-certificate |
| **Vault access policies** | Legacy | Vault-level only |

Azure RBAC provides finer-grained control and consistent management with other Azure resources. Key built-in roles include Key Vault Administrator, Key Vault Secrets User, Key Vault Certificates Officer, Key Vault Crypto Officer, and Key Vault Purge Operator.

### Network access control

- Use private endpoints to restrict Key Vault access to your virtual networks.
- Configure firewall rules to allow only specific IP ranges or trusted Azure services.
- Disable public network access for production Key Vaults.

## Microsoft solutions for secrets, keys, and certificates

| Solution | Capability |
|---|---|
| **Azure Key Vault** | Centralized secret, key, and certificate management with Standard, Premium, and Managed HSM tiers |
| **Azure Cloud HSM** | Customer-owned, single-tenant HSM for PKCS#11 and custom applications |
| **Managed identities** | Credential-free authentication to Key Vault and other Azure services |
| **Key Vault references** | Direct integration with App Service, Functions, and Container Apps |
| **Event Grid integration** | Notifications for expiration, rotation, and lifecycle events |
| **Azure Policy** | Enforce Key Vault configuration standards (soft delete, purge protection, key types, certificate validity) |
| **Microsoft Defender for Key Vault** | Threat detection for unusual or suspicious access patterns |

## Design considerations for security architects

- **Use separate vaults per application, region, and environment**: Each vault defines a security boundary. If a vault is compromised, only the secrets within that vault are exposed. For example, use distinct vaults for production and development, and for each application or service.
- **Create separate key vaults per tenant in multitenant SaaS solutions**: Each tenant's secrets, keys, and certificates are stored within a separate access control and security boundary. A compromise or misconfiguration in one tenant's vault doesn't expose another tenant's cryptographic assets.
- **Eliminate application secrets**: Use managed identities wherever possible so that workloads authenticate without stored connection strings, API keys, or service principal secrets.
- **Design for autorotation**: Configure key rotation policies, event-driven secret rotation, and certificate autorenewal to reduce manual effort and prevent expiration outages.
- **Enforce data protection**: Enable soft delete and purge protection on all production vaults. Use Azure Policy to enforce these settings across your organization.
- **Implement least privilege**: Use Azure RBAC to grant minimal necessary permissions. Separate management-plane and data-plane access.
- **Monitor and detect threats**: Enable diagnostic logging, configure Microsoft Defender for Key Vault, and set up Event Grid alerts for sensitive operations.
- **Align with Zero Trust**: Key management supports the Zero Trust principle of "use least privilege access." Verify explicitly, grant minimal permissions, and assume breach in all access patterns.
