Recall that you can create items within your container using the Azure Cosmos DB SDK for .NET. For this project, the products container contains both the individual *product* items and special *category* items for each category. There's two cases you want to handle in this application:

- If a category is empty, it's fine to just create that category's item individually. There are no related product items to create.
- However, if a category has related products, you want to create the category item and the related product items simultaneously.

Right now, you have two key requirements:

1. Create an item individually as a single operation
1. Use a transactional batch to create multiple related items

:::image type="content" source="../media/project-visual-upload.svg" alt-text="Illustration of icons indicating data being uploaded to the cloud." border="false":::

After you complete this exercise, your project will have the logic to create items in your container either individually or as a batch.

## Add an individual item to a container

In Azure Cosmos DB, you can create, replace, or upsert items to a container. *Creating* an item requires that the item has a unique identifier. *Replacing* an item requires that the item already exists. *Upsert* is the best of both worlds, where it checks the unique identifier, then replaces or creates the item. For this project, you want to be able to run the app multiple times without errors, making *upsert* a clear choice. For our first item, we create a category that doesn't have any associated products. Here, you implement a single upsert operation with a manually created category.

1. Open the *Program.cs* file yet again.

1. Create a new **Category** instance named `goggles` with the following values:

    | Property | Value |
    | --- | --- |
    | **id** | `ef7fa0f1-0e9d-4435-aaaf-a778179a94ad` |
    | **categoryId** | `gear-snow-goggles` |

    ```csharp
    Category goggles = new(
        Id: "ef7fa0f1-0e9d-4435-aaaf-a778179a94ad",
        CategoryId: "gear-snow-goggles"
    );
    ```

1. Create a new <xref:Microsoft.Azure.Cosmos.PartitionKey> instance using the same value as the `categoryId` property for the **Category** instance you created earlier.

    ```csharp
    PartitionKey gogglesKey = new("gear-snow-goggles");
    ```

1. Use the <xref:Microsoft.Azure.Cosmos.Container.UpsertItemAsync%2A> method to create or replace the item passing in an object for the item to create and a partition key value.

    ```csharp
    Category result = await container.UpsertItemAsync(goggles, gogglesKey);
    ```

1. Print various properties of `result` to the console including: The unique identifier of the item and the type of the item.

    ```csharp
    Console.WriteLine($"[New item created]:\t{result.Id}\t(Type: {result.Type})");
    ```

1. Create a new **Category** instance named `helmets` with the following values:

    | Property | Value |
    | --- | --- |
    | **id** | `91f79374-8611-4505-9c28-3bbbf1aa7df7` |
    | **categoryId** | `gear-climb-helmets` |

    ```csharp
    Category helmets = new(
        Id: "91f79374-8611-4505-9c28-3bbbf1aa7df7",
        CategoryId: "gear-climb-helmets"
    );
    ```

1. Create a new <xref:Microsoft.Azure.Cosmos.PartitionKey> instance using the same value as the `categoryId` property for the **Category** instance you created earlier.

    ```csharp
    PartitionKey helmetsKey = new("gear-climb-helmets");
    ```

1. Use the <xref:Microsoft.Azure.Cosmos.Container.UpsertItemAsync%2A> method to create or replace the item. Pass in an object for the item to create and a partition key value. Return an object of type <xref:Microsoft.Azure.Cosmos.ItemResponse%601>.

    ```csharp
    ItemResponse<Category> response = await container.UpsertItemAsync(helmets, helmetsKey);
    ```

1. Print various properties of `response` to the console including: The unique identifier of the underlying item, the type of the underlying item, and the request charge in RUs.

    ```csharp
    Console.WriteLine($"[New item created]:\t{response.Resource.Id}\t(Type: {response.Resource.Type})\t(RUs: {response.RequestCharge})");
    ```

1. **Save** the *Program.cs* file.

## Implement multiple operations as a transactional batch

Now, consider a scenario where you want to create multiple products along with a category. If the products are created, but the category doesn't exist, those products aren't nearly as useful. Creating multiple items is a situation where you can use a transaction to group multiple "point" operations together so they all succeed or fail as a single cohesive unit. Going back to our scenario, we need to create a category for outdoor tents with a few tent products. We already have a single category item without any product items. Here's what we should end up with:

:::image type="complex" source="../media/diagram-items.png" alt-text="Diagram of items in Azure Cosmos DB grouped by their partition key." lightbox="../media/diagram-items.png" border="false":::
    Diagram of various items in Azure Cosmos DB organized by their specific partition key. The diagram illustrates how five items belong to the "tents" partition key value and only one item belongs to "helmets".
:::image-end:::

