After setting up a notebook and attaching it to a cluster, you can use Spark to read and process data files. Spark supports a wide range of formats—such as CSV, JSON, Parquet, ORC, Avro, and Delta—and Databricks provides built-in connectors to access files stored in the workspace, in Azure Data Lake or Blob Storage, or in other external systems.

The workflow usually follows three steps:

1. **Read** a file into a Spark DataFrame using spark.read with the correct format and path. When reading raw text formats like CSV or JSON, Spark can infer the schema (column names and data types), but this is sometimes slow or unreliable. A better practice in production is to define the schema explicitly so that the data is loaded consistently and efficiently.
   
2. **Explore and transform** the DataFrame using SQL or DataFrame operations (for example, filtering rows, selecting columns, aggregating values).
   
3. **Write** the results back to storage in a chosen format.

Working with files in Spark is designed to be consistent across small and large datasets. The same code used to test a small CSV file will also work on much larger datasets, since Spark distributes the work across the cluster. This makes it easier to scale up from quick exploration to more complex data processing.

## Loading data into a dataframe

Let's explore a hypothetical example to see how you can use a dataframe to work with data. Suppose you have the following data in a comma-delimited text file named **products.csv** in the **data** folder in your Databricks File System (DBFS) storage:

```csv
ProductID,ProductName,Category,ListPrice
771,"Mountain-100 Silver, 38",Mountain Bikes,3399.9900
772,"Mountain-100 Silver, 42",Mountain Bikes,3399.9900
773,"Mountain-100 Silver, 44",Mountain Bikes,3399.9900
...
```

In a Spark notebook, you could use the following PySpark code to load the data into a dataframe and display the first 10 rows:

```python
%pyspark
df = spark.read.load('/data/products.csv',
    format='csv',
    header=True
)
display(df.limit(10))
```

The `%pyspark` line at the beginning is called a *magic*, and tells Spark that the language used in this cell is PySpark. Here's the equivalent Scala code for the products data example:

```scala
%spark
val df = spark.read.format("csv").option("header", "true").load("/data/products.csv")
display(df.limit(10))
```

The magic `%spark` is used to specify Scala.

> [!TIP]
> You can also select the language you want to use for each cell in the Notebook interface.

Both of the examples shown previously would produce output like this:

| ProductID | ProductName | Category | ListPrice |
|--|--|--|--|
| 771 | Mountain-100 Silver, 38 | Mountain Bikes | 3399.9900 |
| 772 | Mountain-100 Silver, 42 | Mountain Bikes | 3399.9900 |
| 773 | Mountain-100 Silver, 44 |Mountain Bikes | 3399.9900 |
| ... | ... | ... | ... |

## Specifying a dataframe schema

In the previous example, the first row of the CSV file contained the column names, and Spark was able to infer the data type of each column from the data it contains. You can also specify an explicit schema for the data, which is useful when the column names aren't included in the data file, like this CSV example:

```csv
771,"Mountain-100 Silver, 38",Mountain Bikes,3399.9900
772,"Mountain-100 Silver, 42",Mountain Bikes,3399.9900
773,"Mountain-100 Silver, 44",Mountain Bikes,3399.9900
...
```

The following PySpark example shows how to specify a schema for the dataframe to be loaded from a file named **product-data.csv** in this format:

```python
from pyspark.sql.types import *
from pyspark.sql.functions import *

productSchema = StructType([
    StructField("ProductID", IntegerType()),
    StructField("ProductName", StringType()),
    StructField("Category", StringType()),
    StructField("ListPrice", FloatType())
    ])

df = spark.read.load('/data/product-data.csv',
    format='csv',
    schema=productSchema,
    header=False)
display(df.limit(10))
```

The results would once again be similar to:

| ProductID | ProductName | Category | ListPrice |
|--|--|--|--|
| 771 | Mountain-100 Silver, 38 | Mountain Bikes | 3399.9900 |
| 772 | Mountain-100 Silver, 42 | Mountain Bikes | 3399.9900 |
| 773 | Mountain-100 Silver, 44 |Mountain Bikes | 3399.9900 |
| ... | ... | ... | ... |

## Filtering and grouping dataframes

You can use the methods of the Dataframe class to filter, sort, group, and otherwise manipulate the data it contains. For example, the following code example uses the `select` method to retrieve the **ProductName** and **ListPrice** columns from the **df** dataframe containing product data in the previous example:

```python
pricelist_df = df.select("ProductID", "ListPrice")
```

