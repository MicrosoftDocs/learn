A recovery copy is useful only if it survives the planned failure and can be used without the lost host environment. Independence has physical, logical, and administrative dimensions.

## Separate the copies and the authority

Another volume on the same cluster might survive an individual disk failure but not a cluster-wide loss. An offsite repository might survive a building failure but still be deletable by a compromised production administrator.

Choose backup locations according to the failures the copies must survive. To recover after losing an Azure Local instance, keep a usable copy outside that instance's storage. To recover after losing the entire site, keep a copy at another physical site or in Azure. This separation prevents one infrastructure failure from destroying both the workloads and their recovery copies.

Protect those copies against unwanted changes as well as infrastructure loss. Where supported by the backup product and repository, *immutability* prevents retained backup data from being modified or deleted until an enforced retention period expires. *Offline retention* keeps a copy disconnected from normal network access. These properties aren't interchangeable: an offsite cloud backup is still online, and being offsite doesn't automatically make it immutable.

Neither immutability nor offline retention proves that a backup contains clean application data. If corruption or malicious changes were already present when the backup was taken, these controls can preserve that bad state. Restore and validate a candidate copy in an isolated environment before accepting it for recovery.

Apply least privilege to backup operations, retention administration, and recovery. Where the product supports it, separate the authority to change retention from routine backup administration. Protect emergency access independently, monitor its use, and practice retrieval without placing secrets in incident records.

The diagram shows why recoverable data and recovery access must survive together. The numbers identify the components, not a requirement to build them one at a time.

:::image type="content" source="../media/independent-recovery.svg" alt-text="Diagram that shows production, independently retained copies, separate recovery access, and an isolated restore target." border="false":::

## Choose retention for the failure, not just the schedule

A retention policy determines how long recovery points remain available. Base it on more than backup frequency. Include the delay before corruption might be detected, operational rollback needs, legal holds, and deletion obligations.

Suppose a defect quietly corrupts records for four days before anyone notices. A policy that retains only the last 24 hours might contain no clean point. Replication with a short interval doesn't fix that gap.

Retain enough history to investigate and select a trusted point. Where application-native recovery is required, retain the base backup and all necessary logs as a usable chain. A missing log segment can prevent recovery to the desired transaction boundary.

Immutability can protect a bad backup just as effectively as a good one. Restore testing, integrity checks, and monitoring are therefore still necessary. Plan retention changes carefully because an enforced retention period can also prevent immediate deletion of data that an operator no longer wants.

## Translate recovery objectives into a protection policy

A protection policy must explain how a usable recovery point will remain within the required age at the location that survives the incident. Scheduling a job isn't enough. Include completion time, offsite transfer delay, retention, and the dependencies required to restore the resulting chain.

A *full backup* establishes a baseline. An *incremental backup* captures changes since a previous backup and depends on the product's required chain. A *differential backup* captures changes since a full backup. Application transaction-log backups provide a separate recovery sequence where the application supports it. Products can implement these concepts differently, including synthesizing full recovery points from stored changes. Don't assume that every product exposes the same scheduling choices.

Consider this illustrative policy for the order-processing service. The business explicitly accepts different objectives for two failure scenarios: a ten-minute RPO and 45-minute RTO for database corruption with local infrastructure available, and a 60-minute RPO and four-hour RTO for complete site loss. These are separate agreements, not permission to relax an objective during an incident.

The proposed policy combines machine recovery with application-native recovery. Its schedules are design assumptions that require compatible, supported tooling.

| Protection element | Illustrative policy | Reason and acceptance evidence |
| --- | --- | --- |
| VM operating system and configuration | Nightly VM backup and an additional approved point after significant configuration changes | Provides a recoverable machine baseline, but doesn't by itself satisfy the database's ten-minute RPO |
| Database baseline | Application-native full backup each night | Provides the base for supported transaction-log recovery |
| Transaction history | Application-native log backups every five minutes, completing within two minutes under tested load | Targets a latest usable local transaction boundary no more than about seven minutes old during normal operation |
| Independent offsite copy | Copy required VM, database, and log artifacts offsite, with log-copy completion within ten additional minutes | Targets an offsite transaction boundary about 17 minutes old or less under the stated assumptions, within the separate 60-minute site-loss RPO |
| Recoverable history | Retain 35 days of recovery history, including any earlier base needed to restore the oldest retained point | Covers the example's four-day corruption-detection delay and leaves investigation time |
| Recovery access | Independently protect backup-service recovery material, application keys, and access instructions | Allows recovery without the production site or its normal administration |

