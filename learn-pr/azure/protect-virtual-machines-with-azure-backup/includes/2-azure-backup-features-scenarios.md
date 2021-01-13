
To address your company's business continuity and disaster recovery (BCDR) plan, there must be a full backup and restore capability for all of your high-risk servers. You've been asked to enable and test backup and restore functionality for these critical Windows and Linux assets.

In this unit, you'll look at how Azure Backup works, and study some of the supported use cases for Azure Backup.

## What is Azure Backup?

Azure Backup is a built-in Azure service that provides secure backup for all Azure-managed data assets. It uses zero-infrastructure solutions to enable self-service backups and restores, with at-scale management at a lower and predictable cost. At present, Azure Backup offers specialized backup solutions for Azure and on-premises virtual machines. Azure Backup also enables workloads like SQL Server or SAP HANA running in Azure VMs to have enterprise-class backup and restore options.

In contrast to traditional backup solutions that can take considerable effort to set up, Azure Backup is easily managed through the Azure portal.

### Azure Backup versus Azure Site Recovery

Both Backup and Site Recovery aim to make the system more resilient to faults and failures. However, while the primary goal of backup is to maintain copies of stateful data that allow you to go back in time, site-recovery replicates the data in almost real time and allows for a failover.

In that sense, if there are issues like network or power outages, you can use availability zones. For a region-wide disaster (such as natural disasters), Site Recovery is used. Backups are used in cases of accidental data loss, data corruption, or ransomware attacks.

Additionally, the choice of a recovery approach depends on the criticality of the application, RPO and RTO requirements, and the cost implications.

### Why use Azure Backup?

Traditional backup solutions, such as disk and tape, don't offer the highest level of integration with cloud-based solutions. Azure Backup has several benefits over more traditional backup solutions:

**Zero-infrastructure backup**: Azure Backup eliminates the need to deploy and manage any backup infrastructure or storage. This means there's no overhead in maintaining backup servers or scaling the storage up or down as the needs vary.  

**Long-term retention**:  Meet rigorous compliance and audit needs by retaining backups for many years, beyond which the recovery points will be pruned automatically by the built-in lifecycle management capability.

**Security**: Azure Backup provides security to your backup environment - both when your data is in transit and at rest.  

- **Azure role-based access control**: RBAC allows you to segregate duties within your team and grant only the amount of access to users necessary to do their jobs.

- **Encryption of backups**: Backup data is automatically encrypted using Microsoft-managed keys. Alternatively, you can also encrypt your backed-up data using customer-managed keys stored in the Azure Key Vault.  

- **No internet connectivity required**: When using Azure VMs, all the data transfer happens only on the Azure backbone network without needing to access your virtual network. So no access to any IPs or FQDNs is required.

- **Soft delete**: With soft delete, the backup data is retained for 14 additional days even after the deletion of the backup item. This protects against accidental deletion or malicious deletion scenarios, allowing the recovery of those backups with no data loss.

Azure Backup also offers the ability to back up virtual machines encrypted with Azure Disk Encryption.

**High availability**: Azure Backup offers three types of replication - LRS, GRS, and RA-GRS (to enable customer-controlled cross region restore) to keep your backup data highly available.

**Centralized monitoring and management**: Azure Backup provides built-in monitoring and alerting capabilities in a Recovery Services vault. These capabilities are available without any additional management infrastructure.  

### Azure Backup supported scenarios

- **Azure VMs** - Back up Windows or Linux Azure virtual machines<br> Azure Backup provides independent and isolated backups to guard against unintended destruction of the data on your VMs. Backups are stored in a Recovery Services vault with built-in management of recovery points. Configuration and scaling are simple, backups are optimized, and you can easily restore as needed.
- **On-premises** - Back up files, folders, and system state using the [Microsoft Azure Recovery Services (MARS) agent](https://docs.microsoft.com/azure/backup/backup-support-matrix-mars-agent?azure-portal=true). Or use [Microsoft Azure Backup Server (MABS)](https://docs.microsoft.com/en-us/azure/backup/backup-support-matrix-mabs-dpm) or [Data Protection Manager (DPM) server](https://docs.microsoft.com/en-us/azure/backup/backup-support-matrix-mabs-dpm) to protect on-premises VMs (Hyper-V and VMWare) and other on-premises workloads.
- **Azure Files shares** - Azure Files - Snapshot management by Azure Backup
- **SQL Server in Azure VMs** and **SAP HANA databases in Azure VMs** - Azure Backup offers stream-based, specialized solutions to back up SQL Server or SAP HANA running in Azure VMs. These solutions take workload-aware backups that support different backup types such as full, differential and log, 15-minute RPO, and point-in-time recovery.
