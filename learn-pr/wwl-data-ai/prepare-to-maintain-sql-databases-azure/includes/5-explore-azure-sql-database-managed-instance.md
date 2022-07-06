Most of the features available on Azure SQL Database will also work for Azure SQL Managed Instance as they share the same base code. The fully managed platform as a service (PaaS) provides some of the following benefits:

- Automatic backups
- Automatic patching
- Built-in high availability
- Security and performance tools
- Embedded auditing capabilities

Another key benefit when migrating to one of the PaaS offerings on Azure is that you no longer have to install or patch SQL Server, which can increase application uptime, and reduce maintenance efforts.

Unlike Azure SQL Database, which is designed around single database structures, SQL Managed Instance provides several other features including cross-database queries, common language runtime (CLR), access to the system databases, and use of the SQL Agent features.

For a complete list of the features available on Azure SQL Managed Instance, see [Features of SQL Database and SQL Managed Instance](/azure/azure-sql/database/features-comparison).

## Hybrid licensing options

Microsoft offers several benefits to SQL Server licenses. For both SQL Database and SQL Managed Instance, taking advantage of your existing licenses can reduce the cost of running the PaaS offering.

- For each core of Enterprise Edition with Active Software Assurance, you're eligible for one vCore of SQL Database or SQL Managed Instance Business Critical, and eight vCores of General Purpose.

- For each core of Standard Edition with Active Software Assurance, you're eligible for one vCore of General Purpose.

This model can reduce the total license costs by up to 40%. Effectively, you'll only be paying for the compute and storage costs, and not the software licensing costs.

For more information on bring-your-own licensing model, see [License Mobility through Software Assurance on Azure](https://azure.microsoft.com/pricing/license-mobility/).

## Connectivity architecture

Connections to SQL Managed Instance are made through TDS endpoints. While the routing and security on these connections differ, there's a gateway component that handles and routes connections to the database service. This gateway component is also deployed in a highly available fashion.

## Backup and restore

Automated database backup provides a fully managed backup service that takes full, differential, and log backups regularly for both SQL Managed Instance and SQL Database offerings. Automated backups are geo-redundant, and replicated to a paired-region automatically, which protects your data against localized outages in the primary region.

Similarly, SQL Managed Instance allows easy migration of existing applications, enabling restores from on-premises backups.

There are some important considerations when running backup and restore operations on SQL Managed Instance databases:

- It isn't possible to overwrite an existing database during the restore process. Before restoring a database, you must ensure that it doesn't exist.

- For SQL Managed Instance, backups can only be restored to another managed instance. It isn't possible to restore a managed instance database backup to a SQL Server running on a virtual machine or SQL Database.

- Copy-only backup to Azure blob storage is available for SQL Managed Instance. SQL Database doesn't support this feature.

For more information about automated backups, see [Automated backups - Azure SQL Database & Azure SQL Managed Instance](/azure/azure-sql/database/automated-backups-overview).

## High availability architecture

SQL Database and SQL Managed Instance have similar high availability architectures, which guarantee 99.99% uptime. Windows and SQL Server updates are handled by the backend infrastructure, generally without any effect to your application, though it's important to place a [retry logic](/azure/azure-sql/database/troubleshoot-common-connectivity-issues) into your application.

The auto-failover groups feature allows you to fail over a group of replicated databases on a server to another region. This feature is designed on top of the existing active geo-replication capability, which simplifies deployment and management of geo-replicated databases.

A failover group can include one or multiple databases, often used by the same application. Additionally, you can use the readable secondary databases to offload read-only query workloads.

> [!NOTE]
> The auto-failover groups feature is supported on both SQL Managed Instance and SQL Database.

For more information about auto-failover groups, see [Use auto-failover groups to enable transparent and coordinated geo-failover of multiple databases](/azure/azure-sql/database/auto-failover-group-overview).

## Migration options

In general, migrating to SQL Managed Instance is often simple given the large set of available features. There are a couple of ways to migrate on-premises databases:

- Restoring a backup
- Using Database Migration Service (DMS)

Backup and restore will incur more downtime, as it isn't possible to restore with **NORECOVERY** option, and apply log backups.

The Database Migration Service is a managed service that connects your on-premises (or Azure Virtual Machines) SQL Server to SQL Managed Instance with near zero downtime. As a result, it acts like an automated log shipping process, meaning you can keep your target databases in sync right up to the point of cutover.

## Machine Learning Services

Machine Learning Services provides machine learning operations within your relational database structure. This feature supports Python and R packages, ideal for high-intensive predictive capabilities. This option is available on SQL Managed Instance, SQL Server on Azure virtual machine, and on-premises SQL Server.

Applications can use relational database on Azure combined with machine learning high-performance capabilities, where you can:

- Train machine learning models based on either sampled dataset or population dataset.

- Reduce complexity in security and compliance, where you don't need to relocate your data to build and train your machine learning models.

- Deploy machine learning models using T-SQL stored procedures that support Python or R programming language.

- Use of open-source libraries like scikit-learn, PyTorch, and TensorFlow.

For busy environments, you can use the [T-SQL PREDICT function](/sql/t-sql/queries/predict-transact-sql), which allows you to accelerate predictions based on your stored model.

The Machine Learning Services feature can be enabled by running the following command:

```sql
EXEC sp_configure 'external scripts enabled', 1;
RECONFIGURE WITH OVERRIDE;
```

The command above allows the execution of external scripts in your managed instance, and it should be enabled before you attempt to use **sp_execute_external_script** to execute Python or R scripts in your database.

> [!NOTE]
> SQL Database doesn't support Machine Learning Services feature.

For more information about Machine Learning Services, see [Machine Learning Services in Azure SQL Managed Instance](/azure/azure-sql/managed-instance/machine-learning-services-overview).
