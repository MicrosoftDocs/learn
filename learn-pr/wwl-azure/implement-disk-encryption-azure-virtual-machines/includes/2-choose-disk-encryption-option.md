Azure provides four disk encryption options for virtual machines. Each addresses different security requirements and coverage scopes. Understanding these options helps you select the approach that meets your compliance obligations while preparing for upcoming platform changes.

| Option | What it encrypts | Key management | Status |
|--------|------------------|----------------|--------|
| Server-side encryption (SSE) | OS and data disks only | Platform-managed or customer-managed | Current default |
| Encryption at host | OS disks, data disks, temp disks, caches | Platform-managed or customer-managed | Recommended for new VMs |
| Azure Disk Encryption (ADE) | OS and data disks | Customer-managed via Key Vault | Retiring September 15, 2028 |
| Confidential disk encryption | OS disk (confidential VMs only) | vTPM-bound | For confidential computing workloads |

## Server-side encryption: The baseline

Server-side encryption (SSE) runs automatically on all Azure managed disks. When you create a virtual machine, Azure encrypts the OS and data disks at the storage platform level using AES-256 encryption. This protection requires no configuration and provides defense against physical disk theft or improper disposal.

SSE doesn't encrypt temporary disks or disk caches. For Contoso Manufacturing, this limitation creates the compliance gap identified during their audit. Production data written to temp storage or cached during high-throughput operations remains unencrypted, violating ISO 27001 requirements for comprehensive data protection at rest.

## Encryption at host: The current recommendation

Encryption at host extends SSE coverage to include temporary disks and disk caches. Azure encrypts data flows end-to-end from the VM through the storage layer, addressing the exact gap in Contoso's environment. This approach provides the most comprehensive encryption available for standard VMs.

With encryption at host enabled, all data leaving the VM undergoes encryption before reaching Azure Storage. This includes:

- OS disk read/write operations
- Data disk I/O
- Temporary disk storage (D: drive on Windows, /dev/sdb1 on Linux)
- Disk controller cache operations

You enable encryption at host as a VM property during creation or by stopping an existing VM, enabling the feature, then restarting. The encryption layer sits between the VM and the storage subsystem, requiring no changes to guest OS configurations or application code. For workloads migrating from Azure Disk Encryption before the September 2028 retirement deadline, encryption at host provides a seamless replacement with broader protection coverage.

## Azure Disk Encryption: Legacy option with retirement deadline

Azure Disk Encryption (ADE) uses BitLocker (Windows) or DM-Crypt (Linux) to encrypt disks from within the guest operating system. Many existing Azure workloads currently use this approach. However, Microsoft announced that ADE retires on September 15, 2028.

On September 15, 2028, ADE-enabled workloads will continue to run, but encrypted disks will fail to unlock after VM reboots, causing service disruption. All ADE-enabled VMs and their backups must migrate to encryption at host before the retirement date to avoid this disruption.

Organizations using ADE must migrate to encryption at host or another supported option before the retirement date. The migration involves:

1. Creating snapshots of encrypted disks
2. Creating new VMs with encryption at host enabled
3. Restoring data from snapshots to the new encrypted environment
4. Validating application functionality
5. Decommissioning the ADE-protected VMs

Unlike encryption at host, ADE requires guest OS integration, consumes VM compute resources for encryption operations, and doesn't encrypt temporary disks. These limitations make encryption at host the superior replacement for most workloads.

## Confidential disk encryption: Hardware-isolated protection

Confidential virtual machines provide hardware-based isolation using AMD SEV-SNP (Secure Encrypted Virtualization - Secure Nested Paging) technology. When you create a confidential VM, you can enable confidential disk encryption, which binds the OS disk encryption key to the VM's virtual Trusted Platform Module (vTPM).

This binding ensures that only that specific VM instance can decrypt the OS disk. If an attacker copies the encrypted disk to another system or even another Azure VM, decryption fails because the vTPM key remains isolated within the original VM's hardware-protected boundary. Confidential disk encryption targets workloads processing highly sensitive data subject to regulatory requirements like ITAR, HIPAA, or trade secret protection.

Confidential VMs use DCasv5 or ECasv5 series sizes and require the security type set to "Confidential virtual machine" at creation time. You can't convert existing standard VMs to confidential VMs. For Contoso Manufacturing, confidential disk encryption applies to systems processing proprietary formulas or intellectual property. The systems require defense against both external attackers and insider threats with administrative access.

## Enforce compliance with Azure Policy

Azure provides built-in policies to enforce disk encryption requirements across your VM fleet. Two key policies address encryption compliance:

- **Windows virtual machines should enable Azure Disk Encryption or EncryptionAtHost** - Audits Windows VMs where ADE and encryption at host isn't enabled
- **Linux virtual machines should enable Azure Disk Encryption or EncryptionAtHost** - Audits Linux VMs where ADE and encryption at host isn't enabled

Both policies use the `AuditIfNotExists` effect—they flag noncompliant VMs in the compliance dashboard but don't block VM deployment.

These policies accommodate both legacy ADE deployments and modern encryption at host configurations, allowing gradual migration while maintaining compliance oversight. You assign policies at subscription or resource group scope, then monitor compliance through Microsoft Defender for Cloud's regulatory compliance dashboard. For Contoso's ISO 27001 certification maintenance, these policies provide continuous evidence that all production VMs meet encryption requirements.

## Choose the right option for Contoso Manufacturing

For Contoso's compliance gap, encryption at host provides the optimal solution. It encrypts temporary disks and caches that SSE misses, directly addressing the audit finding. New production VMs enable encryption at host at deployment time. Existing VMs undergo a planned migration window where each system stops, enables encryption at host, then restarts with full protection coverage.

Contoso can implement customer-managed keys (CMK) through a Disk Encryption Set to maintain organizational control over encryption key lifecycle, rotation policies, and access logging. This approach satisfies the ISO 27001 requirement for documented key management procedures while preparing the environment for future growth.

With encryption options understood, you're ready to configure encryption at host using customer-managed keys stored in Azure Key Vault.
