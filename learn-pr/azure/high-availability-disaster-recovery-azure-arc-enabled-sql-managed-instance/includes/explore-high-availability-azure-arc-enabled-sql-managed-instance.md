In the IT field, resiliency is very important, especially with data services. Databases hosted in overseas data centers and the US government-related contract data are of utmost importance from your organization's the business-continuity standpoint. However, implementing the level of resiliency that satisfies business requirements without straining the technology budget and burdening the support staff with excessive administrative overhead has always been complicated. Azure Arc-enabled SQL Managed Instance helps you to find the right balance between these two conflicting objectives.

The business continuity features of Azure Arc-enabled SQL Managed Instance combine the Kubernetes platform's resiliency capabilities with the technologies that deliver the high-availability and disaster-recovery characteristics of SQL Server and Azure SQL Server Managed Instance. You can use these features to address the need for automatic failover of databases hosted in overseas datacenters and for point-in-time restores.

Azure Arc-enabled SQL Managed Instance offers three primary resiliency capabilities:

- Point-in-time restore
- High availability
- Disaster recovery

This learning unit focuses on the point-in-time restore and high-availability options. These options protect databases deployed to a single instance of Azure Arc-enabled SQL Managed Instance. The disaster-recovery option offers extra protection by leveraging multiple instances of Azure Arc-enabled SQL Managed Instance that are typically deployed across separate physical locations.

## Point-in-time restore

Azure Arc-enabled SQL Managed Instance includes a built-in automatic backup that reduces the administrative overhead associated with traditional database backups. You can use this feature to implement scheduled full, differential, and transaction-log backups of user databases configured with full recovery model hosted on an Arc-enabled SQL Managed Instance. Azure stores all backups locally using the storage class you specified during deployment.

For user databases, full backups take place once a week, differential backups every 12 hours, and transaction log backups every five minutes as the following diagram illustrates. The automatic backup also protects the master and msdb system databases with a full backup every 12 hours.

:::image type="content" source="../media/point-in-time-restore-overview-4.png" alt-text="Diagram of automated backup schedule example." border="false":::

Following the initial round of backups, you can restore a database to a point in time within the retention period you specify to the same Arc-enabled SQL Managed Instance on which the backup was taken. To perform a restore, use either the `az sql midb-arc restore` Azure CLI command or Azure Data Studio.

You can set the value of the retention period between 0 and 35 days, with 7 being the default. The value of 0 effectively disables automatic backups. While it's possible to alter the retention period at any point, keep in mind that reducing its value has an immediate impact on the ability to restore the corresponding database to points in time before the newly set period.

## High availability

Azure Arc-enabled SQL Managed Instance includes built-in high availability provisions. The extent of these provisions depends on the service tier you choose to deploy.

### General Purpose tier deployment

This tier implements a single replica of Azure Arc-enabled SQL Managed Instance. Therefore, the increased availability relies on the underlying Kubernetes platform's resiliency features, using such constructs as stateful sets and persistent storage. These features provide built-in health monitoring, failure detection, and failover mechanisms. If a pod or node hosting the managed instance container fails, Kubernetes automatically creates another pod on one of the operational nodes and mounts onto it the persistent storage where the failed instance's databases reside. Note that the managed instance is temporarily unavailable during the failover time.

The failover's impact on database-bound workloads depends on the Kubernetes service type you chose for the managed instance during its deployment. The load balancer service type implements an endpoint that remains the same after the failover. The nodeport service type targets the node where the managed instance pod is running, so applications need to reconnect to that node's IP address.

:::image type="content" source="../media/general-purpose-tier-architecture-1.png" alt-text="Diagram of the General Purpose Tier high-availability architecture." border="false":::

### Business Critical tier deployment

To enhance service availability beyond the Kubernetes-native resiliency, Business Critical tier deployments leverage contained availability groups consisting of multiple replicas of a managed instance. The resulting degree of availability depends on whether you choose to implement two or three replicas. Each replica has its own persistent storage, with the master, msdb, and all user databases automatically updated by using synchronous replication. In addition, each contained availability group includes an endpoint that provides connectivity to the databases on the underlying managed instance. The endpoint serves as the availability group listener.

If a pod or node hosting the managed instance container crashes, the failure is transparent to the workloads using its databases. At least one other pod contains the same data as the primary, and it's ready to accept existing and new connections. Because there's no need to create a new pod or perform a storage mount, the failover time is reduced, resulting in increased uptime compared to the General Purpose tier.

When you deploy two or more replicas, Azure configures one replica as a readable secondary by default. A readable secondary can take over read-only workloads from the primary instance, increasing the usage efficiency of containerized resources.

:::image type="content" source="../media/business-critical-tier-architecture-2.png" alt-text="Diagram of the Business Critical Tier high-availability architecture." border="false":::
