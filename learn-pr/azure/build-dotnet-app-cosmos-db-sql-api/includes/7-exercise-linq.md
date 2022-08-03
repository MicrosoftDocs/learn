Although the application already meets all of the requirements, there's still one more change that can be made. C# developers use the language-integrated query (LINQ) syntax to perform queries over collections of data. The .NET SDK for Azure Cosmos DB SQL API comes with a built-in mechanism to build your SQL query using the LINQ method syntax.

There are two key requirements at this time:

1. Build a new query using LINQ syntax
1. Convert the query to a feed iterator to get results

:::image type="content" source="../media/project-visual-query-linq.png" alt-text="Illustration of icons indicating data being queried using a LINQ expression." lightbox="../media/project-visual-query-linq.png" border="false":::

After you complete this exercise, your queries will now use the LINQ syntax to make it easier for developers to maintain your application moving forward.

## Reinitialize your environment (optional)

It's possible, if you closed your Azure Cloud Shell terminal pane, for the terminal instance to no longer have access to the environment variable and code editor. Here, if needed, you'll set your environment variable again and open the code editor.

> [!NOTE]
> You can safely skip this section if your terminal is already open, your environment variable is still set, and you are already editing your project in the code editor.

1. Set the environment variable named `COSMOS_CONNECTION_STRING` to the value of this command, which gets a connection string to the first Azure Cosmos DB SQL API account in your sandbox subscription.

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

1. Change to the `~/clouddrive/inventorytool` directory and open a code editor.

    ```bash
    cd ~/clouddrive/inventorytool && code .
    ```

## Query using LINQ expressions

Your team wants a unique query that returns all *products* within the container regardless of category. Recall that we used the **type** field to separate our category items from the individual product items. Here, we're going to create a cross-partition query using the LINQ method syntax.

> [!TIP]
> Since we are querying across multiple categories, this will make our query cross-partition. This query could potentially use more RUs than a query that is scoped to a single logical partition key value.

1. Open the **Program.cs** file.

1. At the beginning of the file, add a using directive for the **Microsoft.Azure.Cosmos.Linq** namespace.

    ```csharp
    using Microsoft.Azure.Cosmos.Linq;
    ```

1. Create a new LINQ queryable by using the **Container.GetItemLinqQueryable\<\>** method.

    ```csharp
    IOrderedQueryable<Product> queryable = container.GetItemLinqQueryable<Product>();
    ```

1. Build a LINQ expression using the **Where** and **OrderBy** methods and store the expression in a new variable.

    ```csharp
    var matches = queryable
        .Where(p => p.type == nameof(Product))
        .Where(p => !p.archived)
        .OrderBy(p => p.price);
    ```

1. Use the **IOrderedQueryable\<\>.ToFeedIterator** method to get a feed iterator from the LINQ expression.

    ```csharp
    using FeedIterator<Product> linqFeed = matches.ToFeedIterator();
    ```

1. Output a message to the console.

    ```csharp
    Console.WriteLine($"[Start LINQ query]");
    ```

1. **Save** the **Program.cs** file.

## Paginate LINQ query results

Since we're querying across multiple logical partitions, we need to make sure that we return all results even if a logical partition doesn't have any matching results. For example, the *helmets* category doesn't have any matching products. If we didn't return all possible pages, our application may inadvertently halt when it sees an empty page of results for the *helmets* category. Here, you'll again use a *while* and *foreach* loop in C# to iterate over *all* result pages. The code should be similar to how you used a feed iterator previously.

1. Create a *while* loop that will iterate until the feed iterator doesn't have any more pages.

    ```csharp
    while (linqFeed.HasMoreResults)
    {

    }
    ```

1. Inside of the *while* loop, get a new page of results.

    ```csharp
    FeedResponse<Product> page = await linqFeed.ReadNextAsync();
    ```

1. Still inside of the *while* loop, output the current page's request charge.

    ```csharp
    Console.WriteLine($"[Page RU charge]:\t{page.RequestCharge}");
    ```

