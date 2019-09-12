To demonstrate index monitoring and tuning, we'll use the collections that we set up in Unit 2 and modify the indexing configuration.

We'll use the Azure CLI to modify the index configuration. You can also use the Azure portal, the Azure Cosmos DB REST API, or any of the Azure Cosmos DB SDKs.

We have provided prebuilt index configuration files for your convenience. You can view these files in the `mslearn-monitor-azure-cosmos-db/ExerciseCosmosDB/IndexConfig` directory.

We ran queries in Unit 3 on our collections with all the document properties indexed. The Request Units (RUs) that we used were:

- ~3 RUs to query a 1-KB document within a single partition
- ~13 RUs to add a 1-KB document

## Measure RUs for no index

Update the **Orders** collection to index none of the properties.

1. If Azure Cloud Shell times out, you need to reset the `ENDPOINT`, `KEY`, and  `COSMOS_NAME` variables. The console application needs the environment variables to connect to the database. If Cloud Shell hasn't timed out, you can skip this step.

    You can reset the `COSMOS_NAME` value by running the following command.

    ```bash
    export COSMOS_NAME=$(az cosmosdb list --output tsv --query [0].name)
    ```

    You can reset your `ENDPOINT` and `KEY` variables by running the following commands.

    ```bash
    export ENDPOINT=$(az cosmosdb list --resource-group <rgn>Sandbox Resource Group</rgn> \
            --output tsv --query [0].documentEndpoint)
    ```

    ```bash
    export KEY=$(az cosmosdb list-keys --resource-group <rgn>Sandbox Resource Group</rgn>  \
            --name $COSMOS_NAME --output tsv --query primaryMasterKey)
    ```

1. Make sure you're in the `ExerciseCosmosDB` directory.
    ```bash
    cd mslearn-monitor-azure-cosmos-db/ExerciseCosmosDB
    ```

1. Run the following command to update the collection index to `none`.

    ```bash
    az cosmosdb collection update -g <rgn>Sandbox Resource Group</rgn> -n $COSMOS_NAME -d mslearn -c Orders --indexing-policy @IndexConfig/index-none.json
    ```

    This command reads the index configuration from the file `IndexConfig/index-none.json`. You can view this and other index configurations in the `IndexConfig` directory.

1. Measure the consumption of adding a document without an index.

    ```bash
    dotnet run -- -c Orders -o InsertDocument -n 1 -r
    ```

    Review the output of this command. The write took about 5 RUs.

1. Now measure the consumption of querying the collection without an index.

    Run a query for the `Item.id` value of the document that you just added to the Orders collection.

    ```bash
    dotnet run -- -c Orders -o QueryCollection -q "SELECT TOP 1 * FROM c WHERE c.Item.id='<Item id value>'"
    ```

    You see that without an index, this query's consumption is much higher: about 20 to 200 RUs.

## Measure RUs for a partial index

1. Update the Orders collection to index on only some of the order properties.

    ```bash
    az cosmosdb collection update -g <rgn>Sandbox Resource Group</rgn> -n $COSMOS_NAME -d mslearn -c Orders --indexing-policy @IndexConfig/index-partial.json
    ```

1. Measure the consumption of adding a document with partial indexing.

    ```bash
    dotnet run -- -c Orders -o InsertDocument -n 1
    ```

    Review the output of this command. The write took 6 to 8 RUs.

1. Now measure the consumption of querying the collection with a property that's indexed.

    ```bash
    dotnet run -- -c Orders -o QueryCollection -q "SELECT TOP 1 * FROM c WHERE c.OrderStatus = 'NEW'"
    ```

   You see that with an index, this query consumes only 3 to 6 RUs.

1. Now measure the consumption of querying the collection with a property that isn't indexed.

    ```bash
    dotnet run -- -c Orders -o QueryCollection -q "SELECT TOP 1 * FROM c WHERE c.Customer.State = 'WA'"
    ```

    You see that the consumption of this query without an index is about 10 to 11 RUs. The consumption depends on which property is in the query and how long it takes to find it in the collection. For example, if we run a query for a customer `id` instead of `State`, the search consumes more RUs.

## Measure RUs for lazy indexing

In the previous exercises, the index is set to **consistent** so it's updated synchronously. In this exercise, we set the indexing mode to **lazy**. The index is updated when the collection isn't being used.

1. Update the Orders collection to lazy index on all properties.

    ```bash
    az cosmosdb collection update -g <rgn>Sandbox Resource Group</rgn> -n $COSMOS_NAME -d mslearn -c Orders --indexing-policy @IndexConfig/index-lazy-all.json
    ```

1. Measure the consumption of adding a document with lazy indexing.

    ```bash
    dotnet run -- -c Orders -o InsertDocument -n 1 -r
    ```

    Review the output of this command. The write took about 5 RUs.

   The RUs used are about the same as writing to an unindexed collection. With lazy indexing, the index isn't updated immediately.

1. Now measure the consumption of querying a collection with lazy indexing.

    Run a query on the `Item.id` value of the document that you just added.

    ```bash
    dotnet run -- -c Orders -o QueryCollection -q "SELECT TOP 1 * FROM c WHERE c.Item.id='<Item id value>'"
    ```

    You see that this query takes about 3 RUs.

    The RUs that the query consumes are low because the collection index isn't immediately updated. The lazy configuration works well for a collection that isn't used at capacity all the time.

## Compare RUs across indexing strategies

The following table summarizes the results you've gotten in previous exercises. These results apply to read, query, and insert operations for 1 KB of data that's within a single partition.

| Operation  | Indexing strategy | Approximate consumption (RUs)  |
|------------|------------------|------------------------|
| Read document directly| N/A | 1 |
| Query document | All properties indexed |  3 |
| Query document by indexed property | Partial | 3+ |
| Query document by non-indexed property | Partial | 10+ |
| Query document | No properties indexed | 20+ |
| Insert document | All properties indexed | 13 |
| Insert document | All properties indexed lazily | 7 |
| Insert document | Some properties indexed | 6 |
| Insert document | No properties indexed | 5 |

You see that as indexing complexity goes up, the write consumption goes up, and the read consumption goes down. The indexing strategy that you choose depends on your data and the workloads that it supports.
