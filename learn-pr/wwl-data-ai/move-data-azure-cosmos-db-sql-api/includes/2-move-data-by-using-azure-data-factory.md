**Azure Data Factory** is a native service to extract data, transform it, and load it across sinks and stores in an entirely serverless fashion. From a data integration perspective, this means you can marshal data from one datastore to another, regardless of the nuances of each, as long as you can reasonably transform the data between each data paradigm.

## Setup

Azure Cosmos DB SQL API is available as a **linked service** within Azure Data Factory. This type of linked service is supported both as a **source** of data ingest and as a target (**sink**) of data output. For both, the configuration is identical. You can configure the service using the Azure portal, or alternatively using a JSON object.

```json
{
    "name": "<example-name-of-linked-service>",
    "properties": {
        "type": "CosmosDb",
        "typeProperties": {
            "connectionString": "AccountEndpoint=<cosmos-endpoint>;AccountKey=<cosmos-key>;Database=<cosmos-database>"
        }
    }
}
```

> [!TIP]
> Alternatively, you can use service principals or managed identities to connect to an Azure Cosmos DB SQL API account with Azure Data Factory.

## Read from Azure Cosmos DB

In Azure Data Factory, when reading data from Azure Cosmos DB SQL API, we must configure our linked service as a **source**. This will read data in. To configure this, we must create a SQL query of the data we want to read in. For example, we may write a query such as ``SELECT id, categoryId, price, quantity, name FROM products WHERE price > 500`` to filter the items from the container that we want to read in from Azure Cosmos DB SQL API to Azure Data Factory to be transformed and then eventually loaded into our destination data store.

In Azure Data Factory, our **source** activity has a configuration JSON object that we can use to set properties such as the query:

```json
{
    "source": {
        "type": "CosmosDbSqlApiSource",
        "query": "SELECT id, categoryId, price, quantity, name FROM products WHERE price > 500",
        "preferredRegions": [
            "East US",
            "West US"
        ]        
    }
}
```

## Write to Azure Cosmos DB

In Azure Data Factory, when storing data to Azure Cosmos DB SQL API, we must configure our linked service as a **sink**. This will load out data. To configure this, we must set our write behavior. For example, we may always want to insert our data, or we may want to upsert our data and overwrite any items that may have a matching unique identifier (**id** field).

Our **sink** activity also had a configuration JSON object:

```json
"sink": {
    "type": "CosmosDbSqlApiSink",
    "writeBehavior": "upsert"
}
```
