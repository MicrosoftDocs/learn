[Operational backup for blobs](/azure/backup/blob-backup-overview) is a local backup solution. The backup data isn't transferred to the Backup vault but is stored in the source storage account itself. This is a **continuous backup** solution. You don’t need to schedule any backups. All changes will be retained and restorable from a selected point in time. 

 
### Take advantage of blob soft delete and versioning

Soft delete protects an individual blob, snapshot, container, or version from accidental deletes or overwrites. Soft delete maintains the deleted data in the system for a specified retention period. During the retention period, you can restore a soft-deleted object to its state at the time it was deleted.

:::image type="content" source="../media/soft-delete.png" alt-text="A container has blobs and blobs have versions.":::


- [**Container** soft delete](/azure/storage/blobs/soft-delete-container-enable) can restore a container and its contents at the time of deletion. The retention period for deleted containers is between 1 and 365 days. The default retention period is seven days.

- [**Blob** soft delete](/azure/storage/blobs/soft-delete-blob-enable) can restore a blob, snapshot, or version that has been deleted. Blob soft delete is useful for restoring specific files. The retention period for deleted blobs is also between 1 and 365 days.

- [Blob versioning](/azure/storage/blobs/versioning-enable) works to automatically maintain previous versions of a blob. When blob versioning is enabled, you can restore an earlier version of a blob. Versioning lets you recover your data if it’s incorrectly modified or deleted. Blob versioning is useful if you have multiple authors editing files and need to maintain or restore their individual changes. 

 

> [!TIP]
> Container soft delete doesn’t protect against the deletion of a storage account, but only against the deletion of containers in that account. 

 

### Consider point-in-time restore for block blobs

Like soft delete, [point-in-time restore for block blobs](/azure/storage/blobs/point-in-time-restore-overview) also protects against accidental deletion or corruption. For this feature, you create a management policy for the storage account and specify a retention period. During the retention period, you can restore block blobs from the present state to a state at a previous time.

The following diagram shows how point-in-time restore works. One or more containers or blob ranges is restored to its previous state. The effect is to revert write and delete operations that happened during the retention period. 

:::image type="content" source="../media/blob-point-restore.png" alt-text="A storage account restores containers to a previous point in time.":::

 


> [!NOTE]
> Point-in-time restore enables testing scenarios that require reverting a data set to a known state before running further tests.

### Prevent accidental changes by using resource locks

A [resource lock](/azure/azure-resource-manager/management/lock-resources) prevents resources from being accidentally deleted or changed. Consider using resources locks to protect your data. You can set the lock level to **CanNotDelete** or **ReadOnly**.

- **CanNotDelete** means authorized people can still read and modify a resource, but they can't delete the resource without first removing the lock.

- **ReadOnly** means authorized people can read a resource, but they can't delete or change the resource. Applying this lock is like restricting all authorized users to the permissions granted by the **Reader** role in Azure RBAC.

 

> [!TIP]
> Consider the storage protection features you’ve learned about. Which ones do you think would be most useful? In what scenarios will you use these features?