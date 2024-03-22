
Azure Cosmos DB accounts with a continuous backup mode, gives you the ability to do a point in time recovery. This type of recovery will allow you to choose any timestamp within the 30-day backup retention period and restore a combination of Azure DB containers, databases, or the account. 

## Restore Scenarios

Let's review several point-in-times restores scenarios:

- Restore deleted account - Deleted accounts that can be restored are visible in the **Restore** pane under the Azure Cosmos DB account list page. The information needed for the restore is the timestamp right before the delete, the account name of the deleted account, and the target name to be restored as. Restores can be performed from the Azure portal, PowerShell, or CLI.

- Restore data of an account in a particular region - If you need a copy in a region of an Azure Cosmos DB Account you can do a point in time restore of the account. The information needed for the restore is the desired timestamp, and the target name to be restored as. Restores can be performed from the Azure portal, PowerShell, or CLI.

- Recover from an accidental write or delete operation within a container with a known restore timestamp - If you know the timestamp when the accidental operation was done, you can do a point in time restore from Azure portal, PowerShell, or CLI into another account at the desired timestamp to recover to.

- Restore an account to a previous point in time before the accidental delete of the database - Under the point in time page, use the event feed pane to determine when the database was deleted, and find the restore time. You can do a point in time restore from Azure portal, PowerShell, or CLI into another account at the desired timestamp to recover to.

- Restore an account to a previous point in time before the accidental delete or modification of the container properties - Under the point in time page, use the event feed pane to determine when the container was created, modified, or deleted and find the restore time. You can do a point in time restore from Azure portal, PowerShell, or CLI into another account at the desired timestamp to recover to.

