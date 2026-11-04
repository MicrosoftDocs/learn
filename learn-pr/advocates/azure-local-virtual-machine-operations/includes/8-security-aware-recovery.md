Recovery depends on routine protection as well as a tested restore procedure. VM security features change that recovery boundary. Before choosing a security type, understand both the protection it provides and the operations it restricts.

## Operate routine backup and restore

Select protection for the workload's required recovery outcomes before it enters production. Verify the backup product's support for the Azure Local release, guest OS, VM management model, security type, disks, and attached devices. A product's general Hyper-V support doesn't establish support for every Azure Local managed-VM configuration.

Backup scope determines what you can recover. The following comparison separates VM recovery from application-data recovery.

| Protection scope | Typical recovery purpose | What to establish |
| --- | --- | --- |
| Host-level VM protection | Recover the VM and the supported files and state included by the product. | Verify cluster-aware protection, required host components, included disks and protected state, and continued protection after the VM moves to another node. |
| Guest-level protection | Recover supported files, volumes, or workloads from inside the guest. | Verify backup-agent eligibility, credentials, workload support, and how the VM itself would be recreated if needed. |
| Application-native protection or replication | Recover application data with application-specific consistency and restore options. | Verify transaction or log recovery, dependencies, and retention. Replication alone might reproduce deletion or corruption and isn't automatically an independent backup. |

Distinguish crash-consistent, file-consistent, and application-consistent recovery points. A crash-consistent point captures disk state without coordinating application transactions, so the application might need crash recovery. File consistency protects filesystem consistency but doesn't necessarily establish application-transaction consistency. Application-consistent protection coordinates with the supported application to capture a recoverable state. Confirm the product's actual guarantees for the guest and application, including what happens if quiescence fails. Don't assume that Linux and Windows guests have identical backup behavior.

### Establish and monitor a protection policy

Define backup frequency, retention, recovery location, and the required consistency with the application owner. The schedule must leave enough margin for job duration, failures, and retry time to meet the recovery point objective (RPO). A job that runs every 15 minutes doesn't by itself prove a 15-minute RPO.

Store recovery copies in a design that survives the required failure scenario. Copies on the same cluster or storage system might not survive its loss. Use supported off-system or off-site storage and immutability or offline protection where the recovery and threat model require them. Restrict backup administration and protect encryption keys and recovery credentials separately from ordinary workload access.

Make the following checks part of routine operations:

1. Confirm that every production VM and required application data set is included in the intended policy. Account for newly deployed VMs, added disks, configuration changes, and moves between nodes.
1. Inspect job results, the time of the latest usable recovery point, repository health and capacity, and retention processing. A configured policy or a running backup agent isn't evidence that a recent backup succeeded.
1. Investigate failed or missed jobs before the recovery-point age exceeds the agreed objective. Record the protection gap, notify the workload owner, and escalate if a supported retry can't restore coverage in time.
1. Check that backups include required VM configuration, application configuration, and protected state or keys where applicable. Maintain access to compatible recovery tools without relying solely on the failed workload.
1. Perform sample restores and the regular DR drills described later in this section. Validate data and application behavior, not just successful completion of the backup or restore job.

Backup activity can consume storage, network, CPU, and temporary checkpoint capacity. Include that demand in capacity planning, and investigate failed checkpoint cleanup or merges through the product's supported workflow. Don't delete differencing-disk files directly to recover space.

### Choose the recovery destination deliberately

Before restoring, decide whether to recover data into an existing guest, restore the original VM, or recover to another location. Confirm the available recovery point, consistency, permissions, keys, capacity, network isolation, and management outcome for that exact path. An alternate-location restore can create duplicate identities or expose an old copy of production data if it's connected without a controlled cutover.

Microsoft Azure Backup Server (MABS) supports host-level VM protection and guest-level protection of supported workloads. Host-level protection uses a MABS agent on each participating cluster node. Guest-level protection uses an agent inside the guest and is appropriate when recovery must operate on a supported application or data set rather than only VM files.

For host-level recovery, select the protected VM and the required recovery-point date and time in the MABS Administrator console, then select **Recover**. Select a highly available VM from its cluster entry. The recovery type determines both the destination and the effect on existing VM data.

