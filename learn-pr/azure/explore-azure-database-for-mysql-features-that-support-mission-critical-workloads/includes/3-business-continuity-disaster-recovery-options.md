Azure Database for MySQL - Flexible Server provides business continuity features to protect your database in case of planned or unplanned outages. To address different types of outages, you can apply varying levels of fault protection with different recovery times or risk of data loss.
## Downtime examples

A few example scenarios for both planned and unplanned downtime follow.

### Planned downtime scenarios

The two most common planned downtime scenarios are compute scaling initiated by the user, and scheduled maintenance performed by Azure.

When you perform a compute scaling operation, Azure provisions a new MySQL flexible server with the requested compute configuration. The existing server allows active checkpoints to complete, drains existing connections, cancels uncommitted transactions, and then the existing server shuts down. At this point, Azure attaches the existing server's storage to the new server and starts the database. The database then performs any recovery necessary before continuing to accept client connections.

New features and bug fixes happen automatically as part of service planned maintenance. Minor version upgrade patches are also applied during planned maintenance, incurring a few seconds of downtime. You can schedule those activities as described in the following section, "Scheduled downtime and maintenance windows."

### Unplanned downtime

The database can go down unexpectedly for several reasons, such as:

- Database hardware failure.

- Storage drive failure.

- Application or user errors (e.g. accidentally dropping tables).

- Availability zone & region failures.

If high availability (HA) is not enabled, then Azure attempts recovery such as copying lost data, restarting the server, or even starting the server on another physical node. Enabling HA can reduce or even eliminate these kinds of downtime, as discussed in the following section.

## High availability

Azure Database for MySQL – Flexible Server provides HA with automatic failover, which provides a solution that is designed never to lose committed data and to prevent the database from being a single point of failure. When you have configured HA, the MySQL flexible server automatically provisions and manages a standby replica.

There are two kinds of high availability with different fault tolerance and latency tradeoffs: zone-redundant and same-zone.

### Zone-redundant HA

Zone redundant HA provides redundancy across multiple availability zones, offering the highest level of availability with the ability to recover even if an entire zone goes down. Using a zone-redundant HA configuration introduces additional latency, so be sure to determine if this is acceptable for your application. In addition, using a zone redundant HA configuration also requires that database client applications be zone redundant to ensure that overall operations continue.

### Same-zone HA

In a same-zone HA configuration, the primary and standby servers reside in the same availability zone, which minimizes latency. While low latency might be required in some use cases, with a same-zone HA configuration, if the availability zone goes down, the resulting downtime will be longer as the MySQL flexible server recovers.

Unlike zone-redundant HA, same-zone HA is available in all regions that support Azure Database for MySQL - Flexible Server.

## Backup and restore

Server backups are a crucial component of any business continuity strategy. Azure Database for MySQL - Flexible Server automatically creates backups stored securely in local-redundant storage within the region hosting the database. You can use these backups to restore the database to a specific point in time, in the event of failure or data corruption (e.g. an application bug or development error).

There are two types of backups. With **automated** backups, the MySQL flexible server takes snapshots of database data files as well as the associated transaction logs. Automated snapshot backups occur once a day and transaction log backups occur every five minutes. If a backup fails, the server retries every 20 minutes until the backup succeeds.

With **on-demand** backups, you can create a database backup at any time. With both types of backups, backup files are retained for seven days by default. However, based on your business needs, you can configure the value of retention period from one to 35 days.

You can retain backups for up to 10 years using the long-term retention feature, currently in public preview. The long-term backup solution might be used separately from or in addition to the automated Azure Database for MySQL backups. Long-term backups can be taken on a customer-controlled schedule or on-demand. Backups are stored in Azure Backup managed storage accounts, in separate security and fault domains.

In addition to backing up the database, you can **export backup** files to Azure blob storage, which you can then use for migrations, data recovery, or archival. On-demand exports are currently in public preview and available only in public cloud regions.

To store the backup files, you can select from several storage options:

- With **locally redundant** storage (same datacenter, same zone), backup files are stored in the same datacenter as the database. This option provides eleven 9s (99.999999999%) of durability for backup objects over a year. By default, servers without HA or with same-zone HA use locally redundant storage.

- With **zone-redundant backup** storage (different zone, same region), backup files are stored in the server's availability zone and replicated to another availability zone in the same region. This option provides twelve 9s (99.9999999999%) of durability over a given year. Zone-redundant storage is important for zone-redundant HA and is required if data must remain within a single region.

- With **geo-redundant backup** storage (different regions), backup files are stored in the server's region and then replicated to another geo-paired region. This option provides sixteen 9s (99.99999999999999%) of durability over a given year. Geo-redundant storage is only supported in [Azure paired regions](https://github.com/solliancenet/microsoft-learning-path-work-with-azure-database-for-mysql/blob/main/azure/mysql/flexible-server/overview#azure-regions).

**Note**: With Azure Database for MySQL - Flexible Server, backup space up to 100% of provisioned storage space is available at no additional charge. Additional storage is charged in GB per month. For more information, see the pricing documentation.

After you have a backup, you can restore the backup to a new MySQL flexible server. You can select the backup three ways: manually select a full backup, automatically select the latest restore point, or automatically select the fastest restore point. If you have geo-redundant backups, you can also restore to the paired region (the cross region).

## Scheduled downtime and maintenance windows

Periodic maintenance is required to keep the managed server stable, secure, and up to date. During maintenance windows, the service receives deployments of new features, updates, and patches. Normally, maintenance windows are scheduled to occur at least every 30 days, but critical security patches are at times applied within seven days or less.

You can choose a system-managed schedule or define a custom schedule for each MySQL flexible server in your Azure subscription.

You can receive scheduled maintenance notifications in one of several ways. Notifications might be:

- Emailed to a specific address or Azure Resource Manager role.

- Sent via text message (SMS).

- Pushed as an Azure app notification.

- Delivered via voice message.

### Custom maintenance windows

By default, with a system-managed schedule, the system picks a one-hour window between 11pm and 7am in the MySQL flexible server region's time zone. With a custom schedule, you can specify your maintenance window for the server by choosing the day of the week and a one-hour time.

### Near-zero downtime maintenance for HA servers (public preview)

HA-enabled servers benefit from Near Zero Downtime Maintenance, a new feature which substantially reduces maintenance downtime. The expected downtime is between 40 to 60 seconds. Near-zero downtime maintenance is crucial for applications with very high availability requirements, requiring minimal interruptions to database connectivity.

### Reschedule maintenance (public preview)

You can reschedule maintenance when using the General Purpose or Business Critical service tiers. In the maintenance section of the Azure portal, you can reschedule the next scheduled maintenance to another date and time. You can also initiate maintenance on demand by selecting **Reschedule to Now**.

> [!NOTE]  
>  
> You can't reschedule a maintenance period if there are 15 or fewer minutes before the scheduled maintenance begins.
