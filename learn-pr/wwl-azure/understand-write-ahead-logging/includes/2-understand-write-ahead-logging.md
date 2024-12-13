When changes are made in the database, such as INSERTS or DELETES, those changes are first written to a log, and only then written to data files on disk. This operation is called the write-ahead log, because changes are written to the log, ahead of committing them to data files. If a problem, such as loss of power, the log always holds the latest data and can be used to ensure the database is in a consistent state.

A second benefit is that by writing changes to the log first, changes to tables and indexes can be written in batches, rather than individually. This process reduces the number of disk writes required to keep tables and indexes up to date. Writes to the log are fast because they're done sequentially. Slower writes to tables and indexes can safely be done in batches, because all the data can be recovered from the log. For workloads that typically involve many small updates, performance is improved.

> [!NOTE]
> For on-premises implementations of PostgreSQL, the log file is stored in the **pg_wal** directory. Azure Database for PostgreSQL doesn't provide access to the file system, so you don't have to worry about the physical storage of the log file.

There are several server parameters that allow you to control how write-ahead logging works and optimize it for your workload:

- **commit_delay** - the delay between transaction commit and flushing the log to disk.
- **wal_buffers** - the number of disk page buffers in shared memory for write-ahead logging (WAL).
- **max_wal_size** - maximum size to let the WAL grow before triggering automatic checkpoint.
- **wal_writer_delay** - time interval between WAL flushes performed by the WAL writer.
- **wal_compression** - whether full-page writes in the WAL file are compressed.
- **wal_level** - determines how much information is written to the WAL. The allowed values are REPLICA or LOGICAL.

## Point in time restore

The primary purpose of the write-ahead log (WAL) is to ensure database consistency and durability if there's a crash. The on-premises version of PostgreSQL allows the log to be used as an archive, allowing you to restore to a point in time using the configuration settings **archive_mode** and **archive_command**.

Azure Database for PostgreSQL is a managed service, which doesn't allow access to the underlying file system. It does, however, include automatic full backups of the server including all databases. This backup allows you to recreate your data to a point in time. Backups are scheduled automatically and are done once a day. If you need to restore, you can restore up to the number of days you specified for retaining backups, up to the maximum of 35 days. To specify how long backups should be retained for:

1. In the Azure portal, navigate to your Azure Database for PostgreSQL flexible server.
1. From the **Overview** section, select your **Configuration**.
1. Under Backups, find **Backup retention period (in days)**. The slider bar allows you to select the number of days you want backups to be retained.
1. Select **Save** to retain your changes.
