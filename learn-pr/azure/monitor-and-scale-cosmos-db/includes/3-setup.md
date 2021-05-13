In this unit, you'll create an Azure Cosmos DB account, and use a console application to populate the database.

## Create your database account

A database account is a container for multiple Azure Cosmos DB databases.

1. Add a unique name for your database account. This name must be unique across all Azure Cosmos DB instances. Use the following command to generate a random database account name, by using the **Bash** `$RANDOM` variable, and store it in an environment variable to use later.

    ```bash
    export COSMOS_NAME=cosmos$RANDOM
    ```

1. A sandbox resource group has been created for you, which the following command will store in an environment variable that you'll use for the rest of the code samples in this exercise.

    ```bash
    export RESOURCE_GROUP=$(az group list | jq -r '.[0].name')
    ```

    > [!NOTE]
    > If you were using your own Azure account instead of the sandbox, you would configure a static resource name in this variable.

1. Create an Azure Cosmos DB account using the following command.

    ```azurecli
    az cosmosdb create \
        --resource-group $RESOURCE_GROUP \
        --name $COSMOS_NAME
    ```

The database account can take 10 minutes to provision. You can continue reading this unit while the account is being created.

## Azure Cosmos DB concepts

Azure Cosmos DB concepts consist of:

- Resources
- Partitioning
- Indexing

### Resources

An Azure Cosmos DB account is a container for one or more _databases_. An Azure Cosmos DB database is a container for one or more _collections_. A collection contains _documents_. A document is an unstructured set of key/value pairs, read and written in JSON format.

### Partitioning

_Partitioning_ is the distribution and grouping of your data across the underlying resources. Documents are grouped in a partition based on the value of the partition key. You specify the partition key when you create the collection. To better understand the concept of partition keys, let's review the property and values in the following JSON example document.

[!code-json[](../code/Order.json)]

Any of these properties, or a combination of them, can be a partition key. For example, where you defined the partition key as a combination of the properties **Category** and **Merchant**, any documents that have matching values for **Category** and **Merchant** are grouped in the same partition.

An effective partitioning strategy distributes data and access evenly across partitions, and across time. Querying documents from within the same partition is less expensive than querying across partitions.

You choose how to partition your data at design time. The partitioning configuration can't be changed after a collection is provisioned.

We examine partitioning concepts and examples in detail in subsequent units.

### Indexing

An index is a catalog of document properties and their values. It includes links to documents that contain properties equal to each property value. Indexing makes searching a collection more efficient. But the search efficiency is balanced with the resources required to insert or change a document. When a document is inserted or changed, Azure Cosmos DB has to update the index. The optimal indexing strategy for your collection depends on your workload.

Unlike partitioning, you can change indexing at runtime.

We look at indexing in subsequent units.

## Set environment variables for endpoint and keys

1. After the database is created, run the following command to store its endpoint in an environment variable.

    ```bash
    export ENDPOINT=$(az cosmosdb list \
        --resource-group $RESOURCE_GROUP \
        --output tsv \
        --query [0].documentEndpoint)
    ```

1. Run the following command to store the access key in an environment variable.

    ```bash
    export KEY=$(az cosmosdb keys list \
        --resource-group $RESOURCE_GROUP  \
        --name $COSMOS_NAME \
        --output tsv \
        --query primaryMasterKey)
    ```

## Create your database and collections

1. Create a database called `mslearn` in your Azure Cosmos DB account. We need only one database for these exercises.

    ```azurecli
    az cosmosdb sql database create \
        --resource-group $RESOURCE_GROUP \
        --account-name $COSMOS_NAME \
        --name mslearn
    ```

