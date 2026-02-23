Applications and services require secrets, cryptographic keys, and certificates to authenticate, encrypt data, and establish trust. As a security architect, you design solutions that protect these sensitive assets throughout their lifecycle while enabling secure access for authorized workloads.

## Types of cryptographic assets

Understanding the different types of assets helps you design appropriate protection:

| Asset Type | Purpose | Examples |
|------------|---------|----------|
| **Secrets** | Application authentication and configuration | Connection strings, API keys, passwords |
| **Keys** | Encryption and decryption operations | Symmetric keys for data encryption, asymmetric keys for key wrapping |
| **Certificates** | Identity verification and trust establishment | TLS certificates, code signing certificates, authentication certificates |

Each type requires different protection mechanisms and lifecycle management approaches.

## Azure Key Vault service tiers

Azure Key Vault provides centralized management for secrets, keys, and certificates. Select the appropriate tier based on your security requirements:

| Tier | Key Protection | Use Case |
|------|---------------|----------|
| **Standard** | Software-protected keys | General purpose secret and key management |
| **Premium** | HSM-protected keys (FIPS 140-2 Level 2) | Compliance requirements, enhanced key protection |
| **Managed HSM** | Single-tenant HSM (FIPS 140-2 Level 3) | Highest security requirements, regulatory compliance, full HSM control |

For most scenarios, Premium tier provides adequate protection. Managed HSM is appropriate when you require single-tenant HSM, full control over HSM administration, or must meet FIPS 140-2 Level 3 compliance.

## Designing secret management

Secrets are the most common assets stored in Key Vault. Design your secret management approach with these considerations:

### Secret access patterns

- **Application access** - Use managed identities to authenticate applications to Key Vault without storing credentials
- **User access** - Grant access through Microsoft Entra role-based access control (RBAC)
- **CI/CD access** - Use service principals or workload identity federation for deployment pipelines

### Secret lifecycle management

- **Versioning** - Key Vault automatically versions secrets; configure applications to use latest or specific versions
- **Rotation** - Plan for regular rotation using Event Grid integration and Azure Functions for automated rotation
- **Expiration** - Set expiration dates and configure alerts before secrets expire

### Design considerations for secrets

- Store all application secrets in Key Vault rather than configuration files or environment variables
- Use Key Vault references in App Service, Azure Functions, and other services that support direct integration
- Implement separate Key Vaults for different environments (development, production)

## Designing key management

Cryptographic keys require careful management to ensure data protection without operational disruption.

### Key types and operations

| Key Type | Operations | Use Case |
|----------|------------|----------|
| **RSA** | Encrypt, decrypt, sign, verify, wrap, unwrap | General purpose encryption, key wrapping |
| **EC** | Sign, verify | Digital signatures, authentication |
| **Symmetric (AES)** | Encrypt, decrypt, wrap, unwrap | High-performance bulk encryption |

### Customer-managed keys (CMK)

Many Azure services support customer-managed keys for encryption at rest:

- Azure Storage, Azure SQL Database, Azure Cosmos DB, Azure Disk Encryption
- Keys remain in Key Vault; services request encryption/decryption operations
- Provides control over key lifecycle and audit trail

### Key lifecycle management

- **Key rotation** - Plan for regular key rotation; use automatic key rotation where supported
- **Key backup** - Maintain key backups for disaster recovery
- **Key versioning** - Applications should handle key versioning for encryption/decryption continuity

## Designing certificate management

Azure Key Vault simplifies certificate lifecycle management with integrated acquisition and renewal.

### Certificate sources

- **Key Vault-generated** - Create certificates directly in Key Vault
- **Imported** - Import existing certificates (PFX/PEM format)
- **Integrated CA** - Automatic issuance from DigiCert or GlobalSign

### Certificate lifecycle

- **Automatic renewal** - Configure auto-renewal before expiration for integrated CA certificates
- **Renewal notifications** - Set up alerts using Event Grid for renewal reminders
- **Certificate distribution** - Applications retrieve certificates from Key Vault at runtime

### Certificate design considerations

- Store private keys in Key Vault rather than on application servers
- Use managed identities for application access to certificates
- Implement certificate pinning carefully; plan for certificate rotation

## Access control design

Control who and what can access Key Vault secrets, keys, and certificates.

### RBAC versus access policies

Azure Key Vault supports two permission models:

| Model | Recommendation | Granularity |
|-------|---------------|-------------|
| **Azure RBAC** | Recommended | Per-secret, per-key, per-certificate |
| **Vault access policies** | Legacy | Vault-level only |

Use Azure RBAC for new deployments. It provides finer-grained control and consistent management with other Azure resources.

### Built-in roles

- **Key Vault Administrator** - Full access to manage vault and contents
- **Key Vault Secrets User** - Read secrets only (appropriate for applications)
- **Key Vault Certificates Officer** - Manage certificates
- **Key Vault Crypto Officer** - Manage keys and perform cryptographic operations

### Network access control

- Use private endpoints to restrict Key Vault access to your virtual networks
- Configure firewall rules to allow only specific IP ranges or Azure services
- Disable public network access for production Key Vaults

## Microsoft solutions for secrets management

The following capabilities support your secrets management design:

- **Azure Key Vault** - Centralized secret, key, and certificate management
- **Managed identities** - Credential-free authentication to Key Vault
- **Key Vault references** - Direct integration with App Service, Functions, Container Apps
- **Event Grid integration** - Secret expiration alerts and automation triggers
- **Azure Policy** - Enforce Key Vault configuration standards
- **Microsoft Defender for Key Vault** - Threat detection for unusual access patterns

## Design considerations for security architects

When designing secrets management solutions:

- **Centralize management** - Consolidate secrets in Key Vault rather than distributed storage
- **Eliminate stored credentials** - Use managed identities wherever possible
- **Plan for rotation** - Design applications to handle secret rotation without downtime
- **Separate by environment** - Use different Key Vaults for production and nonproduction
- **Implement least privilege** - Grant minimal necessary permissions using Azure RBAC
- **Monitor access** - Enable diagnostic logging and configure alerts for sensitive operations
- **Consider availability** - Deploy Key Vault in regions matching your application for latency and availability
