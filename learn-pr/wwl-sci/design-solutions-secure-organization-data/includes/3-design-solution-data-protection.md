After discovering and classifying your data, the next priority is implementing protection mechanisms that mitigate threats. This unit focuses on evaluating encryption solutions for data at rest and in transit, specifying priorities for threat mitigation, and understanding key management with Azure Key Vault.

## Specifying priorities for mitigating threats to data

The MCSB and WAF Security pillar provide guidance for prioritizing data protection measures. Consider these threats and corresponding mitigations:

### Threat prioritization framework

| Priority | Threat | Mitigation approach |
|----------|--------|---------------------|
| **Critical** | Unauthorized access to sensitive data | Encryption, access controls, authentication |
| **High** | Data exfiltration | DLP policies, network controls, monitoring |
| **High** | Man-in-the-middle attacks | TLS 1.2+, certificate management |
| **Medium** | Accidental exposure | Classification, labeling, policy enforcement |
| **Medium** | Key compromise | HSM protection, key rotation, separation of duties |

### Defense in depth for data protection

The CAF Secure methodology recommends implementing layered controls:

- **Encryption layer**: Protect data confidentiality through encryption at rest and in transit
- **Access control layer**: Limit who can access data through identity and authorization
- **Network layer**: Isolate data through private endpoints and network segmentation
- **Monitoring layer**: Detect anomalies and threats through logging and alerting

## MCSB controls for data protection

### DP-3: Encrypt sensitive data in transit

Data in transit requires protection against interception and tampering:

- **Enforce TLS 1.2 or higher** for all network communications
- **Disable legacy protocols** including SSL 3.0, TLS 1.0, and TLS 1.1
- **Use strong cipher suites** that provide forward secrecy
- **Implement certificate validation** to prevent man-in-the-middle attacks

The WAF recommends treating all data as sensitive when in transit—don't rely on network isolation alone.

### DP-4: Enable data at rest encryption by default

Azure provides encryption at rest by default for most services:

- **Platform-managed keys (PMK)**: Microsoft manages encryption keys automatically
- **Service-side encryption (SSE)**: Data encrypted before storage, decrypted on retrieval
- **AES-256 encryption**: Industry-standard algorithm used across Azure services

### DP-5: Use customer-managed keys when required

For regulatory compliance or additional control, implement customer-managed keys (CMK):

| Consideration | Platform-managed keys | Customer-managed keys |
|---------------|----------------------|----------------------|
| **Key control** | Microsoft | Customer |
| **Key rotation** | Automatic | Customer responsibility |
| **Compliance** | Standard | Enhanced for regulated industries |
| **Complexity** | Low | Higher operational overhead |
| **Use case** | General workloads | Regulated data, sovereignty requirements |

### DP-6: Use a secure key management process

Key management requires:

- **Centralized key storage**: Use Azure Key Vault rather than storing keys in code or configuration
- **Least privilege access**: Grant key access only to identities that require it
- **Key rotation policies**: Rotate keys according to compliance requirements
- **Audit logging**: Track all key access and operations

## Encryption design considerations

### Data at rest encryption

When designing encryption at rest:

- **Identify encryption requirements** based on data classification and compliance needs
- **Choose encryption scope** at account, container, or object level
- **Determine key management approach** between platform-managed and customer-managed
- **Enable infrastructure encryption** for double encryption when required

#### Double encryption

For highly sensitive workloads, implement [double encryption](/azure/security/fundamentals/double-encryption):

- **Service-level encryption**: First layer using the service's encryption capability
- **Infrastructure encryption**: Second layer at the storage infrastructure level
- **Different keys**: Each layer uses independent keys and algorithms

### Data in transit encryption

Design considerations for data in transit:

- **Enforce HTTPS** for all web traffic and API calls
- **Configure minimum TLS version** to 1.2 across all services
- **Use private connectivity** through Private Link where possible
- **Encrypt within virtual networks** using VPN or ExpressRoute with encryption

## Azure Key Vault for key management

[Azure Key Vault](/azure/key-vault/general/overview) provides centralized secrets, key, and certificate management:

### Key Vault capabilities

- **Key management**: Create, import, and control cryptographic keys
- **Secret management**: Securely store and control access to tokens, passwords, and API keys
- **Certificate management**: Provision, manage, and deploy SSL/TLS certificates
- **HSM protection**: Store keys in FIPS 140-2 Level 2 or Level 3 validated HSMs

### Key Vault design recommendations

| Recommendation | Rationale |
|----------------|-----------|
| **Use separate vaults** for different environments | Isolate production keys from development |
| **Enable soft delete and purge protection** | Prevent accidental or malicious key deletion |
| **Use managed identities** for access | Eliminate credential management |
| **Implement RBAC** over access policies | Provide finer-grained access control |
| **Enable logging** to Azure Monitor | Track all key operations |

### Infrastructure encryption

For workloads requiring the highest protection:

- **Azure Storage infrastructure encryption**: Double encryption at the infrastructure layer
- **Azure SQL TDE with CMK**: Customer-managed keys for transparent data encryption
- **Azure Disk Encryption**: BitLocker (Windows) or dm-crypt (Linux) for VM disks

## Microsoft solutions for data protection

### Microsoft Purview Data Loss Prevention

[Microsoft Purview DLP](/purview/dlp-learn-about-dlp) prevents sensitive data from leaving your organization:

- **Policy-based protection**: Define rules based on sensitive information types
- **Endpoint DLP**: Protect data on Windows and macOS devices
- **Cloud DLP**: Protect data in Microsoft 365 services
- **Integration with labels**: Use sensitivity labels to trigger DLP policies

### Azure Information Protection

Labels applied through classification can trigger protection:

- **Encryption**: Automatically encrypt documents based on labels
- **Access restrictions**: Limit who can open or modify protected content
- **Watermarking**: Apply visual markings to indicate sensitivity
- **Expiration**: Set time limits on document access

## Bringing it together

Effective data protection requires a defense-in-depth approach that combines encryption, access controls, network isolation, and monitoring. Encrypt all data by default—both at rest and in transit—using TLS 1.2 or higher and AES-256 encryption. Centralize key management in Azure Key Vault, using HSM protection for the most sensitive workloads and implementing key rotation policies based on compliance requirements. Classification labels should trigger protection actions through DLP policies and Azure Information Protection, ensuring that sensitivity levels drive the appropriate encryption choices and access restrictions throughout your environment.
