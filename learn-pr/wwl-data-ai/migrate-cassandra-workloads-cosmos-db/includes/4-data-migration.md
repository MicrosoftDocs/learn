You can either use the CQLSH COPY command to move local data to Azure Cosmos DB or you can use Spark.

Spark is the recommended method, however, as versions of Spark and Cassandra change, it can be more complex.

## CQLSH COPY

### Export the data from the Cassandra database

Initially, connect to your Cassandra database from the Azure Cloud Shell using SSH. Once you have connected to the server, perform the following steps:

1. Run the following command to start CQLSH:

```SQL
cqlsh -u <your username> -p <your password>
```


2. Run the following command for each table that you wish to migrate:

```SQL
copy <keyspace name>.<table name>
to '<table and data name>';
```

### Import the data to Cosmos DB

To migrate data using CQLSH COPY, perform the following steps for each table:

1. Connect to your Cosmos DB account in the Azure portal.
2. In Settings, click **Connection String**, and copy the **PRIMARY CONNECTION STRING**.
3. Sign in to CQLSH with the primary connection string.
4. Copy local data to Cosmos DB using the COPY command:

```SQL
COPY <keyspace>.<table> FROM <table and data name>
```

> [!NOTE]
> For **keypace**, specify your keyspace, for **table**, specify your table name, and for **table and data name**, specify the table and data name that you specified during export.

## Migration with Spark

To migrate data with Spark, initially provision an Azure Databricks or HDInsight cluster.
For more information on using Spark with Databricks, see [Access Azure Cosmos DB Cassandra API data from Azure Databricks](https://aka.ms/AA58ejm)

For more information on using an HDInsight cluster, see [Access Azure Cosmos DB Cassandra API from Spark on YARN with HDInsight](https://aka.ms/AA58ejn)

Next, use a Spark table copy operation to move the data.
For more information on the Spark table copy operation, see [Table copy operations on Azure Cosmos DB Cassandra API from Spark](https://aka.ms/AA5p32s)
