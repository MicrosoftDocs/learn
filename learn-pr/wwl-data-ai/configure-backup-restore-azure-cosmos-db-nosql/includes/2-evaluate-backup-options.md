Contoso's catalog account runs in periodic backup mode because that mode is the default for every account. Before the account carries production traffic, you need to decide whether that default meets the team's recovery expectations. The choice is consequential: migrating to continuous mode is a one-way change, and the two modes differ in who can start a restore, how precisely you can target a moment in time, and what you pay.

## Compare the two backup modes

Azure Cosmos DB always backs up your data. Backups run in the background without consuming provisioned throughput and without affecting availability. They're encrypted with Microsoft-managed keys, transferred over a nonpublic network, and stored separately from the account. The modes differ in cadence, retention, and recovery path.

**Periodic backup mode** takes a full backup on an interval. By default, the interval is four hours and the service keeps the latest two backups at no extra cost. You can change the interval to any value from 1 through 24 hours, and set retention from twice the interval up to 720 hours (30 days). Backups are taken only in the write region, and the restore always creates a new account in that region. Periodic backups aren't directly accessible, so recovery starts with a support request to the Azure Cosmos DB team. If a container or database is deleted, the service keeps its snapshots for 30 days.

Periodic mode also lets you choose geo-redundant, zone-redundant, or locally redundant backup storage, subject to regional availability. Geo-redundant storage is the default where the region supports it. In a region without a paired region, select a supported redundancy option explicitly.

**Continuous backup mode** streams changes rather than taking scheduled snapshots. In a steady state, mutations are backed up asynchronously within 100 seconds, and backups are taken in every region where the account exists. You restore to any second within the retention window, without a support request, from the Azure portal, the Azure CLI, Azure PowerShell, or an Azure Resource Manager template. Backup storage redundancy isn't configurable: each region uses locally redundant storage, or zone-redundant storage when the region has availability zones enabled.

:::image type="content" source="../media/backup-mode-comparison.png" alt-text="Diagram comparing periodic backup snapshots restored by support request with continuous backup restored by self-service to a chosen second." lightbox="../media/backup-mode-comparison.png":::

The practical distinction is granularity and control. Periodic mode recovers you to whenever the last usable snapshot happened to run. Continuous mode recovers you to the second before the mistake, and your own team performs the operation.

## Choose a continuous backup tier

Continuous mode has three retention tiers, and the tier sets the restore window:

| Tier | Restore window | Backup storage charge |
|:--|:--|:--|
| `Continuous7Days` | 7 days | None |
| `Continuous30Days` | 30 days | Charged per gigabyte, per region |
| `Continuous35Days` | 35 days | Charged at the same rate as the 30-day tier |

Every tier incurs a charge each time you start a restore, calculated on the volume of data restored. The 7-day tier is free to store, which makes it the reasonable default for a workload whose recovery objective is measured in hours rather than weeks. If you omit the tier when provisioning or migrating, the account uses `Continuous30Days`.

You can switch between tiers later, but you can't set an arbitrary number of days. Moving to a shorter window takes effect immediately and you lose the ability to restore data older than the new window. Moving to a longer window doesn't retroactively extend coverage: you can only restore from the previous window until new backups accumulate. Price changes apply immediately in both directions.

The restore point can never reach further back than the moment the resource was created, regardless of tier.

## Account for the conditions and the gaps

Continuous mode carries account conditions that periodic mode doesn't. Confirm each one before you commit, because migration runs in one direction only.

- The account uses the API for NoSQL, MongoDB, Gremlin, or Table. The API for Cassandra doesn't support continuous backup.
- The account never had Azure Synapse Link disabled on a container. An account in that state can't migrate to continuous mode.

Continuous backup supports both single-write and multi-region-write accounts. For multi-region-write accounts, restore includes only writes confirmed by the hub region by the restore timestamp.

Analytical store data isn't included in backups or restores in either mode. Transactional data continues to be backed up on schedule when Azure Synapse Link is enabled.

A restore also brings back less than learners often expect. Depending on the backup mode and restore target, a restore recovers data and index properties, but not all surrounding configuration. The following limitations apply:

- New-account restores don't return firewall rules, virtual network configuration, private endpoint settings, or data-plane role-based access control assignments.
- Stored procedures, triggers, and user-defined functions.
- New-account restores don't recreate all source regions. A periodic restore produces a single-region account in the write region of the source.
- Periodic backup doesn't restore items already removed by an expired time-to-live value. To keep recovered items from expiring again in continuous mode, select a restore point before expiration and disable time to live during the restore.

Treat these limitations as part of the recovery plan rather than as surprises during an incident. After a new-account restore, reapply the network configuration and role assignments that the application requires. Continuous same-account restore is supported only for deleted databases and containers; it can’t overwrite or roll back an existing live resource. Recovering from accidental item modification requires restoring the relevant data to a new account and then reconciling or copying the recovered data into the application’s active account. A same-account restore retains the existing account’s network settings and account-scoped role assignments and restores the deleted resource in the account’s current regions.

Native periodic and continuous restores don’t support cross-subscription restore. Destination behavior otherwise depends on the restore path: periodic restore and continuous new-account restore create a target account, while continuous same-account restore recreates a deleted database or container in its existing account.

## Audit what your accounts use

Because periodic mode is the default, an account's backup posture is easy to assume and hard to remember. Query it instead. The following Azure Resource Graph query reports the mode and settings for every Azure Cosmos DB account in scope:

```kusto
Resources
| where type =~ "microsoft.documentdb/databaseAccounts"
| extend backupMode = tostring(properties.backupPolicy.type)
| extend periodicBackupIntervalMinutes = toint(properties.backupPolicy.periodicModeProperties.backupIntervalInMinutes)
| extend periodicBackupRetentionHours = toint(properties.backupPolicy.periodicModeProperties.backupRetentionIntervalInHours)
| extend continuousBackupTier = tostring(properties.backupPolicy.continuousModeProperties.tier)
| project subscriptionId, resourceGroup, name, backupMode, periodicBackupIntervalMinutes, periodicBackupRetentionHours, continuousBackupTier
| order by subscriptionId asc, resourceGroup asc, name asc
```

Use periodic mode when scheduled snapshots and a support-assisted restore meet the recovery requirement, and the account can't satisfy the continuous-mode conditions. Use continuous mode when the team needs to recover a specific second on its own. For Contoso's catalog, self-service recovery from an accidental delete is the requirement, so continuous mode at the 7-day tier fits.

Learn more about [choosing a backup mode](/azure/cosmos-db/online-backup-and-restore), [periodic backup](/azure/cosmos-db/periodic-backup-restore-introduction), and [continuous backup](/azure/cosmos-db/continuous-backup-restore-introduction).

With the mode and tier chosen, the next unit enables continuous backup on a new account, migrates an existing one, and verifies the window you have.
