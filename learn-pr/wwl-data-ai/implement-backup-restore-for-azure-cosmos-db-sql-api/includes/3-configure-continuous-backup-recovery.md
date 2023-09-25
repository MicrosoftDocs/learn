When using the *continuous backups* mode, backups are continuously taken in every region where the Azure Cosmos DB account exists. 

The retention period for the backups is either 30 day or if the Azure Cosmos DB account was created before 30 days, up to the resource creation time. The restore can be done for any point in time within the retention period. If the Azure Cosmos DB account is using the **strong consistency level**, the backups taken in the *write region* could be more up to date then the backups taken in the read regions.

## Backup storage redundancy

By default, locally redundant storage accounts are used to store the backups in each region. When Availability zones are enabled for a region, the backups are then stored in a Zone-Redundant storage account. This storage redundancy cannot be updated when using the continuous backup mode.

### Change backup options for a new account

- When creating a new Azure Cosmos DB account, select **Continuous** under the **Backup policy** tab. 

### Change backup options for an existing account

1. In the Azure Cosmos DB account page, under the *Settings* section, choose **Backup & Restore**. 

2. If your account is still in *periodic backup mode*, the following message will appear at top, *Your account is on periodic backup mode. You can now change to continuous mode for a better backup and restore experience. Change to continuous mode*.

3. Select **Change to continuous mode** on the message.

4. Select **Continuous (7 days)** or **Continuous (30 days)** and select **Save** to enable *continuous backup mode*. Do remember that selecting *Continuous (30 days)* will incur additional cost, while selecting *Continuous (7 days)* is free.

## What is and is not restored?

You can choose to restore any combination of Azure Cosmos DB containers, databases, or an entire account. This action will restore all selected data and its indexes to a new Azure Cosmos DB account. The data containers, databases, or account restored is guaranteed to be consistent up to the restore time specified.

Settings that are not restored to the new account:
- Firewall, VNET, private endpoint settings.
- Consistency settings. By default, the account is restored with session consistency.
- Regions.
- Stored procedures, triggers, UDFs.

## Permissions

The owner of an Azure Cosmos DB account can either start the restore, or grant restore rights to roles or  principals.

## Continuous backup mode charges

Backup storage space and restore cost will be added for Azure Cosmos DB accounts that have continuous backup enabled. A separate charge will be added every time a restore is started.

## Limitations when using the continuous backup mode

- Azure Cosmos DB accounts using customer-managed keys are not supported.
- Multi-region write accounts not supported.
- You can't restore an account into a region where the source account did not exist.
- The retention period is 30 days and can't be changed.
- Can't modify or delete IAM policies when restore is in progress.
- Accounts that create unique indexes after the container is created are not supported.
- Point in time restore always restores to a new Azure Cosmos DB account.
- Collection's consistent indexes may still be rebuilding after completing the restore.
- Since TTL container properties are restored with the restore process, restores must be for timestamps before TTL properties were added to a container.  This timestamp will prevent data from being deleted right after the restore.
- Azure Synapse Link and continuous backup mode can't coexist in the same database account. 