The seven-minute local estimate combines a five-minute schedule interval and up to two minutes to finish producing a usable point. The offsite estimate adds the assumed ten-minute copy delay. They aren't product guarantees. Measure the age of the transaction boundary that's actually recoverable, not the age of the last job notification.

A missed log backup can push the usable point outside the ten-minute objective. A missing required log segment can also prevent later segments from advancing recovery until the chain is repaired. Configure alerts before the objective is breached and define who resolves the gap.

Validate the chain as a whole. A recent log file without its required base backup isn't a usable recovery point. Likewise, an offsite copy of the base without the required logs doesn't satisfy the intended offsite RPO. Confirm how the selected tools coordinate application backups and VM snapshots so that one mechanism doesn't invalidate another's recovery assumptions.

## Establish whether the RTO is feasible

An RTO is a business requirement, not evidence that the infrastructure can achieve it. Build a recovery-time budget from measured work: detection and authorization, recovery access, backup-service recovery if needed, retrieval, transfer, restore processing, log replay, startup, validation, and traffic changes.

The *critical path* is the sequence of dependent activities that determines the earliest possible completion. Some tasks can run in parallel, and some products combine transfer and restore processing. Don't count overlapping work twice, but don't assume it overlaps without evidence.

For a transfer-bound restore, a useful lower-bound estimate is:

`Transfer time = data that must move / effective sustained throughput`

For example, 1 TiB is 1,048,576 MiB. At an effective 100 MiB/s, transferring that data takes `1,048,576 / 100 / 60`, or about **174.8 minutes**. That's approximately **2.9 hours**, before additional recovery work. MiB/s measures bytes per second, not the megabits per second commonly used to advertise network links.

The following simplified budget assumes the transfer and other work are sequential. The 35-minute allowance excludes rebuilding a lost backup server.

| Recovery work | Assumed duration | Running total |
| --- | --- | --- |
| Transfer 1 TiB at 100 MiB/s | 174.8 minutes | 174.8 minutes |
| Other critical-path work, including access, startup, validation, and release | 35 minutes | 209.8 minutes |
| Rebuild the backup service first, if required | 40 additional minutes | 249.8 minutes |

The transfer alone rules out a 45-minute RTO for this route. A 209.8-minute estimate fits inside four hours, but leaves limited contingency. Losing the backup server as well raises the estimate beyond four hours. Faster transfers won't fix a different bottleneck, such as slow log replay or delayed access approval.

Use measured throughput from the intended repository and destination under representative contention. Include any retrieval delay, decompression or decryption cost, storage-write performance, and competing recovery jobs. A cloud archive retrieval delay, where applicable to the selected product and storage tier, must be included before transfer begins.

If the design can't meet the RTO, change it before the incident. Options include a supported prepared replica, a nearer recovery copy, preprovisioned recovery infrastructure, or a smaller supported restore scope. Alternatively, obtain an explicit business change to the objective. Initial replication seeding must already be complete, and ongoing bandwidth must keep up with workload change rates for a replica-based design to remain useful.

## Prepare access, infrastructure, and application dependencies

Store or protect recovery catalogs, encryption material, deployment configuration, access instructions, and contacts outside the protected failure domain. A catalog identifies what was backed up and where it's retained. If the catalog is unavailable, you need the product's supported catalog-recovery or alternate-recovery procedure, not an assumption that files can be guessed into place.

Independent access includes the identity services needed to authenticate recovery operators. Avoid circular dependencies, such as a backup server that requires a domain controller whose only backup can be accessed through that server. Design and test the supported identity-recovery sequence with the identity team.

The target needs enough compute capacity and storage performance for both recovery work and the resumed application. Disk capacity alone isn't sufficient. Log replay, data validation, and simultaneous VM startup can impose different demands from normal steady-state operation.

