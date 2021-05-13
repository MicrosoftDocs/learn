
VMs hosting SAP applications are most often backed up using Azure Backup. When backing up SAP workloads by using Azure Backup, keep in mind the limitations resulting from the network consumption of backup operations. Azure Backup agents support throttling throughput utilized during backups and restores. You also have the option of applying compression, however, such approach increases CPU usage, and the additional CPU consumed by the compression process can adversely impact performance of SAP workloads. When backing up SQL Server databases, to mitigate such impact you might want to configure a low-priority compressed backup task, such that CPU usage is limited by SQL Server Resource Governor when CPU contention occurs. Compressed backups also help reduce restore times.

For VM-level recovery, you might consider using Azure VM Backup. Azure Backup stores the backups in Azure and allows a restore of a VM again. However, be aware that Azure VM backup supports only a single scheduled backup per day. 

> [!NOTE]
> In addition, note that using VM Backup does NOT keep the unique VM ID which is used for SAP licensing. This means that a restore from a VM backup requires installation of a new SAP license key as the restored VM is considered to be a new VM and not a replacement of the former one which was saved.

Here's how Azure Backup completes a backup for Azure VMs:

1. For Azure VMs that are selected for backup, Azure Backup starts a backup job according to the backup schedule you specify.

2. During the first backup, a backup extension is installed on the VM if the VM is running.

    * For Windows VMs, the VMSnapshot extension is installed. For Windows VMs that are running, Backup coordinates with Windows Volume Shadow Copy Service (VSS) to take an app-consistent snapshot of the VM. By default, Backup takes full VSS backups. If Backup can't take an app-consistent snapshot, then it takes a file-consistent snapshot of the underlying storage (because no application writes occur while the VM is stopped).
    
    * For Linux VMs, the VMSnapshotLinux extension is installed. For Linux VMs, Backup takes a file-consistent backup. For app-consistent snapshots, you need to manually customize pre/post scripts.
    
3. After Backup takes the snapshot, it transfers the data to the vault.
    
    * The backup is optimized by backing up each VM disk in parallel.
    
    * For each disk that's being backed up, Azure Backup reads the blocks on the disk and identifies and transfers only the data blocks that changed (the delta) since the previous backup.
    
    * Snapshot data might not be immediately copied to the vault. It might take some hours at peak times. Total backup time for a VM will be less than 24 hours for daily backup policies.

4. When the data transfer is complete, the snapshot is removed, and a recovery point is created.

**Backup application consistency**

Windows VMs: For Windows VMs, the Backup service coordinates with VSS to take an app-consistent snapshot of the VM disks.

* By default, Azure Backup takes full VSS backups. 

* To change the setting so that Azure Backup takes VSS copy backups, set the following registry key from a command prompt:

`REG ADD "HKLM\SOFTWARE\Microsoft\BcdrAgent" /v USEVSSCOPYBACKUP /t REG_SZ /d TRUE /f`

Linux VMs: To take app-consistent snapshots of Linux VMs, use the Linux pre-script and post-script framework to write your own custom scripts to ensure consistency.

* Azure Backup invokes only the pre/post scripts written by you.

* If the pre-scripts and post-scripts execute successfully, Azure Backup marks the recovery point as application consistent. However, when you're using custom scripts, you're ultimately responsible for the application consistency.

## Database backup


Backup of Azure VM-based DBMS is typically performed by using DBMS-specific methods. Backing up a database should facilitate the ability to restore it to any point in time.

Two types of backups must be performed to achieve this capability:

* **Database full and differential backups**

* **Transaction log backups**

In addition to full-database backups performed at the database level, you can perform backups with storage snapshots. In general, storage snapshots don't replace transaction log backups (although snapshot-based point-in-time restore is available with SQL Server 2016 or newer). Transaction log backups remain important to restore the database to a certain point in time or to empty the logs from already committed transactions. Storage snapshots can accelerate recovery by quickly providing a roll-forward image of the database.

File-snapshot backups are extremely useful for SAP administrative tasks, such as applying SAP support packs. The backup and restore time are typically measured in seconds. As a best practice, back up your SAP applications before applying support packs and upgrades or performing other major data operations, such as archiving.


## SAP HANA backup

SAP HANA on Azure VMs can be backed up by using the following two methods:

