To envision a solution for virtual machines (VMs), you must first understand the availability options for IaaS-based deployments.

## Infrastructure-as-a-Service versus Platform-as-a-Service

When it comes to availability, the choice of IaaS or PaaS makes a difference. With IaaS, you have a virtual machine, which means there is an operating system with an installation of SQL Server. The administrator or group responsible for SQL Server would have a choice of high availability and disaster recovery (HADR) solutions and a great deal of control over what how that solution was configured.

With PaaS-based deployments such as Azure SQL Database, the HADR solutions are built into the feature and often just need to be enabled. There are minimal options that can be configured.

Because of these differences, the choice of IaaS or PaaS may influence the final design of your HADR solution.

## SQL Server HADR Features for Azure Virtual Machine

When using IaaS, you can use the features provided by SQL Server to increase availability. In some cases, they can be combined with Azure-level features to increase availability even further.

The features available in SQL Server are shown in the table below

| **Feature Name**| **Protects** |
| - | - |
| Always On Failover Cluster Instance (FCI)| Instance |
| Always On Availability Group (AG)| Database |
| Log Shipping| Database |

An instance of SQL Server is the entire installation of SQL Server (binaries, all the objects inside the instance including things like logins, SQL Server Agent jobs, and databases). Instance-level protection means that the entire instance is accounted for in the availability feature.

A database in SQL Server contains the data that end users and applications use. There are system databases that SQL Server relies on, as well as databases created for use by end users and applications. An instance of SQL Server always has its own system databases. Database-level protection means that anything that is in the database, or is captured in the transaction log for a user or application database, is accounted for as part of the availability feature. Anything that exists outside of the database or that is not captured as part of the transaction log such as SQL Server Agent jobs and linked servers must be manually dealt with to ensure the destination server can function like the primary if there is a planned or unplanned failover event.

Both FCIs and AGs require an underlying cluster mechanism. For SQL Server deployments running on Windows Server, it is a Windows Server Failover Cluster (WSFC) and for Linux it is Pacemaker.

## Always On Failover Cluster Instances

An FCI is configured when SQL Server is installed. A standalone instance of SQL Server cannot be converted to an FCI. The FCI is assigned a unique name as well as an IP address that is different from the underlying servers, or nodes, participating in the cluster. The name and IP address must also be different from the underlying cluster mechanism. Applications and end users would use the unique name of the FCI for access. This abstraction enables applications to not have to know where the instance is running. One major difference between Azure-based FCIs versus on-premises FCIs, is that for Azure, an internal load balancer (ILB) is required. The ILB is used to help ensure applications and end users can connect to the FCI’s unique name.

When an FCI fails over to another node of a cluster, whether it is initiated manually or happens due to a problem, the entire instance restarts on another node. That means the failover process is a full stop and start of SQL Server. Any applications or end users connected to the FCI will be disconnected during failover and only applications that can handle and recover from this interruption can reconnect automatically.

Upon starting up on the other node, the instance goes through the recovery process. The FCI will be consistent to the point of failure, so technically there will be no data loss but any transactions that need to be rolled back will do so as part of recovery. As noted above, because this is instance-level protection, everything necessary (logins, SQL Server Agent jobs, etc.) is already there so business can continue as usual once the databases are ready.

FCIs require one copy of a database, but that is also its single point of failure. To ensure another node can access the database, FCIs require some form of shared storage. For Windows Server-based architectures, this can be achieved via an Azure Premium File Share, iSCSI, Azure Shared Disk, Storage Spaces Direct (S2D), or a supported third-party solution like SIOS DataKeeper. FCIs using Standard Edition of SQL Server can have up to two nodes. FCIs also require the use of Active Directory Domain Services (AD DS) and Domain Name Services (DNS), so that means AD DS and DNS must be implemented somewhere in Azure for an FCI to work.

Using Windows Server 2016 or later, FCIs can use Storage Replica to create a native disaster recovery solution for FCIs without having to use another feature such as log shipping or AGs.

## Always On availability groups

AGs were introduced in SQL Server 2012 Enterprise Edition and as of SQL Server 2016, are also in Standard Edition. In Standard Edition, an AG can contain one database whereas in Enterprise Edition, an AG can have more than one database. While AGs share some similarities with FCIs, in most ways they are different.

The biggest difference between an FCI and an AG is that AGs provide database-level protection. The primary replica is the instance participating in an AG that contains the read/write databases. A secondary replica is where the primary sends transactions over the log transport to keep it synchronized. Data movement between a primary replica can be synchronous or asynchronous. The databases on any secondary replica are in a loading state, which means they can receive transactions but cannot be a fully writeable copy until that replica becomes the primary. An AG in Standard Edition can have at most two replicas (one primary, one secondary) whereas Enterprise Edition supports up to nine (one primary, eight secondary). A secondary replica is initialized either from a backup of the database, or as of SQL Server 2016, you can use a feature called ‘automatic seeding’. Automatic seeding uses the log stream transport to stream the backup to the secondary replica for each database of the availability group using the configured endpoints.

An AG provides abstraction with the listener. The listener functions like the unique name assigned to an FCI and has its own name and IP address that is different from anything else (WSFC, node, etc.). The listener also requires an ILB and goes through a stop and start. Applications and end users can use the listener to connect, but unlike an FCI, if desired, the listener does not have to be used. Connections directly to the instance can occur. With Enterprise Edition, secondary replicas in Enterprise Edition can also be configured for read-only access if desired and can be used for other functionality such as database consistency checks (DBCCs) and backups.

AGs can have a quicker failover time compared to an FCI, which is one reason they are attractive. While AGs do not require shared storage, each replica has a copy of the data, which increases the total number of copies of the database and overall storage costs. The storage is local to each replica. For example, if the data footprint of the databases on the primary replica is 1 TB, each replica will also have the same. If there are five replicas, that means you need 5 TB of space.

Remember that any object that exists outside of the database or is not captured in the database’s transaction log must manually be created and accounted for on any other SQL Server instance should that instance need to become the new primary replica. Examples of objects you would be responsible for include SQL Server Agent jobs, instance-level logins, and linked servers. If you can use Windows authentication or use contained databases with AGs, it will simplify access.

Many organizations may face challenges implementing highly available architectures, and may only need the high availability provided by the Azure platform, or using a PaaS solution like Azure SQL Managed Instance. Before we look at Azure platform solutions, there is one other SQL Server feature that you should know about: log shipping.

## Log shipping

Log shipping has been around since the early days of SQL Server. The feature is based on backup, copy, and restore and is one of the simplest methods of achieving HADR for SQL Server. Log shipping is primarily used for disaster recovery, but it could also be used to enhance local availability.

Log shipping, like AGs, provides database-level protection, which means you still need to account for SQL Server Agent jobs, linked servers, instance-level logins, etc. There is no abstraction provided natively by log shipping, so a switch to another server participating in log shipping must be able to tolerate a name change. If that is not possible, there are methods such as a DNS alias, which can be configured at the network layer to try to mitigate the name change issues.

The log shipping mechanism is simple: first, take a full backup of the source database on the primary server, restore it in a loading state (STANDBY or NORECOVERY) on another instance known as a secondary server or warm standby. This new copy of the database is known as a secondary database. An automated process built into SQL Server will then automatically backup the primary database’s transaction log, copy the backup to the standby server, and finally, restore the backup onto the standby.

The SQL Server HADR features are not the only options to enhance IaaS availability. There are some features in Azure that should also be considered.