Prepare target networks and required infrastructure services. Include Domain Name System (DNS), time synchronization, routing, firewall policy, certificates, licenses, and administrative tools. An isolated VM with its original address isn't automatically reachable by users after release. Changes to addresses and DNS can also affect certificates, allowlists, and downstream integrations.

Workload backup doesn't reconstruct the entire Azure Local platform. Preserve deployment information and a supported infrastructure recovery procedure. A failed member of a viable instance can require node repair, while loss of the instance can require platform reconstruction before workload restoration. The infrastructure recovery units in this module distinguish these paths. Don't restore an old host image over orchestrator-owned cluster state without an explicitly supported recovery route.

## Recover the backup infrastructure itself

Treat the backup service as a recoverable dependency. A repository that survives a site failure doesn't automatically supply the server, configuration, permissions, and keys needed to use it.

For MABS, the DPM database, commonly called *DPMDB*, holds configuration and backup metadata, including protection-group settings and schedules. Protect it using the documented MABS server/database procedure, and retain an independently accessible copy. A native SQL database backup stored outside the MABS server and its storage pool can provide a bootstrap copy. A database backup that exists only on destroyed storage can't help rebuild the service.

The following recovery inventory separates control information from the protected data.

| Recovery material | Purpose | Important limitation |
| --- | --- | --- |
| DPMDB backup | Reconstructs MABS configuration and backup metadata | Doesn't recreate recovery-point data on destroyed disks |
| MABS installation and version inventory | Enables a compatible replacement installation | Database recovery requires the matching MABS version and update rollup |
| Retained backup storage | Supplies surviving disk recovery points | Reattachment and synchronization must follow the supported storage-recovery procedure |
| Source server's backup encryption passphrase | Allows access to that server's protected online data | A replacement server's passphrase isn't a substitute |
| Vault access and newly downloaded vault credentials | Authorizes the documented online recovery workflow | Requires working Azure access and doesn't replace the encryption passphrase |
| Independent operator access and target capacity | Allows the recovery process to run | Mustn't depend solely on the failed server or site |

Distinguish two recovery routes:

- **Rebuild the backup service** when you need its configuration and surviving disk protection state. Prepare a trusted replacement with the required installation and SQL prerequisites. For the documented rebuild that retains Modern Backup Storage, preserve the original server name and match the MABS version and update rollup to the database backup. Recover DPMDB, then use the supported synchronization procedure to reconcile storage and protection agents. Confirm the expected data sources and perform a sample recovery before relying on resumed protection.
- **Recover protected online data through another server** when restoring workloads is the immediate goal. Microsoft documents using another supported MABS server registered to the same Recovery Services vault. In **Recovery**, **Add External DPM** discovers the original server's online data using vault credentials and the original server's encryption passphrase. This route doesn't require first restoring the original DPMDB. It does require the online recovery points and their uploaded metadata to be available, supported software versions, Azure connectivity, and sufficient recovery storage.

Alternate-server online recovery isn't automatic failover of the backup service. MABS doesn't support System Center DPM's primary/secondary-server takeover functionality. Don't infer arbitrary cross-version or MABS-to-DPM compatibility from the similar command and interface names.

For example, if the original MABS server and disk repository are destroyed but online data survives, restoring DPMDB won't recreate the lost local points. Use a tested, supported online-data recovery route. If the encryption passphrase is unavailable, installing another server or downloading new vault credentials doesn't remove that dependency.

Record and rehearse the chosen route before an incident. Capture the SQL instance hosting DPMDB, the database's MABS build and update rollup, and the location of its independently accessible backup. If MABS protects DPMDB itself, use a dedicated protection group. If recovery depends on surviving storage-pool copies, also retain the replica paths and volume identifiers needed to locate the database when the normal console is unavailable. Restoring DPMDB is followed by synchronization with the storage pool and protection agents. Missing or inconsistent replicas remain recovery issues even after the database is restored.

For alternate-server online recovery, browse the external server's data sources and explicitly select the recovery date and time. Review the source identity and destination before authorizing writes. In a supported file or folder recovery, **Create copy** preserves an existing same-named file by recovering a separate copy, **Skip** leaves the existing file unchanged, and **Overwrite** replaces it. Choose whether to restore the backed-up security settings or use destination security settings, and validate the resulting access. Monitor the recovery job to completion. These file-recovery options don't remove the separate support and management restrictions on restoring an Azure Local VM.