In this section, we create a transactional batch to create the `tents` category and related products together.

1. In *Program.cs*, create a new **Category** instance named `tents` with the following values:

    | Property | Value |
    | --- | --- |
    | **id** | `5df21ec5-813c-423e-9ee9-1a2aaead0be4` |
    | **categoryId** | `gear-camp-tents` |

    ```csharp
    Category tents = new(
        Id: "5df21ec5-813c-423e-9ee9-1a2aaead0be4",
        CategoryId: "gear-camp-tents"
    );
    ```

1. Create four instances of the **Product** type using these values.

    | Property | `cirroa` | `kuloar` | `mammatin` | `nimbolo` |
    | --- | --- | --- | --- | --- |
    | **Id** | `e8dddee4-9f43-4d15-9b08-0d7f36adcac8` | `e6f87b8d-8cd7-4ade-a005-14d3e2fbd1aa` | `f7653468-c4b8-47c9-97ff-451ee55f4fd5` | `6e3b7275-57d4-4418-914d-14d1baca0979` |
    | **CategoryId** | `gear-camp-tents` | `gear-camp-tents` | `gear-camp-tents` | `gear-camp-tents` |
    | **Name** | `Cirroa Tent` | `Kuloar Tent` | `Mammatin Tent` | `Nimbolo Tent` |
    | **Price** | `490.00` | `530.00` | `0.00` | `330.00` |
    | **Archived** | `false` | `false` | `true` | `false` |
    | **Quantity** | `15` | `8` | `0` | `35` |

    ```csharp
    Product cirroa = new(
        Id: "e8dddee4-9f43-4d15-9b08-0d7f36adcac8",
        CategoryId: "gear-camp-tents"
    ){
        Name = "Cirroa Tent",
        Price = 490.00m,
        Archived = false,
        Quantity = 15
    };
    ```

    ```csharp
    Product kuloar = new(
        Id: "e6f87b8d-8cd7-4ade-a005-14d3e2fbd1aa",
        CategoryId: "gear-camp-tents"
    ){
        Name = "Kuloar Tent",
        Price = 530.00m,
        Archived = false,
        Quantity = 8
    };
    ```

    ```csharp
    Product mammatin = new(
        Id: "f7653468-c4b8-47c9-97ff-451ee55f4fd5",
        CategoryId: "gear-camp-tents"
    ){
        Name = "Mammatin Tent",
        Price = 0.00m,
        Archived = true,
        Quantity = 0
    };
    ```

    ```csharp
    Product nimbolo = new(
        Id: "6e3b7275-57d4-4418-914d-14d1baca0979",
        CategoryId: "gear-camp-tents"
    ){
        Name = "Nimbolo Tent",
        Price = 330.00m,
        Archived = false,
        Quantity = 35
    };
    ```

1. Now, create a new <xref:Microsoft.Azure.Cosmos.PartitionKey> instance using the `gear-camp-tents` value.

    ```csharp
    PartitionKey tentsKey = new("gear-camp-tents");
    ```

1. Create a new transactional batch scoped to the `gear-camp-tents` partition key value using the <xref:Microsoft.Azure.Cosmos.Container.CreateTransactionalBatch(Microsoft.Azure.Cosmos.PartitionKey)> method. Using the fluent syntax, add five *upsert* operations to create the items we need in our container for the category and all of the related products.

    ```csharp
    TransactionalBatch batch = container.CreateTransactionalBatch(tentsKey)
        .UpsertItem<Category>(tents)
        .UpsertItem<Product>(cirroa)
        .UpsertItem<Product>(kuloar)
        .UpsertItem<Product>(mammatin)
        .UpsertItem<Product>(nimbolo);
    ```

1. Output a message to the console to indicating that we're starting a batch operation.

    ```csharp
    Console.WriteLine("[Batch started]");
    ```

1. Use the `TransactionalBatch.ExecuteAsync` method to execute the batch and return a special response type.

    ```csharp
    using TransactionalBatchResponse batchResponse = await batch.ExecuteAsync();
    ```

1. Using a for loop, iterate through all of the items in the response. First, convert each item to the type `TransactionalBatchOperationResult` using your `Item` base class as the generic. Then, print the unique identifier and type of the response object.

    ```csharp
    for (int i = 0; i < batchResponse.Count; i++)
    {
        TransactionalBatchOperationResult<Item> batchResult = batchResponse.GetOperationResultAtIndex<Item>(i);
        Console.WriteLine($"[New item created]:\t{batchResult.Resource.Id}\t(Type: {batchResult.Resource.Type})");
    }
    ```

