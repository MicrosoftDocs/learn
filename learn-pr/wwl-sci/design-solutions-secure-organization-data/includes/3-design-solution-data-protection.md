After discovering, classifying, and prioritizing threats to your data, the next step is evaluating the encryption solutions that protect it. This unit focuses on choosing the right key management approach, selecting an Azure Key Vault tier, and understanding how infrastructure encryption adds a second layer of defense.

## Evaluate key management approaches

Azure encrypts all data at rest by default using AES-256 and encrypts all data in transit between datacenters automatically. The architecture relies on [envelope encryption](/azure/security/fundamentals/encryption-atrest): a **data encryption key (DEK)** encrypts each block of data, and a **key encryption key (KEK)** stored in Azure Key Vault encrypts the DEK.

As a security architect, the core decision is who controls the KEK—Microsoft through **platform-managed keys (PMK)**, or your organization through **customer-managed keys (CMK)**:

| Key type | KEK control | Key rotation | Overhead | Crypto-erasure | Typical use case |
|---|---|---|---|---|---|
| **PMK** | Microsoft generates, stores, rotates | Automatic (every two years) | None | Not available | General workloads with default encryption |
| **CMK** | Customer controls via Key Vault or Managed HSM | Customer-configured; supports [auto-rotation](/azure/key-vault/keys/how-to-configure-key-rotation) | Higher—key lifecycle management required | Disable KEK to erase all wrapped data | Regulated data, sovereignty, crypto-erase |

PMK is the right default for most workloads. CMK adds control at the cost of operational complexity—choose it when regulations demand it or when you need the ability to cryptographically erase data by disabling the key.

### Bring Your Own Key (BYOK)

Organizations that generate keys in their own on-premises HSMs can [import them into Key Vault](/azure/key-vault/keys/byok-specification) to maximize key lifetime and portability while still using Azure services for encryption. BYOK is the recommended approach when compliance requires that keys originate outside of Azure.

## Evaluating Azure Key Vault tiers

Azure offers three key management options. The right choice depends on your compliance requirements, isolation needs, and budget. The table below compares them across several dimensions—here's a brief primer on the key concepts:

- **FIPS validation level** determines the security assurance of the cryptographic module. FIPS 140-2 Level 1 validates that an approved algorithm is used but imposes no physical security requirements—keys are processed in software. FIPS 140-3 Level 3 requires tamper-evident and tamper-resistant HSM hardware with identity-based authentication. Key material cannot be extracted even with physical access to the device.
- **HSM tenancy** describes whether the hardware security module protecting your keys is shared across customers (multitenant), dedicated exclusively to your organization (single-tenant), or not applicable because keys are software-backed.
- **Key types** refer to the cryptographic algorithms available. RSA keys use large integer factoring and are widely supported; common sizes are 2,048 bits, 3,072 bits, and 4,096 bits. Elliptic Curve (EC) keys provide equivalent security at shorter key lengths—for example, a 256-bit EC key is comparable in strength to a 3072-bit RSA key. Managed HSM also supports symmetric (AES) keys for workloads that need them.

| Tier | FIPS validation | HSM tenancy | Key types | BYOK | Best for |
|---|---|---|---|---|---|
| **Key Vault Standard** | [FIPS 140-2 Level 1](/azure/key-vault/keys/about-keys#compliance) (software-backed) | N/A | RSA, EC (software) | No | Dev/test, secrets, certificates |
| **Key Vault Premium** | [FIPS 140-3 Level 3](/azure/key-vault/keys/about-keys#compliance) (shared HSM) | Multitenant | RSA, EC (software and HSM) | Yes | Production CMK workloads |
| **Managed HSM** | [FIPS 140-3 Level 3](/azure/key-vault/keys/about-keys#compliance) (single-tenant HSM) | Single-tenant with dedicated [security domain](/azure/key-vault/managed-hsm/security-domain) | RSA, EC, symmetric (HSM only) | Yes | Highest regulatory bar, crypto-isolation |

### Key Vault design recommendations

| Recommendation | Rationale |
|---|---|
| **Use separate vaults** for different environments | Isolate production keys from development |
| **Enable soft delete and purge protection** | Prevent accidental or malicious key deletion |
| **Use managed identities** for vault access | Eliminate credential management |
| **Implement RBAC** over access policies | Finer-grained access control with audit trail |
| **Enable logging** to Azure Monitor | Track all key, secret, and certificate operations |
| **Use Private Link** for vault network access | Minimize vault exposure to public internet |

### Certificate management

Key Vault also handles TLS/SSL certificate lifecycle—provisioning, renewal, and revocation. Automated rotation with partner CAs (DigiCert, GlobalSign) reduces the risk of expired certificates causing outages. This aligns with MCSB control DP-7 (Use a secure certificate management process).

## Infrastructure encryption

Infrastructure encryption adds a second, independent layer of encryption that is transparent to your application. Azure provides this for both data at rest and data in transit.

### Double encryption for data at rest

For highly sensitive workloads, enable [double encryption](/azure/security/fundamentals/double-encryption):

- **Service-level encryption**—the first layer, using the service's normal encryption (PMK or CMK)
- **Infrastructure encryption**—a second layer at the storage infrastructure level using a separate platform-managed key

Each layer uses independent keys. Services that support infrastructure encryption include Azure Storage, Azure SQL Database, and Azure Managed Disks. Enable it at resource creation when required; it can't be added later.

### Encryption for data in transit

Azure provides two layers of transit encryption:

- **TLS 1.2 or later**—the application-layer protocol for all connections to Azure services. Configure the minimum TLS version on your resources and disable legacy protocols (SSL 3.0, TLS 1.0, TLS 1.1). Connections use [Perfect Forward Secrecy](/azure/security/fundamentals/encryption-overview) with RSA 2048-bit or ECC 256-bit key exchanges.
- **MACsec (IEEE 802.1AE)**—a data-link layer encryption applied automatically to all Azure traffic moving between datacenters, whether within a region or between regions. This prevents physical interception attacks on network hardware and requires no customer configuration.

For site-to-site traffic between on-premises networks and Azure VNets, use IPsec VPN gateways or ExpressRoute with MACsec to extend encryption beyond the Azure backbone.

## Summary

Choose PMK for most workloads and reserve CMK for regulated scenarios that demand Customer Key control or cryptographic erasure. Select a Key Vault tier based on the FIPS validation level and HSM tenancy your compliance posture requires. Layer infrastructure encryption on top of service-level encryption for the most sensitive data, and rely on Azure's automatic MACsec and enforced TLS 1.2 to protect data in transit without extra configuration.
