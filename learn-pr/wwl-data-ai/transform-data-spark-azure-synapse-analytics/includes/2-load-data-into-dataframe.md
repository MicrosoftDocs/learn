
When you initially create a notebook with Azure Synapse Analytics, simply select a primary language like Python. Suppose you or a colleague prefers to use another language after creation. In that case, the integrated platform experience allows you to switch between multiple other languages. You can accomplish this using nothing more than what's referred to as a 'magic' key and is placed directly above your new code. The magic keys available are: 
 
 ```python
%%sql #SparkSQL
%%md #MarkDown
%%spark #Scala
%%pyspark #Python
%%csharp #.NET for Spark C#
%%sparkr  #R
 ```

### Load source data

To load data into a dataframe, you use the spark.read function, specifying the file format, path, and optionally the schema of the data to be read. For example, the following code loads data from all .csv files in the data folder into a dataframe named order_details and then displays the first five records.

```python

order_details = spark.read.csv('/data/*.csv', header=True, inferSchema=True)
display(order_details.limit(5))


```
### Transform the data structure

After loading the source data into a dataframe, you can use the dataframe object's methods and Spark functions to transform it. Typical operations on a dataframe include :

- Filtering rows and columns.
- Renaming columns.
- Creating new columns, often derived from existing ones.
- Replacing null or other values.

In the following example, the code uses the split function to separate the values in the CustomerName column into two new columns named FirstName and LastName. Then it uses the drop method to delete the original CustomerName column.

```python
from pyspark.sql.functions import split, col

# Create the new FirstName and LastName fields
transformed_df = order_details.withColumn("FirstName", split(col("CustomerName"), " ").getItem(0)).withColumn("LastName", split(col("CustomerName"), " ").getItem(1))

# Remove the CustomerName field
transformed_df = transformed_df.drop("CustomerName")

display(transformed_df.limit(5))
```

You can use the full power of the Spark SQL library to transform the data by filtering rows, deriving, removing, renaming columns, and any applying other required data modifications.

### Save the transformed data

Once your dataFrame is in the structure you like, you can save the results to a supported format in your data lake.

At this point we'll now want to save our dataFrame into a parquet file in order to take advantage of the distributed architecture in the data lake which improves performance on the client side queries.

```python

transformed_df.write.mode("overwrite").parquet('/transformed_data/orders.parquet')
print ("Transformed data saved!")

```

 > [!Note]
 > The Parquet format is typically preferred for data files that you will use for further analysis or ingestion into an analytical store. Parquet is a very efficient format that is supported by most large scale data analytics systems. In fact, sometimes your data transformation requirement may simply be to convert data from another format (such as CSV) to Parquet!
