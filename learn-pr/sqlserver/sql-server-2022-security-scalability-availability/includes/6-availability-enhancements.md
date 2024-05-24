---
ms.custom:
  - build-2023
---
There are many availability enhancements to SQL Server 2022, but in this unit, we go over three of the major enhancements: 

- Contained availability groups
- Cross-platform snapshot backups
- Intel&reg; QuickAssist backup compression

For a list of other availability enhancements, see the following diagram and [What's new in SQL Server 2022](/sql/sql-server/what-s-new-in-sql-server-2022#availability).

:::image type="content" source="../media/availability-enhancements-list.png" alt-text="Diagram of the SQL Server 2022 availability enhancements.":::

## Contained availability groups

SQL Server 2022 introduces *contained availability groups*. Instance level objects are now replicated in a contained system database in the availability group along with the user databases. Contained availability groups, allow you to fail over the entire instance, including the system databases, to another instance in the availability group. This capability is a significant improvement over previous versions of SQL Server, where you could only failover user databases.

A contained availability group is an [Always On availability group](/sql/database-engine/availability-groups/windows/overview-of-always-on-availability-groups-sql-server) that supports:

- Managing metadata objects (users, logins, permissions, SQL Agent jobs, etc.) at the availability group level in addition to the instance level.
- Specialized contained system databases within the availability group.

### Challenges with previous versions of SQL Server

Always On availability groups generally consist of one or more user databases intended to operate as a coordinated group. Those databases are then replicated to one or more secondary replicas. In previous versions of SQL Server, objects such as users, logins, permissions, and SQL Agent Jobs, which are stored in one of the system databases (`master` or `msdb`) weren't replicated to the secondary replicas. This behavior meant that if you had to fail over to a secondary replica, you had to manually recreate the logins, users, and SQL Agent jobs on the secondary replica. For applications or users that connect to an Always On availability group database, the database administrator (DBA) must ensure that any changes to those objects are duplicated across all replicas. This manual process could be time consuming and error prone.

Contained availability groups solve the challenges by extending the concept of the group of databases being replicated to include relevant portions of the `master` and `msdb` databases. Contained availability groups are different from contained databases. Contained databases use a different mechanism for the user accounts, storing the user information within the database itself. Contained databases only replicate logins and users, and the scope of the replicated login or user is limited to that single database (and its replicas).

In contrast, in a contained availability group, you can create users, logins, and permissions at the availability group level, and they're *automatically* consistent across replicas in the availability group. They're also consistent across databases within that contained availability group. This structure saves the DBA from having to manually make these changes themselves.

:::image type="content" source="../media/contained-availability-group-challenge.png" alt-text="Diagram of the contained availability groups challenges and properties.":::

### How does a contained availability group work?

Each contained availability group has its own `master` and `msdb` system databases, named after the name of the availability group. For example, in contained availability group `MyAG`, you have databases named `MyAG_master` and `MyAG_msdb`. These system databases are automatically seeded to new replicas, and updates are replicated to these databases just like any other database in an availability group. When you add an object such as a login or SQL Agent Job while connected to the contained availability group, you're able to authenticate using the login created in the contained availability group. You're also able to see the SQL Agent Job when the contained availability group fails over to another instance.

:::image type="content" source="../media/contained-availability-group-flow.png" alt-text="A flow diagram of the contained availability group.":::

To be able to effectively utilize the features of a contained availability group, you must create a listener for the contained availability group. The listener is used to connect to the contained availability group, and is the only way to access the environment of the contained availability group. If you connect to one of the *instances* hosting the contained availability group rather than directly to the contained availability group through the listener, you're in the environment of the instance, and not the contained availability group. If you're connected to the instance and you create a login or SQL Agent Job, it wouldn't be replicated to the other replicas in the contained availability group.

## Cross-platform snapshot backups

Snapshot backups provide a quick method to back up large SQL Server databases by avoiding the need to stream SQL Server files into backup files. Snapshots were supported for SQL Server in previous versions, but required a program that uses the Virtual Device Interface (VDI). This option allows you to take a snapshot backup of a database without the need to use VDI. Windows and SQL Server provide methods to support snapshot backups using the Volume Snapshot Service (VSS) and the SQL Writer service (which uses VDI).

SQL Server 2022 provides built-in support for snapshot backups without VDI using the `ALTER DATABASE` T-SQL statement option `SUSPEND_FOR_SNAPSHOT_BACKUP`. When this statement is executed, SQL Server suspends all input/output (I/O) on database and transaction log files. Users can then use storage provider snapshot technologies to create a consistent snapshot backup from the underlying SQL Server database and transaction log files. The backup process is completed by backing up small amounts of metadata information into a file, allowing I/O to continue for database and transaction log files.

Snapshot backups can be restored with the T-SQL `RESTORE` statement specifying the metadata backup file and all database and transaction log files from the snapshot backup.

This new method now allows snapshot backups to be performed across both Windows and Linux operating systems without relying on VSS, SQL Writer, or custom VDI applications.

For more information, see [Create a Transact-SQL snapshot backup](/sql/relational-databases/backup-restore/create-a-transact-sql-snapshot-backup).

## Intel&reg; QuickAssist backup compression

SQL Server supports options to compress a backup, which can save large amounts of space for the target backup file. The process of compression can take a significant number of CPU cycles for threads within SQL Server that are compressing the backup file.

SQL Server 2022 can use a new compression technique powered by Intel&reg; QuickAssist Technology (QAT). When a backup is executed using Intel&reg; QuickAssist compression, the processing for compression is offloaded to the Intel&reg; QuickAssist hardware versus the CPUs in the system. Offloading provides more CPU cycles for queries and applications while the backup is being compressed.

For more information, see [Integrated acceleration and offloading](/sql/relational-databases/integrated-acceleration/overview).
