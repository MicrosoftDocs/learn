

## Overview

There are three backup possibilities for SAP HANA on Azure Virtual Machines:

- Azure Backup Service working with the proprietary SAP HANA interface to perform a streaming backup (path 1 in the image following). The SAP HANA interface is called [backint](https://www.sap.com/dmc/exp/2013_09_adpd/enEN/), and the Azure Backup service incorporates the SAP HANA backint API.

- HANA backup based on storage snapshots. This creates an application consistent disk snapshot and transfers it to the Azure Backup service (paths 2.1-2.3 in the image).

- HANA backup to the file system in an Azure Virtual Machine (also paths 2.1-2.3 in the image).

    :::image type="content" source="../media/azure-backup-service-for-hana.png" alt-text="Diagram showing two possibilities for saving the current V M state.":::

## Advantages of using Azure Backup to back up and restore SAP HANA databases

- **15-minute Recovery Point Objective (RPO):** RPO indicates how much data loss is acceptable for the user/customer. Azure Storage typically has an RPO of less than 15 minutes.
- **One-click, point-in-time restores:** Restoring production data to alternate HANA servers is easy. Azure manages the chaining of backups and catalogs to perform restores, behind the scenes.
- **Long-term retention:** If you have rigorous compliance and audit needs, you can adjust the retention duration to allow you to retain your backups for years. Beyond the retention duration, the recovery points are pruned automatically by built-in lifecycle management.
- **Backup management from Azure:** Azure Backup's management and monitoring capabilities provide an improved management experience. Azure CLI is also supported.

## Operating system backup

You can also use the Azure Backup service to back up the operating system and other non-database disks. The VM backup is taken once per day, and backs up all disks except for **Write Accelerator (WA) OS disks** and **Ultra disks**.

Since the database is backed up using the Azure SAP HANA backup solution, you can use the [Selective disk backup and restore for Azure VMs](/azure/backup/selective-disk-backup-restore) feature to take a file-consistent backup of the operating system and non-database disks only.

## Other SAP HANA backup methods

There are other backup methods that can be considered, using storage snapshots instead of SAP HANA streaming backups:

:::image type="content" source="../media/other-hana-backup-paths.png" alt-text="Diagram showing options for taking an S A P HANA file backup inside the V M.":::

- **Backing up against a Network File System (NFS) share based on Azure NetApp Files (ANF).** ANF can create snapshots of the volumes you stored backups on. This solution is easy to establish, since HANA can write the backups directly into the Azure native NFS share (path 1 in the previous image). However, given the throughput eventually required to write the backups, this solution can become expensive.

- **Executing the HANA backup against VM-attached disks of Standard SSD or Azure Premium Storage.** This allows you to copy the backup files to Azure Blob storage (paths 2.1-2.2 in the image above). This strategy might be appealing price-wise, because after the first snapshot, regular incremental snapshots can be used to reduce costs.

### Pros and cons of HANA backup versus storage snapshots

SAP doesn't provide any recommendations regarding the choice between the HANA backup and storage snapshots methods. Instead, [Planning Your Backup and Recovery Strategy](https://help.sap.com/viewer/6b94445c94ae495c83a19646e7c3fd56/2.0.05/ef085cd5949c40b788bba8fd3c65743e.html) lists their pros and cons to help you determine which to use, depending on the situation and available storage technology.

>[!Note]
>Currently, the snapshots are stored on your storage account/operational tier, and isn't stored in Recovery Services vault. Thus, the vault features, such as Cross-region restore,Cross-subscription restore, and security capabilities, aren't supported.

On Azure, the blob snapshot feature doesn't provide file system consistency across multiple disks. For more information, see [Using blob snapshots with PowerShell](/archive/blogs/cie/using-blob-snapshots-with-powershell).

In addition, you should understand the billing implications when working frequently with blob snapshots, as it's less obvious than when using Azure virtual disks. For more information, see [Understanding How Snapshots Accrue Charges](/rest/api/storageservices/understanding-how-snapshots-accrue-charges).

The article [SAP HANA backup support matrix](/azure/backup/sap-hana-backup-support-matrix) summarizes the scenarios supported and limitations present when you use Azure Backup to back up SAP HANA databases on Azure VMs.

## Backup/recovery considerations for SQL Server

When deploying SQL Server into Azure, you must review your backup methodology. Even for non-production systems, the SAP database hosted by SQL Server must be backed up periodically.

Azure Storage maintains multiple copies of every Azure VM disk to guarantee protection against data loss or physical data corruption. This means that a backup is now less important in respect to compensating a storage crash. The primary reason for maintaining a proper backup and recovery plan is to compensate for any logical or manual errors, by providing a point-in-time recovery capability. The goal is to either use backups to restore the database back to a certain point in time, or to use the backups in Azure to seed another system by copying the existing database.

For more information about several different SQL Server backup possibilities in Azure, read [Backup and Restore for SQL Server in Azure Virtual Machines](/azure/azure-sql/virtual-machines/windows/backup-restore).

### Manual SQL Server backups

There are several possibilities you can take advantage of if you want to perform your backups manually:

- Conventional SQL Server backups performed onto direct attached Azure disks have the advantage of making the backups available quickly. This is useful for system refreshes and building new systems as copies of existing SAP systems. This method is frequently used in the on-premises world, but it doesn't provide a longer-term backup location. While storing backups in locally attached Azure Storage is possible, it's recommended to move older backups to a different storage solution for long-term retention. You need to use either Azure Backup or another third-party backup/recovery tool to provide access and retention management for your backups. Alternatively, you would need to build out a large file server in Azure using Windows storage spaces.

- You can back up databases to an Azure storage URL, with SQL Server 2012 CU4 and newer versions. This method is described in more detail in [SQL Server Backup to URL](/azure/azure-sql/virtual-machines/windows/backup-restore). The article lists many restrictions. These are the options to perform the backup against:
  - One single Azure page blob, which then limits the backup size to 1,000 GB. This restriction also limits the throughput you can achieve.
  - Up to 64 Azure block blobs, with a theoretical maximum backup size of 12 TB. However, tests with customer databases indicate that the maximum backup size can be smaller than its theoretical limit. In this case, you're responsible for managing retention of backups and access to the backups as well.

    > [!NOTE]
    > Different releases of SQL Server have minor variations of this functionality. Be sure to review the documentation for your particular SQL Server release.

- [File-snapshot backups for database files in Azure Blob storage](/sql/relational-databases/backup-restore/file-snapshot-backups-for-database-files-in-azure). This method only works when your SQL Server data and log files are located on Azure blob storage.

### Automated Backup for SQL Server

Automated Backup provides an automatic backup service for SQL Server Standard and Enterprise editions running in a Windows VM in Azure. This service is provided by the [SQL Server IaaS Agent Extension](/azure/azure-sql/virtual-machines/windows/sql-server-iaas-agent-extension-automate-management), which is automatically installed on SQL Server Windows virtual machine images in the Azure portal. If you deploy your own OS images with SQL Server installed, you must install the VM extensions separately. You can find the steps for completing this task in [Automate management with the SQL Server IaaS Agent extension](/azure/azure-sql/virtual-machines/windows/sql-server-iaas-agent-extension-automate-management). The theoretical backup size limit is 12 TB. These automated backups can be a good method for backup sizes of up to 12 TB. Since multiple blobs are written to in parallel, you can expect a throughput of >100 MB/sec.

The functionality is improved in more recent SQL Server releases. You can find more details about SQL Server automated backups in [SQL Server Managed Backup to Microsoft Azure](/sql/relational-databases/backup-restore/sql-server-managed-backup-to-microsoft-azure).

### Azure Backup for SQL Server VMs

This method for SQL Server backups uses the SQL Server VSS/VDI interface to stream backups to a target location. In this case, the target location is an Azure Recovery Service vault.

To read a detailed description of this backup method, which adds numerous advantages of central backup configurations, monitoring, and administration, see [About SQL Server Backup in Azure VMs](/azure/backup/backup-azure-sql-database).
