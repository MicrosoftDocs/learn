Azure Storage now offers soft delete for blob objects so that you can more easily recover your data when it is erroneously modified or deleted by an application or other storage account user. Soft delete for VMs protects the backups of your VMs from unintended deletion. Even after the backups are deleted, they're preserved in soft-delete state for 14 additional days.

:::image type="content" source="../media/soft-delete-93edca4c.png" alt-text="Flowchart showing a soft deleted state for 14 days until the item is permanently deleted.":::


## How soft delete works for virtual machines

1.  To delete the backup data of a VM, the backup must be stopped.
2.  You can then choose to delete or retain the backup data. If you choose **Delete backup data** and then **Stop backup**, the VM backup won't be permanently deleted. Rather, the backup data will be retained for 14 days in the soft deleted state.
3.  During those 14 days, in the Recovery Services vault, the soft deleted VM will appear with a red **soft-delete** icon next to it. If any soft-deleted backup items are present in the vault, the vault can't be deleted at that time. Try deleting the vault after the backup items are permanently deleted, and there are no items in soft deleted state left in the vault.
4.  To restore the soft-deleted VM, it must first be undeleted. To undelete, choose the soft-deleted VM, and then select the option **Undelete**. At this point, you can also restore the VM by selecting **Restore VM** from the chosen restore point.
5.  After the undelete process is completed, the status will return to **Stop backup with retain data** and then you can choose **Resume backup**. The Resume backup operation brings back the backup item in the active state, associated with a backup policy selected by the user defining the backup and retention schedules.

> [!NOTE]
> Soft delete only protects deleted backup data. If a VM is deleted without a backup, the soft-delete feature won't preserve the data. All resources should be protected with Azure Backup to ensure full resilience.
