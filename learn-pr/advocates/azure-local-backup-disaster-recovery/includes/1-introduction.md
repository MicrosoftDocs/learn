Imagine that you operate an order-processing application on Azure Local. A database VM stores orders, an application VM processes them, and an identity service authenticates users. The application also needs name resolution, certificates, and a connection to a downstream fulfillment service.

One morning, the application stops accepting orders. The cluster restarts the application VM on another node, but the database contains corrupted records. Restarting a VM doesn't reverse those changes. A recent replica might contain the same corruption. Even a clean backup won't help if its decryption key is stored only on the failed site.

Your task is to recover a trusted business service, not just turn on a VM.

## Azure Local backup and recovery

Azure Local runs workloads on infrastructure in your own facilities, with Azure Arc providing Azure-based management capabilities. The workload's virtual disks and application data can remain on local storage. Managing a VM through Azure doesn't automatically back up its contents or make it equivalent to a VM running in an Azure datacenter. You must configure protection for the workload and prepare a supported recovery destination.

*Backup* preserves selected data and configuration so that you can retrieve an earlier state after deletion, corruption, or infrastructure failure. A *recovery point* represents a state that the protection product can restore. A *retention policy* determines how long those points remain available. Keeping several points matters because the most recent copy might already contain the problem you're trying to recover from.

*Restore* is the operation that retrieves backed-up data to its original location or an alternate destination. *Recovery* is the broader process of returning the business service to a usable, trusted state. It can include restoring data, rebuilding a machine, reconnecting dependencies, and validating application transactions. A restored VM isn't fully recovered if its database is inconsistent or users can't authenticate.

An Azure Local recovery design addresses four related layers:

- **Platform recovery**: Repair a failed physical node or reconstruct the instance through a supported recovery path. Preserve surviving storage and validate the platform before relying on it for restored workloads.
- **VM protection**: Preserve the VM files needed to recover its operating system, configuration, and included disks. Account for encryption and guest security state, not just disk contents.
- **Application protection**: Preserve the data, transaction history, and application configuration required for a consistent result. A database might need its own backup and log-recovery process in addition to a whole-VM backup.
- **Recovery dependencies**: Preserve access to identities, keys, backup metadata, network configuration, and replacement capacity. Workload backups don't, by themselves, rebuild the Azure Local platform or restore every Azure management relationship.

High availability and replication complement these backups. Cluster availability can keep a workload running through supported component failures. Replication prepares another operational copy, but can also copy unwanted changes. A *failover* activates a recovery copy as the service location. It still requires suitable data, working dependencies, and control over which copy can accept production writes.

Supported protection options include Microsoft Azure Backup Server, partner products, and application-native backup tools. Hyper-V Replica and Azure Site Recovery provide replication routes for supported configurations. The right combination depends on the workload, its security settings, the recovery destination, and the required consistency. No single method automatically covers every layer.

Finally, keep recovery data and the means to use it outside the failures you're planning for. An offsite backup is of little use if its only decryption key is lost with the primary site. Prove the design by recovering in isolation and checking the application, then measure how much data was lost and how long service was unavailable.

## Recovery objectives

The *recovery-point objective* (RPO) is the maximum acceptable data-loss interval. An RPO of ten minutes means that the business can tolerate losing up to ten minutes of changes, measured against an agreed event boundary. It doesn't mean that a backup job must merely start every ten minutes.

The *recovery-time objective* (RTO) is the maximum acceptable service interruption. If the RTO is 45 minutes, the agreed service must be usable within that interval. Detection, escalation, authorization, data transfer, application recovery, validation, and traffic redirection all consume time.

Objectives are targets. After an incident or exercise, you compare the observed data-loss interval and service interruption with those targets. Define the clock boundaries before the incident so that different teams don't report incompatible measurements.

The following examples translate business requirements into evidence that a recovery team can collect.

| Requirement | Agreement needed before recovery | Evidence needed afterward |
| --- | --- | --- |
| Ten-minute RPO | Which application transaction marks the recovered boundary? | Last verified transaction in recovered data and the agreed failure time |
| 45-minute RTO | When does interruption start, and what counts as restored service? | Failure time and business acceptance time |
| Recover trusted orders | Which integrity checks and reconciliation rules must pass? | Database checks, order reconciliation, and representative transactions |
| Resume safely | Who authorizes a new production writer? | Source-fencing evidence and a recorded release decision |

A business acceptance test might require an authorized user to sign in, submit a test order, retrieve it, and confirm the downstream response. A boot screen or a successful network ping doesn't demonstrate that result.

## Recovery dependencies

A *failure domain* is a set of components that can fail together. A server, a storage system, a building, and an administrative account can each define a failure domain. Two copies on different disks can still share a power supply, a site, or deletion authority.

Ask two questions about every recovery dependency:

- Can it survive the failure or compromise that the plan is intended to address?
- Can an authorized recovery operator use it when the production environment is unavailable?

These questions turn backup design into recovery engineering. You'll apply them to copies, keys, recovery targets, and operational decisions throughout this module.
