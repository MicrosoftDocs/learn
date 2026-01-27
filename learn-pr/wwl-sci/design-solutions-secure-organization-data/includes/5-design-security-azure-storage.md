Azure Storage provides foundational data services including Blob storage, Azure Files, Queue storage, and Table storage. Securing these services requires careful consideration of network controls, encryption options, and access management aligned with MCSB data protection controls.

## Design considerations for Azure Storage security

### Network security options

Azure Storage offers multiple network security mechanisms:

| Mechanism | Description | Use case |
|-----------|-------------|----------|
| **Firewall rules** | Allow access from specific IP addresses/ranges | Known client IPs |
| **Virtual network rules** | Allow access from specific VNet subnets | Azure resources |
| **Private endpoints** | Private IP within your VNet | Complete network isolation |
| **Service endpoints** | Optimized route from VNet to storage | High bandwidth requirements |

The MCSB control [NS-2](/azure/cloud-adoption-framework/organize/cloud-security-infrastructure-endpoint) recommends using private endpoints to secure cloud services, which applies directly to Azure Storage.

### Network isolation strategies

When designing network security for Azure Storage:

1. **Disable public blob access** at the storage account level for sensitive data
2. **Configure private endpoints** for each storage service (blob, file, queue, table)
3. **Use network security groups** to control traffic to private endpoints
4. **Implement Azure Firewall** or NVA for centralized traffic inspection

### DNS considerations for private endpoints

Private endpoints require DNS configuration to resolve storage account names to private IP addresses:

- **Azure Private DNS zones**: Automatic resolution for Azure resources
- **DNS forwarders**: Required for on-premises name resolution
- **Custom DNS**: Configure A records pointing to private endpoint IPs

## Encryption for Azure Storage

### Encryption at rest

[Azure Storage encryption](/azure/storage/common/storage-service-encryption) protects data at rest using AES-256 encryption. This encryption is enabled by default for all storage accounts.

#### Key management options

| Option | Key location | Control | Use case |
|--------|--------------|---------|----------|
| **Microsoft-managed keys** | Microsoft | Microsoft | Standard workloads |
| **Customer-managed keys (CMK)** | Azure Key Vault | Customer | Regulatory compliance |
| **Customer-provided keys** | Customer | Customer | Per-request control |

Customer-managed keys align with MCSB control [DP-5: Use customer-managed key option in data at rest encryption when required](/security/benchmark/azure/mcsb-data-protection#dp-5-use-customer-managed-key-option-in-data-at-rest-encryption-when-required).

### Infrastructure encryption (double encryption)

[Infrastructure encryption](/azure/storage/common/infrastructure-encryption-enable) provides a second layer of encryption for highly sensitive data:

- **First layer**: Service-level encryption with service-managed or customer-managed keys
- **Second layer**: Infrastructure-level encryption with Microsoft-managed keys

Enable infrastructure encryption at storage account creation for:

- Regulatory requirements mandating double encryption
- Defense-in-depth for highly sensitive workloads
- Compliance with internal security policies

### Encryption in transit

Configure encryption in transit through:

- **Require secure transfer**: Force HTTPS for all REST API operations
- **Minimum TLS version**: Set TLS 1.2 as minimum (recommended)
- **SMB 3.0 encryption**: Required for Azure Files access

## Access management for Azure Storage

### Authentication methods

Azure Storage supports multiple authentication mechanisms:

| Method | Protocol | Use case |
|--------|----------|----------|
| **Microsoft Entra ID** | REST API | Azure resources, applications |
| **Shared Key** | REST API | Legacy applications |
| **Shared Access Signatures (SAS)** | REST API | Delegated access |
| **AD DS/Microsoft Entra Domain Services** | SMB | Azure Files identity-based access |

The MCSB recommends using Microsoft Entra ID with managed identities for authentication whenever possible.

### Authorization options

#### Azure RBAC for data plane

Azure Storage supports [data plane RBAC](/azure/storage/blobs/authorize-access-azure-active-directory) with built-in roles:

- **Storage Blob Data Owner**: Full access including ACL management
- **Storage Blob Data Contributor**: Read, write, delete blob data
- **Storage Blob Data Reader**: Read blob data only
- **Storage Queue Data Contributor**: Read, write, delete queue messages

#### Shared Access Signatures (SAS)

When SAS tokens are necessary, follow these best practices:

1. **Use user delegation SAS** backed by Microsoft Entra credentials
2. **Apply shortest practical validity periods**
3. **Grant minimum required permissions**
4. **Use stored access policies** for service SAS management
5. **Implement secure SAS distribution** mechanisms

### Blob access tiers and security

Access tier selection affects cost and availability, not security:

- **Hot, Cool, Cold, Archive** tiers all use the same encryption
- Configure **lifecycle management policies** for automatic tier transitions
- Archive tier requires rehydration before access

## Threat protection for Azure Storage

### Microsoft Defender for Storage

[Microsoft Defender for Storage](/azure/defender-for-cloud/defender-for-storage-introduction) provides:

- **Activity monitoring**: Detect unusual access patterns
- **Malware scanning**: Scan uploaded content for malicious files
- **Sensitive data threat detection**: Alert on suspicious access to sensitive data
- **Hash reputation analysis**: Identify known malware based on file hashes

Defender for Storage aligns with MCSB control [DP-2: Monitor anomalies and threats targeting sensitive data](/security/benchmark/azure/mcsb-data-protection#dp-2-monitor-anomalies-and-threats-targeting-sensitive-data).

### Logging and monitoring

Enable diagnostic settings to capture:

- **StorageRead**: All read operations
- **StorageWrite**: All write operations
- **StorageDelete**: All delete operations
- **Transaction metrics**: Performance and availability data

Send logs to:

- **Log Analytics workspace**: Query and analyze with KQL
- **Storage account**: Long-term retention and compliance
- **Event Hub**: SIEM integration

## Immutable storage for compliance

[Immutable blob storage](/azure/storage/blobs/immutable-storage-overview) supports regulatory compliance requirements:

### Time-based retention policies

- Set retention period for data protection
- Locked policies cannot be shortened
- Supports legal hold for litigation

### Version-level immutability

- Apply policies at blob version level
- Enable versioning to maintain history
- Combine with legal holds for complete protection

Use immutable storage for:

- Financial records requiring SEC 17a-4 compliance
- Healthcare records under HIPAA retention rules
- Legal documents subject to litigation hold

## Bringing it together

Securing Azure Storage requires a layered approach across network, identity, encryption, and monitoring. Use private endpoints and disable public blob access for accounts containing sensitive data. Implement Microsoft Entra authentication with RBAC, preferring user delegation SAS over shared keys. Enable infrastructure encryption with customer-managed keys for regulated workloads, and require secure transfer (HTTPS only) with TLS 1.2 minimum. Enable Microsoft Defender for Storage with malware scanning for accounts accepting uploads, and configure diagnostic logging to detect anomalous activity.
