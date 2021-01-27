In this section, you will learn about how, you can transfer data to or from a dedicated SQL pool using a Pyspark Connector. 
If you're using the notebook experience from the Synapse Studio environment linked to your workspace resource, it is imperative to know that it is not required to use import statements. 
Import statements are only required when you don't go through the integrated notebook experience. 
In addition to the above, the Pyspark connector currently works only in scala.

The examples that are given in this article, only keep in mind that you use the integrated notebook experience. 

So how does the pyspark connector work in order to transfer data to and from a dedicated SQL pool?
Let's say that you have created or loaded a dataframe called "pyspark_df".
Assume that you want to write that dataframe into the DataWarehouse.
How would you go about that task?

The first thing to do is to create a temp table using the dataframe in PySpark.
Below you can find an example on how to do so:

```py
pyspark_df.createOrReplaceTempView("pysparkdftemptable")
```
The parameter that is passed through is the temporary table name, which in this case is called: "pysparkdftemptable"
We are still using the pyspark_df dataframe as you can see in the beginning of the statement. 

Next, you would have to run a Scala cell in the PySpark notebook using magics (since we're using different languages and as mentioned above, it will only work in scala):

```scala
%%spark
val scala_df = spark.sqlContext.sql ("select * from pysparkdftemptable")

scala_df.write.sqlanalytics("sqlpool.dbo.PySparkTable", Constants.INTERNAL)
```
By using val scala_df, we create a fixed value for the scala_dataframe. 
In the statement, select * from pysparkdftemptable we basically say that we want all the data that we created in the temp table in the previous step, and passing this through by defining the scala_df that is now the same as the pysparkdftemptable. 

In the second line of the code, we specified following parameters:
* DBName: sqlpool
* Schema: dbo
* TableName: PySparkTable
* TableType: specification of the type of table, which has the value Constants.INTERNAL, which related to a  Managed table in the dedicated SQL pool.

In the same way this was the write scenario, you can follow the steps to read the data too. 
Keep in mind that you read the data using scala first. 
Second, write it into a temp table. 
Third, use Spark SQL in PySpark to query the temp table into a dataframe. 


