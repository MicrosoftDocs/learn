Within creating a notebook, you need to specify the pool that needs to be attached to the notebook that is, a SQL or Spark pool. 
When it comes to the languages, a notebook has to be set with a primary language. 

The primary languages available within the notebook environment are:
* PySpark (Python)
* Spark (Scala)
* .NET Spark (C#)
* Spark SQL

However, it is possible to use multiple languages in one notebook by specifying the language using a magic command at the beginning of a cell. 
The following table lists the magic commands to switch cell languages:

|Magic command |Language | Description |  
|---|------|-----|
|%%pyspark| Python | Execute a **Python** query against Spark Context.  |
|%%spark| Scala | Execute a **Scala** query against Spark Context.  |  
|%%sql| SparkSQL | Execute a **SparkSQL** query against Spark Context.  |
|%%csharp | .NET for Spark C# | Execute a **.NET for Spark C#** query against Spark Context. |

It is not possible to reference data or variables directly across different languages in a Synapse Studio notebook. 
In Spark, it is possible to reference a temporary table across languages. 

Here is an example of how to read a `Scala` DataFrame in `PySpark` and `SparkSQL` using a Spark temp table as a workaround.

* In Cell 1, the following code shows how you can read a DataFrame from a SQL pool connector using Scala.
It also shows how you can create a temporary table.

   ```scala
   %%spark
   val scalaDataFrame = spark.read.sqlanalytics("mySQLPoolDatabase.dbo.mySQLPoolTable")
   scalaDataFrame.createOrReplaceTempView( "mydataframetable" )
   ```

* If you want to query the data using Spark SQL, you can add a cell below the first cell and using the %%sql command enables you to use a SQL statement such as shown below where you would select everything from the 'mydataframetable'. 
   
   ```sql
   %%sql
   SELECT * FROM mydataframetable
   ```

* If you want to use the data in PySpark, below is given an example using the magic command %%pyspark, in which you create a new Python Dataframe based on the mydataframe table whilst using spark.sql to select everything from that table. 

   ```python
   %%pyspark
   myNewPythonDataFrame = spark.sql("SELECT * FROM mydataframetable")
   ```
You can use familiar Jupyter magic commands in Azure Synapse Studio notebooks. Review the following list as the current available magic commands. Tell us your use cases on GitHub so that we can continue to build out more magic commands to meet your needs.

Available line magics: %lsmagic, %time, %time it

Available cell magics: %%time, %%timeit, %%capture, %%writefile, %%sql, %%pyspark, %%spark, %%csharp
