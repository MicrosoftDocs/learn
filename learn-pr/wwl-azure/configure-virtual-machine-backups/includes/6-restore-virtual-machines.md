After you back up your virtual machine, the backup snapshots and recovery points are stored in your Recovery Services vault. You can recover your machine by accessing the snapshot, or restore data to a specific point-in-time by using recovery points.

:::image type="content" source="../media/virtual-machine-restore-876df613.png" alt-text="Screenshot that shows recovery points in a Recovery Services vault for a virtual machine snapshot in the Azure portal.":::

### Things to know about restoring your virtual machines

Let's review a few points about restoring your virtual machines from your backup snapshots.

- You can select recovery points for your virtual machine snapshots in the Azure portal.

- When you trigger a restore operation, Azure Backup creates a job to track the restore operation.

- Azure Backup creates and temporarily displays notifications about the restore operation.

- You can track the restore operation by monitoring the job notifications in the Azure portal.