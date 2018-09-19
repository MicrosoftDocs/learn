Backup is the final and most powerful line of defense against permanent data loss. An effective backup strategy requires more than simply making copies of data. It needs to take your application's data architecture and infrastructure into consideration. Your app may manage many kinds of data of varying importance, spread widely across filesystems, databases, and other storage services both in the cloud and on-premises. Using the right services and products for the job will simplify your backup process and increase recovery time if a backup needs to be restored.

## Establish backup and restoration requirements

As with a disaster recovery strategy, backup requirements are based on a cost-benefit analysis. Analysis of your app's data should be guided by the relative importance of the different categories of data the app manages, as well as external requirements, such as data retention laws.

To establish backup requirements for your app, group your application's data based on the following requirements:

* How much of this type of data can afford to be lost, measured in duration
* The maximum amount of time a restore of this type of data should require
* Backup retention requirements: how long and at what frequency do backups need to remain available

These concepts map neatly to the concepts of Recovery Point Objective and Recovery Time Objective (RPO and RTO). The duration of acceptable loss will generally translate directly to required backup intervals and RPO. The maximum amount of time a restore takes corresponds to the RTO for the data component of your application. Both requirements should be developed relative to the cost of achieving them. Every organization would like to say that they truly can't afford to lose *any* data, but often that's not the case when the cost of achieving that requirement is considered.

Backup absolutely plays a role in disaster recovery (DR), but backups, restores and their associated scenarios extend beyond the scope of DR. Backups may need to be restored in non-disaster situations, including those where RTO and RPO aren't of great concern. For example, if a small amount of data older than your backup interval is corrupted or deleted, but the application doesn't experience downtime, your application may never be in danger of missing its SLA and a successful restore will result in no data lost. Your disaster recovery plan may or may not include guidance on performing restores in non-disaster situations.

> [!TIP]
> Don't confuse *archival*, *replication*, and *backup*. Archival is the storage of data for long-term preservation and read access. Replication is the near-real-time copying of data between replicas to support high availability and certain disaster recovery scenarios. Some requirements, such as data retention laws, may influence your strategies for all three of these concerns. Archival, replication, and backup all require separate analysis and implementation.

## Azure backup and restore capabilities

Azure offers several backup-related services and features for various scenarios, including data in Azure as well as on-premises data. Most Azure services offer some kind of backup functionality. Here, we'll look at a few of the most popular backup-related Azure offerings.

### Azure Backup

Azure Backup is a family of backup products that back up data to Azure Recovery Services vaults for storage and recovery. Recovery Service vaults are storage resources in Azure that are dedicated to holding data and configuration backups for virtual machines, servers, and individual workstations and workloads.

> [!NOTE]
> Both Azure Backup and Azure Site Recovery use Azure Recovery Service vaults for storage. Azure Backup is a general-purpose backup solution. Azure Site Recovery can coordinate replication and failover and support low RPO and RTO disaster recovery operations.

Azure Backup serves as a general-purpose backup solution for cloud and on-premises workflows that run on VMs or physical servers. It's designed to be a drop-in replacement for traditional backup solutions that stores data in Azure instead of archive tapes or other local physical media.

Four different products and services can use Azure Backup to create backups:

* **Azure Backup Agent** is a small Windows application that backs up files, folders, and system state from the Windows VM or server on which it's installed. It works in a way that's similar to many consumer cloud-based backup solutions, but requires configuration of an Azure Recovery vault. Once you download and install it onto a Windows server or VM, you can configure it to create backups up to three times a day.
* **System Center Data Protection Manager** is a robust, fully featured, enterprise-level backup and recovery system. Data Protection Manager is a Windows Server application that can back up filesystems and virtual machines (Windows and Linux), create bare-metal backups of physical servers, and perform application-aware backup of many Microsoft server products, such as SQL Server and Exchange. Data Protection Manager is part of the System Center family of products and is licensed and sold with System Center, but it's considered part of the Azure Backup family because it can store backups in an Azure Recovery vault.
* **Azure Backup Server** is similar to Data Protection Manager, but it's licensed as part of an Azure subscription and doesn't require a System Center license. Azure Backup Server supports the same functionality as Data Protection Manager except for local tape backup and integration with the other System Center products.
* **Azure IaaS VM Backup** is a turnkey backup and restore feature of Azure Virtual Machines. VM backup supports once-per-day backups for Windows and Linux virtual machines. It supports recovery of individual files, full disks, and entire VMs, and can also perform application-consistent backups. Individual applications can be made aware of backup operations and get their filesystem resources into a consistent state before the snapshot is taken.

