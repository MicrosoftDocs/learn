InnoDb is the default storage engine in Azure Database for MySQL. If you do not define an alternative storage engine, InnoDb will be used.

In Azure Database for MySQL, you can display or modify the default storage engine in **Server parameters**. In the Azure portal, navigate to your MySQL server, and **Server parameters**. Search for **default_storage_engine**. The allowed values are INNODB, CSV, and MEMORY.

> [!NOTE]
> MySQL supports different storage engines at the table level. Azure database for MySQL currently supports InnoDB, Memory, and CSV.

It is good practice, however, to specify the storage engine you want to use. When you create a script, the syntax is:

```sql
CREATE TABLE mytable (myID INT) ENGINE = INNODB;

-- Storage engine = CSV

CREATE TABLE `mycats`.`myowners` (
`OwnerID` INT NOT NULL,
`OwnerName` VARCHAR(45) NOT NULL,
`OwnerTown` VARCHAR(25) NOT NULL)

ENGINE = CSV;

CREATE TABLE mytable2 (myID INT) ENGINE = MEMORY;
```

You can also create a table using MySQL Workbench, or another integrated development environment (IDE). The New Table dialog box includes the option to specify the storage engine, with a drop-down box displaying a list of possible storage engines.

:::image type="content" source="../media/storage-engine.png" alt-text="Screenshot showing the table Description automatically generated." lightbox="../media/storage-engine.png":::

> [!NOTE]
> Not all the storage engine options in MySQL Workbench will be supported for your MySQL server configuration. In Azure Database for MySQL, the server parameter **disabled_storage_engines** displays the storage engines that cannot be used to create tables. This is a static parameter and cannot be changed.

## SHOW ENGINE statement

The SHOW ENGINE statement displays operational information a storage engine. The SHOW ENGINE statement syntax is:

```sql
SHOW ENGINE engine_name {STATUS | MUTEX}
```

To display information from InnoDB Monitor about the state of the InnoDB storage engine, run:

```sql
SHOW ENGINE INNODB STATUS;
```

If SHOW ENGINE INNODB STATUS returns no results, it means that no operations have been performed during the current session.

> [!NOTE]
> There are two similar SHOW ENGINE statements. SHOW ENGINES displays information about supported storage engines. SHOW ENGINE displays operational information about a storage engine.
