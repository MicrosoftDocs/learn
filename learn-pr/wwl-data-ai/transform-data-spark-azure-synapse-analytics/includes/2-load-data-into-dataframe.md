
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

Let's Start by populating a dataframe in your notebook. 

In the below example we're reading historical sales order data from our **data** directory into a dataframe (df). .

```python

order_details = spark.read.csv('/data/*.csv', header=True, inferSchema=True)
display(order_details.limit(5))


```
### Transform the data structure

We'll now want to transform some of the data, in this case we'll want to *split* the **CustomerName** field into two new fields **FirstName** and **LastName**. We'll then *drop* the **CustomerName** field from the dataframe and show the new headers and five records in the results.

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

Once your dataframe is in the structure you like, you can save the results to a supported format in your data lake.

In the following code, you'll be saving your dataframe into a parquet file. 

>[!Warning] the code below will overwrite the *orders.parquet* if it already exists in the **transformed_data** folder.

```python

transformed_df.write.mode("overwrite").parquet('/transformed_data/orders.parquet')
print ("Transformed data saved!")

```

 >[!Note]
 >The Parquet format is typically preferred for data files that you will use for further analysis or ingestion into an analytical store. Parquet is a very efficient format that is supported by most large scale data analytics systems. In fact, sometimes your data transformation requirement may simply be to convert data from another format (such as CSV) to Parquet!
