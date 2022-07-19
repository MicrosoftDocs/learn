Now you can create the various resources; such as databases, containers, and items; that you will use in your Azure Cosmos DB account. For this project, you will create a database named **cosmicworks** with a single container named **products**. You need to make sure that the code won't crash trying to re-create a container if you run this console applicaton multiple times. 

The products container will contain both the individual *product* items and special *category* items for each category. There's two cases you want to handle in this application:

- If a category is empty, it's fine to just create that category's item individually. There are no related product items to create.
- However, if a category has related products, you will want to create the category item and the related product items simultaneously.

Right now, you have a few key requirements:

1. Create a database if it doesn't already exist
1. Create a container if it doesn't already exist
1. Create an item individually as a single operation
1. Use a transactional batch to create multiple related items

[![Illustration of icons indicating data being uploaded to the cloud.](../media/project-visual-upload.png)](../media/project-visual-upload.png)

After you complete this exercise, your project will create any databases or containers it requires to execute. You will also have built the logic to create items in your container either individually, or as a batch.

## Re-initialize your environment (optional)

It's possible, if you closed your Azure Cloud Shell terminal pane, for the terminal instance to no longer have access to the environment variable and code editor. Here, if needed, you will set your environment variable again and open the code editor.

> [!NOTE]
> You can safely skip this section if your terminal is already open, your environment variable is still set, and you are already editing your project in the code editor.

1. Set the environment variable named ``COSMOS_CONNECTION_STRING`` to the value of this command which gets a connection string to the first Azure Cosmos DB SQL API account in your sandbox subscription.

    ```azurecli
    export COSMOS_CONNECTION_STRING=$(az cosmosdb keys list \
        --name $(az cosmosdb list \
            --resource-group <rgn>[sandbox resource group name]</rgn> \
            --query [0].name \
            --output tsv) \
        --resource-group <rgn>[sandbox resource group name]</rgn> \
        --type connection-strings \
        --query "connectionStrings[?description=='Primary SQL Connection String'].connectionString" \
        --output tsv)
    ```

1. Change to the ``~/clouddrive/inventorytool`` directory and open a code editor.

    ```bash
    cd ~/clouddrive/inventorytool && code .
    ```

## (Chunk n heading)

<!-- Introduction paragraph -->

1. <!-- Step 1 -->

    ```csharp
    Database database = await client.CreateDatabaseIfNotExistsAsync(
        id: "cosmicworks",
        throughput: 600
    );
    ```

    ```csharp
    Console.WriteLine($"[Database created]:\t{database.Id}");
    ```

1. <!-- Step 2 -->

    ```csharp
    Container container = await database.CreateContainerIfNotExistsAsync(
        id: "products",
        partitionKeyPath: "/categoryId",
        throughput: 400
    );
    ```

    ```csharp
    Console.WriteLine($"[Container created]:\t{container.Id}");
    ```

1. **Save** the **Program.cs** file.

1. <!-- Step n -->

## (Chunk n heading)

<!-- Introduction paragraph -->

1. <!-- Step n -->

    ```bash
    touch Category.cs
    ```

1. <!-- Step n -->

    ```bash
    code .
    ```

1. <!-- Step n -->

    ```csharp
    public record Category(
        string id,
        string categoryId
    );
    ```

1. <!-- Step n -->

    ```bash
    touch Product.cs
    ```

1. <!-- Step n -->

    ```bash
    code .
    ```

1. <!-- Step n -->

    ```csharp
    public record Product(
        string id, 
        string categoryId, 
        string name, 
        decimal price, 
        bool archived, 
        int quantity
    );
    ```

## (Chunk n heading)

<!-- Introduction paragraph -->

1. <!-- Step 1 -->

    ```csharp

    ```

## (Chunk n heading)

<!-- Introduction paragraph -->

1. <!-- Step 1 -->

    ```csharp

    ```

## Check your work

<!-- Introduction paragraph -->

1. <!-- Step n (if multiple steps are needed) -->

    ```dotnetcli
    dotnet run
    ```




Taking a break

```csharp
using Microsoft.Azure.Cosmos;

string cosmosConnectionString = Environment.GetEnvironmentVariable("COSMOS_CONNECTION_STRING")!;

Console.WriteLine($"[Connection string]:\t{cosmosConnectionString}");

using CosmosClient client = new(
    connectionString: cosmosConnectionString
);

Console.WriteLine("[Client connected]");

Database database = await client.CreateDatabaseIfNotExistsAsync(
    id: "cosmicworks",
    throughput: 400
);

Console.WriteLine($"[Database created]:\t{database.Id}");

Container container = await database.CreateContainerIfNotExistsAsync(
    id: "products",
    partitionKeyPath: "/categoryId",
    throughput: 400
);

Console.WriteLine($"[Container created]:\t{container.Id}");

Category helmets = new (
    id: "91f79374-8611-4505-9c28-3bbbf1aa7df7",
    categoryId: "gear-climb-helmets"
);

PartitionKey helmetsKey = new ("gear-climb-helmets");
ItemResponse<Category> response = await container.UpsertItemAsync(helmets, helmetsKey);

Console.WriteLine($"[New item created]:\t{response.Resource.id}\t(Type: {response.Resource.type})\t(RUs: {response.RequestCharge})");

Category tents = new (
    id: "5df21ec5-813c-423e-9ee9-1a2aaead0be4",
    categoryId: "gear-camp-tents"
);

Product cirroa = new (
    id: "e8dddee4-9f43-4d15-9b08-0d7f36adcac8",
    categoryId: "gear-camp-tents",
    name: "Cirroa Tent", 
    price: 490.00m, 
    archived: false, 
    quantity: 15
);

Product kuloar = new (
    id: "6e3b7275-57d4-4418-914d-14d1baca0979",
    categoryId: "gear-camp-tents",
    name: "Kuloar Tent", 
    price: 530.00m, 
    archived: false, 
    quantity: 8
);

Product mammatin = new (
    id: "f7653468-c4b8-47c9-97ff-451ee55f4fd5",
    categoryId: "gear-camp-tents",
    name: "Mammatin Tent", 
    price: 0m, 
    archived: true, 
    quantity: 0
);

Product nimbolo = new (
    id: "6e3b7275-57d4-4418-914d-14d1baca0979",
    categoryId: "gear-camp-tents",
    name: "Nimbolo Tent", 
    price: 330.00m, 
    archived: false, 
    quantity: 35
);

PartitionKey tentsKey = new ("gear-camp-tents");
TransactionalBatch batch = container.CreateTransactionalBatch(tentsKey)
    .UpsertItem<Category>(tents)
    .UpsertItem<Product>(cirroa)
    .UpsertItem<Product>(kuloar)
    .UpsertItem<Product>(mammatin)
    .UpsertItem<Product>(nimbolo);

Console.WriteLine("[Batch started]");

using TransactionalBatchResponse batchResponse = await batch.ExecuteAsync();

for (int i = 0; i < batchResponse.Count; i++)
{
    TransactionalBatchOperationResult<Item> result = batchResponse.GetOperationResultAtIndex<Item>(i);
    Console.WriteLine($"[New item created]:\t{result.Resource.id}\t(Type: {result.Resource.type})");
}

Console.WriteLine($"[Batch completed]:\t(RUs: {batchResponse.RequestCharge})");
```
