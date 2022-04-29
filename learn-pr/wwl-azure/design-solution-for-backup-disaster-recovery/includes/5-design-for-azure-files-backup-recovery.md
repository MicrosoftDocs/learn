:::image type="content" source="../media/file-share-backup.png" alt-text="File shares snapshots stored in a recovery service vault.":::


Azure Files provides the capability to take [share snapshots of file shares](/azure/storage/files/storage-snapshots-files). Share snapshots give you an extra level of security and help reduce the risk of data corruption or accidental deletion. You can also use them as a general backup for disaster recovery.

- Share snapshots capture the share state at that point in time.

- Snapshots can be created manually using the Azure portal, REST API, client libraries, the Azure CLI, and PowerShell.

- Snapshots can be automated using Azure Backup and backup policies.

- Snapshots are at the root level of a file share and apply to all the folders and files contained in it. Retrieval is provided at individual file level. 

- Snapshots are incremental. Only the deltas between your snapshots will be stored.

- After a share snapshot is created, it can be read, copied, or deleted, but not modified. 

- You cannot delete a share that has share snapshots. To delete the share you must delete all the share snapshots.

>[!IMPORTANT]
>Snapshots are not a replacement for cloud-side backups. 

 

### How can you automate file share backups?

It is recommended you use Azure Backup to automate and manage file share snapshots. 

:::image type="content" source="../media/file-share-automated.png" alt-text="File shares snapshots are restored from the recovery services vault.":::


- Azure Backup keeps the metadata about the backup in the recovery services vault, but no data is transferred. This means a fast backup solution with built-in backup and reporting. 

- When Azure Backup is enabled on the file share soft delete is also enabled. 

- You can configure backups with daily/weekly/monthly/yearly retention according to your requirements.

 

### Considerations for file share backups

- **Use instant restore.** Azure file share backup uses file share snapshots. You can select just the files you want to restore instantly.

- **Implement alerting and reporting**. You can configure alerts for backup and restore failures and use the reporting solution provided by Azure Backup. These reports provide insights on file share backups.

- **Consider self-service restore.** Backup uses server endpoint VSS snapshots. Consider giving advanced users the ability to restore files themselves. 

- **Consider on-demand backups**. Azure Backup policies are limited to scheduling a backup once a day. If a user creates a file in the morning and works on it all day a nightly backup won’t have the new file. For these reasons consider on-demand backups for the most critical file shares. 

- **Organize file shares for backup**. If possible, consider organizing your file shares for backups. For example, public facing vs internal file shares. 

- **Snapshot before code deployments**. If a bug or application error is introduced with the new deployment, you can go back to a previous version of your data on that file share. To help protect against these scenarios, you can take a share snapshot before you deploy new application code. 