## Plan for loss of Azure or WAN connectivity

A running local application and its Azure management connection have different dependencies. A wide area network (WAN) outage can disconnect Azure management while local VMs continue to run. The application might nevertheless fail if it needs an unreachable identity provider, external API, or other cloud service.

First determine what's unavailable: the production site, its external network path, a particular Azure service, or administrative authentication. Don't fail over a healthy workload merely because its Azure resource reports disconnected.

The following distinctions help you select a recovery path without assuming that every local or cloud operation remains available.

| Condition | Potentially usable path | Dependency to prove |
| --- | --- | --- |
| Local workloads are healthy, but Azure management is unavailable | Maintain service and use explicitly supported local observation or administration | Local access, application dependencies, and the operation's Azure Local support boundary |
| A local workload needs recovery while Azure is unreachable | An already configured local disk recovery or local replica workflow | Available copies, supported VM/recovery type, hosts, storage, local networking, identities, and keys |
| Only cloud recovery points are available, and the restore location has no Azure connectivity | Restore connectivity or use a prepared, supported recovery location that can reach Azure | Authorization, cloud access, capacity, and time required to use that location |
| The production site's WAN is lost, but a separate recovery location can reach Azure | A preconfigured cloud recovery route might remain available there | Existing protected data, destination readiness, and fencing of a source that might still be running |

Don't equate access to Hyper-V tools with unrestricted local lifecycle management of Azure Local VMs enabled by Arc. Supported local operations include connecting to a VM console, quick or live migration between nodes in the same cluster, and creating a checkpoint with Hyper-V administrative rights. A checkpoint still isn't an independent backup. Cross-cluster live migration and ad hoc VM cloning aren't supported substitutes for a recovery workflow. Local changes aren't necessarily reflected in Azure, and Azure portal and CLI operations still require their relevant control-plane and identity services.

Connectivity also has time-dependent support consequences. For connected, hyperconverged Azure Local deployments, the requirement is successful Azure synchronization at least once every 30 consecutive days. Beyond that period, the connection status becomes **Out of policy**. Existing VMs continue to run, but reduced functionality prevents new VM creation until synchronization resumes. MABS has a separate constraint: disk and online backups stop after more than 15 days without Azure connectivity. Local disk restore eligibility still depends on the subscription state and local prerequisites. An allowed online restore isn't physically possible from a location that can't reach its data.

These are different limits, not grace periods that make a ten-minute RPO achievable during a long outage. Existing points age while new usable points aren't produced. MABS permits recovery with an active or expired subscription under its supported recovery conditions, but a deprovisioned subscription doesn't permit restore, and its Azure recovery points are deleted. Don't treat subscription deprovisioning as a way to pause protection while preserving recovery access.

Cloud recovery through the Microsoft Azure Recovery Services (MARS) agent on MABS requires access to Azure Backup, Azure Storage, and Microsoft Entra ID. Validate name resolution, proxy and firewall configuration, and the required outbound HTTPS connections on port 443 from the recovery server. Reachability of the Azure portal from an operator's laptop doesn't establish that the recovery server can authenticate and download data. After connectivity returns, confirm synchronization and fresh recovery points rather than assuming that a connected status means the RPO has been restored.

Azure Local disconnected operations is a separate deployment model with its own local control plane and requirements. Losing connectivity in a connected deployment doesn't convert it into that model.

## Prepare for ransomware and administrative compromise

Recovering from a security incident adds a trust decision to the normal availability decision. A replica can contain an attacker's changes, and an immutable backup can preserve malicious configuration or software.

Build the recovery timeline from evidence of initial compromise, persistence, and destructive activity. If encryption began on Friday but an attacker gained access on Monday, a Thursday backup isn't automatically clean. Successful database integrity checks establish something different from the absence of an attacker.

Coordinate the following sequence with the incident-response team. Containment begins immediately rather than waiting for a complete restore.

