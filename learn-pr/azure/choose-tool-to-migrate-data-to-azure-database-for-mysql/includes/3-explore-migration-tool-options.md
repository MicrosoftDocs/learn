There are several tools you can use to migrate data to an Azure Database for MySQL flexible server. Each option has its pros and cons, as explained in the following sections.
## Azure Database for MySQL Import CLI

Azure Database for MySQL Import is a single CLI command that enables you to migrate your MySQL on-premises or Virtual Machine (VM) workload seamlessly to Azure Database for MySQL - Flexible Server. It offers a simple and fast migration path. The command provisions your target flexible server configured according to user inputs, then restores your physical backup file (taken using Percona XtraBackup) of the source server stored in the Azure Blob storage account to the target Flexible Server instance.

The CLI command is: `az mysql flexible-server --import`

When evaluating the import CLI, be sure to take into account the following considerations.

- The source server configuration must include these parameters and values:

  ```ini
  lower_case_table_names = 1
  innodb_file_per_table = ON
  ```

- The system tablespace name should be `ibdata1`, with a size equal to at least 12 MB (the MySQL default).

- Only the InnoDB engine is supported for migration.

- Certain elements on the source server, for example configuration (like firewalls, users, privileges), are not migrated.

- High availability is disabled during the migration to optimize performance. Be sure to reenable HA after the migration is complete.

## Azure Migrate and Azure Database Migration Service

[Azure Migrate](https://azure.microsoft.com/products/azure-migrate/) is a unified platform that discovers assets suitable for migration and assesses their readiness for the process. [Azure Database Migration Service](https://azure.microsoft.com/products/database-migration) (DMS) assists with migrating databases to Azure.

DMS works by creating and running repeatable migration projects. Sources range from on-premises workloads to cloud-based workloads like Amazon RDS MySQL. While DMS is technically an offline migration tool, it makes use of the MySQL `binlog` to perform near-zero downtime online migrations.

## mysqldump

The [`mysqldump`](https://dev.mysql.com/doc/refman/8.0/en/mysqldump.html) client utility, typically installed together with MySQL, is a database backup tool. You can use mysqldump to dump the schema and contents of a source database into SQL statements. You can then run these statements as-is to restore the full or partial contents to the target database.

For large data sets, restoring the dump by running the SQL statements can perform poorly. For example, indexes are updated one statement at a time, which can overload disk I/O performance. Because of this, you can speed up a migration by pairing `mysqldump` with tools such as `mydumper` and `myloader`, which are optimized for bulk data migration. Use `mysqldump` to recreate the database schema, which is a landing zone in the target database, to accommodate the data being imported.

Sometimes, you need to customize the migration data transfer. You might want to export a subset of data for testing or replace the target database's data for a customer. You might even modify the data, such as redacting personal data to debug an issue in a test database, before migrating it.

In these scenarios, `mysqldump` provides you with the most flexibility. Because it exports a file containing SQL statements, you can modify the data however you want before running the statements on the target server.

## mydumper and myloader

`mydumper` and `myloader` are part of the [MyDumper](https://github.com/mydumper/mydumper) package, an open-source MySQL backup tool. Unlike the `mysqldump` tool, which outputs the entire schema to SQL statements to run again linearly, the MyDumper tools take advantage of parallelism and provide benefits such as using separate files by table and human-readable formats, as well as maintaining accurate source and target binary log positions.

It is recommended to use `mydumper` and `myloader` to migrate large databases because these tools offer 10x or greater performance using parallelism.

The tools are available as binary releases for Linux as rpm and deb packages, and for macOS via [Homebrew](https://brew.sh/). On other platforms, you need to compile the tools from source which introduces complexity.

## MySQL Workbench

[MySQL Workbench](https://www.mysql.com/products/workbench/) provides a graphical user interface (GUI) for working with MySQL, and it offers access to many tools, including one for [database migration](https://www.mysql.com/products/workbench/migrate/). MySQL Workbench is available in the Community and commercial editions of MySQL, as called out in the [MySQL Workbench Features](https://www.mysql.com/products/workbench/features.html) list.

## MySQL binlog

The `mysqlbinlog` [tool](https://dev.mysql.com/doc/refman/8.0/en/mysqlbinlog.html) uses the MySQL [binary log](https://dev.mysql.com/doc/refman/8.0/en/binary-log.html), which records database change events such as table modifications or data inserts, updates, and deletes. Each change is identified using an incrementally increasing *position*, and you can inspect and manipulate each change by using the `mysqlbinlog` tool.

You can use binary log as part of both online and offline migrations:

- With online migrations, the binary log is the key mechanism for replicating live data changes from the source to the target.

- With offline migrations, the binary log enables incremental migrations by precisely generating changes since a previously migrated snapshot.

Maintaining the binary log requires additional processing and storage resources.