![An illustration showing an Azure backup agent configured with recovery vault and an Azure virtual machine backup. The backup agent and Azure virtual machine backup saves all the data to the recovery vault.](../media/azure-backup.png)

Azure Backup can add value and contribute to the backup and restore strategy for IaaS and on-premises applications of virtually any size and shape.

### Azure Blob storage

Azure Storage doesn't include an automated backup feature, but blobs are commonly used to back up all kinds of data from various sources. Many services that provide backup capabilities use blobs to store their data, and blobs are a common target for scripts and tools in every kind of backup scenario.

General Purpose v2 storage accounts support three different blob storage tiers of varying performance and cost. **Cool** storage offers the best cost-to-performance ratio for most backups, as opposed to **hot** storage, which offers lower access costs but higher storage costs. **Archive**-tier storage may be appropriate for secondary backups or backups of data with low expectations for recovery time. It's low in cost, but requires up to 15 hours of lead time to access.

Immutable blob storage is configurable to be non-erasable and non-modifiable for a user-specified interval. Immutable blob storage was designed primarily to fulfill strict requirements for certain kinds of data, such as financial data. It's a great option for ensuring that backups are protected against accidental deletion or modification.

### Azure SQL Database

Comprehensive, automatic backup functionality is included with Azure SQL Database at no extra charge. Full backups are created weekly, with differential backups performed every 12 hours, and log backups created every five minutes. Backups created by the service can be used to restore a database to a specific point in time, even if it's been deleted. Restores can be performed using the Azure portal, PowerShell, or the REST API. Backups for databases encrypted with Transparent Data Encryption, enabled by default, are also encrypted.

SQL Database backup is enterprise-grade, production ready, and enabled by default. If you're evaluating different database options for an app, it should be included as part of cost-benefit analysis, as it's a significant benefit of the service. Every app that uses Azure SQL Database should take advantage of it by including it in their disaster recovery plan and backup/restore procedures.

### Azure App Service

Web applications hosted in the Azure App Service Standard and Premium tiers support turnkey scheduled and manual backups. Backups include configuration and file contents as well as contents of databases used by the app. They also support simple filters for excluding files. Restore operations can target different App Service instances, making App Service back up a simple way to move one app's contents to another.

App Service backups are limited to 10 GB total, including app and database content. They're a good solution for new apps under development and small-scale apps. More mature applications won't generally use App Service backup. They will instead rely on robust deployment and rollback procedures, storage strategies that don't use application disk storage, and dedicated backup strategies for databases and persistent storage.

## Verify backups and test restore procedures

No backup system is complete without a strategy for verifying backups and testing restore procedures. Even if you use a dedicated backup service or product, you should still document and practice recovery procedures to ensure that they're well-understood and return the system to the expected state.

Strategies for verifying backups vary and will depend on the nature of your infrastructure. You may want to consider techniques, such as creating a new deployment of the application, restoring the backup to it, and comparing the state of the two instances. In many cases, this technique closely mimics actual disaster recovery procedures. Simply performing a comparison of a subset of the backup data with the live data immediately after creating a backup is enough. A common component of backup verification is attempting to restore old backups to ensure that they're still available and operational, and that the backup system hasn't changed in a way that renders them incompatible.

Any strategy is better than finding out that your backups are corrupted or incomplete while attempting to recover from a disaster.

A backup and restore strategy is an important part of ensuring your architecture can recover from the loss or corruption of data. Review your architecture to define your backup and restore requirements. Azure provides several services and features to provide backup and restore capabilities to any architecture.
