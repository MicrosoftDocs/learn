In this section, you will learn about how, using Azure AD, you can transfer data to or from a dedicated SQL pool or database outside the workspace of your Synapse Analytics account.
If you're using the notebook experience from the Synapse Studio environment linked to your workspace resource, it is imperative to know that it is not required to use import statements. 
Import statements are only required when you don't go through the integrated notebook experience. 

Also, it is imperative to keep in mind that the Azure Synapse Apache Spark to Synapse SQL connector is designed for an optimized transfer of data between the serverless Apache Spark pools and SQL pools or databases outside the workspace of your Azure Synapse Analytics. 
At this moment, the Azure Synapse Apache Spark to Synapse SQL connectors only works on dedicated SQL pools. 
When you use serverless SQL Pools, the connector cannot be used. 
In addition to the above, the connector currently works only in scala. 

In this section, we will focus on transferring data to or from a dedicated SQL Pool or database that is outside the workspace of Synapse Analytics. 
It is based on the virtue that it goes through Azure AD. 

The first thing that is important is that the Constants and the SqlAnalyticsConnector are set up as shown below:

```scala
 import com.microsoft.spark.sqlanalytics.utils.Constants
 import org.apache.spark.sql.SqlAnalyticsConnector._
```

In order to read data from a dedicated SQL pool or database, you are enabled to use the Read API.
The Read API works for Internal tables (Managed Tables) as well as External Tables in the dedicated SQL pool. 
The Read API using Azure AD looks as follows:

```scala
val df = spark.read.
option(Constants.SERVER, "samplews.database.windows.net").
sqlanalytics("<DBName>.<Schema>.<TableName>")
```
The parameters it takes in are:
* Constants.Server: specify the URL of the server
* DBName: the name of the database.
* Schema: the schema definition such as dbo. 
* TableName: the name of the table you want to read data from.

In order to write data to a dedicated SQL Pool or database, you are enabled to use the Write API. 
What the write API does, is that it creates the table in the dedicated SQL pool or database. 
Then, it invokes Polybase to load the data into the table that was created, in the dedicated SQL Pool or database.
One thing to bear in mind is that the table cannot already exist in the dedicated SQL pool or database.
If that happens, you'll receive an error stating: "There is already an object named..."

An example of the Write API using Azure AD is as follows:

```scala
df.write.
option(Constants.SERVER, "samplews.database.windows.net").
sqlanalytics("<DBName>.<Schema>.<TableName>", <TableType>)
```
The parameters it takes in are:
* Constants.Server: specify the URL of the server
* DBName: the name of the database.
* Schema: the schema definition such as dbo. 
* TableName: the name of the table you want to read data from.
* TableType: specification of the type of table, which can have two values.
    * Constants.INTERNAL - Managed table in dedicated SQL pool
    * Constants.EXTERNAL - External table in dedicated SQL pool