The following MABS recovery options have different consequences.

| Recovery option | Result | Important consequence |
| --- | --- | --- |
| **Recover to original instance** | Restores the VM's VHD and configuration files to the original location. | The original VHD and its associated checkpoints are deleted during recovery. Confirm approval to replace the current state and verify the clustered role and high-availability state afterward. Don't treat this as a nondestructive inspection of an older backup. |
| **Recover as virtual machine to any host** | The documented alternate-host workflow restores the VM to a different host within the same cluster. | Alternate-location recovery produces an unmanaged VM, not an Azure Local VM with restored Azure lifecycle ownership. Recovery to a cluster node doesn't automatically make the VM highly available. Selecting the original host instead uses the original-instance behavior, including deletion of the original VHD and checkpoints. |
| **Copy to a network folder** | Recovers supported files, folders, volumes, or VHDs from a host-level backup to a network share or a volume on a MABS-protected server. | This is item-level recovery, not VM provisioning or restoration of Azure management records. The MABS server requires the Hyper-V role for VM item-level recovery, but a MABS agent isn't required inside the guest for this path. |

Review the selected recovery point, destination host and path, replacement impact, and recovery options before starting the job. Monitor **Recovery Status** for completion, then validate the recovered workload separately. For Linux VM backups, the MABS guidance supports file-consistent snapshots, so don't assume that a recovery point is application-consistent merely because the job succeeded.

These are MABS-specific behaviors, not guarantees about every backup product, VM security type, or recovery workflow. Successful restoration of VM files doesn't prove that Azure lifecycle management, cluster high availability, or application-level recovery requirements have been restored.

Don't manually recreate Azure resource records around a restored local VM or assume that installing the Connected Machine agent restores its former lifecycle ownership. If recovery changes the management model, establish an approved operating plan and a supported migration or recreation path before cutover.

After recovery, validate boot, data access, application consistency, required dependencies, and the actual Azure and local resource identities. Re-establish supported monitoring and backup coverage, update inventory, and record any management limitations. Continue to apply the security-specific requirements in the following sections.

## Distinguish standard, Trusted Launch, and confidential VMs

*Secure Boot* validates the boot chain against trusted signatures. A *virtual Trusted Platform Module* (vTPM) provides TPM functions to a VM, including support for measured boot and cryptographic operations. *Attestation* evaluates evidence about a platform or VM against an expected trust policy.

Trusted Launch combines supported boot protections and protected VM state. It isn't equivalent to confidential computing. Confidential VMs additionally use supported hardware-based isolation to protect the guest's memory from the host environment.

The following comparison identifies the decisions an operator must make.

| VM security type | Main operational consideration | Recovery planning requirement |
| --- | --- | --- |
| Standard | Follow the standard VM matrix and guest OS requirements | Validate backup, restore, disk, device, and migration support for the workload. |
| Trusted Launch | Use an eligible image and the documented Secure Boot and vTPM configuration | Preserve and recover protected VM state through a supported workflow, not just disk copying. |
| Confidential VM | Use the supported confidential-computing hardware and tailored image workflow | Validate key, attestation, backup, guest-management, and mobility restrictions before deployment. |

Don't convert an arbitrary VM into a protected VM by changing a security flag. The image, boot generation, host capabilities, and protected state must all satisfy the relevant creation workflow.

## Preserve Trusted Launch state and keys

For Trusted Launch, an operating-system disk alone isn't enough to represent the complete protected VM. The documented protection procedure includes the VM files and the guest-state protection key from the local key vault. Without the required key, the VM can't start.

Follow the supported key-export and recovery procedure, including protection of any key-encryption material needed to recover an encrypted export. Keep keys out of ordinary change records and diagnostic bundles. A backup job that copies disks but omits recoverable protected state doesn't meet the recovery requirement.

The Trusted Launch guidance distinguishes restoration to the same Azure Local instance from restoration to another instance. Same-instance recovery can retain Azure management. The documented cross-instance recovery path leaves the restored VM locally managed. Azure Site Recovery replication isn't supported for this VM type.

