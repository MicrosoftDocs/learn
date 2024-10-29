In this module and throughout the exercises, you gained some experience with many availability-related features for Azure SQL. In the next module in the Azure SQL fundamentals learning path, you'll look at two scenarios that challenge you to create solutions that use Azure SQL.

## Learn more

You can use the following resources to learn more about topics covered in this module.

### Video series: Azure SQL for beginners

People learn in different ways. A Channel 9 video series related to this learning path is available on YouTube. [You can get the 60+ videos here](https://aka.ms/azuresql4beginnersyt).

### Backup and restore

In the SQL documentation, you can learn more about how to [restore to a point in time](/sql/relational-databases/backup-restore/restore-a-sql-server-database-to-a-point-in-time-full-recovery-model) and [restore a deleted database](/azure/sql-database/sql-database-recovery-using-backups#deleted-database-restore).

In the PITR exercise, you used the Azure CLI to perform a restore for Azure SQL Database. In Azure SQL Managed Instance, the process is similar, but uses slightly different commands. You can review the commands in the [SQL documentation](/azure/azure-sql/database/recovery-using-backups#sql-managed-instance-2).  

### Kusto Query Language (KQL) and Azure PowerShell

KQL is used for many logging activities in Azure. To learn more about the language, see the [KQL documentation](/azure/data-explorer/kusto/query/).

You've also used PowerShell in the availability exercises. To learn more about PowerShell commands that are available for Azure SQL, see [Azure PowerShell samples](/azure/azure-sql/database/powershell-script-content-guide).  

### High availability

See the SQL Database documentation for more information about [business continuity](/azure/azure-sql/database/business-continuity-high-availability-disaster-recover-hadr-overview) and [high availability](/azure/azure-sql/database/high-availability-sla) in Azure SQL. You can also review the SLAs for [Azure SQL Managed Instance](https://www.microsoft.com/licensing/docs/view/Service-Level-Agreements-SLA-for-Online-Services) and [Azure SQL Database](https://www.microsoft.com/licensing/docs/view/Service-Level-Agreements-SLA-for-Online-Services).

In the Business Critical tier, you can opt in (for no additional fee) for a [zone-redundant configuration](/azure/azure-sql/database/high-availability-sla#zone-redundant-availability) if your [region supports that](/azure/reliability/availability-zones-service-support).

### Availability and consistency

If you want to learn more about how Azure manages data integrity, check out this in-depth [blog post](https://azure.microsoft.com/blog/data-integrity-in-azure-sql-database/?azure-portal=true). If you want to learn more, the [Accelerated Database Recovery documentation](/azure/azure-sql/accelerated-database-recovery) is detailed and provides references to other resources, like white papers.

### Designing cloud solutions for disaster recovery

You can learn more about how to [design globally available services by using Azure SQL Database here](/azure/azure-sql/database/designing-cloud-solutions-for-disaster-recovery). Also, Microsoft provides [outage recovery guidance](/azure/azure-sql/database/disaster-recovery-guidance) and encourages you to complete [disaster recovery drills](/azure/azure-sql/database/disaster-recovery-drills).

The exercise you completed on implementing a geo-distributed application is based on a [tutorial in the documentation](/azure/azure-sql/database/geo-distributed-application-configure-tutorial). This tutorial also includes information about using the Azure portal and the Azure CLI.
