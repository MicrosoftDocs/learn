In this module, you addressed Contoso Manufacturing's disk encryption compliance gap by implementing encryption at host to protect temporary disks and caches. You compared Azure's four managed disk encryption options, configured customer-managed keys through Disk Encryption Sets, and explored confidential disk encryption for hardware-isolated workloads.

## Key decisions for disk encryption

**Encryption at host is the recommended approach for new Azure VMs**. It provides end-to-end encryption covering OS disks, data disks, temporary storage, and disk caches—protection that server-side encryption (SSE) alone can't deliver. For organizations like Contoso with compliance requirements demanding comprehensive data protection at rest, encryption at host directly addresses audit findings around unencrypted temp disks.

**Azure Disk Encryption (ADE) retires on September 15, 2028**. If your environment currently uses BitLocker-based or DM-Crypt-based ADE, begin migration planning immediately. Create a disk snapshot inventory, identify maintenance windows for VM migration to encryption at host, and test workload compatibility with the new encryption architecture before the retirement deadline.

**Customer-managed keys (CMK) give you organizational control over encryption key lifecycle**. When compliance frameworks like ISO 27001, PCI DSS, or FedRAMP require documented key management procedures, implement CMK through Disk Encryption Sets linked to Azure Key Vault. Enable automatic key rotation to reduce operational burden while maintaining audit evidence of key governance.

**Confidential disk encryption provides vTPM-bound protection for regulated workloads**. Workloads subject to ITAR, trade secret regulations, or defense against insider threats with privileged access benefit from confidential VMs with OS disk encryption keys bound to the virtual Trusted Platform Module. The hardware-enforced isolation ensures only the specific VM instance can decrypt its OS disk, defending against disk theft and unauthorized copying scenarios.

**Azure Policy enforces encryption compliance automatically**. Rather than manually verifying encryption settings on every VM, assign built-in policies like "Virtual machines should enable encryption at host" to audit or automatically remediate noncompliant deployments. This approach scales across growing environments and provides continuous compliance evidence for auditors.

## Learn more

- [Overview of managed disk encryption options](/azure/virtual-machines/disk-encryption-overview)
- [Encryption at host – end-to-end encryption for VM data](/azure/virtual-machines/disk-encryption)
- [Migrate from Azure Disk Encryption to encryption at host](/azure/virtual-machines/disk-encryption-migrate)
- [Confidential VM overview](/azure/confidential-computing/confidential-vm-overview)
- [Customer-managed keys for Azure managed disks](/azure/virtual-machines/disk-encryption-customer-managed-keys)
- [Azure Policy built-in definitions for Azure Virtual Machines](/azure/virtual-machines/policy-reference)
