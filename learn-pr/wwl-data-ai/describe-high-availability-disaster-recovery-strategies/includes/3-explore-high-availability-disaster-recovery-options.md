To envision a solution for virtual machines (VMs), you must first understand the availability options for IaaS-based deployments.

## Infrastructure-as-a-Service versus Platform-as-a-Service

When it comes to availability, the choice of IaaS or PaaS makes a difference. With IaaS, you have a virtual machine, which means there's an operating system with an installation of SQL Server. The administrator or group responsible for SQL Server would have a choice of high availability and disaster recovery (HADR) solutions and a great deal of control over what how that solution was configured.

With PaaS-based deployments such as Azure SQL Database, the HADR solutions are built into the feature and often just need to be enabled. There are minimal options that can be configured.

Because of these differences, the choice of IaaS or PaaS may influence the final design of your HADR solution.

## SQL Server HADR Features for Azure Virtual Machine

When using IaaS, you can use the features provided by SQL Server to increase availability. In some cases, they can be combined with Azure-level features to increase availability even further.

The following table shows the solutions available in SQL Server:

| **Feature Name**| **Protects** |
| - | - |
| Always On Failover Cluster Instance (FCI)| Instance |
| Always On Availability Group (AG)| Database |
| Log Shipping| Database |

An instance of SQL Server is the entire installation of SQL Server (binaries, all the objects inside the instance including things like logins, SQL Server Agent jobs, and databases). Instance-level protection means that the entire instance is accounted for in the availability feature.

A database in SQL Server contains the data that end users and applications use. There are system databases that SQL Server relies on, and databases created for use by end users and applications. An instance of SQL Server always has its own system databases. Database-level protection means that anything that is in the database, or is captured in the transaction log for a user or application database, is accounted for as part of the availability feature. Anything that exists outside of the database or that isn't captured as part of the transaction log such as SQL Server Agent jobs and linked servers must be manually dealt with to ensure the destination server can function like the primary if there's a planned or unplanned failover event.

Both FCIs and AGs require an underlying cluster mechanism. For SQL Server deployments running on Windows Server, it's a Windows Server Failover Cluster (WSFC) and for Linux it's Pacemaker.

## Always On Failover Cluster Instances

An FCI is configured when SQL Server is installed. A standalone instance of SQL Server can't be converted to an FCI. The FCI is assigned a unique name and an IP address that is different from the underlying servers, or nodes, participating in the cluster. The name and IP address must also be different from the underlying cluster mechanism. Applications and end users would use the unique name of the FCI for access. This abstraction enables applications to not have to know where the instance is running. One major difference between Azure-based FCIs versus on-premises FCIs, is that for Azure, an internal load balancer (ILB) is required. The ILB is used to help ensure applications and end users can connect to the FCI’s unique name.

When an FCI fails over to another node of a cluster, whether it's initiated manually or happens due to a problem, the entire instance restarts on another node. That means the failover process is a full stop and start of SQL Server. Any applications or end users connected to the FCI is disconnected during failover and only applications that can handle and recover from this interruption can reconnect automatically.

When the instance starts up on the other node, it undergoes the recovery process. The Failover Cluster Instance (FCI) is consistent up to the point of failure, ensuring no data loss. Any transactions that need to be rolled back is handled during recovery. Since this is instance-level protection, all necessary components (logins, SQL Server Agent jobs, etc.) are already in place, allowing business operations to resume as usual once the databases are ready.

FCIs require one copy of a database, but that is also its single point of failure. To ensure another node can access the database, FCIs require some form of shared storage. For Windows Server-based architectures, this can be achieved via an Azure Premium File Share, iSCSI, Azure Shared Disk, Storage Spaces Direct (S2D), or a supported third-party solution like SIOS DataKeeper. FCIs using Standard Edition of SQL Server can have up to two nodes. FCIs also require the use of Active Directory Domain Services (AD DS) and Domain Name Services (DNS), so that means AD DS and DNS must be implemented somewhere in Azure for an FCI to work.

In Windows Server, FCIs can use storage replica to create a native disaster recovery solution for FCIs without having to use another feature such as log shipping or AGs.

## Always On availability groups

Availability Groups (AGs) were introduced in SQL Server 2012 Enterprise Edition and are available in Standard Edition starting with SQL Server 2016. In Standard Edition, an AG can contain one database, while in Enterprise Edition, it can have multiple databases. Although AGs share some similarities with Failover Cluster Instances (FCIs), they're different in many ways.

The main difference is that AGs provide database-level protection. The primary replica in an AG contains the read/write databases, while the secondary replica receives transactions from the primary to stay synchronized. Data movement can be synchronous or asynchronous. In Standard Edition, an AG can have up to two replicas (one primary, one secondary), whereas Enterprise Edition supports up to nine replicas (one primary, eight secondary). Secondary replicas are initialized from a database backup or through automatic seeding, which streams the backup to the secondary replica.

AGs use a listener for abstraction, which functions like the unique name assigned to an FCI and has its own name and IP address. Applications and end users can connect using the listener, but direct connections to the instance are also possible. In Enterprise Edition, secondary replicas can be configured for read-only access and used for tasks like database consistency checks (DBCCs) and backups.

AGs offer quicker failover times compared to FCIs and don't require shared storage. Each replica has its own copy of the data, increasing the total number of database copies and overall storage costs. For example, if the primary replica's data footprint is 1 TB, each replica will also have 1 TB of data, requiring 5 TB of space for five replicas.

Objects outside the database or not captured in the transaction log must be manually created on any new primary replica. Examples include SQL Server Agent jobs, instance-level logins, and linked servers. Using Windows authentication or contained databases with AGs can simplify access.

Organizations may face challenges implementing highly available architectures and might only need the high availability provided by the Azure platform or a PaaS solution like Azure SQL Managed Instance. Before exploring Azure platform solutions, it's essential to know about another SQL Server feature: log shipping.

## Log shipping

Log shipping has been a fundamental feature of SQL Server since its early days. It's based on backup, copy, and restore, making it one of the simplest methods for achieving High Availability and Disaster Recovery (HADR). While primarily used for disaster recovery, log shipping can also enhance local availability.

Like Availability Groups (AGs), log shipping provides database-level protection, meaning you must account for SQL Server Agent jobs, linked servers, instance-level logins, and other objects. Unlike AGs, log shipping doesn't offer native abstraction, so switching to another server requires tolerating a name change. This can be mitigated using methods like DNS aliases configured at the network layer.

The log shipping process is straightforward: take a full backup of the source database on the primary server, restore it in a loading state (STANDBY or NORECOVERY) on a secondary server, known as a warm standby. This new copy is called the secondary database. SQL Server then automatically backs up the primary database's transaction log, copies the backup to the standby server, and restores it onto the standby.

In addition to SQL Server HADR features, there are Azure features that can enhance IaaS availability.
