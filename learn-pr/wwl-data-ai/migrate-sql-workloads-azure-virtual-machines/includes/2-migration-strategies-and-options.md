In the context of SQL Server migration, careful planning is essential to ensure a successful migration. This planning involves addressing both the **how** and the **why** aspects of the migration. 

:::image type="content" border="false" source="../media/2-why-and-how-considerations.png" alt-text="A visual representation of the SQL Server migration process where it emphasizes understanding benefits, utilizing tools, and balancing downtime for a successful migration."::: 

1. Understanding the **why** entails recognizing the benefits after the migration is completed. 
1. The **how** encompasses the selection of appropriate migration tools and the development of a comprehensive migration plan. 
1. A critical element in this process is to evaluate the amount of downtime that the organization is willing to tolerate. Minimizing downtime during the migration process is crucial to maintaining operational efficiency and continuity.

In this migration project, your team has initiated the process with a kick-off meeting. Your role is to explore the tools for migrating a few SQL Servers and provide insights into the potential impact on future SQL licensing costs. Moreover, you need to reach an agreement on the acceptable level of downtime. The project manager also wants to incorporate a test phase, during which a few servers will be migrated for testing before running the full migration.

## Understand the benefits of migration

You've likely worked with virtual machines on your own infrastructure using either Hyper-V, or other vendors virtual machines. As a result, migrating to this platform shouldn't represent you with a steep learning curve.

Using virtual machine (VM) allows you to have the full administrative control over the host operating system and the SQL Server instance. You can configure and manage high availability, disaster recovery, and patching for SQL Server easier than you can on your on-premises machines. You can also set up automatic backups and updates that will ease your overall administrative burden. Running SQL Server on Azure Virtual Machine fully supports these SQL Server components:

- SQL Server transactional replication
- Always On availability groups
- Integration Services
- Analysis Services
- Reporting Services
- Log shipping

SQL Server is optimized for migrating existing SQL Server applications to Azure virtual machines, with up to 256 TB of storage supported. All the versions and editions of SQL Server are available, and they offer 100% compatibility with your on-premises versions of SQL Server.

### Licensing

There are three types of licensing model that can be used for SQL Server virtual machines hosted in Azure. Assess which one is the most appropriate for your migration scenario.

- The **pay-as-you-go (PAYG)** model means that the per-second cost of running the Azure VM includes the cost of the SQL Server license.

- The **bring-your-own-license (BYOL)** model is also known as the Azure Hybrid Benefit (AHB), and it allows you to use your own SQL Server license with a VM running SQL Server, and you only pay for the VM usage. This option is available only for customers who have an Enterprise Agreement.
 
