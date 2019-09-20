Azure Backup is a suite of components that make it easy to back up machines and workloads in Azure or on-premises. Azure Backup also enables workloads like SQL Server or SharePoint to have additional backup and restore options.

To address your company's business continuity and disaster recovery (BCDR) plan, there must be a full backup and restore capability for all of your high-risk servers. You've been asked to enable and test backup and restore functionality for these critical Windows and Linux assets.

In this unit, you'll look at how Azure Backup works, and study some of the supported use cases for Azure Backup.

## What is Azure Backup?

Azure Backup provides cloud-based backup and restore services for both Azure and on-premises virtual machines. Data, workloads, and machine state can all be backed up automatically at a granular level. Azure Backup offers integration with Microsoft-specific applications such as SQL Server, SharePoint, and Exchange. 

In contrast to traditional backup solutions that can take considerable effort to set up, Azure Backup is easily managed through the Azure portal. Backups are stored in an Azure Recovery Services vault after you set up the appropriate component on the target machine.

### Azure Backup versus Azure Site Recovery

The Azure Backup and Azure Site Recovery services both provide system recovery, but they have their differences:

- **Azure Site Recovery**: Replicates virtual machine workloads to secondary locations for failover if a disaster affects a whole site.
- **Azure Backup**: Recovers data more granularly. For example, it recovers virtual machine disks, or files and folders that became corrupted or were accidentally deleted by users.

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

### Azure Backup types

Azure Backup supports several backup scenarios, for both virtual machines and on-premises machines. Each scenario requires a combination of backup type and agent to make the backup happen.

| Location | OS | Environment | Level | Notes |
|:---|:---:|:---:|:---|:---|
| On-premises | Windows | Virtual | Files, folders, volumes, system state, and app data | Uses System Center Data Protection Manager (DPM) or Microsoft Azure Backup Server (MABS). This scenario supports app-aware snapshots. |
| On-premises | Windows | Physical | Files, folders, volumes, system state, and app data | Uses DPM or MABS. This scenario supports app-aware snapshots. |
| On-premises | Windows | Both | Direct backup of files, folders, and system state | Uses the Microsoft Azure Recovery Services (MARS) agent. This is *not* an app-aware backup. |
| On-premises | Linux | Virtual | Direct backup of files | Not supported with MARS. |
| On-premises | Linux | Physical | Direct backup of files | Not supported with MARS. |
| On-premises | Linux | Virtual | Files, folders, volumes, system state, and app data | Uses DPM or MABS. This scenario supports app-aware snapshots. |
| On-premises | Linux | Physical | Files, folders, volumes, system state, and app data | Not supported. |
| Azure | Windows | Virtual | Entire virtual machine | Uses the Azure Backup virtual machine extension. This scenario provides app-aware backups. |
| Azure | Windows | Virtual | Files, folders, and system state | Uses the virtual machine extension and MARS. This scenario provides app-aware backups. |
| Azure | Linux | Virtual | Entire virtual machine | Uses the Azure Backup virtual machine extension. This scenario provides file-consistent backups. |
| Azure | Linux | Virtual | Files, folders, volumes, system state, and app data | Uses DPM or MARS. This scenario provides app-aware snapshots. |

### SQL Server backups

If you need to back up SQL Server workloads, other options are available. Azure Backup can install a workload backup extension on a SQL Server instance on Windows to support the following options:

- **Full**: Backs up the entire database and file groups. It also contains enough logs to do a restore. Transaction logs hold records of the most recent additions or removals of records in the database. Recent transaction logs are needed to perform an up-to-date restore of a database.
- **Differential**: Based on the last full backup that was performed, and captures only blocks of data that changed since the last full backup.
- **Transaction log**: Allows a point-in-time restoration of a database.

SQL Server on Linux does not currently integrate with Azure Backup.
