The extract, transform, and load (ETL) process takes data from one or more sources, transforms it (normally by adding structure), and then loads it into a target database.

A common ETL job takes log files from a web server, parses out the pertinent fields so that the data can be readily queried, and then loads the data into a database.

ETL may seem simple: applying structure to data so that it’s in the desired form. But the complexity of ETL is in the details. Data engineers who are building ETL pipelines must understand how to:

- Optimize data formats and connections.
- Determine the ideal schema.
- Handle corrupt records.
- Automate workloads.

![An illustration showing an overview of the ETL process.](../media/etl-overview.png)

## The Spark approach

Spark offers a compute engine and connectors to virtually any data source. By using easily scaled infrastructure and accessing data where it lives, Spark addresses the core needs of a big-data application.

The following principles make up the Spark approach to ETL and provide a unified and scalable approach to big-data pipelines:

- Databricks and Spark offer a unified platform.
  - Spark on Databricks combines ETL, stream processing, machine learning, and collaborative notebooks.
  - Data scientists, analysts, and engineers can write Spark code in Python, Scala, SQL, and R.
- Spark's unified platform is scalable to petabytes of data and clusters of thousands of nodes.
  - The same code written on smaller datasets scales to large workloads, often with only minor changes.
- Spark on Databricks decouples data storage from the compute and query engine.
  - Spark's query engine connects to any number of data sources, such as S3, Azure Blob storage, Redshift, and Kafka.
  - This approach minimizes costs because there's no need to maintain a dedicated cluster, and you can easily update the compute cluster to the latest version of Spark.

![An illustration showing the various capabilities of Apache Spark.](../media/spark-approach.png)

## ETL process

A typical ETL process in Databricks includes the following steps:

1. **Extraction:** By using Java Database Connectivity (JDBC), you can virtually connect to any data store, including Azure Blob storage. Databricks supports connections to multiple database types, including:

   - Traditional databases, like PostgreSQL, SQL Server, and MySQL.
   - Message brokers, like Kafka and Kinesis.
   - Distributed databases, like Cassandra and Redshift.
   - Data warehouses, like Hive and Azure Cosmos DB.
   - File types, like CSV, Parquet, and Avro.

1. **Data validation:** One aspect of ETL jobs is to validate that the data is what you expect. The data-validation step primarily includes determining:

   - Approximately the expected number of records.
   - Whether the expected fields are present.
   - That there are no unexpected missing values.

1. **Transformation:** This step generally includes applying structure and a schema to your data so that you can transform it into the desired format. Schemas can be applied to tabular data, such as data found in CSV files or relational databases, or to semistructured data, such as JSON data.

1. **Corrupt record handling:** Handling bad data is also an important part of the entire ETL process. The built-in functions of Databricks allow you to handle corrupt data, such as:

   - Missing and incomplete information.
   - Schema mismatches.
   - Differing formats or data types.
   - User errors when creating data producers.

1. **Loading data:** A common and highly effective design pattern in the Databricks and Spark ecosystem involves loading structured data back to the Databricks File System (DBFS) as a Parquet file. Databricks also allows you to put code into production by scheduling notebooks for regular execution.

In this module, we'll explore some basic ETL techniques by using Azure Databricks.