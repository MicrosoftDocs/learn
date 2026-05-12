Contoso Manufacturing operates factory management systems on Azure virtual machines. During a recent ISO 27001 compliance audit, assessors identified a critical security gap: production VMs lack full disk encryption. While the OS and data disks use Azure's default server-side encryption, temporary disks and disk caches remain unencrypted. This gap exposes sensitive manufacturing process data—including programmable logic controller (PLC) configurations, supply chain logistics, and proprietary formulas—to potential access if physical hardware or hypervisor-level compromise occurs.

As Contoso's security engineer, you need to close this compliance gap while maintaining operational efficiency. You also need to plan for the September 15, 2028 retirement of Azure Disk Encryption (ADE), the legacy BitLocker/DM-Crypt solution that many existing workloads currently use. Modern encryption approaches provide better coverage and align with Zero Trust principles requiring data protection at rest across all storage locations.

In this module, you:

- Compare Azure managed disk encryption options and select the appropriate approach for new and existing VMs
- Configure encryption at host with customer-managed keys using a Disk Encryption Set and Azure Key Vault
- Apply confidential disk encryption to confidential virtual machines
- Enforce disk encryption compliance using Azure Policy

## Prerequisites

- Experience deploying and managing Azure virtual machines
- Understanding of encryption concepts including symmetric encryption and key management
- Familiarity with Azure Key Vault and managed identities

Now that you understand the compliance challenge Contoso faces, you explore the available disk encryption options and determine which approach addresses their audit finding.
