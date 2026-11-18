## Match the method to the failure

Choose a supported restore method that recovers only what you need and lets you demonstrate that the acceptance criteria have been met. This module restores to a new VM so you can test the database, Python runtime, guest access, and application together without replacing the source VM.

The comparison below shows when another method might be preferable.

| Method | Appropriate use | Important constraint or trade-off |
|---|---|---|
| File recovery | Small set of missing files on a compatible guest | Direct file/folder recovery isn't supported for the guest Azure Disk Encryption scenario. Platform-managed server-side disk encryption isn't that configuration. Verify the encryption mode, disk layout, recovery host, and script connectivity |
| Restore disks | Recover a volume or build a customized isolated VM | Restore success doesn't create all application, identity, or network dependencies |
| Create a new VM | Rehearse a basic machine and application recovery | The backed-up VM size, network, permissions, image, and source configuration must support quick VM creation |
| Replace existing disks | Approved in-place recovery of an existing machine | Destructive to current state and excluded from this exercise |

Don't decide file-recovery eligibility from the word "encrypted" alone. Guest Azure Disk Encryption, disk server-side encryption, and vault encryption are separate layers. Retain required key access and check any disk customer-managed-key limitations. If the direct file-recovery path isn't supported, use a supported isolated VM or disk recovery method and validate the recovered files there.

The documentation recommends file recovery for 10 gigabytes or less and gives an expected transfer rate of approximately one gigabyte per hour. These are planning guidance, not an RTO guarantee. Recovery scripts need compatible operating systems and the documented service connectivity. Linux volume-management layouts and Windows Storage Spaces introduce additional restrictions.

> [!NOTE]
> **Advanced storage layouts**: A volume is the logical storage area that an operating system presents to applications. Linux volume management can combine physical disks into groups and allocate logical volumes from them. Windows Storage Spaces pools disks and creates virtual disks that can distribute data across several members. Recovering a file from these layouts can require the complete disk set, its metadata, and compatible software. A single recovered disk might not contain a usable volume, and mounting it on the original machine can introduce identity conflicts.

If you use file recovery in another approved drill, select **File Recovery** on the backup item, select the point, and download the generated executable or script. Run the recovery executable or script only on an approved machine that meets its operating-system and connectivity requirements. Copy data into an alternate directory, then use **Unmount Disks** when finished. Don't leave a mounted recovery session active or include its generated password in evidence.

Replacing existing disks isn't a harmless shortcut. Azure Backup retains original disks and takes recovery-related snapshots according to the supported workflow, but that doesn't make an unapproved overwrite safe. The option has encryption and VM-type limitations and isn't the baseline laboratory path.

## Validate the destination before restore

Same-region restore is the baseline. For a Recovery Services vault using geo-redundant storage (GRS), Cross Region Restore (CRR) enables recovery of replicated vault-tier backups in the Azure paired region without waiting for Azure to declare a disaster. With GRS but without CRR, secondary-region recovery depends on Azure declaring a disaster in the primary region and making the replicated backups available. It isn't an on-demand option during every outage. Azure VM Backup snapshots aren't replicated to the paired region. This laboratory doesn't configure or demonstrate regional recovery. Don't enable CRR or change vault redundancy merely to complete it.

Cross Subscription Restore has same-tenant, recovery-tier, vault-setting, and encryption restrictions. Snapshot-tier restores remain in the protected VM subscription. Cross-zonal restore requires supported vault redundancy and a supported point. Snapshot-tier points don't provide that capability.

Record the exact operating system, VM generation, security type, disk type, encryption mode, subscription, region, and zone. Platform-managed disk encryption isn't the same configuration as guest Azure Disk Encryption or customer-managed keys. If your environment differs from the baseline, verify the specific branch in the current support matrix before approving the method.

For direct Create-new recovery, check capacity and quota for the VM size recorded in the recovery point. The restored VM retains that size, which can differ from the source's current size. A required size or topology change belongs in the approved Restore-disks/custom-deployment branch, not an assumed size selector in the quick restore pane.

For isolation, create `vnet-m09-restore` in `rg-m09-restore` with a nonoverlapping address range and a dedicated subnet. If an approved recovery network is in another resource group, explicitly verify virtual-network read and subnet read/join permissions at its actual scope. Attach a network security group (NSG) before restoring. Allow inbound RDP only from the approved management subnet. Block outbound traffic to the source and production networks. Allow only the other traffic required for management and Azure services. Confirm there's no production load-balancer membership, public application address, peering, private name registration, or automatic scheduler.

The application has no autonomous background writer. Nevertheless, inspect startup tasks and services after recovery before running it. Don't remove security controls to establish a connection. The restore destination uses only the laboratory local account. Don't attach a production user-assigned managed identity.

Record the recovery subnet, effective routes, NSG rules, and management connection details. Include evidence that the restored VM can't reach production systems. Demonstrate isolation with network settings and connectivity results. Naming a resource 'test' doesn't prove that it's isolated.
