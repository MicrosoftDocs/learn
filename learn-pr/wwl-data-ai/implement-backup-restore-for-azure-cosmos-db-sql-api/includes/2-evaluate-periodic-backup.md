
Azure Cosmos DB takes automatic backups of your data at regular periodic intervals. Azure Cosmos DB does these backups in the following way:

- A full backup is taken every 4 hours. Only the last two backups are stored by default. Both the backup interval and the retention period can be configured in the Azure portal. This configuration can be set during or after the Azure Cosmos DB account has been created. 
- If Azure Cosmos DB's containers or database are deleted, the existing container and database snapshots will be retained for 30 days.
- Azure Cosmos DB backups are stored in Azure Blob storage.
- Backups are stored in the current write region or if using multi-region writes to one of the write regions to guarantee low latency.
- Snapshots of the backup are replicated to another region through geo-redundant storage (GRS). This replication provides resiliency against regional disasters.
- Backups can't be accessed directly. To restore the backup, a support ticket needs to be opened with the Azure Cosmos DB team.
- Backups won't affect performance or availability. Furthermore, no RUs are consumed during the backup process.

## Backup Storage Redundancy

Azure Cosmos DB backups use by default geo-redundant blob storage that is replicated to a paired region. This backup storage redundancy can be modified either during or after the creation of the account. The redundancy options available to periodic backup mode are:

- Geo-redundant backup storage: The default value. Copies the backup asynchronously across the paired region.
- Zone-redundant backup storage: Copies the backup synchronously across three Azure availability zones in the primary region.
- Locally redundant backup storage: Copies the backup synchronously three times within a single physical location in the primary region.

## Change the default backup interval and retention period

By default, Azure Cosmos DB takes backups every 4 hours and keeps the last two backups at no extra cost. These settings are set at the Azure Cosmos DB account level and can be configured during or after the account creation. Currently these settings can only be changed from the Azure portal.

### Change backup options for a new account

1. When creating a new Azure Cosmos DB account, select **Periodic** under the **Backup policy** tab. 

1. Change the backup options as needed.

    - Backup Interval - This setting defines how often is the backup going to be done. Can be changed in minutes or hours. The interval period can be between 1 and 24 hours. The default is **240 minutes**.
    - Backup Retention - This setting defines how long should the backups be kept. Can be changed in hours or days. The retention period will be at least two times the backup interval and 720 hours (or 30 days) at the most. The default is **8 Hours**. 
    - Backup storage redundancy - One of the three redundancy options discussed in the previous section. The default is **Geo-redundant backup storage**.

### Change backup options for an existing account

1. On the Azure portal, navigate to the Azure Cosmos DB account.

1. Under the *Settings* section, select **Backup & Restore**.

1. Change the backup options as needed.

    - Backup Interval - This setting defines how often is the backup going to be done. Can be changed in minutes or hours. The interval period can be between 1 and 24 hours. The default is **240 minutes**.
    - Backup Retention - This setting defines how long should the backups be kept. Can be changed in hours or days. The retention period will be at least two times the backup interval and 720 hours (or 30 days) at the most. The default is **8 Hours**. 
    - Backup storage redundancy - One of the three redundancy options discussed in the previous section. The default is **Geo-redundant backup storage**.  

        > [!NOTE] 
        > You must have Azure Cosmos DB owner, contributor, or have the Cosmos DB Operator (`CosmosdbBackupOperator`) role assigned to configure the backup retention period or backup storage redundancy settings.

## Request to restore a backup

If you need to restore a database or container, you'll need to open a request ticket or call the Azure support team. Azure support is available for all plans except for the **Basic** plan. You must have Azure Cosmos DB owner, contributor, or have the Cosmos DB Operator (`CosmosdbBackupOperator`) role assigned to request a restore from the portal.

## Considerations for restoring a backup

Scenarios to consider:

- Delete the entire Azure Cosmos DB account.
- Delete one or more Azure Cosmos DB databases.
- Delete one or more Azure Cosmos DB containers.
- Delete or modify the Azure Cosmos DB items within a container. This specific case is typically referred to as data corruption.

A new Azure Cosmos DB account is created to hold the data every time you restore a backup. Data *can't* be restored to an existing Azure DB account. The account created will have the *\<Azure_Cosmos_account_original_name\>-restored#* name format, where # is an incremental digit when you're doing multiple restores against the same account.

If you delete the Azure Cosmos DB *account*, and wish to recover it with the same name, don't recreate it. Just ask the Azure support team to recreate it with the original name. The restored account will have the same provisioned throughput, indexing policies, and will be in the same region as the original account.

If you delete an Azure Cosmos DB database, you can ask to restore the whole database, or just those containers inside the databases you wish to restore.

If you delete or modify items in a container, and wish to restore that data before the delete or the data modification, you should specify the time to restore to. If your retention period is set to anything less that seven days, it's a good practice to temporarily increase your retention period to at least seven days to make sure your backups aren't overwritten while you open the support ticket. 


Settings that are not restored to the new account:
- VNET access control lists
- Stored procedures, triggers, and user-defined functions
- Multi-region settings


## Costs of Extra backups

Azure Cosmos DB includes the option for the retention of two backups for free. Extra backups will be charged using region-based backup-storing pricing. So for example, if you have a backup interval of 3 hours and you chose a retention period of two days (48 hours), and since two backups are free, you'll pay for (48/3-2) *region-based backup-storing price* backup size.

## Manage your own backups

While you can call Azure support to restore your backups, there are a couple of other approaches you can do to manage your own backups. Those options are:

- Use Azure Data Factory to periodically copy your data to a storage location.
- Use the *Azure Cosmos DB change feed* to get the incremental changes and copy those changes to a storage location.

## I restored a copy of my data, now what?

The first step will be to make sure the data wanted was restored from the backup. Once you confirm you have the data, migrate that data back to the original account.

You could migrate the data to the original account the following ways:

- Use Azure Data Factory.
- Use the Azure Cosmos DB data migration tool.
- Use the Azure Cosmos DB change feed.
- Write your own data migration app in your preferred programming language.

> [!NOTE]
> Don't forget to delete the Azure Cosmos DB account your data was restored to, once you migrate the data back to your production account. If you don't delete the account, you'll incur extra costs. 