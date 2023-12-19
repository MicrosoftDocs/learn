Azure Storage provides data protection for Blob Storage and Azure Data Lake Storage Gen2 to help you to prepare for scenarios where you need to recover data that has been deleted or overwritten. It's important to think about how to best protect your data before an incident occurs that could compromise it.

## Data protection by resource type<br>

The following table summarizes the Azure Storage data protection options according to the resources they protect.

:::image type="content" source="../media/data-protection-resource-type-7c3472b2.png" alt-text="Table showing Azure Storage data protection options according to the resources they protect.":::


## Recover deleted or overwritten data

If you should need to recover data that has been overwritten or deleted, how you proceed depends on which data protection options you've enabled and which resource was affected. The following table describes the actions that you can take to recover data.

:::image type="content" source="../media/recovering-deleted-overwritten-data-cc9cd938.png" alt-text="Table showing actions that you can take to recover data.":::


## Disaster recovery

Azure Storage always maintains multiple copies of your data so that it's protected from planned and unplanned events, including transient hardware failures, network or power outages, and massive natural disasters. Redundancy ensures that your storage account meets its availability and durability targets even in the face of failures.

If a failure occurs in a data center, if your storage account is redundant across two geographical regions (geo-redundant), then you have the option to fail over your account from the primary region to the secondary region.<br>

Customer-managed failover isn't currently supported for storage accounts with a hierarchical namespace enabled.<br>

## Configure an Azure Resource Manager lock on the storage account to protect the account from deletion or configuration changes.<br>

### Apply an Azure Resource Manager lock to a storage account

Microsoft recommends locking all of your storage accounts with an Azure Resource Manager lock to prevent accidental or malicious deletion of the storage account. There are two types of Azure Resource Manager resource locks:

 -  A **CannotDelete** lock prevents users from deleting a storage account, but permits reading and modifying its configuration.
 -  A **ReadOnly** lock prevents users from deleting a storage account or modifying its configuration, but permits reading the configuration.

### Configure an Azure Resource Manager lock

To configure a lock on a storage account with the Azure portal, follow these steps:

1. Navigate to your storage account in the Azure portal.<br>

2. Under the **Settings** section, select **Locks**.<br>

3. Select **Add**.<br>

Provide a name for the resource lock, and specify the type of lock. Add a note about the lock if desired.

To enable blob versioning for a storage account in the Azure portal:

1. Navigate to your storage account in the portal.

2. Under **Data management**, choose **Data protection**.

3. In the **Tracking** section, select **Enable versioning for blobs**, and then choose whether to keep all versions or delete them after a period of time.<br>

:::image type="content" source="../media/lock-storage-account-a56bc8e5.png" alt-text="Screenshot showing Storage account Locks.":::


### Authorizing data operations when a ReadOnly lock is in effect

When a **ReadOnly** lock is applied to a storage account, the List Keys operation is blocked for that storage account. The List Keys operation is an HTTPS POST operation, and all POST operations are prevented when a **ReadOnly** lock is configured for the account. The **List Keys** operation returns the account access keys, which can then be used to read and write to any data in the storage account.

If a client is in possession of the account access keys at the time that the lock is applied to the storage account, then that client can continue to use the keys to access data. However, clients who do not have access to the keys will need to use Microsoft Entra credentials to access blob or queue data in the storage account.<br>

Users of the Azure portal may be affected when a **ReadOnly** lock is applied, if they have previously accessed blob or queue data in the portal with the account access keys. After the lock is applied, portal users will need to use Microsoft Entra credentials to access blob or queue data in the portal. To do so, a user must have at least two RBAC roles assigned to them: the Azure Resource Manager Reader role at a minimum, and one of the Azure Storage data access roles.<br>

Data in Azure Files or the Table service may become unaccessible to clients who have previously been accessing it with the account keys. As a best practice, if you must apply a **ReadOnly** lock to a storage account, then move your Azure Files and Table service workloads to a storage account that is not locked with a **ReadOnly** lock.

## Enable container soft delete for the storage account to recover a deleted container and its contents.

### Enable and manage soft delete for containers

Container soft delete protects your data from being accidentally or erroneously modified or deleted. When container soft delete is enabled for a storage account, a container and its contents may be recovered after it has been deleted, within a retention period that you specify. For more details about container soft delete, see Soft delete for containers.

For end-to-end data protection, Microsoft recommends that you also enable soft delete for blobs and blob versioning.<br>

### Enable container soft delete

You can enable or disable container soft delete for the storage account at any time by using the Azure portal, PowerShell, Azure CLI, or an Azure Resource Manager template. Microsoft recommends setting the retention period for container soft delete to a minimum of seven days.

To enable container soft delete for your storage account by using Azure portal, follow these steps:

1. In the Azure portal, navigate to your storage account.

2. Locate the **Data protection** settings under **Data management**.

3. Select **Enable soft delete for containers**.

4. Specify a retention period between 1 and 365 days.

5. Save your changes.

:::image type="content" source="../media/soft-delete-container-portal-configure-b077497e.png" alt-text="Screenshot showing Storage account Data protection.":::


