If you're using MariaDB, and are considering using Azure to host your MariaDB apps, you must choose between hosting in one of the following ways:

- PaaS, by using Azure Database for MariaDB
- IaaS, by using MariaDB on Azure VMs

In this unit, you'll learn more about the differences between these options and the functions and features they provide, together with their specific requirements. 

## How are the hosting options different?

There are two possible hosting options: 

- **Azure Database for MariaDB**. Fully managed DBaaS requiring minimal user configuration or control. 
- **MariaDB on Azure VMs**.  A database implementation that uses IaaS. The database is managed by you.

The following table identifies important differences.

|  Feature              | Azure Database for MariaDB |  MariaDB on Azure VMs       |
| ---------------------------- | ----------- |-------- |
| Version of MariaDB supported | MariaDB 10.2 or 10.3 | Any version customer wants to install |
| MariaDB update and upgrade management	|   Automatic          |  Customer managed   |
| Operating system updates and patches | Automatic | Customer managed |
| High-availability | Built-in, and based on node-level interruption mechanisms. When interruption occurs, the service automatically creates a new instance and attaches storage to the new instance. | Customer architects, implements, tests, and maintains appropriate high-availability options. |
| Hybrid scenarios | Supports synchronization of data from external MariaDB sources. Also supports up to five read-only replicas, potentially across Azure regions. | Customer managed |
| Backup and restore operations | Automatic. Backups stored in user-configured storage that is either locally redundant or geo-redundant. Point-in-time recovery supported. | Customer managed |
| Advanced threat protection | Provided | Customer managed |

## Select a pricing tier

When you create an Azure Database for MariaDB server, you can choose between three pricing tiers.. These are: 

- Basic. Best suited for workloads that require light compute and I/O performance.
- General Purpose.  Better suited for production workloads requiring high concurrency, scale, and predictable performance.
- Memory Optimized. Better suited for high-performance database workloads that require in-memory performance for faster transaction processing and higher concurrency.

The following table identifies the important differences between these tiers. 

| Resource                         | **Basic**    | **General Purpose** | **Memory Optimized** |
| ------------------------------- | ----------- | ------------------ | ------------------- |
| Compute generation               | Gen 5        | Gen 5               | Gen 5                |
| vCores                           | 1, 2         | 2, 4, 8, 16, 32, 64 | 2, 4, 8, 16, 32      |
| Memory per vCore                 | 2 GB         | 5 GB                | 10 GB                |
| Storage size                     | 5 GB to 1 TB | 5 GB to 4 TB        | 5 GB to 4 TB         |
| Database backup retention period | 7 to 35 days | 7 to 35 days        | 7 to 35 days         |


## Azure Database for MariaDB features

Let's examine some of the key features of Azure Database for MariaDB. 

### Describe high-availability and recovery

Azure Database for MariaDB provides a guaranteed high-availability level defined in a Service Level Agreement (SLA). The SLA defines an uptime of 99.99%. The following table identifies some common failure scenarios, and describes how MariaDB recovers. 

| Scenario                | Recovery                                                     |
| ----------------------- | ------------------------------------------------------------ |
| Database server failure | Automatic. A new database server is automatically deployed, and the remote data storage is attached to the new database server. After the database recovery is complete, clients can connect to the new database server. |
| Storage failure         |  Automatic. All data is stored in three copies. Consequently, applications don't notice any impact from disk failure or block corruption.                 |
|  Region failure	      |   Manual. A rare occurrence in Azure. If you want protection from a region failure, you can configure one or more MariaDB read replicas in other regions for disaster recovery.   |
| Logical/User errors         |  Manual. Use a point-in-time recovery to rollback to a time prior to the error.           |

> [!IMPORTANT]
> Applications that connect to Azure Database for MariaDB databases must be built to detect and retry dropped connections and failed transactions. This enables the Gateway (which handles client access) to transparently redirect the retried connections to the newly created database server.


### Describe backup and restore

Azure Database for MariaDB performs the following types of backup operations:

- Full
- Differential
- Transaction log

By using these backups, you can restore a server to a specific point in time. 

> [!TIP]
> The default retention period is seven days, but you can configure up to 35 days. 

Backup frequency varies, depending on database size:

- Up to 4-TB storage:

   - Full backups weekly
   - Differential backups twice daily
   - Transaction logs every five minutes

> [!NOTE]
> Servers with up to 4-TB of storage retain up to two full database backups, all the differential backups, and transaction log backups performed since the earliest full database backup.

- Up to 16-TB storage. These backups are snapshot based, and occur as follows:

   - First snapshot after server deployment
   - Differential snapshots at least once a day thereafter 
   - Transaction logs every five minutes


> [!NOTE]
> Servers with up to 16-TB storage retain the full database snapshot, all the differential snapshots and transaction log backups in last eight days.


### Describe scaling

As discussed, Azure Database for MariaDB is available in several service tiers> these are:

- Basic
- General Purpose
- Memory Optimized

Each tier provides different performance capabilities to support lightweight to heavyweight database workloads. However, you can build your first database app on a small database using the Basic pricing tier, for a few dollars a month. As your needs change, you can adjust the scale to meet the needs of your solution. This dynamic scalability can help your database apps to respond transparently to changes in resource requirements. 

### Describe security

Azure Database for MariaDB provides the following protections for your apps:

- In-transit data protection. MariaDB secures your data by encrypting with Transport Layer Security (TLS). Encryption with (SSL/TLS) is on by default.
- At-rest data protection. MariaDB  uses the FIPS 140-2 validated cryptographic module for encryption of data at-rest.
- Network security:
   - Connections to MariaDB are routed through a regional gateway. The gateway must have a publicly accessible IP. But your MariaDB server IP is protected. 
   - Firewall rules are created that block all access to any newly deployed MariaDB server.
   - Advanced Threat Protection is available as an option to help further protect your MariaDB server.
- 


Next, let's consider whether Azure Database for MariaDB is suitable for  your organization, its apps and database workloads. 
