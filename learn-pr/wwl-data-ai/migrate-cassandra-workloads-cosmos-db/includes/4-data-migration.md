Having planned and created the Cassandra API database in Azure Cosmos DB, the next stage is to migrate data into it from your on-premises server.

In your video camera manufacturer, you want to migrate data into Azure with no changes and with no recoding for the web application. You've been asked to choose and execute the most appropriate migration of data.

Here, you'll learn how to execute a database migration. You can either use the `CQLSH COPY` command to move local data to Azure Cosmos DB or you can use Spark.

## What is CQLSH?

Cassandra Query Language (CQL) is the native query language that administrators and developers use to define the data in a Cassandra Database, populate the database, and run queries against it. CQL is the Cassandra equivalent of SQL for structured databases but it has features that facilitate working with the semi-structured, tabular data you find in Cassandra.

CQLSH is a command-line tool that you can use to run CQL commands against a Cassandra database or a Cassandra API database in Azure Cosmos DB. It includes an interactive `COPY` command, which you can use to extract data from your on-premises database and import it into Cosmos DB.

## What is Apache Spark?

Apache Spark is a general-purpose framework for running computing tasks on clusters of computers. It is designed to handle large quantities of data and process it quickly by distributing tasks across members of the cluster and handling operations in memory.

Spark is open-source and often used for Extract, Transform, and Load (ETL) workloads, data-processing in real-time, and batch processing of large quantities of data at rest. It also has extensions that can perform machine learning, graph processing, and SQL operations.

For migrating a database to Cassandra API databases in Azure Cosmos DB, Spark is much more flexible than CQLSH. However it may take more work to set up and execute migrations.

Spark is the recommended method, however, as versions of Spark and Cassandra change, it can be more complex.

## CQLSH COPY

### Export the data from the Cassandra database

Initially, connect to your Cassandra database from the Azure Cloud Shell using SSH. Once you have connected to the server, perform the following steps:

1. Run the following command to start CQLSH:

    ```bash
    cqlsh -u <your username> -p <your password>
    ```

1. Run the following command for each table that you wish to migrate:

    ```bash
    COPY <keyspace name>.<table name>
    TO '<filename>.csv';
    ```

The command creates a .csv file, which contains all the data from the table.

### Import the data to Cosmos DB

To migrate data using CQLSH COPY, perform the following steps for each table:

1. Connect to your Cosmos DB account in the Azure portal.
1. In Settings, click **Connection String**, and copy the **PRIMARY CONNECTION STRING**.
1. Sign in to CQLSH with the primary connection string.
1. Copy local data to Cosmos DB using the COPY command:

    ```bash
    COPY <keyspace>.<table> FROM <table and data name>
    ```

> [!NOTE]
> For **keypace**, specify your keyspace, for **table**, specify your table name, and for **table and data name**, specify the table and data name that you specified during export.

## Migration with Spark

Apache Spark is a data processing framework that distributes processing tasks across multiple servers or containers in order to scale out to very large capacities. It's an ideal tool to use for migration when you have a large quantity of data to import into Azure Cosmos DB Cassandra API because you can scale the Spark cluster to process data very quickly. It also has extensive capabilities for transforming the data should that be necessary for your project.

You can use a Spark cluster on-premises or outside Azure. However, Azure provides the Databricks and HDInsight services for hosting clusters in Azure.

### Spark in Azure

If you want to run a Spark cluster in Azure, you can choose from these services:

- **Azure Databricks.** Databricks is a data analytics platform that has been optimized for and implemented on the Azure cloud. It includes Azure Databricks SQL Analytics for running SQL queries against a data lake. It also includes Azure Databricks Workspace, which enables collaboration on data processing by data engineers, data scientists, and machine learning engineers. The Databricks Workspace includes Spark for processing data.
- **Azure HDInsight.** HDInsight is a implementation of Hadoop in the Azure cloud and it helps users to process very large quantities of data. It includes Apache Spark for in-memory data processing on clustered computer nodes.

