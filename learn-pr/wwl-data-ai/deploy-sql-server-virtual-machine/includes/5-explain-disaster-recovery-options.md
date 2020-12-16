While the Azure platform offers 99.9% up time by default, disasters can still occur and affect application uptime. It's important that you have a proper disaster recovery plan in place when you are performing any type of migration. Azure offers us several methods to ensure that your SQL Server on a virtual machine is protected in case of a disaster. There are two components to this protection. First, there are Azure platform options like geo-replicated storage for backups and Azure Site Recovery, which is an all-encompassing disaster recovery solution for all of your workloads. Second, there are SQL Server specific offerings like Availability Groups and backups.

## Native SQL Server backups

Backups are considered the life blood of any database administrator and it's not any different when working with a cloud solution. With SQL Server on an Azure virtual machine, you have granular control of when backups occur and where they're stored. You can use SQL agent jobs to back up directly to a URL linked to Azure blob storage. Azure provides the option to use geo-redundant storage (GRS) or read-access geo-redundant storage (RA-GRS) to ensure that your backup files are stored safely across the geographic landscape.

Additionally as part of the Azure SQL VM service provider, you can have your backups automatically managed by the platform.

## Azure Backup for SQL Server

The Azure Backup solution requires an agent to be installed on the virtual machine. The agent then communicates with an Azure service that manages automatic backups of your SQL Server databases. Azure Backup also provides a central location that you can use to manage and monitor the backups to ensure meeting any specified RPO/RTO metrics.

:::image type="content" source="../media/module-22-plan-implement-final-04.png" alt-text="Azure Backup for SQL Server Architecture":::

As shown above, the Azure Backup solution is a comprehensive, enterprise backup solution that provides long-term data retention, automated management, and additional data protection. This option costs more than simply performing your own backups, or using the Azure resource provider for SQL Server, but does offer a more complete backup feature set.

## Availability groups

In addition to the high availability scenarios described above, Always On Availability Groups can be used for disaster recovery purposes. You can implement up to nine replicas of a database across Azure regions, and stretch this architecture even further using Distributed Availability Groups. Availability Groups ensure that a viable copy of your database(s) is in another location beyond the primary region. By doing so, you help to ensure that your data ecosystem is protected against natural disasters as well as some human made ones.

:::image type="content" source="../media/module-22-plan-implement-final-05.png" alt-text="Always On Availability Group Configuration":::

The image above shows a logical diagram of an Always On Availability Group, running on a Windows Server Failover Cluster. There are one primary and four secondary replicas. In this scenario all five replicas could be synchronous, or some combination of synchronous and asynchronous replicas. Keep in mind that the unit of failover is the group of databases and not the instance. While a failover cluster instance provides HA at an instance level, it doesn't provide disaster recovery.

## Azure Site Recovery

Azure Site Recovery is a low-cost solution that will perform block level replication of your Azure virtual machine. This service offers various options, including the ability to test and verify your disaster recovery strategy. This solution is best used for stateless environments (for example, web servers) versus transactional database virtual machines. Azure Site Recovery is supported for use with SQL Server, but keep in mind that you will need to set a higher recovery point which means potential loss. In this case, your RTO will essentially be your RPO. 
