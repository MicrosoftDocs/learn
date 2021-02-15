Let's talk about dataframes. 

What are dataframes?

Basically you could view DataFrames as you might see in excel.
It's like a box with squares in it, that organizes data, which we could also refer to as table of data. 

What does a table of data mean?

It is a single set of two-dimensional data that can have multiple rows and columns in the data. 
Each row, is a sample of data. 
Each column is a variable or parameter that is able to describe the row that contains the sample of data. 

Just like you organize your shoe cabinet. 
Each row of shoes in the cabinet is a sample of data. 
You might have different type of shoes that is, sneakers, pumps, which you could organize accordingly. 
These could become the variables or the column names for the shoes you put in the shoe cabinet. 

What would happen though, if you have thousands and thousands of drawers?

A DataFrame creates a data structure and it's one of the core data structures in Spark. 
In Spark, it is a distributed collection of that data that is organized into columns that have names. 

What you see in Data Engineering is that you start with reading or loading data that can be unstructured, semi-structured, or structured, store it in a DataFrame and start transforming that data in order to get insights. 
You can use different functionalities in order to do so like using Spark SQL, PySpark, and others. 
Usually when you see 'df' in some code it refers to a dataframe. 

You can either create your own dataframe as this example shows:

   ```python
   new_rows = [('CA',22, 45000),("WA",35,65000) ,("WA",50,85000)]
   demo_df = spark.createDataFrame(new_rows, ['state', 'age', 'salary'])
   demo_df.show()
   ```

Or load a file that contains data into a dataframe like in the below example where the open taxi dataset is used:

```python
from azureml.opendatasets import NycTlcYellow

data = NycTlcYellow()
data_df = data.to_spark_dataframe()
display(data_df.limit(10))
```

Once you're at the stage where you'd like to manipulate the data that is stored in a DataFrame, you can use User-Defined Functions (UDFs) that are column-based and help you transform and manipulate the data stored in a DataFrame. 


