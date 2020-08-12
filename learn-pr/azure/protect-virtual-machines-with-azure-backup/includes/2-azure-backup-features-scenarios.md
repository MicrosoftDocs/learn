
To address your company's business continuity and disaster recovery (BCDR) plan, there must be a full backup and restore capability for all of your high-risk servers. You've been asked to enable and test backup and restore functionality for these critical Windows and Linux assets.

In this unit, you'll look at how Azure Backup works, and study some of the supported use cases for Azure Backup.

## What is Azure Backup?

Azure Backup is a built-in Azure service which provides secure backup for all Azure-managed data assets, using zero-infrastructure solutions to enable self-service backups and restores, with at-scale management at a lower and predictable cost. At present, Azure Backup offers specialized backup solutions for Azure and on-premises virtual machines. Azure Backup also enables workloads like SQL Server or SAP HANA running in Azure VMs to have enterprise-class backup and restore options.

In contrast to traditional backup solutions that can take considerable effort to set up, Azure Backup is easily managed through the Azure portal.

### Azure Backup versus Azure Site Recovery

Both backup and site recovery aim to make the system more resilient to faults and failures. However, while the primary objective of backup is to maintain copies of stateful data that allow you to go back in time, site-recovery replicates the data in almost real-time and allows for a failover.

In that sense, if there are issues like network or power outages, one can use availability zones. For a region-wide disaster (such as natural disasters), site recovery is used. Backups are used in case of accidental data loss, data corruption or ransomware attacks.

Additionally, the choice of a recovery approach depends on the criticality of the application, RPO and RTO requirements, as well as the cost implications.

### Why use Azure Backup?

Traditional backup solutions, such as disk and tape, don't offer the highest level of integration with cloud-based solutions. Azure Backup has several benefits over more traditional backup solutions:

- **Automatic storage management**: You can maintain a fully Azure-based backup solution, or a heterogeneous solution where data is backed up and stored both on-premises and in Azure. Using on-premises storage devices is free, and storing within Azure uses a pay-as-you-go model.

- **High availability**: Because the service is cloud based, it's redundant and highly available by nature. The service doesn't need to be maintained, upgraded, or patched as a traditional solution would be.

- **Unlimited data transfer**: Inbound and outbound backup traffic to your Azure subscription is unlimited.

- **Data security**: The service uses AES 256-bit encryption for on-premises virtual machines and Storage Service Encryption for Azure virtual machines. Data is secured at rest on the Azure platform, and then decrypted when an authorized person or service accesses it.

- **No-limit retention times**: Long-term and short-term options are available to keep your data, depending on your data retention policy.

- **Highly available storage**: Two types of storage help ensure that data is always available:
  - Locally redundant storage (LRS): Replicates data three times within the same region.
  - Geo-redundant storage (GRS): Replicates data to another region within the geography. This is the default. We recommend this option in most cases, because it uses LRS in a primary region and a secondary region.

### Azure Backup supported scenarios

- **Azure VMs** - [Back up Windows or Linux Azure virtual machines](https://docs.microsoft.com/azure/backup/backup-azure-vms-introduction)<br> Azure Backup provides independent and isolated backups to guard against un-intended destruction of the data on your VMs. Backups are stored in a Recovery Services vault with built-in management of recovery points. Configuration and scaling are simple, backups are optimized, and you can easily restore as needed.
- **On-premises** - Back up files, folders, and system state using the [Microsoft Azure Recovery Services (MARS) agent](https://docs.microsoft.com/azure/backup/backup-support-matrix-mars-agent). Or use [Azure Backup Server (MABS)](https://docs.microsoft.com/azure/backup/backup-mabs-protection-matrix) or [DPM](https://docs.microsoft.com/azure/backup/backup-azure-dpm-introduction) server to protect on-premises VMs (Hyper-V and VMWare) and other on-premises workloads.
- **Azure Files shares** - [Azure Files - Snapshot management by Azure Backup](https://docs.microsoft.com/azure/backup/backup-afs)
- **SQL Server in Azure VMs** - [Back up SQL Server databases running on Azure VMs](https://docs.microsoft.com/azure/backup/backup-azure-sql-database)
- **SAP HANA databases in Azure VMs** - [Backup SAP HANA databases running on Azure VMs](https://docs.microsoft.com/azure/backup/backup-azure-sap-hana-database)

[Azure Backup](https://docs.microsoft.com/azure/backup/backup-overview) offers stream-based, specialized solutions to back up SQL Server or SAP HANA running in Azure VMs. These solutions take workload-aware backups that support different backup types such as full, differential and log, 15-minute RPO, and point-in-time recovery.
