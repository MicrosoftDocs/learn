VMs hosting SAP applications can be backed up using Azure Backup. When you're creating SAP workload backups by using Azure Backup, keep in mind the limitations resulting from the network consumption of backup operations. Azure Backup agent supports throttling throughput utilized during backup and restore. You also have the option of applying compression, but such an approach increases CPU usage and can adversely affect the performance of SAP workloads. When creating SQL Server database backups, you might want to configure a low-priority compressed backup task, such that CPU usage is limited by SQL Server Resource Governor when CPU contention occurs. Compressed backups also help reduce restore times.

For VM-level recovery, you might consider using Azure VM Backup. Azure Backup stores the backups in Azure and allows a restore of a VM again. However, Azure VM backup supports only a single scheduled backup per day. In addition using VM Backup doesn't keep the unique VM ID that's used for SAP licensing. This means that a restore from a VM backup requires installation of a new SAP license key as the restored VM is considered to be a new VM and not a replacement of the former one, which was saved.

Here's how Azure Backup completes a backup for Azure VMs:

1. For Azure VMs that are selected for backup, Azure Backup starts a backup job according to the backup schedule you specify.
2. During the first backup, a backup extension is installed on the VM if the VM is running.

     - For Windows VMs, the VM Snapshot extension is installed. For Windows VMs that are running, Backup coordinates with Windows Volume Shadow Copy Service (VSS) to take an app-consistent snapshot of the VM. By default, Backup takes full VSS backups. If Backup can't take an app-consistent snapshot, then it takes a file-consistent snapshot of the underlying storage (because no application writes occur while the VM is stopped).
     - For Linux VMs, the VM Snapshot Linux extension is installed. For Linux VMs, Backup takes a file-consistent backup. For app-consistent snapshots, you need to manually customize pre/post scripts.
3. After Backup takes the snapshot, it transfers the data to the vault.

     - The backup is optimized by backing up each VM disk in parallel.
     - For each disk that's being backed up, Azure Backup reads the blocks on the disk and identifies and transfers only the data blocks that changed (the delta) since the previous backup.
     - Snapshot data might not be immediately copied to the vault. It might take some hours at peak times. Total backup time for a VM will be less than 24 hours for daily backup policies.
4. When the data transfer is complete, the snapshot is removed, and a recovery point is created.

## Backup application consistency (Windows VMs)

For Windows VMs, the Backup service coordinates with VSS to take an app-consistent snapshot of the VM disks.

- By default, Azure Backup takes full VSS backups.
- To change the setting so that Azure Backup takes VSS copy backups, set the following registry key from a command prompt:

`REG ADD "HKLM\SOFTWARE\Microsoft\BcdrAgent" /v USEVSSCOPYBACKUP /t REG_SZ /d TRUE /f`

## Backup application consistency (Linux VMs)

To take app-consistent snapshots of Linux VMs, use the Linux pre-script and post-script framework to write your own custom scripts to ensure consistency.

- Azure Backup invokes only the pre/post scripts written by you.
- If the pre-scripts and post-scripts execute successfully, Azure Backup marks the recovery point as application consistent. However, when you're using custom scripts, you're ultimately responsible for application consistency.