1. Create the first collection.

    We're going to create three collections to compare different partitioning strategies and workloads.

    We'll allocate a smaller capacity to this collection to demonstrate overloading it. The partition key for this collection is the unique identifier of the order. In this case, the partition isn't important because the collection is smaller than a single partition. In addition, this first collection is configured for 400 request units per second (RU/s), which is less than the next two collections.

    ```azurecli
    az cosmosdb sql container create \
        --resource-group $RESOURCE_GROUP \
        --account-name $COSMOS_NAME \
        --database-name mslearn \
        --name Small \
        --partition-key-path /id \
        --throughput 400
    ```

1. Create the second collection.

    This collection uses an order item's product category as the partition key. We'll explore the consequences of this choice as we go through the exercises in this module. This second collection is configured for 7000 RU/s, which is more than the first collection.

    ```azurecli
    az cosmosdb sql container create \
        --resource-group $RESOURCE_GROUP \
        --account-name $COSMOS_NAME \
        --database-name mslearn \
        --name HotPartition \
        --partition-key-path /Item/Category \
        --throughput 7000
    ```

1. Create a third collection.

    This collection partitions the documents by the order item's unique product identifier. This last collection is also configured for 7000 RU/s.

    ```azurecli
    az cosmosdb sql container create \
        --resource-group $RESOURCE_GROUP \
        --account-name $COSMOS_NAME \
        --database-name mslearn \
        --name Orders \
        --partition-key-path /Item/id \
        --throughput 7000
    ```

## Populate your collections

We'll use an open-source C# console application to populate your collections. This application generates random order documents and inserts them into your collections. We'll also use this application in subsequent units to query the collections.

1. Clone the console application repository from GitHub. Run the following command in the sandbox environment.

    ```bash
    git clone https://github.com/MicrosoftDocs/mslearn-monitor-azure-cosmos-db
    ```

1. Change into the application's directory.

    ```bash
    cd mslearn-monitor-azure-cosmos-db/ExerciseCosmosDB
    ```

1. Check your environment variables. The console application needs the environment variables to connect to the database. If Azure Cloud Shell times out, you need to set these and the `COSMOS_NAME` variable again. You can reset your `COSMOS_NAME`, `RESOURCE_GROUP`, `ENDPOINT` and `KEY` variables by running the following commands.

    ```bash
    export COSMOS_NAME=$(az cosmosdb list --output tsv --query [0].name)

    export RESOURCE_GROUP=$(az group list | jq -r '.[0].name')

    export ENDPOINT=$(az cosmosdb list \
        --resource-group $RESOURCE_GROUP \
        --output tsv \
        --query [0].documentEndpoint)

    export KEY=$(az cosmosdb keys list \
        --resource-group $RESOURCE_GROUP  \
        --name $COSMOS_NAME \
        --output tsv \
        --query primaryMasterKey)
    ```

1. Populate the `Small` collection.

    ```bash
    dotnet run -- -c Small -o InsertDocument -n 4000 -p 10
    ```

    Again, the application takes a few minutes to run. We need to populate the database with enough data that we can discern metrics for different partitioning and indexing strategies. To populate this collection, the console application is running with the following options:

    | Option | Value | Description |
    |---|---|---|
    | -c | Small | The name of the collection to use. |
    | -o | InsertDocument | The name of the task to run. |
    | -n | 4000 | The number of times to run. |
    | -p | 10 | The degree of parallelism to use. That's the number of threads used for the experiment. The higher this number, the greater the demand on the collection. |

    The first time you run the application, it shows a welcome message.

    You can see the other options for this application by running `dotnet run -- --help`.

    While the console application runs, you see one line printed per second that shows the status and Request Units needed for the database writes.

1. Populate the `HotPartition` collection.

    ```bash
    dotnet run -- -c HotPartition -o InsertDocument -n 20000 -p 10
    ```

1. Populate the `Orders` collection.

    ```bash
    dotnet run -- -c Orders -o InsertDocument -n 20000 -p 10
    ```

Notice that the throughput changes for each of the different collections; the data populates the `Small` collection at a slower rate than the remaining collections because it was configured to use 400 RU/s, whereas the `HotPartition` and `Orders` were configured for 7000 RU/s.
