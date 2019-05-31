By default, SQL Database backups are stored in geo-replicated blob storage (RA-GRS). The following options are available for database recovery using automated database backups:

- Create a new database on the same SQL Database server recovered to a specified point in time within the retention period.
- Create a database on the same SQL Database server recovered to the deletion time for a deleted database.
- Create a new database on any SQL Database server in the same region recovered to the point of the most recent backups.
- Create a new database on any SQL Database server in any other region recovered to the point of the most recent replicated backups.

Restoring an Azure SQL Database takes a few clicks through the Azure Portal to restore it to a desired point in time. Just keep in mind that those backups are retained for either 7 or 35 days, depending on your service-tier.

## Point-in-time restore

You can restore a standalone, pooled, or instance database to an earlier point in time using the Azure portal, PowerShell or the REST API

You generally restore a database to an earlier point for recovery purposes. You can treat the restored database as a replacement for the original database or use it as a source data to update the original database.

To recover a single, pooled, or instance database to a point in time using the Azure portal, open the page for your database and click **Restore** on the toolbar.

## Deleted database restore

You can restore a deleted database to the deletion time or an earlier point in time on the same SQL Database server using the Azure portal, PowerShell, or the REST (createMode=Restore). You can restore deleted database on Managed Instance using PowerShell.

### Deleted database restore using the Azure portal

To recover a deleted database using the Azure portal, open the page for your server and in the Operations area, click **Deleted databases**. Select the database from the list of deleted databases and you will have the option to set the **Database name**, **Target server** and **Restore point**

## Geo-restore

You can restore a SQL database on any server in any Azure region from the most recent geo-replicated backups. Geo-restore uses a geo-replicated backup as its source. It can be requested even if the database or data center is inaccessible due to an outage.

Geo-restore is the default recovery option when your database is unavailable because of an incident in the hosting region. You can restore the database to a server in any other region. There is a delay between when a backup is taken and when it is geo-replicated to an Azure blob in a different region. As a result, the restored database can be up to one hour behind the original database. The following illustration shows restore of the database from the last available backup in another region.

   > [!NOTE]
   > Geo-restore using the Azure portal is not available in Managed Instance. Please use PowerShell instead
