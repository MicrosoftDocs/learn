Azure Storage now offers the _soft delete_ option for Azure Blob objects. With this feature, you can more easily recover your data when it's erroneously modified or deleted by an application or other storage account user.

:::image type="content" source="../media/soft-delete-93edca4c.png" alt-text="Flowchart that shows how backup items remain in the soft delete state for 14 days until the item is permanently deleted." border="false":::

Soft delete for virtual machines protects backups of your virtual machines from unintended deletion. Even after the backups are deleted, they're preserved in the soft-delete state for 14 more days.

> [!Important]
> Soft delete only protects deleted backup data. If a virtual machine is deleted without a backup, the soft-delete feature won't preserve the data. All resources should be protected with Azure Backup to ensure full resilience.

### Things to know about soft delete for backups

Review the following details regarding implementing soft delete for your virtual machine backups.

- **Stop backup job**. Before you can delete or retain backup data for your virtual machine, you must stop the active backup job. After you stop the backup job in the Azure portal, you can choose to delete or retain your backup data.

- **Apply soft-delete state**. Prevent your virtual machine backup data from being permanently deleted by selecting **Delete backup data** followed by **Stop backup**. The soft-delete state is applied to your backup data, and the data is retained for 14 days. If you apply the state to a virtual machine, the machine is referred to as _soft-deleted_.

- **View soft-delete data in the vault**. During the 14 day retention period, the Recovery Services vault shows your soft-deleted virtual machine with a red **soft-delete** icon. 

   > [!Note]
   > When a Recovery Services vault contains any soft-deleted items, the vault can't be deleted. First delete or undelete all soft-deleted items, and then delete the vault.

- **Undelete backup items**. Before you can restore a soft-deleted virtual machine, you must undelete the backup data.

- **Restore items**. After you undelete the backup item, you can restore your virtual machine by selecting **Restore virtual machine** from the chosen recovery point in the backup.

- **Resume backups**. When the undelete process completes, the backup job status returns to **Stop backup with retain data**, and you can choose **Resume backup**. The resume operation retrieves the backup item in the _active_ state according to the backup policy selected by the user. The policy defines the backup and retention schedules.