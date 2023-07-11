---
ms.custom:
  - build-2023
---
When you create a table in a Microsoft Fabric lakehouse, a delta table is defined in the metastore for the lakehouse and the data for the table is stored in the underlying Parquet files for the table.

With most interactive tools in the Microsoft Fabric environment, the details of mapping the table definition in the metastore to the underlying files are abstracted. However, when working with Apache Spark in a lakehouse, you have greater control of the creation and management of delta tables.

## Creating a delta table from a dataframe

One of the easiest ways to create a delta table in Spark is to save a dataframe in the *delta* format. For example, the following PySpark code loads a dataframe with data from an existing file, and then saves that dataframe as a delta table:

```python
# Load a file into a dataframe
df = spark.read.load('Files/mydata.csv', format='csv', header=True)

# Save the dataframe as a delta table
df.write.format("delta").saveAsTable("mytable")
```

The code specifies that the table should be saved in delta format with a specified table name. The data for the table is saved in Parquet files (regardless of the format of the source file you loaded into the dataframe) in the **Tables** storage area in the lakehouse, along with a **_delta_log** folder containing the transaction logs for the table. The table will be listed in the **Tables** folder for the lakehouse in the **Data explorer** pane.

## *Managed* vs *external* tables

In the previous example, the dataframe was saved as a *managed* table; meaning that the table definition in the metastore and the underlying data files are both managed by the Spark runtime for the Fabric lakehouse. Deleting the table will also delete the underlying files from the **Tables** storage location for the lakehouse.

You can also create tables as *external* tables, in which the relational table definition in the metastore is mapped to an alternative file storage location. For example, the following code creates an external table for which the data is stored in the folder in the **Files** storage location for the lakehouse:

```python
df.write.format("delta").saveAsTable("myexternaltable", path="Files/myexternaltable")
```

In this example, the table definition is created in the metastore (so the table is listed in the **Tables** user interface for the lakehouse), but the Parquet data files and JSON log files for the table are stored in the **Files** storage location (and will be shown in the **Files** node in the **Lakehouse explorer** pane).

You can also specify a fully qualified path for a storage location, like this:

```python
df.write.format("delta").saveAsTable("myexternaltable", path="abfss://my_store_url..../myexternaltable")
```

Deleting an external table from the lakehouse metastore <u>does not</u> delete the associated data files.

## Creating table metadata

While it's common to create a table from existing data in a dataframe, there are often scenarios where you want to create a table definition in the metastore that will be populated with data in other ways. There are multiple ways you can accomplish this goal.

### Use the *DeltaTableBuilder* API

The **DeltaTableBuilder** API enables you to write Spark code to create a table based on your specifications. For example, the following code creates a table with a specified name and columns.

```python
from delta.tables import *

DeltaTable.create(spark) \
  .tableName("products") \
  .addColumn("Productid", "INT") \
  .addColumn("ProductName", "STRING") \
  .addColumn("Category", "STRING") \
  .addColumn("Price", "FLOAT") \
  .execute()
```

### Use Spark SQL

You can also create delta tables by using the Spark SQL `CREATE TABLE` statement, as shown in this example:

```sql
%%sql

CREATE TABLE salesorders
(
    Orderid INT NOT NULL,
    OrderDate TIMESTAMP NOT NULL,
    CustomerName STRING,
    SalesTotal FLOAT NOT NULL
)
USING DELTA
```

The previous example creates a managed table. You can also create an external table by specifying a `LOCATION` parameter, as shown here:

```sql
%%sql

CREATE TABLE MyExternalTable
USING DELTA
LOCATION 'Files/mydata'
```

When creating an external table, the schema of the table is determined by the Parquet files containing the data in the specified location. This approach can be useful when you want to create a table definition that references data that has already been saved in delta format, or based on a folder where you expect to ingest data in delta format.

## Saving data in delta format

So far you've seen how to save a dataframe as a delta table (creating both the table schema definition in the metastore and the data files in delta format) and how to create the table definition (which creates the table schema in the metastore without saving any data files). A third possibility is to save data in delta format without creating a table definition in the metastore. This approach can be useful when you want to persist the results of data transformations performed in Spark in a file format over which you can later "overlay" a table definition or process directly by using the delta lake API.

For example, the following PySpark code saves a dataframe to a new folder location in *delta* format:

```python
delta_path = "Files/mydatatable"
df.write.format("delta").save(delta_path)
```

After saving the delta file, the path location you specified includes Parquet files containing the data and a **_delta_log** folder containing the transaction logs for the data. Any modifications made to the data through the delta lake API or in an external table that is subsequently created on the folder will be recorded in the transaction logs.

You can replace the contents of an existing folder with the data in a dataframe by using the **overwrite** mode, as shown here:

```python
new_df.write.format("delta").mode("overwrite").save(delta_path)
```

You can also add rows from a dataframe to an existing folder by using the **append** mode:

```python
new_rows_df.write.format("delta").mode("append").save(delta_path)
```

> [!TIP]
> If you use the technique described here to save a dataframe to the **Tables** location in the lakehouse, Microsoft Fabric uses an automatic table discovery capability to create the corresponding table metadata in the metastore.
