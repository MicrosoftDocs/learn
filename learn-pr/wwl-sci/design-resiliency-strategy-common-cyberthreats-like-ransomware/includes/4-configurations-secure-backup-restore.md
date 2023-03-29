Azure Backup backs up the data, machine state, and workloads running on on-premises machines and Azure virtual machine (VM) instances. There are a number of Azure Backup scenarios.

## How does Azure Backup work?

![Diagram showing the general architecture of Azure Backup.](../media/azure-backup-overview.png)

You can back up machines and data by using a number of methods:

- **Back up on-premises machines**:
  - You can back up on-premises Windows machines directly to Azure by using the Azure Backup Microsoft Azure Recovery Services (MARS) agent. Linux machines aren't supported.
  - You can back up on-premises machines to a backup server - either System Center Data Protection Manager (DPM) or Microsoft Azure Backup Server (MABS). You can then back up the backup server to a Recovery Services vault in Azure.

- **Back up Azure VMs**:
  - You can back up Azure VMs directly. Azure Backup installs a backup extension to the Azure VM agent that's running on the VM. This extension backs up the entire VM.
  - You can back up specific files and folders on the Azure VM by running the MARS agent.
  - You can back up Azure VMs to the MABS that's running in Azure, and you can then back up the MABS to a Recovery Services vault.

![Diagram showing backup architecture for Azure VMs.](../media/backup-architecture.png)

## Hybrid backup supported options

![Diagram showing backup architecture for on-premises machines.](../media/architecture-on-premises.png)

Here's what's supported if you want to back up on-premises machines:

**Machine** | **What's backed up** | **Location** | **Features**
--- | --- | --- | ---
**Direct backup of Windows machine with MARS agent** | - Files, folders <br><br> - System state | Back up to Recovery Services vault. | - Back up three times a day<br/><br/> - Back up once a day. <br><br> No app-aware backup<br/><br/> Restore file, folder, volume
**Direct backup of Linux machine with MARS agent** | Backup not supported
**Back up to DPM** | Files, folders, volumes, system state, app data | Back up to local DPM storage. DPM then backs up to vault. | App-aware snapshots<br/><br/> Full granularity for backup and recovery<br/><br/> Linux supported for VMs (Hyper-V/VMware)<br/><br/> Oracle not supported
**Back up to MABS** | Files, folders, volumes, system state, app data | Back up to MABS local storage. MABS then backs up to the vault. | App-aware snapshots<br/><br/> Full granularity for backup and recovery<br/><br/> Linux supported for VMs (Hyper-V/VMware)<br/><br/> Oracle not supported

## Where is data backed up?

Azure Backup stores backed-up data in vaults - Recovery Services vaults and Backup vaults. A vault is an online-storage entity in Azure that's used to hold data, such as backup copies, recovery points, and backup policies.

Vaults have the following features:

- Vaults make it easy to organize your backup data, while minimizing management overhead.
- You can monitor backed-up items in a vault, including Azure VMs and on-premises machines.
- You can manage vault access with Azure role-based access control (Azure RBAC).
- You specify how data in the vault is replicated for redundancy:
  - **Locally redundant storage (LRS)**: To protect your data against server rack and drive failures, you can use LRS. LRS replicates your data three times within a single data center in the primary region. LRS provides at least 99.999999999% (11 nines) durability of objects over a given year.
  - **Geo-redundant storage (GRS)**: To protect against region-wide outages, you can use GRS. GRS replicates your data to a secondary region. 
  - **Zone-redundant storage (ZRS)**: replicates your data in availability zones, guaranteeing data residency and resiliency in the same region.
  - By default, Recovery Services vaults use GRS.

Recovery Services vaults have the following additional features:

- In each Azure subscription, you can create up to 500 vaults.

## Backup agents

Azure Backup provides different backup agents, depending on what type of machine is being backed up:

**Agent** | **Details**
--- | ---
**MARS agent** | <ul><li>Runs on individual on-premises Windows Server machines to back up files, folders, and the system state.</li> <li>Runs on Azure VMs to back up files, folders, and the system state.</li> <li>Runs on DPM/MABS servers to back up the DPM/MABS local storage disk to Azure.</li></ul>
**Azure VM extension** | Runs on Azure VMs to back them up to a vault.

## Backup types

The following table explains the different types of backups and when they're used:

**Backup type** | **Details** | **Usage**
--- | --- | ---
**Full** | A full backup contains the entire data source. Takes more network bandwidth than differential or incremental backups. | Used for initial backup.
**Differential** |  A differential backup stores the blocks that changed since the initial full backup. Uses a smaller amount of network and storage, and doesn't keep redundant copies of unchanged data.<br/><br/> Inefficient because data blocks that are unchanged between later backups are transferred and stored. | Not used by Azure Backup.
**Incremental** | An incremental backup stores only the blocks of data that changed since the previous backup. High storage and network efficiency. <br/><br/> With incremental backup, there's no need to supplement with full backups. | Used by DPM/MABS for disk backups, and used in all backups to Azure. Not used for SQL Server backup.

## Advanced backup configuration details

To help you protect your backup data and meet the security needs of your business, Azure Backup provides confidentiality, integrity, and availability assurances against deliberate attacks and abuse of your valuable data and systems. Consider the following security guidelines for your Azure Backup solution:

### Authentication and authorization using Azure role-based access control (Azure RBAC)

- Azure role-based access control (Azure RBAC) enables fine-grained access management, segregation of  duties within your team and granting only the amount of access to users necessary to perform their jobs.

- If you’ve multiple workloads to back up (such as Azure VMs, SQL databases, and PostgreSQL databases) and you've multiple stakeholders to manage those backups, it is important to segregate their responsibilities so that user has access to only those resources they’re responsible for. Azure role-based access control (Azure RBAC) enables granular access management, segregation of duties within your team, and granting only the types of access to users necessary to perform their jobs.

- You can also segregate the duties by providing minimum required access to perform a particular task. For example, a person responsible for monitoring the workloads shouldn't have access to modify the backup policy or delete the backup items. Azure Backup provides three built-in roles to control backup management operations: Backup contributors, operators, and readers. Learn more here..

- Azure role-based access control (Azure RBAC) also provides the flexibility to build Custom Roles based on your individual requirements. If you’re unsure about the types of roles recommended for specific operation, you can utilize the built-in roles provided by Azure role-based access control (Azure RBAC) and get started.

  The following diagram explains about how different Azure built-in roles work:

    ![Diagram explains about how different Azure built-in roles work.](../media/different-azure-built-in-roles-actions.png)

  - In the above diagram, _User2_ and _User3_ are Backup Readers. Therefore, they have the permission to only monitor the backups and view the backup services.

  - In terms of the scope of the access,

    - _User2_ can access only the Resources of Subscription1, and User3 can access only the Resources of Subscription2. 
    - _User4_ is a Backup Operator. It has the permission to enable backup, trigger on-demand backup, trigger restores, along with the capabilities of a Backup Reader. However, in this scenario, its scope is limited only to Subscription2. 
    - _User1_ is a Backup Contributor. It has the permission to create vaults, create/modify/delete backup policies, and stop backups, along with the capabilities of a Backup Operator. However, in this scenario, its scope is limited only to _Subscription1_.

- Storage accounts used by Recovery Services vaults are isolated and can't be accessed by users for any malicious purposes. The access is only allowed through Azure Backup management operations, such as restore.