1. Output another message to the console indicating that the batch is complete. Include the request charge for the entire batch in this message.

    ```csharp
    Console.WriteLine($"[Batch completed]:\t(RUs: {batchResponse.RequestCharge})");
    ```

1. **Save** the *Program.cs* file.

## Check your work

Your app now creates multiple items and is designed to be resilient enough to be ran multiple times without causing an exception. Here, you run the application and check the output for the unique identifiers of each of the six newly created items.

### [Run application](#tab/run-app)

1. Run the .NET application in the terminal:

    ```dotnetcli
    dotnet run
    ```  

1. Observe the output of running the application. The output should match the example here:

    ```output
    ...
    [New item created]:     ef7fa0f1-0e9d-4435-aaaf-a778179a94ad    (Type: Category)
    [New item created]:     91f79374-8611-4505-9c28-3bbbf1aa7df7    (Type: Category)        (RUs: 10.29)
    [Batch started]
    [New item created]:     5df21ec5-813c-423e-9ee9-1a2aaead0be4    (Type: Category)
    [New item created]:     e8dddee4-9f43-4d15-9b08-0d7f36adcac8    (Type: Product)
    [New item created]:     e6f87b8d-8cd7-4ade-a005-14d3e2fbd1aa    (Type: Product)
    [New item created]:     f7653468-c4b8-47c9-97ff-451ee55f4fd5    (Type: Product)
    [New item created]:     6e3b7275-57d4-4418-914d-14d1baca0979    (Type: Product)
    [Batch completed]:      (RUs: 36.76)
    ```

    > [!TIP]
    > The RUs shown in this example output may vary from your output.

### [Review code](#tab/review-code)

1. Review the *Program.cs* code file to make sure that your code matches this sample.

    ```csharp
    using Microsoft.Azure.Cosmos;
    using Microsoft.Azure.Cosmos.Fluent;
    using Microsoft.Azure.Cosmos.Linq;
    
    // Code to create client omitted for brevity
    
    // Code to create resources omitted for brevity

    Category goggles = new(
        Id: "ef7fa0f1-0e9d-4435-aaaf-a778179a94ad",
        CategoryId: "gear-snow-goggles"
    );
    
    PartitionKey gogglesKey = new("gear-snow-goggles");
    
    Category result = await container.UpsertItemAsync(goggles, gogglesKey);
    
    Console.WriteLine($"[New item created]:\t{result.Id}\t(Type: {result.Type})");
    
    Category helmets = new(
        Id: "91f79374-8611-4505-9c28-3bbbf1aa7df7",
        CategoryId: "gear-climb-helmets"
    );
    
    PartitionKey helmetsKey = new("gear-climb-helmets");
    
    ItemResponse<Category> response = await container.UpsertItemAsync(helmets, helmetsKey);
    
    Console.WriteLine($"[New item created]:\t{response.Resource.Id}\t(Type: {response.Resource.Type})\t(RUs: {response.RequestCharge})");
    
    Category tents = new(
        Id: "5df21ec5-813c-423e-9ee9-1a2aaead0be4",
        CategoryId: "gear-camp-tents"
    );
    
    Product cirroa = new(
        Id: "e8dddee4-9f43-4d15-9b08-0d7f36adcac8",
        CategoryId: "gear-camp-tents"
    ){
        Name = "Cirroa Tent",
        Price = 490.00m,
        Archived = false,
        Quantity = 15
    };
    
    Product kuloar = new(
        Id: "e6f87b8d-8cd7-4ade-a005-14d3e2fbd1aa",
        CategoryId: "gear-camp-tents"
    ){
        Name = "Kuloar Tent",
        Price = 530.00m,
        Archived = false,
        Quantity = 8
    };
    
    Product mammatin = new(
        Id: "f7653468-c4b8-47c9-97ff-451ee55f4fd5",
        CategoryId: "gear-camp-tents"
    ){
        Name = "Mammatin Tent",
        Price = 0.00m,
        Archived = true,
        Quantity = 0
    };
    
    Product nimbolo = new(
        Id: "6e3b7275-57d4-4418-914d-14d1baca0979",
        CategoryId: "gear-camp-tents"
    ){
        Name = "Nimbolo Tent",
        Price = 330.00m,
        Archived = false,
        Quantity = 35
    };
    
    PartitionKey tentsKey = new("gear-camp-tents");
    
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
        TransactionalBatchOperationResult<Item> batchResult = batchResponse.GetOperationResultAtIndex<Item>(i);
        Console.WriteLine($"[New item created]:\t{batchResult.Resource.Id}\t(Type: {batchResult.Resource.Type})");
    }
    
    Console.WriteLine($"[Batch completed]:\t(RUs: {batchResponse.RequestCharge})");
    ```

---
