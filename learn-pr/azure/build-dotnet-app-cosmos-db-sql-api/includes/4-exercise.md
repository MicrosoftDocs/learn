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

## Create a database and container

The SDK contains useful methods that will only create a new resource if it does not already exist. By using these methods, you can run the applicaton multiple times without worrying about exceptions raised by conflicts. Here, you will create a database with shared throughput, and a container with a specific "slice" of that throughput.

1. Open the **Program.cs** file.

1. Create, or get, a new database by calling ``CosmosClient.CreateDatabaseIfNotExistsAsync``. Store the result in a variable named **database**. Be sure to set these parameters:

    | Parameter | Value |
    | --- | --- |
    | **id** | ``cosmicworks`` |
    | **throughput** | ``600`` |

    ```csharp
    Database database = await client.CreateDatabaseIfNotExistsAsync(
        id: "cosmicworks",
        throughput: 600
    );
    ```

1. Output the unique identifier for the database.

    ```csharp
    Console.WriteLine($"[Database created]:\t{database.Id}");
    ```

1. Create, or get, a new container by calling ``Database.CreateContainerIfNotExistsAsync``. Store the result in a variable named **container**. Be sure to set these parameters:

    | Parameter | Value |
    | --- | --- |
    | **id** | ``products`` |
    | **partitionKeyPath** | ``/categoryId`` |
    | **throughput** | ``400`` |

    ```csharp
    Container container = await database.CreateContainerIfNotExistsAsync(
        id: "products",
        partitionKeyPath: "/categoryId",
        throughput: 400
    );
    ```

1. Now, output the unique identifier for the container.

    ```csharp
    Console.WriteLine($"[Container created]:\t{container.Id}");
    ```

1. **Save** the **Program.cs** file.

## Create record types for items

C# data can be represented using a variety of types including classes, structs, and records. For this SDK, records are really useful because they are immutable, have an easy to read syntax if you want to create a modified copy, and are quick to create with only a few lines of code. In this section, you will create a base type for all items and individual types for each "kind" of item.

1. Using the terminal, create a new file named **Item.cs**.

    ```bash
    touch Item.cs
    ```

1. Refresh the code editor by invoking the ``code`` command again.

    ```bash
    code .
    ```

1. Create a base type named **Item** that carries the three properties you want to use in all items for this container: ``id``, ``categoryId``, and ``type``.

    ```csharp
    public record Item(
        string id,
        string categoryId,
        string type
    );
    ```

1. **Save** the **Item.cs** file.

1. Create a new file named **Category.cs**.

    ```bash
    touch Category.cs
    ```

1. Refresh the code editor again.

    ```bash
    code .
    ```

1. Create a new type named **Category** that inherits from the **Item** type. Ensure the type passes it's values to the base implementation, and set the **type** variable to output the name of the **Category** type.

    ```csharp
    public record Category(
        string id,
        string categoryId,
        string type = nameof(Category)
    ) : Item(
        id,
        categoryId,
        type
    );
    ```

1. **Save** the **Category.cs** file.

1. Create a new file named **Product.cs**.

    ```bash
    touch Product.cs
    ```

1. Refresh the code editor again.

    ```bash
    code .
    ```

1. Create a new type named **Product** that inherits from **Item** and adds a few new fields: ``name``, ``price``, ``archived``, and ``quantity``.

    ```csharp
    public record Product(
        string id, 
        string categoryId, 
        string name, 
        decimal price, 
        bool archived, 
        int quantity,
        string type = nameof(Product)
    ) : Item(
        id,
        categoryId,
        type
    );
    ```

1. **Save** the **Product.cs** file.

## Add an individual item to a container

In Azure Cosmos DB, you can create, replace, or upsert items to a container. Creating an item requires that the item has a unique identifier. Replacing an item requires that the item already exists. Upsert is the best of both worlds where it will check the unique identifier, and then replace or create the item. For this project, you want to be able to run the app multiple times without errors making *upsert* a clear choice. For our first item, we will create a category that doesn't have any associated products. Here, you will implement a single upsert operation with a manually created category.

1. Open the **Program.cs** file again.

1. Create a new **Category** instance named **helmets** with the following values:

    | Field | Value |
    | --- | --- |
    | **id** | ``91f79374-8611-4505-9c28-3bbbf1aa7df7`` |
    | **categoryId** | ``gear-climb-helmets`` |

    ```csharp
    Category helmets = new (
        id: "91f79374-8611-4505-9c28-3bbbf1aa7df7",
        categoryId: "gear-climb-helmets"
    );
    ```

1. Create a new **PartitionKey** instance using the same value as the **categoryId** field for the **Category** instance you created.

    ```csharp
    PartitionKey helmetsKey = new ("gear-climb-helmets");
    ```

