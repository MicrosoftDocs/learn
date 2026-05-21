Before you migrate data, establish the security foundation for your target storage environment. Configuring security at this stage is significantly easier than retrofitting it after migration. If you set up network controls, identity management, and encryption before any data moves, your environment is protected from the first byte transferred.

## Network security

Restrict access to your storage accounts to only the networks that need it:

- Use Private Endpoints to expose storage accounts only on your virtual network. This removes public internet exposure entirely.
- If Private Endpoints aren't feasible, configure Storage Firewalls with virtual network rules and IP allow lists.
- During migration, the migration tool (for example, the Storage Mover agent or File Sync agent) must have network access to the target. Plan firewall rules accordingly.

Learn more: [Use private endpoints for Azure Storage](/azure/storage/common/storage-private-endpoints)

## Identity and access management

With network access locked down, the next layer is controlling who can authenticate and what they can do. Plan how applications and users authenticate and authorize access to data after migration:
- **Azure RBAC**: Assign roles (Storage Blob Data Contributor, Storage File Data SMB Share Contributor, and so on) to users, groups, and service principals.
- **Managed Identities**: Use system-assigned or user-assigned managed identities for applications running in Azure. This eliminates the need for storage account keys.
- **Shared Access Signatures (SAS)**: Use for time-limited, scoped access when RBAC isn't practical (for example, external partners).
- **Storage Account Keys**: Avoid using account keys in production. If legacy applications require them, plan to rotate keys regularly and migrate to Managed Identities.
- **On-premises Active Directory**: For Azure Files with SMB, configure identity-based authentication using on-premises AD DS or Microsoft Entra Domain Services.

Learn more: [Authorize access with Microsoft Entra ID](/azure/storage/blobs/authorize-access-azure-active-directory)

## Encryption

Beyond controlling who can access your data, you also need to protect the data itself. All data in Azure Storage is encrypted at rest by default using Microsoft-managed keys. Consider whether your compliance requirements need additional control:
- **Customer-managed keys (CMK)** stored in Azure Key Vault provide full control over encryption keys.
- **Infrastructure encryption** (double encryption) adds a second layer of encryption at the storage infrastructure level.
- **Encryption in transit**: All Azure Storage traffic uses TLS 1.2 by default. Enforce the minimum TLS version on your storage accounts.

Learn more: [Azure Storage security guide](/azure/storage/common/storage-security-guide)

## Key and secret rotation

Encryption keys and access credentials require ongoing management. Plan key management from the start:
- **Storage account keys**: Enable automated key rotation through Azure Key Vault to eliminate manual rotation processes and reduce the risk of leaked credentials.
- **SAS tokens**: Generate SAS tokens with the shortest practical expiry. Use stored access policies on containers and shares so you can revoke access without regenerating the storage account key.
- **Customer-managed encryption keys**: Configure automatic key rotation in Key Vault to ensure encryption keys are rotated on a defined schedule without disrupting storage access.

Learn more: [Configure key auto-rotation in Azure Key Vault](/azure/key-vault/keys/how-to-configure-key-rotation)

## Microsoft Defender for Storage

With access controls and encryption in place, add threat detection to complete your security posture. Enable Microsoft Defender for Storage on your target storage accounts to detect threats and suspicious activity:
- **Anomaly detection**: Identifies unusual access patterns such as access from unexpected locations, anomalous data exfiltration, or unusual changes in permissions.
- **Malware scanning**: Scans uploaded blobs for known malware using Microsoft Threat Intelligence. This is especially important when you migrate user-generated content or externally sourced data.
- **Sensitive data discovery**: Identifies storage accounts containing sensitive data such as credentials, personally identifiable information, or financial records.

> [!IMPORTANT]
> Enable Defender for Storage before migration begins so that your target environment is monitored from the first byte of data transferred.

Learn more: [Overview of Microsoft Defender for Storage](/azure/defender-for-cloud/defender-for-storage-introduction)

## Immutable storage and retention policies

If your migration involves data subject to regulatory or legal retention requirements, configure immutability policies on the target before transferring data:
- **Time-based retention policies**: Prevent data from being modified or deleted for a specified retention period. Used for regulatory compliance (SEC, FINRA, CFTC, and others).
- **Legal hold**: Prevents deletion or modification indefinitely until the hold is explicitly removed. Use for data subject to litigation or investigation.
- **Policy scope and locking**: Immutability policies apply at the container or blob version level and can be configured as locked (irreversible) or unlocked (modifiable).

> [!NOTE]
> Immutable storage is available for Azure Blob Storage and ADLS Gen2. Plan your container structure with retention requirements in mind before migration.

Learn more: [Immutable storage for Azure Blob Storage](/azure/storage/blobs/immutable-storage-overview)

## Governance with Azure Policy

Use Azure Policy to enforce security baselines consistently across all storage accounts created for the migration:
- **Deny public access**: Deny creation of storage accounts with public blob access enabled.
- **Require Private Endpoints**: Require Private Endpoints on all storage accounts.
- **Enforce TLS version**: Enforce minimum TLS version of 1.2.
- **Require CMK encryption**: Require customer-managed keys for encryption.
- **Audit Defender for Storage**: Audit storage accounts that don't have Microsoft Defender for Storage enabled.

Applying policies at the subscription or resource group level ensures that every storage account in your migration target meets your security standards, even as new accounts are added.

Learn more: [Azure Policy built-in definitions for Azure Storage](/azure/storage/common/policy-reference)

With your security foundation in place, you can migrate data with confidence that your target environment is protected from the start.
