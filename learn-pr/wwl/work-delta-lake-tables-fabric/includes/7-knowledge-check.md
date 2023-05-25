---
ms.custom:
  - build-2023
---
## quiz title: Check your knowledge

## Multiple Choice

Which of the following descriptions best fits Delta Lake?

() A Spark API for exporting data from a relational database into CSV files. {{Incorrect. Delta Lake does not export data from a relational database into CSV files.}}

(x) A relational storage layer for Spark that supports tables based on Parquet files. {{Correct. Delta Lake provides a relational storage layer in which you can create tables based on Parquet files in a data lake.}}

() A synchronization solution that replicates data between SQL Server and SPark. {{Incorrect. Delta Lake does not replicate data between SQL Server and Spark.}}  

## Multiple Choice

You've loaded a Spark dataframe with data, that you now want to use in a delta table. What format should you use to write the dataframe to storage?

() CSV {{Incorrect. Delta Lake does not support tables based on CSV files.}}

() PARQUET {{Incorrect. Although Delta Lake tables are based on Parquet files, the format must also include a transaction log.}}

(x) DELTA {{Correct. Storing a dataframe in DELTA format creates parquet files for the data and the transaction log metadata necessary for Delta Lake tables.}}

## Multiple Choice

You have a managed table based on a folder that contains data files in delta format. If you drop the table, what happens?

(x) The table metadata and data files are deleted. {{Correct. The life-cycle of the metadata and data for a managed table are the same.}}

() The table definition is removed from the metastore, but the data files remain intact. {{Incorrect. The life-cycle of the metadata and data for a managed table are the same.}}

() The table definition remains in the metastore, but the data files are deleted. {{Incorrect. The life-cycle of the metadata and data for a managed table are the same.}}
