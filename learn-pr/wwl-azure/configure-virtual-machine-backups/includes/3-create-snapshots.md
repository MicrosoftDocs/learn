An Azure backup job consists of two phases. First, a virtual machine snapshot is taken. Second, the virtual machine snapshot is transferred to the Azure Recovery Services vault.

:::image type="content" source="../media/virtual-machine-snapshot-aeddf5a2.png" alt-text="A virtual machine snapshot is transferring data to an Azure Recovery Services vault.":::


A recovery point is considered created only after both steps are completed. As a part of the upgrade, a recovery point is created as soon as the snapshot is finished. This recovery point is used to perform a restore. You can identify the recovery point in the Azure portal by using “snapshot” as the recovery point type. After the snapshot is transferred to the vault, the recovery point type changes to “snapshot and vault”.

## Capabilities and considerations

 -  Ability to use snapshots taken as part of a backup job that is available for recovery without waiting for data transfer to the vault to finish.
 -  Reduces backup and restore times by retaining snapshots locally, for two days by default. This default snapshot retention value is configurable to any value between 1 to 5 days.
 -  Supports disk sizes up to 32 TB. Resizing of disks is not recommended by Azure Backup.
 -  Supports Standard SSD disks along with Standard HDD disks and Premium SSD disks.
 -  Incremental snapshots are stored as page blobs. All the users using unmanaged disks are charged for the snapshots stored in their local storage account. Since the restore point collections used by Managed VM backups use blob snapshots at the underlying storage level, for managed disks you will see costs corresponding to blob snapshot pricing and they are incremental.
 -  For premium storage accounts, the snapshots taken for instant recovery points count towards the 10-TB limit of allocated space.
 -  You get an ability to configure the snapshot retention based on the restore needs. Depending on the requirement, you can set the snapshot retention to a minimum of one day in the backup policy blade as explained below. This will help you save cost for snapshot retention if you don’t perform restores frequently.

> [!NOTE]
> By default, snapshots are retained for two days. This feature allows restore operation from these snapshots there by cutting down the restore times. It reduces the time that is required to transform and copy data back from the vault.
