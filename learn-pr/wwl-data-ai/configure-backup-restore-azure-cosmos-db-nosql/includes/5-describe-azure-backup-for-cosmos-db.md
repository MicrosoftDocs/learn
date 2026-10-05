Contoso's catalog account now recovers to any second in the past seven days, which handles the accidental delete the team was worried about. Compliance asks a different question: how long can the company produce the state of the catalog on a given date last year, and can an administrator with account access destroy that evidence? Native backups are immutable while retained, and continuous backup supports recovery of a deleted account within its configured retention period. However, the longest native window is 35 days, so it can't preserve last year's state. Azure Backup for Azure Cosmos DB provides longer retention and separate vault controls for that requirement.

> [!NOTE]
> Azure Backup for Azure Cosmos DB is in public preview. Evaluate it against your recovery requirements before you plan a production dependency on it.

## Recognize where the native window ends

Native backup, whether periodic or continuous, is built for operational recovery. The platform manages it entirely, and its longest retention is 35 days. Backups are immutable while they're retained: they can't be altered, re-encrypted, deleted, or disabled, and no person or module can list them. Deleting a continuous-backup account doesn't immediately remove its recoverable backups, but they remain subject to the configured retention period.

Three requirements fall outside that design:

- **Retention measured in years.** Regulatory frameworks, audit obligations, and legal holds routinely require the ability to reconstruct a past state long after any operational recovery window closes.
- **Isolation from the source account.** In a ransomware or compromised-credential scenario, the recovery plan assumes an attacker may reach the account. Recovery data held outside the account's own control plane survives that reach.
- **Centralized governance.** Teams that already run Azure Backup across virtual machines, databases, and file shares want Azure Cosmos DB in the same policy, monitoring, and reporting model rather than in a separate operational process.

Azure Backup for Azure Cosmos DB addresses all three by copying backups into a **Backup vault**, storage that Microsoft manages and the source account can't reach.

:::image type="content" source="../media/native-vaulted-backup.png" alt-text="Diagram of a Cosmos DB account with native continuous backup for days of recovery and a Backup vault for years of retention." lightbox="../media/native-vaulted-backup.png":::

## Understand how vaulted backup works

Azure Backup reads Azure Cosmos DB's transactionally consistent backup stream and writes recovery points into a vault on the schedule a backup policy defines. Setting it up follows the same shape as any other Azure Backup workload: create a Backup vault, define a policy with a schedule and retention, and let the service stream backups into the vault.

The policy combines two backup types. A **full backup** is a complete copy of the account and anchors the chain that follows it. An **incremental backup** captures only what changed since the previous backup, so it's smaller, faster, and cheaper. A typical policy takes one full backup weekly and an incremental backup on each remaining day, which yields a one-day recovery point objective. Every policy must include a weekly full backup; incremental-only policies aren't supported, and a policy can't schedule more than one full backup per week. On-demand backups are always full backups.

Restoring an incremental recovery point requires its chain to be intact, meaning the parent full backup and every incremental backup between it and the selected point.

Backups are taken at the account level and include all databases and containers in the account. There's no item-level backup and no item-level restore, so vaulted backup complements rather than replaces the fine-grained recovery you get from a native point-in-time restore.

The vault adds separate security controls and longer retention to the protection that native backup provides. It provides write-once, read-many immutable storage, soft delete for recovery points, role-based access control over backup and restore operations, multi-user authorization for critical actions, and encryption at rest and in transit. Although Backup vaults generally support multiple redundancy options, Azure Cosmos DB vaulted backup currently requires a Backup vault configured with geo-redundant storage.

Recovery points can be retained for up to 10 years.

## Plan around the preview boundaries

The most important dependency is easy to miss: **vaulted backup requires the account to be in native continuous backup mode**. Azure Backup runs alongside native backup rather than replacing it, so the work in the previous units is a prerequisite rather than an alternative.

The rest of the current boundaries shape whether the option fits a given account:

| Area | Current state |
|:--|:--|
| APIs | API for NoSQL and API for MongoDB accounts that use request units |
| Regions | All Azure public cloud regions; national clouds and sovereign regions aren't supported |
| Restore target | An empty, single-region account using the same API as the source |
| Cross-subscription restore | Supported |
| Cross-region restore | Not supported, although cross-region backups are |
| Account features | Hierarchical partition keys, per-partition automatic failover, and network security perimeter aren't supported |
| Target account limits | Serverless targets and targets with a throughput limit aren't supported |
| Scale | Accounts with up to 2,500 partitions, roughly 125 terabytes |

Two placement rules are easy to violate by accident: the account's primary write region must match both the Backup vault's region and the account's deployment region.

Costs come in three parts: a fixed protected-instance fee per account based on source data size, a per-gigabyte monthly charge for backup data stored in the vault, and a restore fee based on the volume restored.

For Contoso, the decision is a layered one rather than a choice between options. Continuous backup at the 7-day tier serves the operational recovery the developers perform, and vaulted backup serves the multiyear retention and tamper resistance that compliance asks for. An account that doesn't need long retention or vault isolation doesn't need the second layer.

Learn more about [Azure Backup for Azure Cosmos DB](/azure/backup/backup-azure-cosmos-db-overview) and its [support matrix](/azure/backup/backup-azure-cosmos-db-support-matrix).

The next unit puts the native workflow into practice: enabling continuous backup, deleting data, and recovering it to a point you choose.
