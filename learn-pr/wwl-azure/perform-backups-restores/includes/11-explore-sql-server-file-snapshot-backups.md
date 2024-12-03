A file-snapshot backup consists of a set of Azure snapshots of the blobs that contain database files and a backup file containing pointers to these file-snapshots. Each file-snapshot is stored in the container with the base blob. You can specify that the backup file itself to be written to URL, disk, or tape. File-snapshot backup to URL is recommended.

You can use this approach for both full database and transaction log backups:

- **Full database backup**: Performing a full database backup using file-snapshot backup creates an Azure snapshot of each data and log file comprising the database, establishes the transaction log backup chain, and writes the location of the file-snapshots into the backup file.
- **Transaction log backup**: Performing a transaction log backup using file-snapshot backup creates a file-snapshot of each database file (not just the transaction log), records the file-snapshot location information into the backup file, and truncates the transaction log file.

After the initial full backup that's required to establish the transaction log backup chain (which can be a file-snapshot backup), you only need to perform transaction log backups because each transaction log file-snapshot backup set contains file-snapshots of all database files and can be used to perform a database restore or a log restore. More full or differential backups aren't needed after an initial full database backup. The Azure Blob storage service handles differences between each file-snapshot and the current state of the base blob for each database file.

## Considerations and limitations

- **Premium storage**: Premium storage limitations include:

  - The backup file itself can't be stored using premium storage.
  - The frequency of backups can be no shorter than 10 minutes.
  - The maximum number of snapshots that you can store is 100.
  - RESTORE WITH MOVE is required.
- **Single storage account**: The file-snapshot and destination blobs must use the same storage account.
- **Bulk recovery model**: When using bulk-logged recovery mode and working with a transaction log backup containing a minimum of logged transactions, you can't do a log restore (including point in time recovery) using the transaction log backup. Instead, you perform a database restore to the time of the file-snapshot backup set. This limitation is identical to the limitation with streaming backup.
- **Online restore**: When using file-snapshot backups, you can't perform an online restore.
- **Billing**: When SQL Server file-snapshot backup is in use, charges are incurred for data changes. Archival: If you wish to archive a file-snapshot backup, you can archive to blob storage or to streaming backup. To archive to blob storage, copy the snapshots in the file-snapshot backup set into separate blobs. To archive to streaming backup, restore the file-snapshot backup as a new database. Then perform a normal streaming backup with compression and/or encryption and archive it for as long as desired, independent of the base blobs.
