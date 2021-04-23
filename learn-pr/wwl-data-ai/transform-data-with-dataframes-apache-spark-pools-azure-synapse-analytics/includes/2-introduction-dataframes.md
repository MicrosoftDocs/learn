DataFrames are a collection of data organized into named columns. DataFrames enable Apache Spark to understand the schema of the data, and optimize any execution plans on queries that will access the data held in the DataFrame. DataFrames are designed to process a large volume of data from a wide variety of data sources from structured data sources through to Resilient Distributed Datasets (RDDs) in either a batch or streaming data architecture. In short, DataFrames are to Apache Spark, what tables are to relational databases.

The first step is to construct a DataFrame. You can create a DataFrame and populate it with data at execution time as shown in the following example:

   ```python
   new_rows = [('CA',22, 45000),("WA",35,65000) ,("WA",50,85000)]
   demo_df = spark.createDataFrame(new_rows, ['state', 'age', 'salary'])
   demo_df.show()
   ```

In the example above, the variable named **new_rows** creates the data in the code segment to store in the DataFrame. Then a second variable named **demo_df** is created to use the spark.createDataFrame method, which refers to the **new_rows** variable in the first parameter, and in the second parameter defines the column heading names for the DataFrame as state, age, and salary. The third line uses the show method to output the results of the **demo_df** variable.

However, it is more common to ingest data from a data source such as a file into a DataFrame as shown in the next example:

```python
from azureml.opendatasets import NycTlcYellow

data = NycTlcYellow()
data_df = data.to_spark_dataframe()
display(data_df.limit(10))
```

In this example, the New York Taxi open-source data is imported and stored in a variable named data. The second line creates an Apache Spark DataFrame in a variable named data_df using the to_spark_dataframe() method. Finally, 10 rows of data are returned back from the data_df variable using the display method.

Once you're at the stage where you have populated a DataFrame with data, you manipulate the data stored in a DataFrame. The manipulation of data can be done with User Defined Functions (UDFs) that are column-based and help you transform and manipulate the data stored in a DataFrame.