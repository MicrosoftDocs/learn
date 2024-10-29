After creating and starting a SQL Warehouse, you can start to work with data in tables.

## Database schema

All SQL Warehouses contain a default database schema named **default**. You can use create tables in this schema in order to analyze data. However, if you need to work with multiple tables in a relational schema, or you have multiple analytical workloads where you want to manage the data (and access to it) separately, you can create custom database schema. To create a database, use the SQL editor to run a `CREATE DATABASE` or `CREATE SCHEMA` SQL statement. These statements are equivalent, but `CREATE SCHEMA` is preferred, as shown in this example:

```sql
CREATE SCHEMA salesdata;
```

> [!TIP]
> For more information, see [CREATE SCHEMA](/azure/databricks/sql/language-manual/sql-ref-syntax-ddl-create-schema) in the Azure Databricks documentation.

## Tables

You can use the user interface in the Azure Databricks portal to upload delimited data, or import data from a wide range of common data sources. The imported data is stored in files in Databricks File System (DBFS) storage, and a Delta table is defined for it in the Hive metastore.

If the data files already exist in storage, or you need to define an explicit schema for the table, you can use a `CREATE TABLE` SQL statement. For example, the following code creates a table named **salesorders** in the **salesdata** database, based on the */data/sales/* folder in DBFS storage.

```sql
CREATE TABLE salesdata.salesorders
(
    orderid INT,
    orderdate DATE,
    customerid INT,
    ordertotal DECIMAL
)
USING DELTA
LOCATION '/data/sales/';
```

> [!TIP]
> For more information, see [CREATE TABLE](/azure/databricks/sql/language-manual/sql-ref-syntax-ddl-create-table) in the Azure Databricks documentation.
