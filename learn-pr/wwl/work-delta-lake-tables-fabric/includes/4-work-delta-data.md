---
ms.custom:
  - build-2023
---
You can work with delta tables (or delta format files) to retrieve and modify data in multiple ways.

## Using Spark SQL

The most common way to work with data in delta tables in Spark is to use Spark SQL. You can embed SQL statements in other languages (such as PySpark or Scala) by using the **spark.sql** library. For example, the following code inserts a row into the **products** table.

```python
spark.sql("INSERT INTO products VALUES (1, 'Widget', 'Accessories', 2.99)")
```

 Alternatively, you can use the `%%sql` magic in a notebook to run SQL statements.

```sql
%%sql

UPDATE products
SET Price = 2.49 WHERE ProductId = 1;
```

## Use the Delta API

When you want to work with delta files rather than catalog tables, it may be simpler to use the Delta Lake API. You can create an instance of a **DeltaTable** from a folder location containing files in delta format, and then use the API to modify the data in the table.

```python
from delta.tables import *
from pyspark.sql.functions import *

# Create a DeltaTable object
delta_path = "Files/mytable"
deltaTable = DeltaTable.forPath(spark, delta_path)

# Update the table (reduce price of accessories by 10%)
deltaTable.update(
    condition = "Category == 'Accessories'",
    set = { "Price": "Price * 0.9" })
```

## Use *time travel* to work with table versioning

Modifications made to delta tables are logged in the transaction log for the table. You can use the logged transactions to view the history of changes made to the table and to retrieve older versions of the data (known as *time travel*)

To see the history of a table, you can use the `DESCRIBE` SQL command as shown here.

```sql
%%sql

DESCRIBE HISTORY products
```

The results of this statement show the transactions that have been applied to the table, as shown here (some columns have been omitted):

| version | timestamp | operation | operationParameters |
| -- | -- | -- | -- |
| 2 | 2023-04-04T21:46:43Z | UPDATE	| {"predicate":"(ProductId = 1)"} |
| 1	| 2023-04-04T21:42:48Z | WRITE | {"mode":"Append","partitionBy":"[]"} |
| 0	| 2023-04-04T20:04:23Z | CREATE TABLE | {"isManaged":"true","description":null,"partitionBy":"[]","properties":"{}"} |

To see the history of an external table, you can specify the folder location instead of the table name.

```sql
%%sql

DESCRIBE HISTORY 'Files/mytable'
```

You can retrieve data from a specific version of the data by reading the delta file location into a dataframe, specifying the version required as a `versionAsOf` option:

```python
df = spark.read.format("delta").option("versionAsOf", 0).load(delta_path)
```

Alternatively, you can specify a timestamp by using the `timestampAsOf` option:

```python
df = spark.read.format("delta").option("timestampAsOf", '2022-01-01').load(delta_path)
