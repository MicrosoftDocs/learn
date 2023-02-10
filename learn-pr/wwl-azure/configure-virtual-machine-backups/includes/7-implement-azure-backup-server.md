Another option for backing up your virtual machines is to use System Center Data Protection Manager (DPM) or Microsoft Azure Backup Server (MABS). You can use these services to back up specialized workloads, virtual machines, or files, folders, and volumes. Specialized workloads can include data from Microsoft SharePoint, Microsoft Exchange, and SQL Server.

:::image type="content" source="../media/system-center-76153528.png" alt-text="Illustration that shows workloads, virtual machines, and files being backed up to Azure by using System Center DPM or MABS." border="false":::

You can back up your virtual machines and applications to System Center DPM or MABS storage, and then back up the DPM or MABS storage to an Azure Recovery Services vault.

### Things to know about using System Center DPM or MABS

Let's examine the configuration details for using System Center DPM or MABS to back up your data.

- When you set up protection for a machine or application by using System Center DPM or MABS, you select to back up to the MABS or DPM local disk for short-term storage, and to Azure for online protection. You specify when to run the backup to the local DPM or MABS storage, and when to run the online backup to Azure.

- To protect your on-premises machines, the System Center DPM or MABS instance must be located on-premises.

- To protect your Azure virtual machines, the MABS instance must run as an Azure virtual machine and located in Azure.

- The System Center DPM / MABS protection agent must be installed on each machine you want to protect. For details, see [Deploy the System Center DPM protection agent](/system-center/dpm/deploy-dpm-protection-agent) and [Install the DPM protection agent (for MABS)](/azure/backup/backup-azure-microsoft-azure-backup#install-and-update-the-data-protection-manager-protection-agent).

- The machines that you want to back up must be added to a [System Center DPM _protection group_](/system-center/dpm/create-dpm-protection-groups).

- When the backup triggers, the disk of the protected workload is backed up to the local MABS or DPM disks, according to the schedule you specified. The DPM and MABS disks are then backed up to the Recovery Services vault by the MARS agent running on the DPM or MABS instance.

### Things to consider when using System Center DPM or MABS

There are several advantages to choosing System Center DPM or MABS for your backup solution.

- **Consider optimized app-aware backups**. Back up your data to MABS or System Center DPM to enable app-aware backups that are optimized for common apps. Apps can include SQL Server, Exchange, and SharePoint. The optimization can be achieved for file/folder/volume backups, and machine-state backups. The machine-state backups can be bare-metal, or system-state.

- **Consider simplified backups for on-premises machines**. Implement System Center DPM or MABS implementation to avoid installing the Microsoft Azure Recovery Services (MARS) agent on each on-premises machine to back up. Your on-premises machines automatically run the System Center DPM (and MABS) **protection** agent. The MARS agent runs only on the MABS or DPM instance.

- **Consider flexibility and scheduling**. Configure System Center DPM or MABS to gain flexibility and more granular scheduling options for running your backups.

- **Consider consolidated management**. Manage backups for multiple machines by gathering them into protection groups in a single console. Grouping machines is useful when apps are tiered over multiple machines and you want to back them up at the same time.