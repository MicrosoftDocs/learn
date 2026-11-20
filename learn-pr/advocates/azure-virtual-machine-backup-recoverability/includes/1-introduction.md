> [!VIDEO https://learn-video.azurefd.net/vod/player?id=6d11ab2a-25f1-42a1-be1c-c071b40a9106]

A restore job can succeed while the recovered application remains unusable. The database might be on a disk excluded from backup, the latest recovery point might have been created after the deletion, or the application might lack required access. Successful infrastructure recovery is necessary, but it isn't the acceptance test.

This module follows a controlled recovery rehearsal for an Azure virtual machine that hosts a test order ledger. You'll define recovery acceptance criteria, inspect backup coverage and recovery points, and choose a supported restore method and isolated destination. You'll then validate the recovered data and application behavior, measure recovery duration and data loss, and decide whether the evidence meets the agreed objectives. Finally, you'll repair the original source, confirm continued backup protection, and preserve evidence before cleanup and assessment. You can complete the exercise in an approved Azure lab or analyze the supplied synthetic records.

> [!NOTE]
> Unit durations estimate active learning time. Backup, restore, and scheduled-protection waits are additional. The recovery time objective is measured separately within the exercise.

## Assumed knowledge

This module assumes you can configure Azure Backup and restore Azure infrastructure as a service (IaaS) virtual machines (VMs). Use these brief refreshers to recall the workflows.

### Configure Azure Backup

Azure Backup protects a VM through a Recovery Services vault and a policy that controls backup timing and retention. Enabling protection doesn't prove that a usable recovery point exists.

For an unprotected laboratory VM with a working VM agent and the required permissions, recall this sequence:

1. In the Azure portal, open the VM's **Backup** page. Select an approved Recovery Services vault in the VM's subscription and region, and choose the approved backup policy.
1. Review the schedule, retention, and coverage of required operating system and data disks. Select **Enable backup** and confirm that protection is enabled.
1. Select **Backup now** with the approved retention date, or wait for the initial scheduled backup. Inspect the job and confirm that the recovery point contains the required disks and is available in the intended restore tier.

### Perform an initial restore

An initial restore checks that a recovery point can produce a usable copy of an Azure VM. For a rehearsal, restore to a new VM rather than replace the source VM's disks.

Recall the basic isolated-restore procedure:

1. Prepare an approved isolated destination and management access. Confirm that you have permission to create the restored resources.
1. Open the protected backup item, select **Restore VM**, and choose a suitable recovery point. Review its timestamp, consistency, and included disks.
1. Choose **Create new**, then **Create new virtual machine**, when supported. Specify a unique name, target resource group, isolated network and subnet, and staging storage if requested.
1. Select **Restore** and monitor the job. Connect to the restored guest and check its disks, expected data, and a basic application operation. Job completion alone isn't proof of usable recovery.

### Rehearse recovery before an incident

Rehearsals expose missing permissions, dependencies, data, and unrealistic recovery expectations before an incident. Repeat them regularly and after material changes because a previous successful restore doesn't establish that today's workload is recoverable.

Use this short sequence to recall what a rehearsal should establish:

1. Agree the failure scenario, expected data, recovery-time and data-loss limits, timer boundaries, roles, and isolation controls.
1. Restore into isolation and validate the application against known expected results. Record elapsed time and missing acknowledged writes without allowing the test copy to send production traffic or accept normal workload updates.
1. Compare results with the agreed limits, assign fixes, and repeat failed checks. Confirm that the authoritative VM remains protected, preserve evidence, and remove only approved test resources.

## Example workload

The example workload used in this module is a small, single-machine order-reporting application backed by SQLite. It has no production dependencies and never sends messages or payments. Its important behavior is reading the correct orders, calculating an exact total, and completing a reversible database transaction.

> [!NOTE]
> SQLite is an embedded database engine that the Python application uses directly, without a separate database server. It stores tables of rows and columns in a local file. Structured Query Language (SQL) statements read or change those rows through a database connection.

A schema defines the table structure and rules, such as a primary key that uniquely identifies each order. In this application, `id` means identifier. An integrity check examines database structure, but doesn't establish that the expected business records survived.

> [!NOTE]
> **Database transactions**: A transaction groups changes into an all-or-nothing operation. A commit makes those changes persistent, while a rollback discards changes that haven't been committed. In-flight writes are operations still underway when capture begins. This exercise closes its database connection before backup and later inserts a temporary order inside a transaction, reads it, and rolls it back. That probe demonstrates working read and write behavior without leaving an extra order in the recovered ledger.

## Prerequisite and safety check

Complete M01 and bring existing Azure Backup, Windows guest administration, and recovery-planning skills. All cloud operations in this module are instructions for an approved laboratory, not a claim that resources have been deployed or tested for you.

Before starting the live path, establish these conditions.

- Use a dedicated laboratory subscription or approved resource groups containing only disposable resources.
- Use synthetic records, a local laboratory account, and no production certificates, secrets, or managed identities.
- Assign the application owner, recovery operator, and evidence reviewer roles. One learner can perform all three roles only if the laboratory approval permits it.
- Preserve the existing Recovery Services vault policy, soft delete, immutability, retention, and any multi-user authorization controls.
- Confirm a working management route into both source and isolated recovery networks before changing data.
- Agree a cost ceiling and expiry time. Include running machines, managed disks, backup storage, staging storage, networking, and management access.

### Resource organization and access

A resource is an individually managed Azure item, such as a virtual machine or disk. A resource group collects related resources for management, and a subscription contains resource groups and provides a billing and governance boundary. A region is a geographic area containing Azure datacenters. Resource groups can contain resources in different regions, so grouping the laboratory resources doesn't establish regional compatibility or network isolation.

Authentication establishes who's requesting access, while authorization determines permitted actions. A local guest account belongs to the operating system. A managed identity is an Azure-managed application identity that can authenticate to other services without embedded credentials.

Azure role-based access control assigns an identity a built-in or custom set of permissions at a scope, such as a subscription, resource group, or resource. For example, a role assigned at subscription scope also applies to the resource groups and resources within that subscription. Some operations also require permissions on related resources, such as the restore subnet or staging account. Vault permissions alone don't grant guest sign-in or access to every restore dependency.

### Backup scope and safeguards

A Recovery Services vault manages backup policies, protected items, and retained backup data. A protected item represents a workload enrolled for backup. A job is an individual backup or restore execution.

A snapshot captures disk state at a point in time, while a recovery point identifies a recoverable version with a timestamp and defined disk scope. The snapshot tier supports faster access to retained snapshots. The vault tier contains backup data transferred into vault storage. A completed snapshot doesn't prove that its vault transfer has finished or that service-side validation of the transferred data has succeeded.

A backup policy specifies when scheduled backups run and how long recovery points are retained. An on-demand backup is a separately requested run, not a change to the schedule. Retention determines how long a point remains available, and expiration marks the end of its retention period. Snapshot and vault retention can differ.

Enhanced policies support multiple scheduled backups per day and additional capabilities, but the selected frequency, retention, and service limits still govern the laboratory. Preserve the approved policy and the vault safeguards throughout the exercise.

An Enhanced hourly schedule can create several scheduled snapshots per day, but it doesn't transfer every scheduled snapshot to the vault. The documented behavior transfers the last scheduled backup of the policy day. If that backup fails, the first backup the following day is transferred. A scheduled snapshot-only point therefore doesn't automatically have the daily vault retention.

An on-demand backup is a separate case. It can transfer data to the vault and uses the retention approved for that request. Record whether each point came from a scheduled or on-demand job. Don't infer its tier or expiration from the policy name alone.

> [!NOTE]
> **Backup security safeguards**: Soft delete delays permanent deletion so that deleted backup data can be recovered during its configured retention period. Immutability blocks operations that would remove protected backup data before its applicable retention ends. Locking the immutability setting makes that setting irreversible. Multi-user authorization uses a separately controlled Resource Guard resource to require additional authorization for protected operations. These safeguards address different risks and aren't interchangeable. A restore rehearsal isn't permission to disable or bypass them.

### Network isolation and resource cleanup

A virtual network defines a private address space, and subnets divide that space. Nonoverlapping ranges avoid address conflicts. Peering connects virtual networks, routes select traffic paths, and network security group rules allow or deny traffic by direction, addresses, ports, and protocol.

Network isolation also requires reviewing the services connected to the VM. A load balancer distributes requests to machines, while private name registration makes a machine discoverable by name. A private endpoint provides private-address access to a service. Review all these paths rather than assuming that a differently named subnet provides isolation.

Plan cleanup separately from guest shutdown. Shutting down the guest doesn't necessarily release its allocated Azure compute resources. Deallocation releases that allocation and stops usage-based virtual machine compute charges, but retained disks, backups, and other services can still incur charges.

Deleting a virtual machine may leave dependent resources behind, depending on deletion settings. Staging storage holds intermediate restore artifacts, such as disk files or deployment templates, when the chosen workflow requires them. Track each resource separately so that cleanup removes only approved test artifacts and preserves required recovery evidence.

### Evidence-analysis alternative

If you choose the evidence-analysis alternative, analyze the supplied records and synthetic job data. Run the local application checks if possible, and label your results **Analysis only**. Copying a database locally is useful for understanding validation. It isn't an Azure Backup restore.

> [!NOTE]
> **Evidence artifacts and provenance**: A fixture is supplied test data or a synthetic event record used for repeatable analysis, not proof of a real service operation. A manifest records the expected contents of a dataset. This exercise's manifests contain order identifiers, amounts, a content hash, row-write samples, and a capture timestamp. Separate `WRITE_ACK` events record post-commit acknowledgements. Provenance records where an artifact came from, when it was captured, and who preserved it. Keep the known-good manifest and acknowledgement evidence independently of the restored data so that a damaged or incorrect restore can't also replace the reference used to judge it.
