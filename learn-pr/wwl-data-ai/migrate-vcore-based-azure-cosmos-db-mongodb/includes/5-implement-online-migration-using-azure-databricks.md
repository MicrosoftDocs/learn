Azure Databricks simplifies moving large MongoDB datasets to vCore-based Azure Cosmos DB for MongoDB, making the transfer of complex data more straightforward. It allows for detailed control over the migration pace and data transformations, effectively handling large datasets.

## Why use Azure Databricks?

Azure Databricks, a Platform as a Service (PaaS) for Apache Spark, introduces a streamlined, efficient method for both offline and online migration of databases from MongoDB. Its architecture is designed to support extensive datasets, making it a suitable choice for your migration projects.

## Prerequisites

Before you start the migration, ensure you have the following prerequisites:

- Confirm that your vCore-based Azure Cosmos DB for MongoDB account is active and properly configured. Make sure that you enabled a managed identity for your Azure MongoDB account and granted the necessary permissions to access the source MongoDB database.
- Provision an Azure Databricks cluster, selecting Databricks runtime *version 7.6* for optimal *Spark 3.0* compatibility.

![Screenshot of how to add the MongoDB migration extension to Azure Data Studio.](../media/5-create-databricks-cluster.png)

- Add the Maven *MongoDB Connector for Spark* library to your cluster. This library enables connections to both native MongoDB and Azure Cosmos DB endpoints.

## Perform the migration

You can create either a Python or Scala notebook in Azure Databricks to perform the migration. For example, if you want to migrate data from MongoDB to vCore-based Azure Cosmos DB for MongoDB using a Python notebook, you would add this code snippet to your notebook:

```python
from pyspark.sql import SparkSession
from azure.identity import DefaultAzureCredential

# Set up the managed identity credential
credential = DefaultAzureCredential()

# Retrieve the access token for Azure Cosmos DB
token = credential.get_token("https://cosmos.azure.com/.default")

# Construct the target connection string using the access token
target_account_name = "<ACCOUNTNAME>"  # Replace with your Cosmos DB account name
target_connection_string = (
    f"mongodb://:@{target_account_name}.mongo.cosmos.azure.com:10255/"
    f"?ssl=true&replicaSet=globaldb&retrywrites=false&maxIdleTimeMS=120000&appName=@{target_account_name}@"
    f"&authMechanism=PLAIN&authSource=$external&password={token.token}"
)

# MongoDB source connection details
source_connection_string = "mongodb://<USERNAME>:<PASSWORD>@<HOST>:<PORT>/<AUTHDB>"  # Replace with your source MongoDB connection
source_db = "<DB NAME>"
source_collection = "<COLLECTIONNAME>"
target_db = "<DB NAME>"
target_collection = "<COLLECTIONNAME>"

# Initialize Spark session
my_spark = SparkSession \
    .builder \
    .appName("MongoDB to CosmosDB Migration") \
    .config("spark.mongodb.input.uri", source_connection_string) \
    .config("spark.mongodb.output.uri", target_connection_string) \
    .getOrCreate()

# Read from source MongoDB
df = my_spark.read.format("com.mongodb.spark.sql.DefaultSource") \
    .option("uri", source_connection_string) \
    .option("database", source_db) \
    .option("collection", source_collection) \
    .load()

# Write to Azure Cosmos DB (MongoDB API)
df.write.format("mongo") \
    .mode("append") \
    .option("uri", target_connection_string) \
    .option("database", target_db) \
    .option("collection", target_collection) \
    .save()
```

### Execute the migration

Execute your migration notebook, monitoring the process for any potential rate-limiting errors and adjusting parameters as necessary to ensure a smooth data transfer.

### Enhance the migration performance

Depending on your vCore-based Azure Cosmos DB for MongoDB cluster tier, you might want to tweak some settings to improve the migration performance. A couple of those settings include:

- **Spark Cluster Configuration**: Optimizing the number of workers and cores directly impacts the computational capability to process your data migration.
- **Batch Size Adjustments**: Tuning the **maxBatchSize** parameter can help mitigate rate-limiting errors. This parameter controls the number of documents sent to the target database in each batch.

Regardless if you're doing an online or offline migration, using Azure Databricks for your migration project offers a robust, scalable solution for transferring large datasets from MongoDB to vCore-based Azure Cosmos DB for MongoDB. It provides the flexibility to adjust migration speed and data transformation, ensuring a successful migration process.
