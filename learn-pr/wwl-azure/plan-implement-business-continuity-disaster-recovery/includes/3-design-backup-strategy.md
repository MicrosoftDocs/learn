This unit describes how the [Azure Backup service](/azure/backup/backup-overview) backs up Azure virtual machines (VMs).

Azure Backup provides independent and isolated backups to guard against unintended destruction of the data on your VMs. Backups are stored in a Recovery Services vault with built-in management of recovery points. Configuration and scaling are simple, backups are optimized, and you can easily restore as needed.

As part of the backup process, a [snapshot is taken](/azure/backup/backup-azure-vms-introduction#snapshot-creation), and the data is transferred to the Recovery Services vault with no impact on production workloads. The snapshot provides different levels of consistency. You can opt for an agent-based application-consistent/file-consistent backup or an agentless crash-consistent backup in the backup policy.

## Backup process

Here's how Azure Backup completes a backup for Azure VMs:

1.  For Azure VMs that are selected for backup, Azure Backup starts a backup job according to the backup schedule you specify.
2.  If you have opted for application or file-system consistent backups, the VM needs to have a backup extension installed to coordinate for the snapshot process. If you have opted for [crash-consistent backups](/azure/backup/backup-azure-vms-agentless-multi-disk-crash-consistent-overview), no agents are required in the VMs.
3.  During the first backup, a backup extension is installed on the VM if the VM is running.
4.  For Windows VMs that are running, Azure Backup coordinates with Windows Volume Shadow Copy Service (VSS) to take an app-consistent snapshot of the VM.
    
    
     -  By default, Backup takes full VSS backups.
     -  If Backup can't take an app-consistent snapshot, then it takes a file-consistent snapshot of the underlying storage (because no application writes occur while the VM is stopped).
5.  For Linux VMs, Backup takes a file-consistent backup. For app-consistent snapshots, you need to manually customize pre/post scripts.
6.  For Windows VMs, Microsoft Visual C++ 2013 Redistributable (x64) version 12.0.40660 is installed, the startup of Volume Shadow Copy Service (VSS) is changed to *automatic*, and a Windows Service IaaSVmProvider is added.
7.  After Backup takes the snapshot, it transfers the data to the vault.
    
    
     -  The backup is optimized by backing up each VM disk in parallel.
     -  For each disk that's being backed up, Azure Backup reads the blocks on the disk and identifies and transfers only the data blocks that changed (the delta) since the previous backup.
     -  Snapshot data might not be immediately copied to the vault. It might take some hours at peak times. Total backup time for a VM will be less than 24 hours for daily backup policies.

## Encryption of Azure VM backups

When you back up Azure VMs with Azure Backup, VMs are encrypted at rest with Storage Service Encryption (SSE). Azure Backup can also back up Azure VMs that are encrypted by using Azure Disk Encryption.

| **Encryption**        | **Details**                                                                                                                                                                                                                                                                                                                                                                                                                         | **Support**                                                                                                                                                                                                                                                                                                                                                                                                                                                        |
| --------------------- | ----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------- | ------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------ |
| SSE                   | With SSE, Azure Storage provides encryption at rest by automatically encrypting data before storing it. Azure Storage also decrypts data before retrieving it. Azure Backup supports backups of VMs with two types of Storage Service Encryption: SSE with platform-managed keys: This encryption is by default for all disks in your VMs. SSE with customer-managed keys. With CMK, you manage the keys used to encrypt the disks. | Azure Backup uses SSE for at-rest encryption of Azure VMs.                                                                                                                                                                                                                                                                                                                                                                                                         |
| Azure Disk Encryption | Azure Disk Encryption encrypts both OS and data disks for Azure VMs.<br><br>Azure Disk Encryption integrates with BitLocker encryption keys (BEKs), which are safeguarded in a key vault as secrets. Azure Disk Encryption also integrates with Azure Key Vault key encryption keys (KEKs).                                                                                                                                         | Azure Backup supports backup of managed and unmanaged Azure VMs encrypted with BEKs only, or with BEKs together with KEKs.<br><br>Both BEKs and KEKs are backed up and encrypted.<br><br>Because KEKs and BEKs are backed up, users with the necessary permissions can restore keys and secrets back to the key vault if needed. These users can also recover the encrypted VM.<br><br>Encrypted keys and secrets can't be read by unauthorized users or by Azure. |

For managed and unmanaged Azure VMs, Backup supports both VMs encrypted with BEKs only or VMs encrypted with BEKs together with KEKs.

The backed-up BEKs (secrets) and KEKs (keys) are encrypted. They can be read and used only when they're restored back to the key vault by authorized users. Neither unauthorized users, or Azure, can read or use backed-up keys or secrets.

BEKs are also backed up. So, if the BEKs are lost, authorized users can restore the BEKs to the key vault and recover the encrypted VMs. Only users with the necessary level of permissions can back up and restore encrypted VMs or keys and secrets.

## Snapshot creation

Azure Backup takes snapshots according to the backup schedule.

If you have opted for application or file-system-consistent backups, the VM needs to have a backup extension installed to coordinate for the snapshot process.

Windows VMs: For Windows VMs, the Backup service coordinates with VSS to take an app-consistent snapshot of the VM disks. By default, Azure Backup takes a full VSS backup (it truncates the logs of application such as SQL Server at the time of backup to get application level consistent backup). If you're using a SQL Server database on Azure VM backup, then you can modify the setting to take a VSS Copy backup (to preserve logs).
