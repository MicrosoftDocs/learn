Here, you explore how Azure Database for MariaDB works. If you're using MariaDB and considering using Azure to host your MariaDB apps, you must choose between hosting with:

- PaaS, by using Azure Database for MariaDB.
- IaaS, by using MariaDB on Azure VMs.

In this unit, you learn more about the differences between these options, the functions and features each provides, and the specific requirements of each.

## How are the hosting options different?

There are two possible hosting options:

- Azure Database for MariaDB. A fully managed DBaaS that requires minimal user configuration or control.
- MariaDB on Azure VMs.  A database implementation that uses IaaS. You manage the database.

The following table identifies important differences between Azure Database for MariaDB and MariaDB on Azure VMs.

|  Feature              | Azure Database for MariaDB |  MariaDB on Azure VMs       |
| ---------------------------- | ----------- |-------- |
| Version of MariaDB supported | MariaDB 10.2 or 10.3 | Any version the customer wants to install |
| MariaDB update and upgrade management|   Automatic          |  Customer-managed   |
| OS updates and patches | Automatic | Customer-managed |
| High availability | Built-in and based on node-level interruption mechanisms. When interruption occurs, the service automatically creates a new instance and attaches storage to it. | The customer architects, implements, tests, and maintains appropriate high-availability options. |
| Hybrid scenarios | Supports data synchronization from external MariaDB sources. Also supports up to five read-only replicas, potentially across Azure regions. | Customer-managed |
| Backup and restore operations | Automatic. Backups are stored in user-configured storage that's either locally redundant or geo-redundant. Point-in-time recovery is supported. | Customer-managed |
| Advanced threat protection | Provided | Customer-managed |

## Select a pricing tier

When you create an Azure Database for MariaDB server, there are three pricing tiers from which you can choose:

- Basic. This tier is best for workloads that require light compute and I/O performance.
- General purpose. This tier is best for production workloads that require high concurrency, scale, and predictable performance.
- Memory-optimized. This tier is best for high-performance database workloads that require in-memory performance for faster transaction processing and higher concurrency.

The following table identifies the important differences between these tiers.

| Resource                         | **Basic**    | **General Purpose** | **Memory Optimized** |
| ------------------------------- | ----------- | ------------------ | ------------------- |
| Compute generation               | Gen 5        | Gen 5               | Gen 5                |
| vCores                           | 1, 2         | 2, 4, 8, 16, 32, 64 | 2, 4, 8, 16, 32      |
| Memory per vCore                 | 2 gigabytes (GB)         | 5 GB                | 10 GB                |
| Storage size                     | 5 GB to 1 terabyte (TB) | 5 GB to 4 TB        | 5 GB to 4 TB         |
| Database backup-retention period | 7 to 35 days | 7 to 35 days        | 7 to 35 days         |

## Azure Database for MariaDB features

Let's examine some of the key features of Azure Database for MariaDB.

### High availability and recovery

Azure Database for MariaDB provides a guaranteed high-availability level as defined in a Service Level Agreement (SLA). The SLA defines an uptime of 99.99 percent. The following table identifies common failure scenarios and how MariaDB helps you recover from them.

| Scenario                | Recovery                                                     |
| ----------------------- | ------------------------------------------------------------ |
| Database server failure | Automatic. A new database server automatically deploys and the remote data storage is attached to it. After the database recovery is complete, clients can connect to the new database server. |
| Storage failure         |  Automatic. All data is stored in three copies. So, applications don't notice any impact from disk failure or block corruption.                 |
|  Region failure      |   Manual. This type of failure is a rare occurrence in Azure. To help protect against a region failure, configure one or more MariaDB read replicas in other regions for disaster recovery.   |
| Logical or user errors         |  Manual. Use a point-in-time recovery to roll back to a pre-error point in time.           |

> [!IMPORTANT]
> Applications that connect to Azure Database for MariaDB databases must be built to detect and retry dropped connections and failed transactions. The applicable gateway that manages client access, can then transparently redirect retried connections to the newly created database server.

### Backup and restore

Azure Database for MariaDB performs several backup operations, including:

- Full
- Differential
- Transaction log

Using these backups enables server restoration to a specific point in time.

> [!TIP]
> The default retention period is seven days. However, you can configure retention for a maximum of 35 days.

Backup frequency varies, depending on database size:

- Up to 4-TB storage:

  - Full backups weekly.
  - Differential backups twice daily.
  - Transaction logs every 5 minutes.

> [!NOTE]
> Servers that have up to 4 TB of storage can retain two full database backups, all differential backups, and transaction log backups performed since the earliest full database backup.

- Up to 16-TB storage. These backups are snapshot-based and occur as follows:

  - First snapshot after server deployment.
  - Differential snapshots at least once a day thereafter.
  - Transaction logs every 5 minutes.

> [!NOTE]
> Servers that have up to 16 TB of storage retain a full database snapshot, all differential snapshots, and transaction log backups from the last eight days.

### Describe scaling

Azure Database for MariaDB is available in the following service tiers:

- Basic
- General Purpose
- Memory Optimized

Each tier provides different performance capabilities that support lightweight to heavyweight database workloads. However, you can build your first database app on a small database using the Basic pricing tier, for a few dollars a month. As your needs change, you can adjust the scale to meet your needs. This dynamic scalability can help your database apps respond transparently to resource-requirement changes.

### Describe security

Azure Database for MariaDB provides the following app protections:

- In-transit data protection. MariaDB encrypts your data with Transport Layer Security (TLS). It provides encryption with Secure Sockets Layer and TLS (SSL/TLS) by default.
- At-rest data protection. MariaDB encrypts at-rest data using a cryptographic module. The Federal Information Processing Standard 140-2 (FIPS 140-2) validates this module.
- Network security:
  - Connections to MariaDB are routed through a regional gateway. The gateway must have a publicly accessible IP. However, your MariaDB server IP is protected.
  - Firewall rules are created that block all access to any newly deployed MariaDB server.
  - You can optionally implement Advanced Threat Protection to help provide more protection for your MariaDB server.

Next, we consider whether Azure Database for MariaDB is suitable for your organization, its apps, and database workloads.
