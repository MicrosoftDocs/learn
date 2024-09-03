Azure Database for MySQL currently supports two storage engines: InnoDB and Memory.

## InnoDB

InnoDB is now MySQL's default storage engine, and the one that is most widely used. InnoDB is ACID (Atomicity, Consistency, Isolation, Durability) compliant, designed for short transactions that are normally committed, rather than being rolled back. It's a reliable, general purpose storage engine that works well for most workloads.

Some of the benefits of InnoDB include:

- It supports transactions.
- It supports foreign keys.
- InnoDB writes first to a log, before writing changes to disk. In the event of a crash or server restart, any changes not yet written to disk can be recovered from the log.
- InnoDB tables can be encrypted at rest.
- InnoDB supports partitioning data.

> [!TIP]
> Although MySQL supports alternative storage engines, for most scenarios InnoDB is the right choice.

InnoDB is the only MySQL storage engine that supports foreign key constraints. This means that for most database applications, InnoDB is the only option. When you create a table in MySQL, the InnoDB engine will be used unless you specify another storage engine.

InnoDB uses memory as a cache to avoid disk access and performs well with a large amount of memory allocated to it. This strategy avoids swapping, when the disk writes are forced because there's insufficient memory. Azure Database for MySQL allows you to monitor the percentage of memory in use. See [Azure Monitor data platform - Azure Monitor | Microsoft Learn](/azure/azure-monitor/data-platform) for more information. You can also set up [alerts](/azure/mysql/howto-alert-on-metric).

### InnoDB strict mode

**Innodb_strict_mode** controls how issues such as invalid values or values outside their maximum length are handled. When strict mode isn't enabled, InnoDB produces a warning and depending on the error may truncate values. When strict mode is enabled, you have to fix the problem before proceeding. In Azure Database for MySQL, **Innodb_strict_mode** is enabled, and can't be modified at the server level. You can enable **innodb_strict_mode** at the session level, by using **init_connect**.

> [!NOTE]
> On a read replica server, setting **innodb_strict_mode** to **OFF** at the session level on a source server will break the replication. If you have read replicas, keep the parameter set to **ON**.

**Innodb_strict_mode** interacts with other parameter settings to either generate errors or block certain actions. See the [MySQL documentation](https://dev.mysql.com/doc/refman/8.0/en/innodb-compression-syntax-warnings.html#innodb-compression-create-and-alter-options-table) for further details.

> [!NOTE]
> If you receive an error message such as Row size too large (> 8126), consider setting the **innodb_strict_mode** parameter to **OFF** at the session level. If row data size is larger than 8K, the row will be truncated, and data may be lost. No error message will be displayed.

**Innodb_buffer_pool_size** is a server parameter that defines the size of memory where InnoDB caches table and index data. The value is in bytes, and the default is 134217728 bytes (128 MB).

## Memory

The Memory storage engine stores table data in memory; data is never written to disk. This means that access is fast. However, if there's a crash or the server restarts, the memory storage engine doesn't write to a log, so data can't be recovered.