1. Use the **Container.UpsertItemAsync** method to create or replace the item passing in an object for the item to create and a partition key value.

    ```csharp
    ItemResponse<Category> response = await container.UpsertItemAsync(helmets, helmetsKey);
    ```

1. Print various properties of the response object to the console including: The unique identifier of the item, the type of the item, and the request charge in RUs.

    ```csharp
    Console.WriteLine($"[New item created]:\t{response.Resource.id}\t(Type: {response.Resource.type})\t(RUs: {response.RequestCharge})");
    ```

1. **Save** the **Program.cs** file.

## Implement multiple operations as a transactional batch

Now consider a scenario where you want to create multiple products along with a category. If the products are created, but the category doesn't exist, those products are not nearly as useful. This is a situation where you can use a transaction to group multiple "point" operations together so they all succeed or fail as a single cohesive unit. Going back to our scenario, we need to create a category for outdoor tents with a few tent products. Here, we will create a transactional batch to create the category and products together.

1. Create a new **Category** instance named **helmets** with the following values:

    | Field | Value |
    | --- | --- |
    | **id** | ``5df21ec5-813c-423e-9ee9-1a2aaead0be4`` |
    | **categoryId** | ``gear-camp-tents`` |

    ```csharp
    Category tents = new (
        id: "5df21ec5-813c-423e-9ee9-1a2aaead0be4",
        categoryId: "gear-camp-tents"
    );
    ```

1. Create four instances of the **Product** type using these values.

    | Field | *cirroa* | *kuloar* | *mammatin* | *nimbolo* |
    | --- | --- | --- | --- | --- |
    | **id** | ``e8dddee4-9f43-4d15-9b08-0d7f36adcac8`` | ``6e3b7275-57d4-4418-914d-14d1baca0979`` | ``f7653468-c4b8-47c9-97ff-451ee55f4fd5`` | ``6e3b7275-57d4-4418-914d-14d1baca0979`` |
    | **categoryId** | ``gear-camp-tents`` | ``gear-camp-tents`` | ``gear-camp-tents`` | ``gear-camp-tents`` |
    | **name** | ``Cirroa Tent`` | ``Kuloar Tent`` | ``Mammatin Tent`` | ``Nimbolo Tent`` |
    | **price** | ``490.00`` | ``530.00`` | ``0.00`` | ``330.00`` |
    | **archived** | ``false`` | ``false`` | ``true`` | ``false`` |
    | **quantity** | ``15`` | ``8`` | ``0`` | ``35`` |

    ```csharp
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
        price: 0.00m, 
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
    ```

1. Now, create a new **PartitionKey** instance using the ``gear-camp-tents`` value.

    ```csharp
    PartitionKey tentsKey = new ("gear-camp-tents");
    ```

1. Create a new transational batch scoped to the ``gear-camp-tents`` partition key value. Using the fluent syntax, add five *upsert* operations to create the items we need in our container for the category and all of the related products.

    ```csharp
    TransactionalBatch batch = container.CreateTransactionalBatch(tentsKey)
        .UpsertItem<Category>(tents)
        .UpsertItem<Product>(cirroa)
        .UpsertItem<Product>(kuloar)
        .UpsertItem<Product>(mammatin)
        .UpsertItem<Product>(nimbolo);
    ```

1. Output a message to the console to indicating that we are starting a batch operation.

    ```csharp
    Console.WriteLine("[Batch started]");
    ```

1. Use the ``TransactionalBatch.ExecuteAsync`` method to execute the batch and return a special response type.

    ```csharp
    using TransactionalBatchResponse batchResponse = await batch.ExecuteAsync();
    ```

1. Using a for loop, iterate through all of the items in the response. First, convert each item to the type ``TransactionalBatchOperationResult`` using your ``Item`` base class as the generic. Then, print the unique identifier and type of the response object.

    ```csharp
    for (int i = 0; i < batchResponse.Count; i++)
    {
        TransactionalBatchOperationResult<Item> result = batchResponse.GetOperationResultAtIndex<Item>(i);
        Console.WriteLine($"[New item created]:\t{result.Resource.id}\t(Type: {result.Resource.type})");
    }
    ```

1. Output another message to the console indicating that the batch is complete. Include the request charge for the entire batch in this message.

    ```csharp
    Console.WriteLine($"[Batch completed]:\t(RUs: {batchResponse.RequestCharge})");
    ```

1. **Save** the **Program.cs** file.

## Check your work

Your app now creates multiple items and is designed to be resilient enough to be ran multiple times without causing an exception. Here, you will run the application and check the output for the unique identifiers of each of the six newly created items.

1. Run the .NET application in the terminal

    ```dotnetcli
    dotnet run
    ```  

1. Observe the output of running the application. The output should match the example here.

    ```output

    ```