### Prerequisites

Before you start a migration from a Cassandra database into Azure Cosmos DB, you must satisfy the following requirements:

- In your Azure subscription, you must have created an Azure Cosmos DB account with the Cassandra API.
- You must have the account name, account endpoint, and key for the Azure Cosmos DB account.
- You must have created a Spark environment by using one of the Azure or external options described above.
- The Spark environment must include the Spark connector for Cassandra.
- The Spark environment must include the Azure Cosmos DB helper library for Cassandra API.

Both the connector and the helper library are JAR files that you can obtain from the Maven central repository. This Scala code shows how to configure these prerequisites in Spark:

```scala
import org.apache.spark.sql.cassandra._

//Include the Spark connector for Cassandra
import com.datastax.spark.connector._
import com.datastax.spark.connector.cql.CassandraConnector

//Include the Azure Cosmos DB helper library for Cassandra API
import com.microsoft.azure.cosmosdb.cassandra

//Configure the connection to Azure Cosmos DB Cassandra API
spark.conf.set("spark.cassandra.connection.host","YOUR_ACCOUNT_NAME.cassandra.cosmosdb.azure.com")
spark.conf.set("spark.cassandra.connection.port","10350")
spark.conf.set("spark.cassandra.connection.ssl.enabled","true")
spark.conf.set("spark.cassandra.auth.username","YOUR_ACCOUNT_NAME")
spark.conf.set("spark.cassandra.auth.password","YOUR_ACCOUNT_KEY")
spark.conf.set("spark.cassandra.connection.factory", "com.microsoft.azure.cosmosdb.cassandra.CosmosDbConnectionFactory")

//Configure Spark throughput properties
spark.conf.set("spark.cassandra.output.batch.size.rows", "1")
spark.conf.set("spark.cassandra.connection.connections_per_executor_max", "10")
spark.conf.set("spark.cassandra.output.concurrent.writes", "1000")
spark.conf.set("spark.cassandra.concurrent.reads", "512")
spark.conf.set("spark.cassandra.output.batch.grouping.buffer.size", "1000")
spark.conf.set("spark.cassandra.connection.keep_alive_ms", "600000000")
```

### Copy data between tables

Now, you can use Spark to copy data from the Cassandra database on-premises into Azure Cosmos DB. This Scala code shows how to execute the copy. Remember that you can use Spark's extensive ETL capabilities to transform the data if you need to adapt its format:

```scala
//Create a table in Cosmos DB
val cdbConnector = CassandraConnector(sc)
cdbConnector.withSessionDo(session => session.execute(
   "CREATE TABLE IF NOT EXISTS books_ks.
      books_copy(book_id TEXT PRIMARY KEY,book_author TEXT, book_name TEXT,book_pub_year INT,book_price FLOAT) 
      WITH cosmosdb_provisioned_throughput=4000;"))

//Read from the source table in the Cassandra DB on-premises
val readBooksDF = sqlContext
  .read
  .format("org.apache.spark.sql.cassandra")
  .options(Map( "table" -> "books", "keyspace" -> "books_ks"))
  .load

//Write data to the destination table in CosmosDB
readBooksDF.write
  .cassandraFormat("books_copy", "books_ks", "")
  .save()

//Validate the copy operation
sqlContext
  .read
  .format("org.apache.spark.sql.cassandra")
  .options(Map( "table" -> "books_copy", "keyspace" -> "books_ks"))
  .load
  .show
```

For more information on using Spark with Databricks, see [Access Azure Cosmos DB Cassandra API data from Azure Databricks](https://aka.ms/AA58ejm)

For more information on using an HDInsight cluster, see [Access Azure Cosmos DB Cassandra API from Spark on YARN with HDInsight](https://aka.ms/AA58ejn)

For more information on the Spark table copy operation, see [Table copy operations on Azure Cosmos DB Cassandra API from Spark](https://aka.ms/AA5p32s)