* **HANA backup to the file system in an Azure Linux VM**

* **HANA backup based on storage snapshots using either the Azure storage blob snapshot feature manually or Azure VM Level Backup** 

SAP doesn't provide any recommendations regarding the choice between these two methods. It lists their pros and cons, so one can determine which to use depending on the situation and available storage technology 

Be aware that the Azure blob snapshot doesn't guarantee file system consistency. This needs to be accounted for when taking storage snapshots. File system and application consistency is a complex issue when taking storage snapshots. The easiest way to avoid problems would be to shut down SAP HANA, or maybe even the whole virtual machine. A shutdown might be doable with a demo or prototype, or even a development system, but it is not an option for a production system.

File system consistency is available when using the SAP HANA snapshot feature, if there is only a single virtual disk involved. But even with a single disk, there are additional considerations outlined in SAP Note 2039883. For example, with the XFS file system, it is necessary, to run xfs_freeze before starting a storage snapshot to guarantee consistency.

The topic of consistency becomes even more challenging in a case where a single file system spans multiple disks/volumes. As per the same SAP Note: " the storage system has to guarantee I/O consistency while creating a storage snapshot per SAP HANA data volume, i.e. snapshot of an SAP HANA service-specific data volume must be an atomic operation."

Assuming there is an XFS file system spanning four Azure virtual disks, the following steps provide a consistent snapshot that represents the HANA data area:

1. HANA snapshot prepare

1. Freeze the file system (for example, use xfs_freeze)

1. Create all necessary blob snapshots on Azure

1. Unfreeze the file system

1. Confirm the HANA snapshot


> **Recommendation** is to use the procedure above in all cases to be on the safe side, no matter which file system. 

It is critical to confirm the HANA snapshot. Due to the "Copy-on-Write," SAP HANA might not require additional disk space while in this snapshot-prepare mode. In addition , it is not possible to start new backups until the SAP HANA snapshot is confirmed.

When working with snapshots, it is also important to understand the billing implications.



## SAP HANA backup scheduling strategy


A common backup scheduling strategy described in the HANA Administration guide involves the following backups:

* Storage snapshot (daily)

* Complete data backup using file or bacint format (once a week)

* Automatic log backups

Optionally, one could go completely without storage snapshots; they could be replaced by HANA delta backups, like incremental or differential backups.

The HANA Administration guide provides an example list. It suggests that one recover SAP HANA to a specific point in time using the following sequence of backups:

1. Full data backup

1. Differential backup

1. Incremental backup 1

1. Incremental backup 2

1. Log backups

Regarding an exact schedule as to when and how often a specific backup type should happen, it is not possible to give a general guideline—this would be customer-specific and dependent on the volume of data changes in the system. One basic recommendation from SAP, which is general guidance, is to make one full HANA backup once a week. SAP also recommends doing some housekeeping of the backup catalog to keep it from growing infinitely.

**SAP HANA configuration files**

The SAP HANA configuration files are not part of a standard HANA backup. They are not essential to restore a system. The HANA configuration could be changed manually after the restore. In case one would like to get the same custom configuration during the restore process, it is necessary to back up the HANA configuration files separately.

If standard HANA backups are going to a dedicated HANA backup file system, one could also copy the configuration files to the same backup filesystem, and then copy everything together to the final storage destination like cool blob storage.

**SAP HANA backup encryption**

SAP HANA offers encryption of data and log. If SAP HANA data and log are not encrypted, then the backups are also not encrypted. It is up to the customer to use some form of third-party solution to encrypt the SAP HANA backups. 

On Microsoft Azure, a customer could use the IaaS VM encryption feature. For example, one could use dedicated data disks attached to the VM, which are used to store SAP HANA backups, then make copies of these disks. Azure Backup service can handle encrypted VMs/disks. Another option would be to maintain the SAP HANA VM and its disks without encryption and store the SAP HANA backup files in a storage account for which encryption was enabled.

**Test backup size estimation**

It is important to estimate the backup size of SAP HANA. This estimate helps to improve performance by defining the max backup file size for several backup files, due to parallelism during a file copy. One must also decide whether to do a full backup or a delta backup (incremental or differential). Fortunately, there is a simple SQL statement that estimates the size of the backup files: select * from M_BACKUP_SIZE_ESTIMATIONS.




