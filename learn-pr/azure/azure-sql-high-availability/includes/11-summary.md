In this module and throughout the activities, you got to get hands-on with many availability-related features that are available for Azure SQL. In the next module in the Azure SQL fundamentals learning path, you'll take a look at one of two scenarios that challenge you to create a solution leveraging Azure SQL.  

## Learn more

You can leverage the following resources to dive deeper into topics covered in this module.

### Video series: Azure SQL for beginners

People learn in different ways. With that in mind, a video series related to this learning path was created with Channel 9 on YouTube. [You can access all 60+ videos here](https://aka.ms/azuresql4beginnersyt).

### Backup/Restore

In the documentation, you can learn more about how [restoring to a point in time](https://docs.microsoft.com/sql/relational-databases/backup-restore/restore-a-sql-server-database-to-a-point-in-time-full-recovery-model?view=sql-server-ver15?azure-portal=true) and [restoring a deleted database](https://docs.microsoft.com/azure/sql-database/sql-database-recovery-using-backups#deleted-database-restore?azure-portal=true) work.

In the PITR exercise, you leverage the Azure CLI to perform a restore for Azure SQL Database. In Azure SQL Managed Instance, it is a very similar process, but slightly different commands. You can review them in the [documentation](https://docs.microsoft.com/cli/azure/sql/midb?view=azure-cli-latest#az-sql-midb-restore?azure-portal=true).  

### Kusto query language (KQL) and Az PowerShell

KQL is used for many logging activities within Azure. To learn more about the language via the KQL documentation, [refer here](https://docs.microsoft.com/azure/kusto/query/?azure-portal=true).

PowerShell has also been leveraged to see a few examples of availability in action. To learn more about various PowerShell commands used and available for Azure SQL, [refer here](https://docs.microsoft.com/azure/sql-database/sql-database-powershell-samples?tabs=single-database&azure-portal=true).  

### High availability

You can read more about [business continuity](https://docs.microsoft.com/azure/sql-database/sql-database-business-continuity?azure-portal=true) and [high availability](https://docs.microsoft.com/azure/sql-database/sql-database-high-availability?azure-portal=true) in Azure SQL in the documentation.

In the Business critical tier, you can opt-in (for no additional fee) for a [zone redundant configuration](https://docs.microsoft.com/azure/sql-database/sql-database-high-availability#zone-redundant-configuration?azure-portal=true) if your [region supports that](https://docs.microsoft.com/azure/availability-zones/az-overview#services-support-by-region?azure-portal=true). The links will guide you to more information.

### Availability and consistency

If you're interested in diving deeper into how Azure manages data integrity, there is an in-depth [blog post here](https://azure.microsoft.com/blog/data-integrity-in-azure-sql-database/?azure-portal=true). Additionally, if you want to learn more about Accelerated Database Recovery, the [documentation](https://docs.microsoft.com/azure/azure-sql/accelerated-database-recovery?azure-portal=true) has great detail and references to other resources like white papers.

### Designing cloud solutions for disaster recovery

You can learn more about what is needed to [design globally available services using Azure SQL Database here](https://docs.microsoft.com/azure/sql-database/sql-database-designing-cloud-solutions-for-disaster-recovery?azure-portal=true). In addition, Microsoft provides [Outage Recovery Guidance](https://docs.microsoft.com/azure/sql-database/sql-database-disaster-recovery?azure-portal=true), and encourages and guides you to complete [disaster recovery drills](https://docs.microsoft.com/azure/sql-database/sql-database-disaster-recovery-drills?azure-portal=true).

The exercise you completed for implementing a geo-distributed application is based off of a [tutorial in the documentation](https://docs.microsoft.com/azure/sql-database/sql-database-implement-geo-distributed-database?tabs=azure-powershell&azure-portal=true) that also has information about using the Azure portal and the Azure CLI.