1. Contain affected systems and compromised access using the approved incident-response process. Preserve evidence and recoverable copies rather than deleting potentially important material during an improvised cleanup.
1. Establish trusted recovery administration and an isolated recovery environment. Don't reuse a suspect administrator workstation, management server, or configuration merely because it still functions.
1. Investigate candidate recovery points against the compromise timeline. Validate restored systems and data in isolation, using application checks and security investigation together. A malware scan alone isn't proof of a clean environment.
1. Remove persistence and address the exploited weaknesses through supported remediation or rebuilding. Rotate affected authentication credentials and update dependent services in an approved order.
1. Obtain security and application-owner approval before reconnecting the recovered service. Confirm source fencing, required monitoring, business behavior, and protection at the new location.

Separate credential rotation from destruction of historical decryption material. Old backup passphrases, keys, or certificates might still be needed to read retained recovery points. Preserve controlled recovery access while the security team contains compromise. Prove a supported migration or re-encryption process before retiring required historical material. Changing an administrator password doesn't re-encrypt old backups.

Include the extra investigation and rebuilding time in cyber recovery planning. Attackers can operate for weeks or months before visible encryption, introduce backdoors, contaminate successive backups, and target recovery instructions as well as application data. Retain independently accessible copies of runbooks, configuration inventories, network diagrams, and support contacts. Exercise recovery with normal email and chat unavailable so that coordination doesn't depend on compromised or failed systems.

Validate recovery material when it's produced and again before use. Restoring application availability doesn't resolve possible data theft or prove that the attacker has been removed. Keep those investigations and security-release decisions with the incident-response team. If no trusted point can meet the normal RPO or RTO, escalate the business impact and document the exception. Don't release a suspect workload just to report that a target was met.

## Build a runbook with decision gates

A *runbook* is an operational procedure with prerequisites, actions, expected results, stop conditions, and owners. A list of commands without decision criteria isn't a complete runbook.

The following fields make the recovery procedure usable when normal administrators or infrastructure are unavailable.

| Runbook field | What to record |
| --- | --- |
| Scope and authority | Workload identity, incident owner, application owner, release approver, and escalation contacts |
| Recovery objectives | RPO, RTO, start and stop boundaries, and acceptable degraded-service conditions |
| Feasibility and fallback | Measured critical-path timings, recovery capacity, connectivity assumptions, and an approved route if the preferred method is unavailable |
| Protection inventory | Product and version, recovery-point locations, consistency, retention, and supported destination |
| Access prerequisites | Where approved emergency identities and key-retrieval instructions are held, without embedding secrets |
| Backup-service recovery | Independent database/configuration backup, installation versions, surviving repositories, and a supported alternate-server route |
| Target prerequisites | Compute, storage, network isolation, DNS, time, identity, certificates, and licenses |
| Recovery sequence | Dependency order, restore actions, expected outcomes, and stop conditions |
| Security incident gate | Containment owner, trusted administration, compromise-timeline evidence, and security approval for reconnection |
| Release and return | Source fencing, traffic changes, business acceptance, reprotection, and separately approved failback |
| Evidence and ownership | Logs, timestamps, integrity results, approvals, cleanup responsibilities, and next review date |

The recovery gates establish a simple rule: a failed prerequisite blocks the next release decision.

:::image type="content" source="../media/concept-flow.svg" alt-text="Diagram that shows recovery gates from independent access through isolated restore to validation, release, and reprotection." border="false":::

The stages can contain parallel work. For example, one team can prepare DNS while another retrieves a backup. Parallel activity mustn't bypass a prerequisite or allow more than one production writer.

## Include Kubernetes application state

For Kubernetes workloads, distinguish the cluster, workload definitions, secrets, and persistent application data. A *persistent volume* stores data beyond the life of an individual container. A *storage class* describes how storage is provisioned. Neither the container image nor the workload manifest contains all persistent data.

Protect declarative configuration, secrets through approved secret-management processes, persistent volumes, and application-native state within a supported product's scope. Recreate required storage classes, identities, and operators before restoring dependent applications. An operator is a controller that manages application-specific lifecycle behavior.

Restore resources in an application-aware order. Starting every restored workload at once can cause components to write into incomplete databases or contact live external services. Worker-machine recovery alone doesn't prove transaction-consistent application recovery.
