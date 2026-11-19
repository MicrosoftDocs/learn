## Prepare a supported baseline

Use one standalone Windows Server 2022 x64 virtual machine (VM), `m09-source`, in an approved region such as East US 2. Use a supported size with at least two virtual processors, such as `Standard_D2s_v5`, one managed operating system (OS) disk, and one 32-gibibyte (GiB) Standard solid-state drive (SSD) data disk. Use platform-managed encryption, no guest Azure Disk Encryption, no shared disks, no ephemeral operating system disk, and no availability set.

For this portal-based laboratory, select a Generation 2 Windows Server 2022 image with Trusted Launch, Secure Boot, and a virtual Trusted Platform Module (vTPM) enabled. Use one network interface and a VM that isn't pinned to an availability zone, with no production load-balancer membership. Use the extension-based backup method for the application-consistency exercise, not the separate agentless crash-consistent method. Keep the VM agent healthy and record the actual consistency of the recovery point.

Restore compatibility depends on the VM's configuration, not its name. The guest is the operating system running inside the VM. The VM size defines compute and capacity limits, such as processor count, memory, and supported disks. Here, x64 means the 64-bit x86 processor architecture, and an image supplies the initial operating system and software.

VM generation defines the virtual hardware and boot model, while security type selects platform protections. An availability set distributes multiple VMs across separate hardware and maintenance groups. These choices also affect whether a restore destination is compatible.

Azure manages the underlying storage for a managed disk. The OS disk contains the bootable operating system, while a data disk holds additional files such as this ledger. Standard SSD describes the storage performance tier, and GiB measures capacity.

Temporary disks and ephemeral OS disks use local host storage rather than persistent managed-disk storage and aren't protected by this VM backup path. Shared disks can attach to multiple VMs and require coordinated access. A backup captures only supported, included disks, not every location the application can read.

> [!NOTE]
> **Encryption models**: Storage-level encryption protects disk data at rest. With platform-managed keys, Azure manages the encryption keys. With customer-managed keys, you control the key used for storage encryption. Keep the key available and ensure that the required identities retain permission to use it. Azure Disk Encryption instead encrypts volumes inside the guest, using operating-system encryption such as BitLocker on Windows. These configurations have different restore requirements. Having backup data isn't enough if the required keys or permissions are unavailable, so this baseline uses platform-managed encryption.

Keep the Recovery Services vault, source, restore destination, and staging account in the same subscription and region for this baseline. Use the administrator-approved Enhanced policy. Enhanced isn't optional for this Trusted Launch portal-enrollment path. Standard-policy support through specified automation-client and application programming interface (API) versions is a different branch, not the procedure used here.

If the assigned policy or source configuration doesn't match the baseline, stop for the administrator to approve a supported branch before enrollment. Don't downgrade the VM's security type, modify protection controls, or reduce retention merely to continue the exercise. A cross-region or cross-subscription exercise also requires a separate support and permission review.

Check Create-new eligibility before starting the timer. Azure Monitor diagnostic settings on the source can prevent the quick Create-new operation. This isn't a general prohibition on boot diagnostics or monitoring extensions. If required diagnostic settings or another source configuration need a different restoration path, obtain approval for Restore disks and a reviewed deployment. Don't remove mandatory monitoring to make quick restore succeed.

> [!NOTE]
> **Recovery across Azure boundaries**: Cross-subscription restore changes the subscription that owns the recovered resources. A tenant is an organization's identity directory in Microsoft Entra ID, and multiple subscriptions can trust that directory. Cross-region restore changes geographic region. Some regions have an Azure-designated paired region used by supported replication features, but not every region is paired. An availability zone is a physically separate datacenter location within a region. Vault redundancy determines where additional stored copies are maintained, such as across zones or in a paired region. Replication doesn't by itself enable every cross-boundary restore option.

In the portal, create `rg-m09-source` and `rg-m09-restore` if they don't already exist. Create the source VM with no public inbound ports, attach the data disk, and initialize only that new disk in Disk Management. Assign drive `F:` and create `F:\RecoveryLab`. Keep application code in `C:\RecoveryLab`. Install an organization-approved Python 3.11 or later interpreter and verify `python --version` in the guest.

