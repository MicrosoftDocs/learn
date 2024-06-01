Azure Files provides the capability to take [share snapshots of file shares](/azure/storage/files/storage-snapshots-files). Share snapshots give you an extra level of security, and help reduce the risk of data corruption or accidental deletion. You can also use share snapshots as a general backup for disaster recovery.

:::image type="content" source="../media/file-share-backup.png" alt-text="Diagram of Azure file shares snapshots stored in a Recovery Services vault." border="false":::

### Things to know about Azure File share backup and recovery

Let's review some of the characteristics regarding backup and recovery of Azure file shares.

- Share snapshots capture the share state at that specific point in time.

- Snapshots can be created manually by using the Azure portal, REST API, client libraries, the Azure CLI, and PowerShell.

- Snapshots can be automated by using Azure Backup and backup policies.

- Snapshots are at the root level of a file share and apply to all the folders and files contained in the share. Retrieval is provided at the individual file level. 

- Snapshots are incremental. Only the deltas between your snapshots are stored.

- After a share snapshot is created, it can be read, copied, or deleted, but it can't be modified. 

- You can't delete a share that has share snapshots. To delete the share, you must delete all the share snapshots.

> [!IMPORTANT]
> Snapshots aren't a replacement for cloud-side backups. 

#### Automated file share backups

You can automate and manage your Azure file shares snapshots. Automating snapshot backups with Azure Backup is the recommended approach. The following diagram shows how automatic backups of file shares can be restored from a Recovery Services vault.

:::image type="content" source="../media/file-share-automated.png" alt-text="Diagram that shows how Azure file shares snapshots are restored from a Recovery Services vault in Azure Backup." border="false":::

- Azure Backup keeps the metadata about the snapshot backup in the Recovery Services vault, but no data is transferred. This method provides you with a fast backup solution that has built-in backup and reporting. 

- When Azure Backup is enabled on the file share, the soft delete feature is also enabled. 

- You can configure snapshot backups for daily, weekly, monthly or yearly retention, according to your requirements.

### Things to consider when using file share backups

Take a moment to review some considerations for creating and recovering from file share backups. Think about how you can use this approach to support the Tailwind Traders BCDR requirements.

- **Consider instant restore.** Azure file share backup uses file share snapshots. You can select just the files you want to restore instantly.

- **Consider alerts and reporting**. You can configure alerts for backup and restore failures and use the reporting solution provided by Azure Backup. These reports provide insights on file share backups.

- **Consider self-service restore**. Azure Backup uses server endpoint Windows Volume Shadow Copy Service (VSS) snapshots. You might consider giving advanced users the ability to restore files themselves. 

- **Consider on-demand backups**. Azure Backup policies are limited to scheduling a backup once a day. If a user creates a file in the morning and works on it all day, a nightly backup doesn't include the new file. For these reasons, consider on-demand backups for the most critical file shares. 

- **Consider file share organization**. Organize your file shares according to how you intend to store the data in backups. You might separate your file shares for backup according to public facing data versus internal file shares. 

- **Consider code deployments**. If a bug or application error is introduced with the new deployment, you can go back to a previous version of your data on that file share. To help protect against these scenarios, you can take a share snapshot before you deploy new application code. 