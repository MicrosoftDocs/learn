While many organizations initially migrate to Azure using IaaS offerings, the platform as a service (PaaS) provides extra benefits. With PaaS, the service handles installing and patching SQL Server, so you no longer need to perform these tasks. Consistency checks, backups, security, and performance tools are also included as part of the managed service.

[Azure SQL Managed Instance](/azure/azure-sql/managed-instance/sql-managed-instance-paas-overview) is a fully functional SQL Server instance that is nearly 100% compatible with your on-premises ecosystem. It includes features like SQL Agent, access to tempdb, cross-database queries, and common language runtime (CLR). This service uses the same infrastructure as Azure SQL Database and offers all the benefits of PaaS, such as automatic backups, automatic patching, and built-in high availability.

### Azure SQL Managed Instance capabilities

Azure SQL Managed Instance offers a seamless migration path for existing applications by enabling restores from on-premises backups. Unlike Azure SQL Database, which is designed for single database structures, SQL Managed Instance provides a full SQL Server instance, supporting up to 100 databases and granting access to system databases. It also includes features not available in Azure SQL Database, such as cross-database queries, common language runtime (CLR), and the use of SQL Agent through the msdb system database.

When creating an Azure SQL Managed Instance, you can choose between two service tiers: Business Critical and General Purpose. These tiers align with the Azure SQL Database vCore model, as SQL Managed Instances are purchased using this model. The primary differences between the two tiers are that Business Critical includes In-Memory OLTP and provides a readable secondary, features not available in the General Purpose tier. Both tiers offer high availability, with the Business Critical tier using Always On Availability Groups for higher resilience. Additionally, both tiers allow for independent configuration of storage and compute resources.

### Managed Instance link

The Link feature provides hybrid capabilities by replicating databases from SQL Server instances to Azure SQL Managed Instance. It uses distributed availability groups, part of the Always On availability group technology, to replicate data. Transaction log records are replicated as part of these distributed availability groups.

Transaction log records on the primary instance can't be truncated until they're replicated to the secondary instance. Regular transaction log backups help reduce the risk of running out of space on your primary instance.

The Link feature can also be used as a hybrid disaster recovery solution, allowing you to fail over your SQL Server databases hosted anywhere to a database running on SQL Managed Instance. Additionally, you can use the Link feature to provide a read-only secondary database in SQL Managed Instance, offloading intensive read-only operations.

For more information about how to configure link feature for Azure SQL Managed Instance, see [Prepare environment for link feature - Azure SQL Managed Instance](/azure/azure-sql/managed-instance/managed-instance-link-preparation).

### Instance pool

Instance pools provide a cost-efficient way to migrate smaller SQL Server instances to the cloud. Instead of consolidating smaller databases into a larger managed instance, which requires extra governance and security planning, instance pools allow you to pre-provision resources based on your total migration needs and requirements.

The instance pool feature offers a fast deployment time of up to 10 minutes, making it ideal for scenarios where deployment duration is crucial. Additionally, all instances in a pool share the same virtual machine, and the total IP allocation is independent of the number of instances deployed.

To learn how to deploy an instance pool for SQL Managed Instance, see [Deploy Azure SQL Managed Instance to an instance pool ](/azure/azure-sql/managed-instance/instance-pools-configure).

### High availability and Disaster recovery

Azure SQL Managed Instance, as a PaaS service, inherently provides high availability. A standalone SQL Managed Instance offers a 99.99% Service Level Agreement (SLA), ensuring a maximum of 52.60 minutes of downtime per year. The architecture mirrors that of Azure SQL Database: the General Purpose tier uses storage replication for availability, while the Business Critical tier employs multiple replicas for enhanced resilience.

Azure SQL Managed Instance offers auto-failover groups for disaster recovery, protecting the entire managed instance and all its databases. This feature asynchronously replicates data from the primary Azure SQL Managed Instance to a secondary instance, but it's currently limited to the paired Azure region of the primary instance, with only one replica allowed.

Similar to Azure SQL Database, auto-failover groups provide read-write and read-only listener endpoints, simplifying connection string management. If there's a failover, the application connection strings are automatically routed to the appropriate instance. However, these endpoints follow a slightly different format: `<fog-name>.zone_id.database.windows.net` for SQL Managed Instance, compared to `<fog-name>.zone_id.database.windows.net whereas Azure SQL Database is in the <fog-name>.secondary.database.windows.net` for Azure SQL Database.

Both the primary and secondary managed instances must be within the same DNS zone. This ensures that the same multi-domain certificate can be used for client connection authentication between the instances in the failover group. You can specify a “DNS Zone Partner” through the Azure portal, PowerShell, or Azure CLI.

### Backups

Automatic backups are configured by default for Azure SQL Managed Instance. A key difference between Azure SQL Managed Instance and Azure SQL Database is that with SQL Managed Instance, you can manually create a copy-only backup of a database. These backups must be stored to a URL, as local storage access isn't permitted. Additionally, you can configure long-term retention (LTR) to retain automatic backups for up to 10 years in geo-redundant Azure Blob storage.

Database backups follow the same schedule as Azure SQL Database, and these schedules can't be adjusted.

- **Full –** Once a week
- **Differential –** Every 12 hours
- **Transaction Log –** Every 5-10 minutes depending on transaction log usage

Restoring a database to an Azure SQL Managed Instance is similar to the process with Azure SQL Database. You can use Azure portal, PowerShell, or Azure CLI. To restore from one instance to another, both instances must reside within the same Azure subscription and region. Additionally, you can't restore the entire managed instance, only individual databases within the SQL Managed Instance.

As with Azure SQL Database, you can't restore over an existing database. You need to drop or rename the existing database before restoring it from backup. Since SQL Managed Instance is a fully functional SQL Server instance, you can execute a `RESTORE` command, which isn't possible with Azure SQL Database. However, as a PaaS service, there are some limitations:

- You must restore from a URL endpoint, as local drives aren't accessible.
- You can use the following options (in addition to specifying the database):
    - FILELISTONLY
    - HEADERONLY
    - LABELONLY
    - VERIFYONLY
- Backup files containing multiple log files can't be restored
- Backup files containing multiple backup sets can't be restored
- Backups containing In-Memory/FILESTREAM can't be restored

By default, databases in a managed instance are encrypted using [Transparent Data Encryption (TDE)](/sql/relational-databases/security/encryption/transparent-data-encryption) with a Microsoft-managed key. To take a user-initiated copy-only backup, you must disable TDE for the specific database. If a database is encrypted, you can restore it, but you need access to either the certificate or asymmetric key used for encryption. Without these, you can't restore the database to a SQL Managed Instance.

To learn the new features for Azure SQL Managed Instance, see [What's new in Azure SQL Managed Instance?](/azure/azure-sql/managed-instance/doc-changes-updates-release-notes-whats-new).