- The **high availability/disaster recovery (HA/DR) license** model is used for the free HA/DR replica in Azure. If you have [Software Assurance](https://www.microsoft.com/licensing/licensing-programs/software-assurance-default?rtc=1&activetab=software-assurance-default-pivot:primaryr3), you can implement hybrid disaster recovery plans with SQL Server without incurring additional licensing costs for the passive disaster recovery instance.

>[!TIP]
> To learn how to change the license model for a SQL virtual machine in Azure, see [Change the license model for a SQL virtual machine in Azure](/azure/azure-sql/virtual-machines/windows/licensing-model-azure-hybrid-benefit-ahb-change)

### Networking

If you provision a SQL Server VM in the Azure portal, you have the option of specifying the type of SQL connectivity, which includes:

- **Public**: Connect to SQL Server over the internet
- **Private**: Connect to SQL Server in the same virtual network
- **Local**: Connect to SQL Server locally on the same virtual machine

If you want to connect to your SQL Server database engine from the Internet, select Public. The portal automatically does the following steps:

- Enables the TCP/IP protocol for SQL Server.
- Configures a firewall rule to open the SQL Server TCP port (default 1433).
- Enables SQL Server Authentication, required for public access.
- Configures the network security group on the VM to all TCP traffic on the SQL Server port.

When you choose Private for the SQL connectivity type in the portal, Azure configures most of the settings identical to Public. The difference is that there's no network security group rule to allow outside traffic on the SQL Server port (default 1433). You can change the connectivity settings for your SQL virtual machine in the Azure portal.

### Key management

SQL Server provides encryption features that require you to manage and store the cryptographic keys. The Azure Key Vault (AKV) service is designed to improve the security and management of these keys in a secure and highly available location. The SQL Server Connector enables SQL Server to use these keys from Azure Key Vault.

You can save time by using the AKV integration feature. When this feature is enabled, it automatically installs the SQL Server Connector. The feature then configures the Extensible Key Management (EKM) provider to access the AKV, and creates the credentials to allow you to access your vault.

### Virtual machine sizing

To get started, you can choose a SQL Server virtual machine image with your required version, edition, and operating system. SQL Server 2008 R2 SP3 is the earliest supported version, and you can configure the number of CPUs and memory to the size that is appropriate for your workloads.

Many of the database performance tuning options you use to ensure your SQL Server performs well for your on-premises workloads still apply to SQL Server running on an Azure VM. There are other considerations that you need to be mindful of including the size of VM and the configuration of the disks. Use the following checklist as a guide to ensure you have the optimal performance set up for a SQL Server running on Azure Virtual Machine.

| Performance metric | Optimization option |
| - | - |
| Virtual machine    | <ul><li>The minimum virtual machine size that should be selected for Enterprise editions of SQL Server is **DS3_v2** or higher</li><li>For standard or web edition, use **DS2_v2** as a minimum size</li></ul> |
| Storage            | <ul><li>Use **premium SSDs** for production workloads</li><li>**Standard** storage for dev/test environment</li><li>Make sure that the storage is colocated in the **same location** as the virtual machine</li></ul> |
| Disks              | <ul><li>Use a minimum of **2 P30 disks** (1 for log files and 1 for data files including TempDB) </li><li>For workloads requiring **~50,000 IOPS**, consider using an Ultra SSD</li><li>Avoid using operating system or temporary disks for database storage or logging</li><li>**Enable read caching** on the disk(s) hosting the data files and TempDB data files</li><li>**Don't enable caching** on disk(s) hosting the log file</li><li>**Stripe** multiple Azure data disks to get increased IO throughput</li><li>**Format** with documented allocation sizes</li><li>Place **TempDB on local SSD** for mission critical SQL Server workloads (after choosing correct VM size)</li></ul> |
| I/O                | <ul><li>**Enable database page compression**</li><li>**Enable instant file initialization** for data files</li><li>**Limit autogrowth** of the database</li><li>**Disable autoshrink** of the database</li><li>Move all databases to data disks, including system databases</li><li>**Move SQL Server error log and trace file** directories to data disks</li><li>**Setup default backup** and **database file** locations</li><li>**Enable locked pages**</li><li>**Apply SQL Server performance fixes**</li></ul> |

There may be specific performance setting that you want to apply that are specific to your workload. Make sure that the settings are tested in a test environment before the migration.

## Tools and features to support your migration

There are many different ways that you can migrate your SQL Server to an Azure Virtual Machine. The first step in the process is to provision an Azure VM that has SQL Server installed. 

You get the best data transfer performance by migrating the database files to the Azure VM using a compressed backup file.

To minimize downtime during the database migration process, use either the Always On option or the transactional replication option. If it's not possible to use any of the above methods, you still can manually migrate your database.

These are the main tools and features to support and migrate your SQL Server databases to SQL Server running on an Azure Virtual Machine.

- **[Azure SQL Migration extension for Azure Data Studio](/sql/azure-data-studio/extensions/azure-sql-migration-extension)**
    The Azure SQL Migration extension helps in assessing your migration readiness, providing appropriate SKU recommendations for Azure resources, and facilitating the migration of your SQL Server database to Azure and is ideal for small to medium-sized databases. It's powered by the latest version of Data Migration Services, and also provides an advanced assessment feature that evaluates SQL Server databases that are ready for migration to Azure SQL.

- **[Backup and restore with Azure Blob Storage](/sql/relational-databases/backup-restore/sql-server-backup-and-restore-with-microsoft-azure-blob-storage-service)**
    You can restore a database from Azure Blob Storage to your SQL Server running on an Azure Virtual Machine.

- **[Detach and attach from a URL](/sql/relational-databases/databases/database-detach-and-attach-sql-server)**
    Detach your database and log files and transfer them to an Azure Storage account. Then attach the database from the blob URL on your Azure Virtual Machine.
- 
- **[Log shipping](/sql/database-engine/log-shipping/about-log-shipping-sql-server)**
    Log shipping is a method to migrate a SQL Server database to an Azure VM. It involves continuously synchronizing a secondary copy of the database on the destination server using transaction log backups from the source server. When ready, the final log backup is applied to the Azure VM, enabling a seamless migration with minimal downtime.

- **[Azure Migrate](/azure/migrate/migrate-services-overview)**
    Azure Migrate is a comprehensive migration service that supports a wide range of migration scenarios, including SQL Server migration. Azure Migrate provides a suite of tools designed for assessment and migration of on-premises servers, infrastructure, applications, and data at scale, with the purpose of migrating them to Azure. 

- **[Data Migration Assistant (DMA)](/sql/dma/dma-overview)**
   Use the Data Migration Assistant to migrate database schema, data, users, server roles, SQL Server and Windows logins from an on-premises SQL Server to a SQL Server on Azure Virtual Machine. The tool will first run an assessment that prompts you to address any compatibility issues. You can then use the same tool to migrate the assessed database schema and data to Azure.

- **[Database Experimentation Assistant (DEA)](/sql/dea/database-experimentation-assistant-overview)**
   Use the Database Experimentation Assistant to assess if your target server can handle the workload if you have concerns about performance. You can use the analysis metrics to give comparison data to allow you to decide on whether the targeted version would provide a better experience after the migration.

> [!TIP]
> To learn how to assess on-premises SQL Server instance(s) to migrate to Azure SQL or discover new features in the target SQL Server platform that the database can benefit from after an upgrade, see [Assess SQL Server databases for migration to Azure SQL module](/training/modules/assess-sql-server-databases-for-migration-to-azure-sql/).

## Define your migration approach

It's important to consider the business downtime requirements associated with the migration. Whether you migrate to SQL Server in a virtual machine, or to an Azure SQL Database.

The method chosen to migrate the database is typically dependent on how much time the SQL Server databases can be offline. Another factor in your decision might be how much of the process you would like to automate, versus doing the migration manually. There are three types of migrations based on downtime:

- Zero downtime migration
- Small maintenance window migration
- Large maintenance window migration

### Zero downtime migration

Zero downtime migrations are normally required by mission critical workloads. You can use Always On availability groups to replicate data from a SQL Server database to SQL Server on Azure Virtual Machine.

### Small maintenance window migration

Small maintenance windows are often measured in minutes. Use the Azure SQL migration extension for Azure Data Studio or the Data Migration Assistant (DMA) to replicate and migrate data from an on-premises SQL Server database to a SQL Server running on Azure Virtual Machine.

> [!NOTE]  
> To migrate an entire application, consider using [Azure Site Recovery](/azure/site-recovery/site-recovery-overview).

### Large maintenance window migration

Large maintenance windows are often measured in hours or days, and are suitable for application databases that change infrequently, or where the workload isn't
critical to the business. You have several options from using SQL Server Management Studio BACPAC export and import files, use a backup and restore approach, or
detach and then attach the database.
