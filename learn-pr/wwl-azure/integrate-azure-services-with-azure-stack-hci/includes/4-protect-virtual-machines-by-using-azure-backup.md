As part of the initiative to modernize and streamline its operational and business continuity capabilities, Contoso has reviewed its current backup strategy. The review has revealed many inefficiencies, including a significant overhead involved in managing backup tapes and insufficient data protection provisions. You want to determine if these inefficiencies can be eliminated by using Azure Backup to protect Azure Stack HCI workloads. Before you use Azure Backup, you want to learn about its features.

## Overview of Azure Backup

Azure Backup is a cloud-based backup service that protects on-premises and cloud workloads. For on-premises scenarios, Azure Backup offers the following backup options:

- **File-consistent backup of local files, folders, volumes, and system state**. File-consistent backup uses the Microsoft Azure Recovery Services (MARS) agent. This approach is suitable on any Windows 64-bit operating system. Backups are uploaded directly to Azure.
- **File- and application-consistent backup**. File- and application-consistent backup allows for backing up a wide range of workloads running on Windows and Linux servers by using Microsoft Azure Backup Server (MABS) or Microsoft System Center Data Protection Manager and their agents. MABS and Data Protection Manager rely on the MARS agent to upload its backups to Azure for long-term storage.

The MARS agent supports manual and scheduled backups with up to three scheduled backups per day. The initial full backup is followed by incremental ones, capturing delta changes to the protected content of local disks. 

In addition, Azure Backup offers enhanced protection of backups stored in Azure, including:

- Soft delete, which is enabled by default and retains deleted backups for 14 days.
- The ability to set a custom PIN, which is required to stop protection and delete backup data.
- Administrative email alerts triggered by such events as disabling or deleting backups.
- Automatic replication of backups to another Azure region.
- Practically unlimited (99 years) data retention period.

By implementing Azure Backup at Contoso, you can minimize or even eliminate the need for maintaining physical backup media such as tapes. 

## Azure Backup components

Azure Backup uses agents installed either directly on protected servers, or in case of MABS and Data Protection Manager, on servers performing remote backups. The agents manage upload of local backup files when performing backups and their download during restores. Just like Azure Site Recovery, an Azure Recovery Services vault provides and manages cloud-based storage and serves as the primary configuration interface for setting up and managing backups and restores. 

:::image type="content" source="../media/architecture-3.png" alt-text="The diagram depicts how Azure Stack HCI relies on the Microsoft Azure Recovery Services (MARS) agent installed directly on protected VMs to manage backup operations and transfer backup data during backups and restores. An Azure Recovery Services vault provides and manages cloud-based storage and serves as the primary configuration interface for setting up and managing backups and restores. The vault supports automatic replication of backups to another Azure region." border="false":::

Backup and restore operations are always initiated outbound to Azure, which eliminates the need for opening any inbound ports at the edge of the internal network.

## Azure Backup support for Azure Stack HCI

You can install the MARS agent directly on Windows Server VMs that run on an Azure Stack HCI cluster and use file-consistent backups to protect their volumes and system state. At Contoso, this is suitable for workloads such as Internet Information Services (IIS) servers or Active Directory Domain Services (AD DS) domain controllers. It is also a viable option for file servers. However, for file servers, to fully benefit from Azure hybrid capabilities, you might want to use Azure File Sync instead.

> [!NOTE]
> As of March 2021, Azure Backup does not yet support MABS for backup of Azure Stack HCI VMs.

## Onboarding Azure Stack HCI to Azure Backup

As the next step in evaluating Azure Backup to eliminate inefficiencies, you decide to onboard an Azure Stack HCI cluster to Azure Backup. To do this, you can use Windows Admin Center, which offers the option to automatically provision all required Azure components, including the target Azure Recovery Services vault, and install the MARS agent on the protected VMs. Windows Admin Center assigns a default backup schedule and retention period, gives you the option to back up system state and individual volumes, and prompts you to specify an encryption passphrase.

:::image type="content" source="../media/wac-enable-backup-steps.png" alt-text="The screenshot depicts how Windows Admin Center automatically provisions all required Azure components, including the target Azure Recovery Services vault, and installs the MARS agent on the protected VMs. Windows Admin Center assigns a default backup schedule and retention period, gives you the option to back up system state and individual volumes, and prompts you to specify an encryption passphrase." border="false":::

Windows Admin Center also allows you to identify the backup status, trigger on-demand backups following the initial scheduled backup, track backup jobs, and view recovery points and recover data. To modify the backup configuration, including the backup scope, schedule, retention period, and encryption passphrase, you can use the Azure Backup application installed locally on protected servers or Azure PowerShell. The Azure Recovery Services vault interface in the Azure portal allows you to set up backup-related alert notifications and provides a single view for inventory of all protected servers.

:::image type="content" source="../media/wac-backup-configured.png" alt-text="The screenshot depicts how you can use Windows Admin Center to review the backup status, trigger on-demand backups following the initial scheduled backup, track backup jobs, as well as view recovery points and recover data." border="false":::

---


---