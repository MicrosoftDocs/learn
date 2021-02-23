In this module and throughout the exercises, you gained some experience with many availability-related features that are available for Azure SQL. In the next module in the Azure SQL fundamentals learning path, you'll look at two scenarios that challenge you to create solutions that use Azure SQL.  

## Learn more

You can use the following resources to learn more about topics covered in this module.

### Video series: Azure SQL for beginners

People learn in different ways. A Channel 9 video series related to this learning path is available on YouTube. [You can get the 60+ videos here](https://aka.ms/azuresql4beginnersyt).

### Backup and restore

In the SQL documentation, you can learn more about how to [restore to a point in time](https://docs.microsoft.com/sql/relational-databases/backup-restore/restore-a-sql-server-database-to-a-point-in-time-full-recovery-model?view=sql-server-ver15?azure-portal=true) and [restore a deleted database](https://docs.microsoft.com/azure/sql-database/sql-database-recovery-using-backups#deleted-database-restore?azure-portal=true).

In the PITR exercise, you used the Azure CLI to perform a restore for Azure SQL Database. In Azure SQL Managed Instance, the process is similar but uses slightly different commands. You can review the commands in the [SQL documentation](https://docs.microsoft.com/cli/azure/sql/midb?view=azure-cli-latest#az-sql-midb-restore?azure-portal=true).  

### Kusto Query Language (KQL) and Azure PowerShell

KQL is used for many logging activities in Azure. To learn more about the language, see the [KQL documentation](https://docs.microsoft.com/azure/kusto/query/?azure-portal=true).

You've also used PowerShell in the availability exercises. To learn more about PowerShell commands that are available for Azure SQL, see [Azure PowerShell samples](https://docs.microsoft.com/azure/sql-database/sql-database-powershell-samples?tabs=single-database&azure-portal=true).  

### High availability

See the SQL Database documentation for more information about [business continuity](https://docs.microsoft.com/azure/sql-database/sql-database-business-continuity?azure-portal=true) and [high availability](https://docs.microsoft.com/azure/sql-database/sql-database-high-availability?azure-portal=true) in Azure SQL. You can also review the SLAs for [Azure SQL Managed Instance](https://azure.microsoft.com/en-in/support/legal/sla/azure-sql-sql-managed-instance/v1_0/) and [Azure SQL Database](https://azure.microsoft.com/en-us/support/legal/sla/sql-database/v1_5/).

In the Business Critical tier, you can opt in (for no additional fee) for a [zone-redundant configuration](https://docs.microsoft.com/azure/sql-database/sql-database-high-availability#zone-redundant-configuration?azure-portal=true) if your [region supports that](https://docs.microsoft.com/azure/availability-zones/az-overview#services-support-by-region?azure-portal=true).

### Availability and consistency

If you want to learn more about how Azure manages data integrity, check out this in-depth [blog post](https://azure.microsoft.com/blog/data-integrity-in-azure-sql-database/?azure-portal=true). If you want to learn more about Accelerated Database Recovery, the [documentation](https://docs.microsoft.com/azure/azure-sql/accelerated-database-recovery?azure-portal=true) is detailed and provides references to other resources, like white papers.

### Designing cloud solutions for disaster recovery

You can learn more about how to [design globally available services by using Azure SQL Database here](https://docs.microsoft.com/azure/sql-database/sql-database-designing-cloud-solutions-for-disaster-recovery?azure-portal=true). Also, Microsoft provides [outage recovery guidance](https://docs.microsoft.com/azure/sql-database/sql-database-disaster-recovery?azure-portal=true) and encourages you to complete [disaster recovery drills](https://docs.microsoft.com/azure/sql-database/sql-database-disaster-recovery-drills?azure-portal=true).

The exercise you completed on implementing a geo-distributed application is based on a [tutorial in the documentation](https://docs.microsoft.com/azure/sql-database/sql-database-implement-geo-distributed-database?tabs=azure-powershell&azure-portal=true). This tutorial also includes information about using the Azure portal and the Azure CLI.
