You protect an Azure Cosmos DB account by matching its backup mode, retention tier, and restore path to the recovery the team performs. These decisions give you a window you can measure and a procedure you can rehearse before an incident forces the question.

## What you learned

- You compare periodic and continuous backup on granularity, retention, cost, and who starts a restore, and you check the account conditions before committing to a one-way migration.
- You enable continuous backup on new and existing accounts, name the tier explicitly rather than accepting the charged default, and verify the applied policy and the latest restorable timestamp.
- You choose between restoring a deleted resource into the same account and restoring into a new one, identify a restore point from the event feed, and reapply the network and permission settings a new-account restore doesn't return.
- You describe how vaulted backup layers years of immutable, isolated retention on top of the native window, and where the preview's supported scenarios currently stop.

## Learn more

- [Compare backup modes](/azure/cosmos-db/online-backup-and-restore)
- [Review periodic backup](/azure/cosmos-db/periodic-backup-restore-introduction)
- [Review continuous backup and point-in-time restore](/azure/cosmos-db/continuous-backup-restore-introduction)
- [Provision an account with continuous backup](/azure/cosmos-db/provision-account-continuous-backup)
- [Migrate from periodic to continuous mode](/azure/cosmos-db/migrate-continuous-backup)
- [Restore a deleted container or database to the same account](/azure/cosmos-db/how-to-restore-in-account-continuous-backup)
- [Configure restore permissions](/azure/cosmos-db/continuous-backup-restore-permissions)
- [Explore Azure Backup for Azure Cosmos DB](/azure/backup/backup-azure-cosmos-db-overview)
