The [Azure Backup](/azure/backup/backup-overview) service uses Azure resources for short-term and long-term storage. Azure Backup minimizes or even eliminates the need for maintaining physical backup media. Examples of backup media are tapes, hard drives, and DVDs.

### What can you do with Azure Backup?


:::image type="content" source="../media/azure-backup-overview.png" alt-text="Azure Backup Service uses on-premises and cloud agents.":::


You can use Azure Backup for these backup types:

- **On-premises.** Azure Backup can back up files, folders, and system state using the Microsoft Azure Recovery Services (MARS) agent. Alternatively, you can use Data Protection Manager (DPM) or the Microsoft Azure Backup Server (MABS) agent to protect on-premises VMs (both Hyper-V and VMware), and other on-premises workloads.

- **Azure VM.** Back up entire Windows or Linux VMs (using backup extensions), or back up files, folders, and system state using the MARS agent.

- **Azure Files shares**. Back up Azure File shares to a storage account.

- **Microsoft SQL Server in Azure VMs**. Back up SQL Server databases running on Azure VMs.

- **SAP HANA databases in Azure VMs**. Back up SAP HANA databases running on Azure VMs.

- **Microsoft cloud**. Azure Backup can replace your existing on-premises or off-site backup solution with a cloud-based solution that's reliable, secure, and cost-competitive.

Azure Backup offers multiple components that you can download and deploy on the appropriate computer, server, or in the cloud. The component (or agent) that you deploy depends on what you want to protect.

### Where is the data backed up?

Azure Backup organizes your backup data in a storage entity called a vault. A storage vault stores backup copies, recovery points, and backup policies.. There are two types of vaults. The primary differences in the vaults are supported data sources and supported Azure products. 

| Capability| Supported data sources| Supported products |
| - | - | - |
| Backup vault| Azure database for PostgreSQL servers<br>Azure blobs<br>Azure disks| Azure Backup |
| Recovery services vault| Azure virtual machines (VMs)<br>SQL in an Azure VM<br>Azure Files<br>SAP HANA in Azure VM<br>Azure Backup Server<br>Azure Backup Agent<br>Data Protection Manager| Azure Backup, Azure Site Recovery |


 

### Considerations for storage vaults

- **Think about how to organize the vaults**. If your workloads are all managed by a single subscription and single resource, then you can use a single vault. If your workloads are spread across subscriptions, then you can create multiple vaults. Use separate vaults for Azure Backup and Azure Site Recovery.

- **Use Azure policy**. If you needed consistent policy across vaults, then you can use Azure Policy to propagate backup policy across multiple vaults. A backup policy is scoped to a vault.

- **Protect using Azure role-based access control (RBAC).** Protect and manage vault access by using Azure RBAC. 

- **Design for Redundancy.** Specify how data in the vault is replicated for redundancy. Use Locally redundant storage (LRS) to protect against failure in a datacenter. LRS replicates data to a storage scale unit. Use Geo-redundant storage (GRS) to protect against region-wide outages. GRS replicates your data to a secondary region.. 
