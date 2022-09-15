The default and most widely used MySQL storage engine is InnoDB. Azure Database for MySQL supports **InnoDB** for both single server and flexible server. In this unit you will learn about other common storage engines.

## MyISAM

The MyISAM storage engine is MySQL's legacy storage engine and was the default storage engine for many years. There are limitations with MyISAM, including that it does not guarantee that a write will get written to the disk. If the system crashes, tables may be corrupted, and data may be lost.

MyISAM does not support transactions; each individual statement is treated as a transaction. Nor does MyISAM support encryption. From MySQL version 8.0, MyISAM is no longer supported and it is also not supported on Azure Database for MySQL.

## Blackhole

Blackhole is a storage engine that does not store data. Data written to a table held in the Blackhole storage engine will be immediately discarded (it goes into a black hole). When you query a Blackhole table, it will return an empty result. The table definition is held in the global data dictionary, but there are no files associated with the table because the table will never store any data. As unlikely as it sounds, there are use cases for this storage engine. The Blackhole storage engine is not supported on Azure Database for MySQL.

## Archive

Archive **is** a specialist storage engine designed for archive data. The data is not indexed and is stored in a compressed and encrypted format. You can insert data into the file, but not delete or update it. The archive storage engine is not supported on Azure Database for MySQL.

## Federated

The Federated storage engine allows you to query data from a remote MySQL database. This storage engine is not enabled by default in MySQL and is not supported on Azure Database for MySQL.

> [!NOTE]
> Foreign keys are not supported by all storage engines. InnoDB does support foreign key constraints. For other storage engines, a foreign key constraint can be created, but it is ignored.
