Beyond its built-in high availability, the Azure platform offers two options for providing higher levels of availability for VM and some PaaS workloads. Availability Zones and Availability Sets protect your workloads from planned maintenance activity and potential hardware failures.

## High availability options

Most SQL Server high availability solutions are available on Azure virtual machines (VMs). In an Azure-only solution, the entire HADR system runs in Azure. In a hybrid configuration, part of the solution runs in Azure and the other part runs on-premises in your organization. The flexibility of the Azure environment enables you to move partially or completely to Azure to satisfy the budget and HADR requirements of your SQL Server database systems.

### Availability Zones

Availability Zones are unique physical locations within a region. Each zone is made up of one or more data centers equipped with independent power, cooling, and networking. Within Azure regions that support Availability Zones, you can specify in which zone you want the virtual machine to reside when you choose to use Available Zones during VM creation. There are three Availability Zones within each supported Azure region. Availability Zones provide high availability against data center failures when you deploy multiple VMs into different zones. In addition, they also provide a means for Microsoft to perform maintenance (using a grouping called an update domain) within each region by only updating one zone at any given time. You can spread out your virtual machine ecosystem across three zones in the region. Utilizing Availability Zones in conjunction with your Azure virtual machines raises your uptime to four nines (99.99%) which equates to a maximum of 52.60 minutes of downtime per year. You can identify which Azure regions support Availability Zones at [docs.microsoft.com](/azure/availability-zones/az-overview). If Availability Zones are available in your region, and your application can support the minimal cross-zone latency, Availability Zones will provide the highest level of availability for your application.

:::image type="content" source="../media/module-22-plan-implement-final-03.png" alt-text="Azure Availability Zones":::

In the image above, you can see the availability zone configuration. When you deploy a VM into a region with an availability zone you will be presented with the option to deploy in Zone 1, 2, and 3. These zones are logical representations of physical data centers, which means a deployment to Zone 1 in one subscription, does not mean that Zone 1 represents the same data center in another subscription.

### Availability Sets

Availability sets are similar to Availability Zones, except instead of spreading workloads across data centers in a region, they spread workloads across servers and racks in a data center. Since nearly all workloads in Azure are virtual, you can use availability sets in order to guarantee that the two VMs containing your Always On Availability Group members are not running on the same physical host. Availability sets can provide up to 99.95% availability, and should be used when Availability Zones are unavailable in a region, or an application cannot tolerate intra-zone latency.

### Always On availability groups (AG)

Always On availability groups can be implemented between two or more (up to a maximum of nine) SQL Server instances running on Azure virtual machines or across an on-premises data center and Azure. In an availability group, database transactions are committed to the primary replica, and then the transactions are sent either synchronously or asynchronously to all secondary replicas. The physical distance between the servers (that is, whether or not they are in the same Azure region) dictates which availability mode you should choose. Generally, if the workload requires the lowest possible latency or the secondary replicas are geographically spread apart, asynchronous availability mode is recommended. If the replicas are within the same Azure region and the applications can withstand some level of latency, synchronous commit mode should be considered. Synchronous mode will help to ensure that each transaction is committed to one or more secondaries before allowing the application to continue. Always On availability groups provide both high availability and disaster recovery, because a single availability group can support both synchronous and asynchronous availability modes. The unit of failover for an availability group is a group of databases, and not the entire instance.

Always On Availability Groups can also be used for disaster recovery purposes. You can implement up to nine replicas of a database across Azure regions, and stretch this architecture even further using Distributed Availability Groups. Availability Groups ensure that a viable copy of your database(s) is in another location beyond the primary region. By doing so, you help to ensure that your data ecosystem is protected against natural disasters as well as some human made ones.

:::image type="content" source="../media/module-22-plan-implement-final-05.png" alt-text="Always On Availability Group Configuration":::

The image above shows a logical diagram of an Always On Availability Group, running on a Windows Server Failover Cluster. There are one primary and four secondary replicas. In this scenario all five replicas could be synchronous, or some combination of synchronous and asynchronous replicas. Keep in mind that the unit of failover is the group of databases and not the instance. While a failover cluster instance provides HA at an instance level, it doesn't provide disaster recovery.

### SQL Server Failover Cluster instances

If you need to protect the entire instance, you could use a SQL Server Failover Cluster Instance (FCI), which provides high availability for an entire instance, in a single region. A FCI doesn't provide disaster recovery without being combined with another feature like availability groups or log shipping. FCIs also require shared storage that can be provided on Azure by using shared file storage or using Storage Spaces Direct on Windows Server.

For Azure workloads, availability groups are the preferred solution for newer deployments, because the shared storage require of FCIs increases the complexity of deployments. However, for migrations from on-premises solutions, an FCI may be required for application support.

## Disaster Recovery options

While the Azure platform offers 99.9% up time by default, disasters can still occur and affect application uptime. It's important that you have a proper disaster recovery plan in place when you are performing any type of migration. Azure offers us several methods to ensure that your SQL Server on a virtual machine is protected in case of a disaster. There are two components to this protection. First, there are Azure platform options like geo-replicated storage for backups and Azure Site Recovery, which is an all-encompassing disaster recovery solution for all of your workloads. Second, there are SQL Server specific offerings like Availability Groups and backups.

### Native SQL Server backups

Backups are considered the life blood of any database administrator and it's not any different when working with a cloud solution. With SQL Server on an Azure virtual machine, you have granular control of when backups occur and where they're stored. You can use SQL agent jobs to back up directly to a URL linked to Azure blob storage. Azure provides the option to use geo-redundant storage (GRS) or read-access geo-redundant storage (RA-GRS) to ensure that your backup files are stored safely across the geographic landscape.

Additionally as part of the Azure SQL VM service provider, you can have your backups automatically managed by the platform.

### Azure Backup for SQL Server

The Azure Backup solution requires an agent to be installed on the virtual machine. The agent then communicates with an Azure service that manages automatic backups of your SQL Server databases. Azure Backup also provides a central location that you can use to manage and monitor the backups to ensure meeting any specified RPO/RTO metrics.

:::image type="content" source="../media/module-22-plan-implement-final-04.png" alt-text="Azure Backup for SQL Server Architecture":::

As shown above, the Azure Backup solution is a comprehensive, enterprise backup solution that provides long-term data retention, automated management, and additional data protection. This option costs more than simply performing your own backups, or using the Azure resource provider for SQL Server, but does offer a more complete backup feature set.

### Azure Site Recovery

Azure Site Recovery is a low-cost solution that will perform block level replication of your Azure virtual machine. This service offers various options, including the ability to test and verify your disaster recovery strategy. This solution is best used for stateless environments (for example, web servers) versus transactional database virtual machines. 

Azure Site Recovery is supported for use with SQL Server, but keep in mind that you will need to set a higher recovery point which means potential loss. In this case, your RTO will essentially be your RPO.

:::image type="content" source="../media/module-55-optimize-queries-final-17.png" alt-text="Azure Site Recovery Architecture":::

1. VM is registered with Azure Site Recovery
1. Data is continuously replicated to cache
1. Cache is replicated to the target storage account
1. During failover the virtual machine is added to the target environment
