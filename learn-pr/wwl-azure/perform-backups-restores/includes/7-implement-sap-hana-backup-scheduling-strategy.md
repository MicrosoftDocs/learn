A common backup scheduling strategy described in the HANA Administration guide involves the following backups:

- Storage snapshot (daily)
- Complete data backup using file or bacint format (once a week)
- Automatic log backups

Optionally, one could go completely without storage snapshots; they could be replaced by HANA delta backups, like incremental or differential backups.

The HANA Administration guide provides an example list. It suggests that one recover SAP HANA to a specific point in time using the following sequence of backups:

- Full data backup
- Differential backup
- Incremental backup 1
- Incremental backup 2
- Log backups

Regarding an exact schedule as to when and how often a specific backup type should happen, it's not possible to give a general guideline—this would be customer-specific and dependent on the volume of data changes in the system. One basic recommendation from SAP, which is general guidance, is to make one full HANA backup once a week. SAP also recommends doing some housekeeping of the backup catalog to keep it from growing infinitely.

## SAP HANA configuration files

As stated in the FAQ in [SAP Note \#1642148](https://me.sap.com/notes/1642148), the SAP HANA configuration files aren't part of a standard HANA backup. They're not essential to restore a system. The HANA configuration could be changed manually after the restore. In case one would like to get the same custom configuration during the restore process, it's necessary to back up the HANA configuration files separately.

If standard HANA backups are going to a dedicated HANA backup file system, one could also copy the configuration files to the same backup filesystem, and then copy everything together to the final storage destination like cool blob storage.

## SAP HANA backup encryption

SAP HANA offers encryption of data and log. If SAP HANA data and log aren't encrypted, then the backups are also not encrypted. It's up to the customer to use some form of third-party solution to encrypt the SAP HANA backups.

On Microsoft Azure, a customer could use the IaaS virtual machine encryption feature. For example, one could use dedicated data disks attached to the virtual machine, which are used to store SAP HANA backups, then make copies of these disks. Azure Backup service can handle encrypted virtual machines/disks. Another option would be to maintain the SAP HANA virtual machine and its disks without encryption and store the SAP HANA backup files in a storage account for which encryption was enabled.

## Test backup size estimation

It is important to estimate the backup size of SAP HANA. This estimate helps to improve performance by defining the max backup file size for several backup files, due to parallelism during a file copy. One must also decide whether to do a full backup or a delta backup (incremental or differential). Fortunately, there's a simple SQL statement that estimates the size of the backup files: select \* from M\_BACKUP\_SIZE\_ESTIMATIONS. The information from M\_BACKUP\_SIZE\_ESTIMATIONS is also available from the SAP HANA and SAP HANA cockpit backup dialog.
