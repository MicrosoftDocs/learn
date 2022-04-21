While many organizations initially migrate to Azure using IaaS offerings, the platform as a service (PaaS) service offering allows for extra benefits. Also, you no longer have to install or patch SQL Server as that is performed by the service. Consistency checking, and backups are also part of the managed service, including security and performance tools that are part of the PaaS offerings.

Azure SQL Managed Instance is a fully functional SQL Server instance that is almost 100% compatible with your on-premises ecosystem. It includes features like SQL Agent, access to tempdb, cross-database query and common language runtime (CLR). The service uses the same infrastructure as Azure SQL Database and all the benefits of the PaaS service such as automatic backups, automatic patching, and built-in high availability.

### Azure SQL Managed Instance features

Azure SQL Managed Instance allows for easy migration paths for existing applications by allowing restores from on-premises backups. Unlike Azure SQL Database, which is designed around single database structures, SQL Managed Instance provides an entire SQL Server instance, allowing up to 100 databases, and providing access to the system databases. SQL Managed Instance provides other features that aren't available in Azure SQL Database, including cross-database queries, common language runtime (CLR) and along with the msdb system database, it allows the use of SQL Agent.

### Options

There are two service tiers available when creating an Azure SQL Managed Instance, and they're the same as Azure SQL Database vCore model (managed instance is purchased using the vCore model), Business Critical and General Purpose. There are minimal functionality differences between the two tiers—the main two are that Business Critical includes In-Memory OLTP and offers a readable secondary, neither of which is available with the General Purpose tier. Both tiers offer the same levels of availability and allow for independent configuration of storage and compute.

### Link feature (preview)

Link feature provides hybrid capability of replicating databases from SQL Server instances to Azure SQL Managed Instance. The link feature replicates data using distributed availability groups available on Always On availability group technology. Transaction log records are replicated as part of distributed availability groups.

The transaction log records on the primary instance can't be truncated until they've been replicated to the secondary instance. Regularly transaction log backups reduce the risk of running out of space on your primary instance.

Link feature can also be used as a hybrid disaster recover solution, where you can fail over your SQL Server databases hosted anywhere to a database running on SQL Managed Instance. Likewise, you can use link feature to provide a read-only secondary database in SQL Database SQL Managed Instance to offload intensive read-only operations.

For more information about how to configure link feature for Azure SQL Managed Instance, see [Prepare environment for link feature - Azure SQL Managed Instance](/azure/azure-sql/managed-instance/managed-instance-link-preparation).

### Instance pool (preview)

Instance pool provides a cost-efficient way to migrate smaller SQL Server instances to the cloud. When migrating to Azure, instead of consolidating smaller databases into larger managed instance, which requires extra governance and security planning, instance pools allow you to pre-provision your resources based on your total migration resources and requirements.

The instance pool feature provides a fast deployment time of up to five minutes, which is a good option for scenarios where deployment duration is important. Also, all instances in a pool share the same virtual machine, and the total IP allocation is independent of the number of instances deployed.

To learn how to deploy an instance pool for SQL Managed Instance, see [Deploy Azure SQL Managed Instance to an instance pool ](/azure/azure-sql/managed-instance/instance-pools-configure).

### High availability

Because Azure SQL Managed Instance is backed by the PaaS Service, it has high availability baked into the product. A standalone SQL Managed Instance offers a 99.99% Service Level Agreement (SLA) which guarantees at most 52.60 minutes of downtime per year. The architecture is the same as Azure SQL Database with General Purpose, which uses storage replication for availability, and Business critical using multiple replicas.

### Backups

Automatic backups are also automatically configured for Azure SQL Managed Instance. One key difference between Azure SQL Managed Instance and Azure SQL Database is that with MI you can manually make a copy-only backup of a database. You must back up to a URL, as access to the local storage isn't permissible. You can also configure long-term retention (LTR) for retaining automatic backups for up to 10 years in geo-redundant Azure blob storage.

Database backups occur on the same schedule as with Azure SQL Database. These schedules aren't adjustable.

- **Full –** Once a week
- **Differential –** Every 12 hours
- **Transaction Log –** Every 5-10 minutes depending on transaction log usage

Restoring a database to an Azure SQL Managed Instance is also similar to the process with Azure SQL Database. You can use:

- Azure portal
- PowerShell
- Azure CLI

However, there are some limitations when restoring. In order to restore from one instance to another, both instances must reside within the same Azure subscription and the same Azure region. You also can't restore the entire managed instance, only individual databases within the SQL Managed Instance itself.

As with Azure SQL Database, you can't restore over an existing database. You need to drop or rename the existing database prior to restoring it from backup. Since SQL Managed Instance is a fully functional SQL Server instance, you can execute a RESTORE command whereas with Azure SQL Database that isn't possible. However, since it's a PaaS service, there are some limitations, such as:

- You must restore from a URL endpoint. You don't have access to local drives.
- You can use the following options (in addition to specifying the database):
    - FILELISTONLY
    - HEADERONLY
    - LABELONLY
    - VERIFYONLY
- Backup files containing multiple log files can't be restored
- Backup files containing multiple backup sets can't be restored
- Backups containing In-Memory/FILESTREAM can't be restored

By default, the databases in a managed instance are encrypted using Transparent Data Encryption (TDE) with a Microsoft managed key. In order to take a user-initiated copy only backup, you must turn off TDE for the specific database. If a database is encrypted, you can restore it, however, you'll need to ensure that you have access to either the certificate or asymmetric key that was used to encrypt the database. If you don't have either of those two items, you won't be able to restore the database to a SQL Managed Instance.

### Disaster recovery

Azure SQL Managed Instance offers auto-failover groups as a means to implement disaster recovery. This feature protects the entire managed instance and all of the databases contained within it, not just specific databases. This process asynchronously replicates data from the Azure SQL Managed Instance to a secondary; however, it's currently limited to the paired Azure region of the primary copy, and only one replica is allowed.

Much like Azure SQL Database, auto-failover groups offer read-write and read-only listener endpoints, which facilitate easy connection string management. If there is a failover, application connection strings will automatically be routed to the appropriate instance. While fairly consistent with Azure SQL Database, these endpoints follow a slightly different format, `<fog-name>.zone_id.database.windows.net whereas Azure SQL Database is in the <fog-name>.secondary.database.windows.net` format.

Each managed instance, primary and secondary, must be within the same DNS zone. This placement will ensure that the same multi-domain certificate can be used for client connection authentication between either of the two instances in the same failover group. You can specify a “DNS Zone Partner” through various methods such as the Azure portal, PowerShell, or Azure CLI.

To learn the new features for Azure SQL Managed Instance, see [What's new in Azure SQL Managed Instance?](/azure/azure-sql/managed-instance/doc-changes-updates-release-notes-whats-new).