> [!NOTE]
> **Guest disk administration**: Attaching a disk in Azure makes it available to the guest, but a new empty disk still needs a partition layout and formatted volume before Windows can store files on it. Disk Management provides these operations and assigns a drive letter such as `F:`. A drive letter is a guest mapping, not the disk's Azure resource identifier. During recovery, match the disk identity, size, attachment position, and contents before using the path. Don't initialize or format a restored disk that already contains the recovery data.

The Python interpreter runs the saved program, and its standard library supplies the imported modules without extra packages. Run it from PowerShell, which passes arguments such as the action `verify` or the named option `--manifest`. Paths beginning with `.\` are relative to the current directory, while `F:\RecoveryLab` identifies an absolute guest path.

The acceptance checks use ordinary conditional failures, so they remain active even if Python optimization is enabled. A missing file, malformed manifest, database error, or failed check stops the invocation without printing `VALIDATION=PASS`. A successful invocation exits with code zero. Record the exit code immediately in PowerShell, before another native command can replace it. A Python failure doesn't automatically stop subsequent PowerShell commands, so check each must-succeed invocation before advancing. An exited process is no longer running, not merely idle.

Use Azure Bastion or an approved private management host for Remote Desktop Protocol (RDP) access. A separate recovery virtual network with no peering to the source prevents accidental application traffic. Maintain its own approved management path. Don't apply a blanket outbound deny that breaks the VM agent or backup services.

> [!NOTE]
> **Private management and service connectivity**: Azure Bastion brokers an administrator's connection to a VM's private address without requiring public inbound access on that VM. An approved management host is a controlled machine from which the administrator connects. Either route still needs working network rules and valid guest credentials. The VM agent runs inside the guest and supports extensions, including the backup extension used for application-consistent snapshots. Required service connections are separate from application traffic. Preserve those documented connections while blocking production application paths, and verify management access independently in the recovery network.

## Verify permissions before the timed exercise

Azure role-based access control (RBAC) separates vault operations from resource creation and guest access. A Backup Reader can inspect evidence but can't perform a restore.

Request the permissions needed to enable backup and perform the chosen restore, at the narrowest appropriate scopes. Enrollment is a separate operation from taking an on-demand backup of an already protected item.

| Operation | Baseline role and scope to verify |
|---|---|
| Read backup jobs and policy | Backup Reader on the laboratory vault |
| Enable VM backup through the vault | Backup Operator on the resource group containing the vault, plus Virtual Machine Contributor on the source VM, or equivalent required actions |
| Create or change a backup policy | Backup Contributor on the laboratory vault (operation performed by the authorized administrator) |
| Trigger backup of an enrolled VM | Backup Operator on the laboratory vault |
| Initiate restore | Backup Operator on the laboratory vault, plus the linked-resource permissions below |
| Restore resource creation | Contributor on `rg-m09-restore`, or a reviewed custom role |
| Source VM access for restore operations | Virtual Machine Contributor on the specific source VM, or equivalent required actions |
| Staging account operations | Storage Account Contributor on the dedicated staging account, or equivalent required actions |
| Guest validation | Approved local guest account and management access, separate from Azure RBAC |

The administrator provisions the vault and policy if the learner can't. Additional permissions can be needed for network subnet joins, encryption keys, private endpoints, or cross-region restore. Use the current role-action mapping rather than assuming a vault role grants subscription-wide access.

## Prevalidate staging and the fallback deployment

Have the administrator preprovision a dedicated staging account and validate its permitted access path before the timer starts. Account-scoped permissions don't themselves authorize creating that account. A shared access signature (SAS) provides scoped access to storage resources and is used by the documented Deploy Template experience.

Record the following staging prerequisites for this laboratory.

| Item | Laboratory requirement |
|---|---|
| Account purpose | Dedicated test staging, with its resource ID and cleanup owner recorded |
| Account configuration | Standard general-purpose v2, hierarchical namespace (HNS) disabled, same subscription and region as the vault and destination |
| Redundancy | An explicitly approved supported option, such as locally redundant storage (LRS) for this disposable same-region lab |
| Operator access | Required staging-account and destination resource-creation permissions from the preceding table |
| Service authorization | If the restore uses the vault's managed identity, separately provision and verify that identity's required access |
| Network access | An administrator-prevalidated, policy-compliant path for the exact restore method |
| Template fallback | Confirm whether the SAS-backed Deploy Template experience is permitted by the account's Shared Key policy |

This is a conservative laboratory configuration, not a universal product requirement. Zone-redundant storage (ZRS) staging is also supported. HNS is left disabled to avoid page-blob limitations in paths that produce virtual hard disk (VHD) artifacts. A `BlobStorage` account kind isn't the same thing as a general-purpose v2 account that provides a blob service.

The operator's Azure role doesn't automatically authorize a vault managed identity. For firewall-restricted staging, use the documented system-assigned vault identity path where applicable and verify its required roles. Don't assume that adding the restored VM's subnet to storage rules grants the backup service access. Prevalidate private-endpoint-only or other specialized staging variants rather than declaring them universally supported or unsupported.

Some restore paths use staging differently or don't use the specified account for disk data. Select the approved account when requested, without assuming that every managed-VM restore must copy its disks into staging. If policy prevents the intended path, obtain an approved alternative or stop before the exercise. Don't enable unrestricted public access, Shared Key, or weaker disk controls merely to proceed.

## Enroll the source in backup

Creating a vault doesn't automatically enroll a new VM in backup or create its protected item. Have the appropriately authorized administrator complete this vault-based enrollment before continuing.

1. Open the approved **Recovery Services vault**, select **Backup**, choose **Azure** as the workload location, and select **Virtual machine** as the workload to protect.
1. Select the approved Enhanced policy for the defined Trusted Launch portal baseline. If it doesn't exist or doesn't support the source configuration, stop for the authorized policy administrator. Don't improvise a different policy or shorter retention period.
1. Select `m09-source` from `rg-m09-source`. Review disk selection and include both the operating system disk and the managed data disk containing `F:\RecoveryLab`. If the pane defaults to all disks, confirm that both named disks appear rather than assuming the default is sufficient.
1. Select **Enable backup** and monitor configuration until the protected item appears under **Backup items**, **Azure Virtual Machine**.
1. Open that item and verify protection is enabled, the intended policy is assigned, both disks are included, and the next scheduled backup is shown. Capture the enrollment result and resource identifiers.
1. Give the recovery operator the vault and protected-item details needed to continue the exercise. An initial backup might run during setup. For this exercise, use the later backup taken after you populate the application with test orders, so you know which records it should contain.

If enrollment is missing or failed, stop here. Vault-scoped permission to select **Backup now** doesn't replace enrollment permissions or establish that a protected item exists.

## Inspect actual scope

Open **Recovery Services vaults**, select the laboratory vault, then **Backup items**, **Azure Virtual Machine**, and `m09-source`. Inspect the policy name, next scheduled backup, last backup status, and available recovery points. In the item's disk selection settings, verify both the operating system disk and the data disk containing `F:\RecoveryLab`.

For a backup transferred to the vault, inspect **Snapshot**, **Transfer data to vault**, and **Validate backup**. Azure Backup's validation checks the transferred backup data. Completing transfer, or reaching 100% on its progress bar, doesn't establish that the vault point is ready. The progress bar covers transfer only and isn't an estimate of total backup completion or remaining time.

Service-side validation isn't the same as validating the recovered application. It doesn't establish that `A102` survived, that all required business records are present, or that the application can perform its required transaction.

Open **Backup Jobs** and inspect the selected point's job and subtasks. For a supported snapshot-tier restore, confirm that snapshot creation succeeded and that the snapshot point is available. You don't need to wait for vault transfer or vault validation to use that snapshot. For a vault-tier readiness claim, confirm that **Transfer data to vault** and **Validate backup** succeeded and that the point is available in the vault tier. Record capture and transfer-completion times separately, along with applicable phase results, consistency, included disks, and expiration. Record the point's available tiers separately from the restore source used by the chosen workflow.

If service-validation evidence can't be established, leave vault readiness unverified. Don't fill in a successful result from the transfer percentage. Record an unavailable or unexposed result honestly and use the supported job/recovery-point evidence or escalation path. For a snapshot-only scheduled point, record the actual skipped, not-applicable, or pending vault phases as appropriate. Don't mislabel an unobserved phase as successful or classify a valid snapshot-only point as failed merely because it has no completed vault path.

A point labeled **snapshot and vault** has both tiers available. For the ordinary same-region workflow used here, Azure Backup automatically uses the local snapshot for such a point. Waiting for its vault transfer doesn't, by itself, select the vault copy. Record the available tiers and the restore source separately.

Capture the source information reported by the restore job or other supported evidence when available. If you rely on the documented selection behavior rather than observed job detail, label that source as inferred. If the source can't be established, record it as undetermined. Don't invent a portal field, assume an undocumented "force vault" switch, or claim a vault-based restore when the evidence doesn't establish one.

If the needed snapshot has expired or is unavailable, inspect the available vault points again. A less recent vaulted point can have different content and fail the data-loss objective even though the current policy still creates frequent snapshots. Don't assume every earlier snapshot has a corresponding vaulted copy.

> [!NOTE]
> **Backup consistency mechanisms**: An application-consistent backup coordinates with the application to prepare its data on disk for recovery. A Windows Volume Shadow Copy Service writer is an application-aware component that prepares its data for capture. Linux pre-snapshot and post-snapshot scripts can pause, flush, and resume application writes. File-system consistency preserves a coherent file-system state without guaranteeing application transaction consistency. Crash consistency captures disk state without that application preparation, so buffered changes can be absent. Transaction-log replay uses a database's recorded changes to complete recovery when supported. Applications spanning multiple VMs need coordination across those machines, not just a successful snapshot of each one.

Use this synthetic inspection record for the analysis path. This table shows the recovery points available after the drill. P2 wasn't available when recovery was authorized at 09:22.

| Point | UTC content boundary | Consistency and available tiers | Scope and content | Decision |
|---|---|---|---|---|
| P0 | 08:50 | Crash-consistent, vault | Operating system only, with the data disk excluded | Reject for ledger recovery |
| P1, on-demand | 09:10 | Application-consistent, snapshot and vault | Both disks, with `A101` through `A103` present | Candidate before deletion |
| P2, on-demand | 09:25 | Application-consistent, snapshot and vault | Both disks, but `A102` already missing | Reject for this failure |

P1 and P2 have separately approved on-demand vault retention. Their displayed content times aren't claims that vault transfer finished at those instants. The table describes their later available tiers. At authorization, confirm the available tiers and use a supported restore method. Record the restore source separately rather than treating a dual-tier label as a source selector.

These are teaching fixtures, not a guaranteed backup frequency or actual recovery-point identifiers. Live learners record their actual point names, trigger types, available tiers, restore-source evidence or labeled inference, and times. Don't repeatedly trigger backups to manufacture this table. Service frequency limits and the configured policy still apply.

Windows application-consistent backup uses the Volume Shadow Copy Service and cooperating writers. A consistency label isn't proof that every custom application coordinated correctly. This SQLite exercise closes its connection before backup to remove in-flight writes, but still verifies recovered content.

Linux VM backup normally provides file-system consistency. Application-consistent protection requires appropriate application-aware pre-snapshot and post-snapshot scripts. A crash-consistent point resembles recovery after power loss and may require transaction-log replay. Backups of a stopped VM are crash-consistent rather than application-consistent. None of these labels guarantees multi-VM application consistency.

Data on temporary disks, remote file shares, or excluded disks is outside this VM backup's recovery scope. Identify the alternate protection owner before proceeding. If a recovery method is unavailable or unsupported, revise the recovery plan rather than weakening vault controls.
