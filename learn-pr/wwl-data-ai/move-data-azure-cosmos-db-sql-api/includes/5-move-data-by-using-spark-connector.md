With **Azure Synapse Analytics** and **Azure Synapse Link** for **Azure Cosmos DB**, you can create a cloud-native hybrid transactional and analytical processing (HTAP) to run analytics over your data in Azure Cosmos DB SQL API. This connection makes integration over your data pipeline on both ends of your data world, Azure Cosmos DB and Azure Synapse Analytics.

## Setup

First, you should make sure **Synapse Link** is enabled at the account level. This can be accomplished using the Azure portal or by using the Azure CLI:

```azurecli
az cosmosdb create --name <name> --resource-group <resource-group> --enable-analytical-storage true
```

You can also use Azure PowerShell:

```azurepowershell
New-AzCosmosDBAccount -ResourceGroupName <resource-group> -Name <name>  -Location <location> -EnableAnalyticalStorage true
```

When creating a container, you should enable analytical storage at the container level on a per container basis. Again this can be accomplished with the portal.

This can also be accomplished with the CLI:

```azurecli
az cosmosdb sql container create --resource-group <resource-group> --account <account> --database <database> --name <name> --partition-key-path <partition-key-path> --throughput <throughput> --analytical-storage-ttl -1

```

Or with Azure PowerShell:

```azurepowershell
New-AzCosmosDBSqlContainer -ResourceGroupName <resource-group> -AccountName <account> -DatabaseName <database> -Name <name> -PartitionKeyPath <partition-key-path> -Throughput <throughput> -AnalyticalStorageTtl -1
```

> [!TIP]
> You can also use the various developers SDKs to enable or disable either analytical storage on a per-container level or Synapse Link at the account level.

## Read from Azure Cosmos DB

> [!NOTE]
> The next couple of Python examples should be performed within your Azure Synapse Analytics workspace.

There are two options to query data from Azure Cosmos DB SQL API. First, you can choose to load to a Spark DataFrame where the metadata is cached. This example uses Python to load a Spark DataFrame that points to an Azure Cosmos DB SQL API account.

```python
productsDataFrame = spark.read.format("cosmos.olap")\
    .option("spark.synapse.linkedService", "cosmicworks_serv")\
    .option("spark.cosmos.container", "products")\
    .load()
```

Alternatively, you can create a Spark table that points to the Azure Cosmos DB SQL API directly. You can then run SparkSQL queries against the Spark table without impacting the underlying store. This example uses Python to create a Spark table.

```python
create table products_qry using cosmos.olap options (
    spark.synapse.linkedService 'cosmicworks_serv',
    spark.cosmos.container 'products'
)
```

## Write to Azure Cosmos DB

> [!NOTE]
> The next couple of Python examples should be performed within your Azure Synapse Analytics workspace.

If we want to write new data to Azure Cosmos DB from our Spark DataFrame, we can use the following Python script to append the data in a DataFrame to an existing container.

```python
productsDataFrame.write.format("cosmos.oltp")\
    .option("spark.synapse.linkedService", "cosmicworks_serv")\
    .option("spark.cosmos.container", "products")\
    .mode('append')\
    .save()
```

> [!NOTE]
> This operation will impact our existing transaction workloads and will consume request units on the Azure Cosmos DB SQL API container\[s\].

We can even take it further and stream data from a DataFrame, starting from a checkpoint. We can also append this streaming data to an existing container using this example Python script.

```python
query = productsDataFrame\
    .writeStream\
    .format("cosmos.oltp")\
    .option("spark.synapse.linkedService", "cosmicworks_serv")\
    .option("spark.cosmos.container", "products")\
    .option("checkpointLocation", "/tmp/runIdentifier/")\
    .outputMode("append")\
    .start()

query.awaitTermination()
```
