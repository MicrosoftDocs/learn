Azure Backup is a suite of components that make it easy to back up machines and workloads in Azure or on-premises. Azure Backup also enables workloads like SQL Server or SharePoint to have additional backup and restore options.

To address your company's business continuity and disaster recovery (BCDR) plan, there must be a full backup and restore capability for all of your high risk servers. You've been asked to enable and test back up and restore functionality for these critical Windows and Linux assets.

In this unit, you'll look at how Azure Backup works, and study some of the supported use cases for Azure Backup.

## What is Azure Backup?

Azure Backup provides cloud-based backup and restore services for both Azure and on-premises virtual machines. Data, workloads, and machine state can all be backed up automatically at a granular level. Azure Backup offers integration with Microsoft-specific applications such as SQL Server, SharePoint, and Exchange. In contrast to traditional backup solutions that can take considerable effort to set up, Azure Backup is easily managed through the Azure portal, and backups are stored in an Azure Recovery Services vault after you set up the appropriate component on the target machine.

### Azure Backup versus Azure Site Recovery

Both Azure Backup and Azure Site Recovery are services that provide system recovery, but they have their differences.

- **Azure Site Recovery** - replicates virtual machine workloads to secondary locations for failover if a disaster that affects a whole site.
- **Azure Backup** - recovers data more granularly. For example, virtual machine disks, or files and folders that have become corrupted or accidentally deleted by users.

### Why use Azure Backup?

Traditional backup solutions, such as disk and tape, do not offer the highest level of integration with cloud-based solutions. Azure Backup has several benefits over more traditional backup solutions:

- **Automatic storage management** - The ability to maintain a fully Azure-based backup solution, or a heterogeneous solution where data is backed up and stored both on-premises and in Azure. Using on-premises storage devices are free, and storing within Azure uses a pay-as-you-go model.

- **High availability** - Being cloud-based means that the backup service is redundant and highly available by nature. The service doesn't need to be maintained, upgraded, or patched as a traditional solution would be.

- **Unlimited data transfer** - Allows unlimited inbound and outbound backup traffic to your Azure subscription.

- **Data security** - Using AES256 bit encryption for on-premises virtual machines and Storage Service Encryption (SSE) for Azure virtual machines. Data is secured at rest on the Azure platform, and then decrypted when accessed by an authorized person or service.

- **No limit retention times** -Long and short-term options are available to keep your data depending on your data retention policy.

- **Highly available storage** - There are two types of storage for ensuring data is always available:
  - Locally Redundant (LRS) - replicates data three times within the same region
  - Geo-redundant storage (GRS) - Replicates data to another region within the geography. This is the default, and it is the most recommended option as it uses LRS in a primary and a secondary region.

### Azure Backup types

Azure Backup supports different backup scenarios, from backing up Azure virtual machines to on-premises machines. Differing scenarios require different backup types and different agents to make the backup happen.

| Location | OS | Environment | Level | Notes |
|:---|:---:|:---:|:---|:---|
| On-premises | Windows | Virtual | Files, folders, volumes, system state, an app data | Using DPM or MABS, app-aware snapshots supported |
| On-premises | Windows | Physical | Files, folders, volumes, system state, an app data | Using DPM or MABS, app-aware snapshots supported |
| On-premises | Windows | Both | Direct back up of files, folders, system state | Use MARS agent. NOT an app-aware backup |
| On-premises | Linux | Virtual | Direct back up of files | Not supported with MARS |
| On-premises | Linux | Physical | Direct back up of files | Not supported with MARS |
| On-premises | Linux | Virtual | Files, folders, volumes, system state, an app data | Using DPM or MABS, app-aware snapshots supported |
| On-premises | Linux | Physical | Files, folders, volumes, system state, an app data | Not supported |
| Azure | Windows | Virtual | Entire virtual machine | Uses Azure Backup virtual machine extension, provides app-aware backups |
| Azure | Windows | Virtual | Files, folders, and system state | Uses virtual machine extension and MARS, provides app-aware backups |
| Azure | Linux | Virtual | Entire virtual machine | Uses Azure Backup virtual machine extension, provides file-consistent backups |
| Azure | Linux | Virtual | Files, folders, volumes, system state, an app data | Uses DPM or MARS, provides app-aware snapshots |

- *DPM* = System Center Data Protection Manager
- *MABS* = Microsoft Azure Backup Server
- *MARS* = Microsoft Azure Recovery Services

### SQL Server backups

If you need to back up SQL Server workloads, there are additional options available. Azure Backup can install a workload backup extension on a Windows SQL Server to support the following additional options:

- **Full** - Backs up the entire database and file groups, it also contains enough logs to do a restore. Transaction logs hold records of the most recent additions or removals of records in the database, recent transaction logs are needed to perform an up-to-date restore of a database.
- **Differential** - Based on the last full backup that was performed, and captures only blocks of data that has changed since the last full backup.
- **Transaction Log** - Allows a point in time restoration of a database.

SQL Server on Linux does not currently integrate with Azure Backup.