The results from this code example would look something like this:

| ProductID | ListPrice |
|--|--|
| 771 | 3399.9900 |
| 772 | 3399.9900 |
| 773 | 3399.9900 |
| ... | ... |

In common with most data manipulation methods, `select` returns a new dataframe object.

> [!TIP]
> Selecting a subset of columns from a dataframe is a common operation, which can also be achieved by using the following shorter syntax:
>
> `pricelist_df = df["ProductID", "ListPrice"]`

You can "chain" methods together to perform a series of manipulations that results in a transformed dataframe. For example, this example code chains the `select` and `where` methods to create a new dataframe containing the **ProductName** and **ListPrice** columns for products with a category of **Mountain Bikes** or **Road Bikes**:

```python
bikes_df = df.select("ProductName", "ListPrice").where((df["Category"]=="Mountain Bikes") | (df["Category"]=="Road Bikes"))
display(bikes_df)
```

The results from this code example would look something like this:

| ProductName | ListPrice |
|--|--|
| Mountain-100 Silver, 38 | 3399.9900 |
| Road-750 Black, 52 | 539.9900 |
| ... | ... |

To group and aggregate data, you can use the `groupby` method and aggregate functions. For example, the following PySpark code counts the number of products for each category:

```python
counts_df = df.select("ProductID", "Category").groupBy("Category").count()
display(counts_df)
```

The results from this code example would look something like this:

| Category | count |
|--|--|
| Headsets | 3 |
| Wheels | 14 |
| Mountain Bikes | 32 |
| ... | ... |


> [!NOTE]
> Spark DataFrames are **declarative and immutable**. Each transformation (like `select`, `filter`, or `groupBy`) creates a new DataFrame that represents what you want, not how it runs. This makes code reusable, optimizable, and free of side effects. But none of these transformations actually execute until you trigger an **action** (for example, `display`, `collect`, `write`), at which point Spark runs the full optimized plan.

## Using SQL expressions in Spark

The Dataframe API is part of a Spark library named Spark SQL, which enables data analysts to use SQL expressions to query and manipulate data.

### Creating database objects in the Spark catalog

The Spark catalog is a metastore for relational data objects such as views and tables. The Spark runtime can use the catalog to seamlessly integrate code written in any Spark-supported language with SQL expressions that may be more natural to some data analysts or developers.

One of the simplest ways to make data in a dataframe available for querying in the Spark catalog is to create a temporary view, as shown in the following code example:

```python
df.createOrReplaceTempView("products")
```

A *view* is temporary, meaning that it's automatically deleted at the end of the current session. You can also create *tables* that are persisted in the catalog to define a database that can be queried using Spark SQL.

> [!NOTE]
> We won't explore Spark catalog tables in depth in this module, but it's worth taking the time to highlight a few key points:
> 
> - You can create an empty table by using the `spark.catalog.createTable` method. Tables are metadata structures that store their underlying data in the storage location associated with the catalog. Deleting a table also deletes its underlying data.
> - You can save a dataframe as a table by using its `saveAsTable` method.
> - You can create an *external* table by using the `spark.catalog.createExternalTable` method. External tables define metadata in the catalog but get their underlying data from an external storage location; typically a folder in a data lake. Deleting an external table doesn't delete the underlying data.

### Using the Spark SQL API to query data

You can use the Spark SQL API in code written in any language to query data in the catalog. For example, the following PySpark code uses a SQL query to return data from the **products** view as a dataframe.

```python
bikes_df = spark.sql("SELECT ProductID, ProductName, ListPrice \
                      FROM products \
                      WHERE Category IN ('Mountain Bikes', 'Road Bikes')")
display(bikes_df)
```

The results from the code example would look similar to the following table:

| ProductName | ListPrice |
|--|--|
| Mountain-100 Silver, 38 | 3399.9900 |
| Road-750 Black, 52 | 539.9900 |
| ... | ... |

### Using SQL code

The previous example demonstrated how to use the Spark SQL API to embed SQL expressions in Spark code. In a notebook, you can also use the `%sql` magic to run SQL code that queries objects in the catalog, like this:

```sql
%sql

SELECT Category, COUNT(ProductID) AS ProductCount
FROM products
GROUP BY Category
ORDER BY Category
```

The SQL code example returns a result set that is automatically displayed in the notebook as a table, like the one below:

| Category | ProductCount |
|--|--|
| Bib-Shorts | 3 |
| Bike Racks | 1 |
| Bike Stands | 1 |
| ... | ... |