Trusted Launch also doesn't imply that every attestation feature is available for every image. The overview documents disabled guest attestation for custom images and identifies boot-integrity verification separately as preview. Live-migration traffic isn't encrypted by default, so follow the documented network-protection guidance when transferring protected state.

## Recognize confidential-image operating boundaries

Azure Local 2610 release notes announce general availability of confidential VMs using AMD SEV-SNP on the documented AMD Genoa platforms. That announcement doesn't make every guest OS, device, image, or management capability supported. Validate the specific hardware and image workflow.

The integrity-protected confidential VM reference image uses a different operating model from an ordinary mutable guest. *Integrity protection* checks that protected image content hasn't changed. The documented image-building workflow establishes expected boot measurements, and attestation can control release of secrets from Azure Key Vault. Changing the image or application can change those measurements and require a new approved image and attestation configuration.

For that reference image, guest management must remain disabled. Both the Connected Machine agent and VM configuration-agent enablement flags must be false. Direct SSH uses image-prepared credentials, and Hyper-V console connection isn't the guest-access path. The documented restrictions also exclude GPU attachment and adding NICs to an integrity-protected guest after its initial boot.

Don't copy Trusted Launch's boot settings into a confidential VM recipe. The documented locally built, unsigned integrity-protected image requires Secure Boot to be off while vTPM remains required. This is a specific image-workflow requirement, not general advice to disable boot protection.

Running confidential VM migration isn't supported in the documented reference workflow. Plan shutdown before migration, and account for cloud connectivity needed for attestation and key release.

## Define recovery objectives and prove the recovery path

The *recovery point objective* (RPO) describes how much data loss the business can tolerate, expressed as time. The *recovery time objective* (RTO) describes how quickly the service must be restored.

For example, a 15-minute RPO and a two-hour RTO require more than retaining a daily image. The protection design must capture sufficiently recent workload data and restore a usable service within the required time. Include application configuration, identity, network dependencies, and protected state where applicable.

Perform regular disaster recovery (DR) drills under realistic failure conditions to validate that the agreed RPO and RTO are achievable. Each drill should establish that the restored workload boots, can unlock and access its data, reconnects to required dependencies, and meets application acceptance checks. Measure the data-loss window against the RPO and the elapsed time from the simulated outage to restoration of a usable service against the RTO, not just the time needed to start the VM. Record the results, correct any gaps, and repeat drills after significant workload or infrastructure changes. Use an isolated recovery environment where needed to prevent duplicate identities or accidental production writes.

If the exact VM type doesn't have a supported recovery method that meets the business requirement, resolve that gap before deployment. Application-level replication or a different availability design might be necessary. Don't silently weaken the security configuration to make an unsupported backup method appear to work.

For manual Trusted Launch key recovery on Azure Local 2505 and later, retain the original RSA wrapping-key pair and the unchanged timestamped key-backup directory as well as the VM backup. The wrapping key protects the exported VM keys, so a newly generated pair can't decrypt an existing export. On the destination instance, import the original wrapping key under a unique name, then import the backed-up VM keys into the local key vault before starting the restored VM. The `Import-TvmWrappingKeyFromPem` and `Import-TVMKeys` commands belong to the `TvmBackupUtils.psm1` helper module, not built-in PowerShell. Include the approved recovery module in the recovery toolkit.

Same-instance key recovery has an additional step that removes the existing `AzureStackTvmAKRootKey` attestation root key before importing the backup. This step doesn't apply to recovery on a different instance and must remain part of the approved infrastructure recovery procedure, not routine VM troubleshooting. After successful import, remove the temporary PEM copies and imported wrapping key from the destination. Preserve the secured original recovery materials for future restores.

For the integrity-protected confidential-image workflow, also record the prerequisites needed if the VM must be recreated: the cluster's `confidentialVmIntent` must be `Enable`, the Azure Stack HCI VM extension must be version 1.12.0 or later, and the prepared image must retain its required identity and attestation configuration. Recovery access requires network connectivity to the guest IP and the username plus SSH key or password prepared in the image. Creation-time placeholder administrator credentials don't replace that identity. Verify the resulting security state through attestation as well as checking boot and application health. These creation prerequisites aren't a substitute for a supported confidential-VM restore procedure.
