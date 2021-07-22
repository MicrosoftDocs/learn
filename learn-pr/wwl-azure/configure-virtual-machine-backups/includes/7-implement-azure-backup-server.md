Another method of backing up virtual machines is using a Data Protection Manager (DPM) or Microsoft Azure Backup Server (MABS) server. This method can be used for specialized workloads, virtual machines, or files, folders, and volumes. Specialized workloads can include SharePoint, Exchange, and SQL Server.

:::image type="content" source="../media/system-center-76153528.png" alt-text="Diagram showing workloads, vms, and files being backed up to Azure using DPM or MABS.":::


## Advantages

The advantages of backing up machines and apps to MABS/DPM storage, and then backing up DPM/MABS storage to a vault are as follows:

 -  Backing up to MABS/DPM provides app-aware backups optimized for common apps. These apps include SQL Server, Exchange, and SharePoint. Also, file/folder/volume backups, and machine state backups. Machine state backups can be bare-metal, or system state.
 -  For on-premises machines, you don't need to install the MARS agent on each machine you want to back up. Each machine runs the DPM/MABS protection agent, and the MARS agent runs on the MABS/DPM only.
 -  You have more flexibility and granular scheduling options for running backups.
 -  You can manage backups for multiple machines that you gather into protection groups in a single console. Grouping machines is useful when apps are tiered over multiple machines and you want to back them up at the same time.

## Backup steps

1.  Install the DPM or MABS protection agent on machines you want to protect. You then add the machines to a DPM protection group.
2.  To protect on-premises machines, the DPM or MABS server must be located on-premises.
3.  To protect Azure VMs, the MABS server must be located in Azure, running as an Azure VM.
4.  With DPM/MABS, you can protect backup volumes, shares, files, and folders. You can also protect a machine's system state (bare metal), and you can protect specific apps with app-aware backup settings.
5.  When you set up protection for a machine or app in DPM/MABS, you select to back up to the MABS/DPM local disk for short-term storage and to Azure for online protection. You also specify when the backup to local DPM/MABS storage should run and when the online backup to Azure should run.
6.  The disk of the protected workload is backed up to the local MABS/DPM disks, according to the schedule you specified.
7.  The DPM/MABS disks are backed up to the vault by the MARS agent that's running on the DPM/MABS server.