### View soft-deleted containers

When soft delete is enabled, you can view soft-deleted containers in the Azure portal. Soft-deleted containers are visible during the specified retention period. After the retention period expires, a soft-deleted container is permanently deleted and is no longer visible.

To view soft-deleted containers in the Azure portal, follow these steps:

1. Navigate to your storage account in the Azure portal and view the list of your containers.

2. Toggle the Show deleted containers switch to include deleted containers in the list.

:::image type="content" source="../media/soft-delete-container-portal-list-95444ee8.png" alt-text="Screenshot showing how to view soft-deleted containers.":::


### Restore a soft-deleted container

You can restore a soft-deleted container and its contents within the retention period. To restore a soft-deleted container in the Azure portal, follow these steps:

1. Navigate to your storage account in the Azure portal and view the list of your containers.

2. Display the context menu for the container you wish to restore, and choose **Undelete** from the menu.

:::image type="content" source="../media/soft-delete-container-portal-restore-915b1d90.png" alt-text="Screenshot showing how to restore a soft-deleted container.":::


## Save the state of a blob at regular intervals:

 -  For Blob Storage workloads, enable blob versioning to automatically save the state of your data each time a blob is overwritten.

### Enable and manage blob versioning

You can enable Blob storage versioning to automatically maintain previous versions of a blob when it is modified or deleted. When blob versioning is enabled, then you can restore an earlier version of a blob to recover your data if it is erroneously modified or deleted.

### Enable blob versioning

You can enable blob versioning with the Azure portal, PowerShell, Azure CLI, or an Azure Resource Manager template.

To enable blob versioning for a storage account in the Azure portal:

1. Navigate to your storage account in the portal.

2. Under **Data management**, choose **Data protection**.

3. In the **Tracking** section, select **Enable versioning for blobs**, and then choose whether to keep all versions or delete them after a period of time.

:::image type="content" source="../media/portal-enable-versioning-92d62db8.png" alt-text="Screenshot showing how to enable and manage blob versioning.":::


### List blob versions

To display a blob's versions, use the Azure portal, PowerShell, or Azure CLI. You can also list a blob's versions using one of the Blob Storage SDKs.

To list a blob's versions in the Azure portal:

1. Navigate to your storage account in the portal, then navigate to the container that contains your blob.<br>

2. Select the blob for which you want to list versions.<br>

3. Select the **Versions** tab to display the blob's versions.<br>

:::image type="content" source="../media/portal-list-blob-versions-644ebee9.png" alt-text="Screenshot showing how to list blob versions.":::


4. Toggle the Show deleted versions button to display soft-deleted versions. If blob soft delete is enabled for the storage account, then any soft-deleted versions that are still within the soft-delete retention interval will appear in the list.

:::image type="content" source="../media/portal-list-deleted-versions-949336f1.png" alt-text="Screenshot showing how to list deleted versions.":::


 -  For Azure Data Lake Storage workloads, take manual snapshots to save the state of your data at a particular point in time.

### Blob snapshots

A snapshot is a read-only version of a blob that's taken at a point in time.

*Snapshots in accounts that have the hierarchical namespace feature enabled is currently in PREVIEW.* 

A snapshot of a blob is identical to its base blob, except that the blob URI has a DateTime value appended to the blob URI to indicate the time at which the snapshot was taken. For example, if a page blob URI is `http://storagesample.core.blob.windows.net/mydrives/myvhd`, the snapshot URI is similar to `http://storagesample.core.blob.windows.net/mydrives/myvhd?snapshot=2011-03-09T01:42:34.9360000Z`.

A blob can have any number of snapshots. Snapshots persist until they're explicitly deleted, either independently or as part of a Delete Blob operation for the base blob. You can enumerate the snapshots associated with the base blob to track your current snapshots.

*All snapshots share the base blob's URI. The only distinction between the base blob and the snapshot is the appended DateTime value.*

A blob can have any number of snapshots. Snapshots persist until they're explicitly deleted, either independently or as part of a Delete Blob operation for the base blob. You can enumerate the snapshots associated with the base blob to track your current snapshots.

When you create a snapshot of a blob, the blob's system properties are copied to the snapshot with the same values. The base blob's metadata is also copied to the snapshot, unless you specify separate metadata for the snapshot when you create it. After you create a snapshot, you can read, copy, or delete it, but you can't modify it.<br>

Any leases associated with the base blob don't affect the snapshot. You can't acquire a lease on a snapshot.<br>

You can create a snapshot of a blob in the hot or cool tier. Snapshots on blobs in the archive tier aren't supported.<br>

A VHD file is used to store the current information and status for a VM disk. You can detach a disk from within the VM or shut down the VM, and then take a snapshot of its VHD file. You can use that snapshot file later to retrieve the VHD file at that point in time and recreate the VM.

## Recover deleted or overwritten data

If you should need to recover data that has been overwritten or deleted, how you proceed depends on which data protection options you've enabled and which resource was affected. The following table describes the actions that you can take to recover data.
