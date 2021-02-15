In the previous topic we have discussed the transfer of data to or from a SQL Pool within the workspace of Synapse Analytics using Azure AD with the Azure Synapse Apache Spark Pool to Synapse SQL connector.
Another way to authenticate is using SQL Auth, instead of Azure AD with the Azure Synapse Apache Spark Pool to Synapse SQL connector.

Why is this good to know?
Currently, the Azure Synapse Apache Spark Pool to Synapse SQL connector does not support a token-based authentication to a dedicated SQL pool that is outside of the workspace of Synapse Analytics. 
In order to establish and transfer data to a dedicated SQL pool that is outside of the workspace without Azure AD, you would have to use SQL Auth. 

In order to read data from a dedicated SQL pool outside your workspace without Azure AD, you are enabled to use the Read API.
The Read API works for Internal tables (Managed Tables) as well as External Tables in the dedicated SQL pool. 

The Read API looks as follows when using SQL Auth:

```scala
val df = spark.read.
option(Constants.SERVER, "samplews.database.windows.net").
option(Constants.USER, <SQLServer Login UserName>).
option(Constants.PASSWORD, <SQLServer Login Password>).
sqlanalytics("<DBName>.<Schema>.<TableName>")
```

The parameters it takes in are:
* Constants.Server: specify the URL of the server
* Constants.USER: SQLServer Login UserName
* Constants.PASSWORD: SQLServer Login Password
* DBName: the name of the database.
* Schema: the schema definition such as dbo. 
* TableName: the name of the table you want to read data from.

In order to write data to a dedicated SQL Pool, you are enabled to use the Write API. 
What the write API does, is that it creates the table in the dedicated SQL pool.
Then, it invokes Polybase to load the data into the table that was created, in the dedicated SQL Pool.
One thing to bear in mind is that the table cannot already exist in the dedicated SQL pool.
If that happens, you'll receive an error stating: "There is already an object named..."

The Write API using SQL Auth looks as follows:

```scala
df.write.
option(Constants.SERVER, "samplews.database.windows.net").
option(Constants.USER, <SQLServer Login UserName>).
option(Constants.PASSWORD, <SQLServer Login Password>).
sqlanalytics("<DBName>.<Schema>.<TableName>", <TableType>)

The parameters it takes in are:
* Constants.Server: specify the URL of the server
* Constants.USER: SQLServer Login UserName
* Constants.PASSWORD: SQLServer Login Password
* DBName: the name of the database.
* Schema: the schema definition such as dbo. 
* TableName: the name of the table you want to read data from.
* TableType: specification of the type of table, which can have two values.
    * Constants.INTERNAL - Managed table in dedicated SQL pool
    * Constants.EXTERNAL - External table in dedicated SQL pool