1. Still inside of the *while* loop, create a new **foreach** loop to iterate over the page's items.

    ```csharp
    foreach (Product item in page)
    {
    }
    ```

1. Inside of the *foreach* loop, write the individual items to the console.

    ```csharp
    Console.WriteLine($"[Returned item]:\t{item}");
    ```

1. **Save** the **Program.cs** file.

## Check your work

Your app now uses LINQ to build a cross-partition query that your developer team natively understands. Here, you'll run the application one last time to ensure that all queries return the results you expected.

### [Run application](#tab/run-app)

1. Run the .NET application in the terminal

    ```dotnetcli
    dotnet run
    ```  

1. Observe the output of running the application. The output should match the example here.

    ```output
    [Start LINQ query]
    [Page RU charge]:       3
    [Returned item]:        Product { id = 6e3b7275-57d4-4418-914d-14d1baca0979, categoryId = gear-camp-tents, type = Product, name = Nimbolo Tent, price = 330, archived = False, quantity = 35 }
    [Returned item]:        Product { id = e8dddee4-9f43-4d15-9b08-0d7f36adcac8, categoryId = gear-camp-tents, type = Product, name = Cirroa Tent, price = 490, archived = False, quantity = 15 }
    [Returned item]:        Product { id = e6f87b8d-8cd7-4ade-a005-14d3e2fbd1aa, categoryId = gear-camp-tents, type = Product, name = Kuloar Tent, price = 530, archived = False, quantity = 8 }
    ```

    > [!TIP]
    > The RUs shown in this example output may vary from your output.

### [Review code](#tab/review-code)

1. Review the **Item.cs** code file to make sure that your code matches this sample.

    ```csharp
    public record Item(
        string id,
        string categoryId,
        string type
    );
    ```

1. Review the **Category.cs** code file to make sure that your code matches this sample.

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

1. Review the **Product.cs** code file to make sure that your code matches this sample.

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

1. Review the **Program.cs** code file to make sure that your code matches this sample.

    ```csharp
    using Microsoft.Azure.Cosmos;
    using Microsoft.Azure.Cosmos.Linq;
    
    string cosmosConnectionString = Environment.GetEnvironmentVariable("COSMOS_CONNECTION_STRING")!;
    
    Console.WriteLine($"[Connection string]:\t{cosmosConnectionString}");
    
    using CosmosClient client = new(
        connectionString: cosmosConnectionString
    );
    
    Console.WriteLine("[Client connected]");

    Database database = await client.CreateDatabaseIfNotExistsAsync(
        id: "cosmicworks"
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
        id: "e6f87b8d-8cd7-4ade-a005-14d3e2fbd1aa",
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

    PartitionKey readKey = new ("gear-climb-helmets");
    
    ItemResponse<Category> readResponse = await container.ReadItemAsync<Category>(
        id: "91f79374-8611-4505-9c28-3bbbf1aa7df7",
        partitionKey: readKey
    );
    
    Category readItem = readResponse.Resource;
    
    Console.WriteLine($"[Point read item]:\t{readItem.id}\t(RUs: {readResponse.RequestCharge})");
    
    string sql = "SELECT * FROM products p WHERE p.categoryId = @partitionKey";
    
    var query = new QueryDefinition(
        query: sql
    );
    
    var parameterizedQuery = query.WithParameter("@partitionKey", "gear-camp-tents");
    
    using FeedIterator<Product> feed = container.GetItemQueryIterator<Product>(
        queryDefinition: parameterizedQuery
    );
    
    Console.WriteLine($"[Start SQL query]:\t{sql}");
    
    double totalRequestCharge = 0d;
    
    while (feed.HasMoreResults)
    {
        FeedResponse<Product> page = await feed.ReadNextAsync();
        
        totalRequestCharge += page.RequestCharge;
    
        foreach (Product item in page)
        {
            Console.WriteLine($"[Returned item]:\t{item.id}\t(Name: {item.name})");
        }
    }
    
    Console.WriteLine($"[SQL query metrics]:\t(RUs: {totalRequestCharge})");  
    ```

---
