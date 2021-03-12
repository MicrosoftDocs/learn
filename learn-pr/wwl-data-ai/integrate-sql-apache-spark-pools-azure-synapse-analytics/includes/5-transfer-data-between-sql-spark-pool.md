In this section, you will learn about how, using Azure AD, you can transfer data to or from a dedicated SQL pool attached within the workspace you've created for you Synapse Analytics account. 
If you're using the notebook experience from the Synapse Studio environment linked to your workspace resource, it is imperative to know that it is not required to use import statements. 
Import statements are only required when you don't go through the integrated notebook experience. 
Also, it is imperative to keep in mind that the Azure Synapse Apache Spark to Synapse SQL connector is designed for an optimized transfer of data between the serverless Apache Spark pools and SQL pools in Azure Synapse Analytics. At this moment, the Azure Synapse Apache Spark to Synapse SQL connectors only works on dedicated SQL pools. 
When you use serverless SQL Pools, the connector cannot be used. 
In addition to the above, the connector currently works only in scala. 

In this section, we will focus on transferring data to or from a dedicated SQL Pool that is attached within the workspace of Synapse Analytics. 
It is based on the virtue that it goes through Azure AD.

The first thing that is imperative, is that the Constants and the SqlAnalyticsConnector are set up as shown below:

```scala
 import com.microsoft.spark.sqlanalytics.utils.Constants
 import org.apache.spark.sql.SqlAnalyticsConnector._
```

In order to read data from a dedicated SQL pool, you are enabled to use the Read API.
The Read API works for Internal tables (Managed Tables) as well as External Tables in the dedicated SQL pool. 
The Read API using Azure AD looks as follows:

```scala
val df = spark.read.sqlanalytics("<DBName>.<Schema>.<TableName>")
```
The parameters it takes in are:
* DBName: the name of the database.
* Schema: the schema definition such as dbo. 
* TableName: the name of the table you want to read data from.

In order to write data to a dedicated SQL Pool, you are enabled to use the Write API. 
What the write API does, is that it creates the table in the dedicated SQL pool.
Then, it invokes Polybase to load the data into the table that was created, in the dedicated SQL Pool.
One thing to bear in mind is that the table cannot already exist in the dedicated SQL pool.
If that happens, you'll receive an error stating: "There is already an object named..."

The Write API using Azure AD looks as follows:

```scala
df.write.sqlanalytics("<DBName>.<Schema>.<TableName>", <TableType>)
```
The parameters it takes in are:
* DBName: the name of the database.
* Schema: the schema definition such as dbo. 
* TableName: the name of the table you want to read data from.
* TableType: specification of the type of table, which can have two values.
    * Constants.INTERNAL - Managed table in dedicated SQL pool
    * Constants.EXTERNAL - External table in dedicated SQL pool

The TableType parameter in the Write API has some additional parameters to take into account as mentioned above. 
An example of a SQL pool-managed table looks as follows:

```scala
df.write.sqlanalytics("<DBName>.<Schema>.<TableName>", Constants.INTERNAL)
```

An example of a SQL pool external table comes with additional needed information before it's able to write the data into the external table. 
The requirement is that in order to write to the dedicated SQL pool external table, you need to have an EXTERNAL DATA SOURCE and an EXTERNAL FILE FORMAT that exists on the pool. 

So how do you specify writing to an external table in a dedicated SQL Pool? 
Below are some examples for creating just that, in the dedicated SQL pool.

```sql
--For an external table, you need to pre-create the data source and file format in dedicated SQL pool using SQL queries:
CREATE EXTERNAL DATA SOURCE <DataSourceName>
WITH
  ( LOCATION = 'abfss://...' ,
    TYPE = HADOOP
  ) ;

CREATE EXTERNAL FILE FORMAT <FileFormatName>
WITH (  
    FORMAT_TYPE = PARQUET,  
    DATA_COMPRESSION = 'org.apache.hadoop.io.compress.SnappyCodec'  
);
```
It is not necessary to create an EXTERNAL CREDENTIAL object if you are using Azure Active Directory pass-through authentication from the storage account. 
The only thin you need to take in mind is that you need to be a member of the "Storage Blob Data Contributor" role on the storage account.

The next step is to use the df.write command within scala with DATA_SOURCE, FILE_FORMAT, and the sqlanalytics command as similar to writing data to an internal table. 
The example is shown below:

```scala

df.write.
    option(Constants.DATA_SOURCE, <DataSourceName>).
    option(Constants.FILE_FORMAT, <FileFormatName>).
    sqlanalytics("<DBName>.<Schema>.<TableName>", Constants.EXTERNAL)

```