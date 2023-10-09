---
ms.custom:
  - build-2023
---
Natively, Spark uses a data structure called a *resilient distributed dataset* (RDD); but while you *can* write code that works directly with RDDs, the most commonly used data structure for working with structured data in Spark is the *dataframe*, which is provided as part of the *Spark SQL* library. Dataframes in Spark are similar to those in the ubiquitous *Pandas* Python library, but optimized to work in Spark's distributed processing environment.

> [!NOTE]
> In addition to the Dataframe API, Spark SQL provides a strongly-typed *Dataset* API that is supported in Java and Scala. We'll focus on the Dataframe API in this module.

## Loading data into a dataframe

Let's explore a hypothetical example to see how you can use a dataframe to work with data. Suppose you have the following data in a comma-delimited text file named **products.csv** in the **Files/data** folder in your lakehouse:

```csv
ProductID,ProductName,Category,ListPrice
771,"Mountain-100 Silver, 38",Mountain Bikes,3399.9900
772,"Mountain-100 Silver, 42",Mountain Bikes,3399.9900
773,"Mountain-100 Silver, 44",Mountain Bikes,3399.9900
...
```

### Inferring a schema

In a Spark notebook, you could use the following PySpark code to load the file data into a dataframe and display the first 10 rows:

```python
%%pyspark
df = spark.read.load('Files/data/products.csv',
    format='csv',
    header=True
)
display(df.limit(10))
```

The `%%pyspark` line at the beginning is called a *magic*, and tells Spark that the language used in this cell is PySpark. You can select the language you want to use as a default in the toolbar of the Notebook interface, and then use a magic to override that choice for a specific cell. For example, here's the equivalent Scala code for the products data example:

```scala
%%spark
val df = spark.read.format("csv").option("header", "true").load("Files/data/products.csv")
display(df.limit(10))
```

The magic `%%spark` is used to specify Scala.

Both of these code samples would produce output like this:

| ProductID | ProductName | Category | ListPrice |
| -- | -- | -- | -- |
| 771 | Mountain-100 Silver, 38 | Mountain Bikes | 3399.9900 |
| 772 | Mountain-100 Silver, 42 | Mountain Bikes | 3399.9900 |
| 773 | Mountain-100 Silver, 44 |Mountain Bikes | 3399.9900 |
| ... | ... | ... | ... |

### Specifying an explicit schema

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

df = spark.read.load('Files/data/product-data.csv',
    format='csv',
    schema=productSchema,
    header=False)
display(df.limit(10))
```

The results would once again be similar to:

| ProductID | ProductName | Category | ListPrice |
| -- | -- | -- | -- |
| 771 | Mountain-100 Silver, 38 | Mountain Bikes | 3399.9900 |
| 772 | Mountain-100 Silver, 42 | Mountain Bikes | 3399.9900 |
| 773 | Mountain-100 Silver, 44 |Mountain Bikes | 3399.9900 |
| ... | ... | ... | ... |

> [!TIP]
> Specifying an explicit schema also improves performance!

## Filtering and grouping dataframes

You can use the methods of the Dataframe class to filter, sort, group, and otherwise manipulate the data it contains. For example, the following code example uses the **select** method to retrieve the **ProductName** and **ListPrice** columns from the **df** dataframe containing product data in the previous example:

```python
pricelist_df = df.select("ProductID", "ListPrice")
```

The results from this code example would look something like this:

| ProductID | ListPrice |
| -- | -- |
| 771 | 3399.9900 |
| 772 | 3399.9900 |
| 773 | 3399.9900 |
| ... | ... |

In common with most data manipulation methods, **select** returns a new dataframe object.

> [!TIP]
> Selecting a subset of columns from a dataframe is a common operation, which can also be achieved by using the following shorter syntax:
>
> `pricelist_df = df["ProductID", "ListPrice"]`

You can "chain" methods together to perform a series of manipulations that results in a transformed dataframe. For example, this example code chains the **select** and **where** methods to create a new dataframe containing the **ProductName** and **ListPrice** columns for products with a category of **Mountain Bikes** or **Road Bikes**:

```python
bikes_df = df.select("ProductName", "Category", "ListPrice").where((df["Category"]=="Mountain Bikes") | (df["Category"]=="Road Bikes"))
display(bikes_df)
```

The results from this code example would look something like this:

| ProductName | Category | ListPrice |
| -- | -- | -- |
| Mountain-100 Silver, 38 | Mountain Bikes | 3399.9900 |
| Road-750 Black, 52 | Road Bikes | 539.9900 |
| ... | ... | ... |

To group and aggregate data, you can use the **groupBy** method and aggregate functions. For example, the following PySpark code counts the number of products for each category:

```python
counts_df = df.select("ProductID", "Category").groupBy("Category").count()
display(counts_df)
```

The results from this code example would look something like this:

| Category | count |
| -- | -- |
| Headsets | 3 |
| Wheels | 14 |
| Mountain Bikes | 32 |
| ... | ... |

## Saving a dataframe

You'll often want to use Spark to transform raw data and save the results for further analysis or downstream processing. The following code example saves the dataFrame into a *parquet* file in the data lake, replacing any existing file of the same name.

```python
bikes_df.write.mode("overwrite").parquet('Files/product_data/bikes.parquet')
```

 > [!Note]
 > The Parquet format is typically preferred for data files that you will use for further analysis or ingestion into an analytical store. Parquet is a very efficient format that is supported by most large scale data analytics systems. In fact, sometimes your data transformation requirement may simply be to convert data from another format (such as CSV) to Parquet!

### Partitioning the output file

Partitioning is an optimization technique that enables Spark to maximize performance across the worker nodes. More performance gains can be achieved when filtering data in queries by eliminating unnecessary disk IO.

To save a dataframe as a partitioned set of files, use the **partitionBy** method when writing the data. The following example saves the **bikes_df** dataframe (which contains the product data for the *mountain bikes* and *road bikes* categories), and partitions the data by category:

```python
bikes_df.write.partitionBy("Category").mode("overwrite").parquet("Files/bike_data")
```

The folder names generated when partitioning a dataframe include the partitioning column name and value in a ***column=value*** format, so the code example creates a folder named **bike_data** that contains the following subfolders:

- **Category=Mountain Bikes**
- **Category=Road Bikes**

Each subfolder contains one or more parquet files with the product data for the appropriate category.

> [!NOTE]
> You can partition the data by multiple columns, which results in a hierarchy of folders for each partitioning key. For example, you might partition sales order data by year and month, so that the folder hierarchy includes a folder for each year value, which in turn contains a subfolder for each month value.

## Load partitioned data

When reading partitioned data into a dataframe, you can load data from any folder within the hierarchy by specifying explicit values or wildcards for the partitioned fields. The following example loads data for products in the **Road Bikes** category:

```python
road_bikes_df = spark.read.parquet('Files/bike_data/Category=Road Bikes')
display(road_bikes_df.limit(5))
```

> [!NOTE]
> The partitioning columns specified in the file path are omitted in the resulting dataframe. The results produced by the example query would not include a **Category** column - the category for all rows would be *Road Bikes*.
