SQL Server has two types of databases: system and user. System databases are the ones used by SQL Server such as master and msdb. User databases are the ones created by users that store the data for applications. Both are important to account for when devising a backup and recovery plan. The nature of most system databases is that they are updated less frequently, although there are exceptions. As a general rule of thumb, system databases are not restored from one SQL Server instance to another. Your main concern should be backing up the user databases.

The most common types of backups generated for SQL Server installations are full, differential, and transaction log. Depending on the deployment method, not all of these may be available as an option.

A full database backup is a backup of a single database. When the backup is made, all the pages from the database are copied to the backup device. The backup contains enough information so that you can restore the database to the point at which the backup was made. If you want to restore to a specific point-in-time to achieve your RPO, that can happen with the use of differential and/or transaction log backups. full backup does not flush (or back up) the transaction log. Only a transaction log backup does that and is discussed below.

A differential backup contains all the database pages that have changed since the last time a full backup was made.

A transaction log backup is not only used to be able to achieve RPO and get to a more granular point in time but clears the transaction log and keeps its size manageable. Transaction log backups can be generated as frequently as every 30 seconds, although that is impractical. 

> [!IMPORTANT]
> Understand how the transaction log works because it impacts not only how the transaction log is backed up, but also how you can do point-in-time recovery using transaction log files.

There are other backup options such as copy-only, file, filegroup, partial, and more.

A differential or a log backup can be restored after a full database is restored, as long as the database RESTORE command uses either the WITH NORECOVERY or the WITH STANDBY option. If neither option is used, the database RESTORE will do a recovery of the database, after which no additional backups can be applied.

Every SQL Server database uses one of three recovery models: FULL, BULK_LOGGED, or SIMPLE. The recovery model is set as a database option, and governs the type of backups and restores that could be used with the database. Most databases are set to FULL or SIMPLE. FULL allows all types of backups to be generated while SIMPLE does not allow transaction log backups. This means that if you have a smaller RPO, SIMPLE may not meet your needs as you cannot restore to a granular point in time.
