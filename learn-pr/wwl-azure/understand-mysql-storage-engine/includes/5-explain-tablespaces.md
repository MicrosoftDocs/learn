A tablespace is a group of datafiles. Each tablespace can store data for one or many tables. There are three types of tablespaces:

- System tablespace
- File-per-tablespace
- General tablespace

To display a full list of tablespaces on your MySQL server, run the query:

```sql
SELECT TABLESPACE_NAME, FILE_NAME FROM information_schema.FILES;
```

This returns a list of tablespaces together with their file names.

InnoDb data files have an .ibd extension.

> [!NOTE]
> MySQL does a scan of tablespaces when it starts, so a very large number of tablespaces may cause MySQL to take longer to start or failover.

### System tablespace

Each MySQL database has at least one table space, the **system tablespace**, and you can create more with the **CREATE TABLESPACE** statement.

There's always a **system tablespace**, which is where the InnoDB data dictionary and undo logs are stored.

In Azure Database for MySQL, the server parameter **innodb_data_file_path** is a static parameter that is set to **autoextend**. This configures the system tablespace to auto extend, which means it will not run out of space. This parameter can't be modified, so you never have to worry about resizing the system tablespace.

## File-per-tablespace

By default, table and index data are stored in a file-per-table tablespaces, or single-table tablespace. A file-per-table tablespace contains one table including the data and indexes. When the table is dropped, the file-per-tablespace is also dropped.

The server parameter **innodb_file_per_table** defines whether each newly created table is created in its own tablespace. By default, this parameter is set to ON. If **Innodb_file_per_table** is set to OFF, then new tables are created in the system tablespace.

> [!TIP]
> For best performance, do not change the **innodb_file_per table** default.

## General tablespace

If you want to store tables in a tablespace you create, use the syntax:

```sql
CREATE TABLESPACE mytablespace ADD DATAFILE '/var/lib/mysql/mytablespace.ibd' engine = Innodb;
```

To create a table in the general tablespace you've created, use the following syntax:

```sql
CREATE TABLE new_table (myID INT) TABLESPACE = mytablespace;
```

When you create a general tablespace, the datafile location is optional. The following syntax will also work:

```sql
CREATE TABLESPACE mytablespace ADD DATAFILE 'mytablespace.ibd' engine = Innodb;
```

General tablespace doesn't get dropped automatically, even if all the tables they contain have been dropped. To drop a general tablespace:

```sql
DROP TABLESPACE mytablespace;
```

Generally, it's better to keep the default of creating each new table in its own file-per-tablespace. If you've a high number of small tables, there may be some unused space or fragmentation which needs to be managed, but overall performance will be better.

## Tablespace best practice

- Create all tables in the **innodb_file_per_table** tablespace.
- If any one table that is larger than 1 TB in size, consider [partitioning](https://dev.mysql.com/doc/refman/5.7/en/partitioning.html)the table.
- Even for large tables, consider using the file-per-table tablespace. This prevents the system tablespace exceeding the maximum storage limit.
