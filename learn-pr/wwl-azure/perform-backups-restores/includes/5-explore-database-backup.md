Backup of Azure Virtual Machine-based DBMS is typically performed by using DBMS-specific methods. Backing up a database should facilitate the ability to restore it to any point in time.

Two types of backups must be performed to achieve this capability:

- Database full and differential backups
- Transaction log backups

In addition to full-database backups performed at the database level, you can perform backups with storage snapshots. In general, storage snapshots don't replace transaction log backups (although snapshot-based point-in-time restore is available with SQL Server 2016 or newer). Transaction log backups remain important to restore the database to a certain point in time or to empty the logs from already committed transactions. Storage snapshots can accelerate recovery by quickly providing a roll-forward image of the database.

File-snapshot backups are useful for SAP administrative tasks, such as applying SAP support packs. The backup and restore time are typically measured in seconds. As a best practice, back up your SAP applications before applying support packs and upgrades or performing other major data operations, such as archiving.
