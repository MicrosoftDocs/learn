Delta lake is built on tables, which provide a relational storage abstraction over files in a data lake.

## Creating a Delta Lake table from a dataframe

One of the easiest ways to create a Delta Lake table is to save a dataframe in the *delta* format, specifying a path where the data files and related metadata information for the table should be stored.

For example, the following PySpark code loads a dataframe with data from an existing file, and then saves that dataframe to a new folder location in *delta* format:

```python
# Load a file into a dataframe
df = spark.read.load('/data/mydata.csv', format='csv', header=True)

# Save the dataframe as a delta table
delta_table_path = "/delta/mydata"
df.write.format("delta").save(delta_table_path)
```

After saving the delta table, the path location you specified includes parquet files for the data (regardless of the format of the source file you loaded into the dataframe) and a **_delta_log** folder containing the transaction log for the table.

> [!NOTE]
> The transaction log records all data modifications to the table. By logging each modification, transactional consistency can be enforced and versioning information for the table can be retained.

You can replace an existing Delta Lake table with the contents of a dataframe by using the **overwrite** mode, as shown here:

```python
new_df.write.format("delta").mode("overwrite").save(delta_table_path)
```

You can also add rows from a dataframe to an existing table by using the **append** mode:

```python
new_rows_df.write.format("delta").mode("append").save(delta_table_path)
```

## Making conditional updates

While you can make data modifications in a dataframe and then replace a Delta Lake table by overwriting it, a more common pattern in a database is to insert, update or delete rows in an existing table as discrete transactional operations. To make such modifications to a Delta Lake table, you can use the **DeltaTable** object in the Delta Lake API, which supports *update*, *delete*, and *merge* operations. For example, you could use the following code to update the **price** column for all rows with a **category** column value of "Accessories":

```python
from delta.tables import *
from pyspark.sql.functions import *

# Create a deltaTable object
deltaTable = DeltaTable.forPath(spark, delta_table_path)

# Update the table (reduce price of accessories by 10%)
deltaTable.update(
    condition = "Category == 'Accessories'",
    set = { "Price": "Price * 0.9" })
```

The data modifications are recorded in the transaction log, and new parquet files are created in the table folder as required.

> [!TIP]
> For more information about using the Delta Lake API, see [the Delta Lake API documentation](https://docs.delta.io/latest/delta-apidoc.html).

## Querying a previous version of a table

Delta Lake tables support versioning through the transaction log. The transaction log records modifications made to the table, noting the timestamp and version number for each transaction. You can use this logged version data to view previous versions of the table - a feature known as *time travel*.

You can retrieve data from a specific version of a Delta Lake table by reading the data from the delta table location into a dataframe, specifying the version required as a `versionAsOf` option:

```python
df = spark.read.format("delta").option("versionAsOf", 0).load(delta_table_path)
```

Alternatively, you can specify a timestamp by using the `timestampAsOf` option:

```python
df = spark.read.format("delta").option("timestampAsOf", '2022-01-01').load(delta_table_path)