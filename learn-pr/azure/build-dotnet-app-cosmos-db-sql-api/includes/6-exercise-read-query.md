Recall that your application is expected to both add items to an Azure Cosmos DB SQL API container and read those same items back as validation. At this point, your application successfully adds items to the container. There are two key ways to read an item: by performing a point read, or by performing a SQL query.

There are three key requirements at this time:

1. Point read an item using both the unique identifier and partition key value
1. Create a SQL query using a simple query string
1. Paginate the results of the SQL query using a feed iterator

[![Illustration of icons indicating data being queried using common search techniques.](../media/project-visual-query.png)](../media/project-visual-query.png)

After you complete this exercise, your application will almost be ready. You'll have queries that can read the category and product items you previously created.

## Reinitialize your environment (optional)

It's possible, if you closed your Azure Cloud Shell terminal pane, for the terminal instance to no longer have access to the environment variable and code editor. Here, if needed, you'll set your environment variable again and open the code editor.

> [!NOTE]
> You can safely skip this section if your terminal is already open, your environment variable is still set, and you are already editing your project in the code editor.

1. Set the environment variable named ``COSMOS_CONNECTION_STRING`` to the value of this command, which gets a connection string to the first Azure Cosmos DB SQL API account in your sandbox subscription.

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

## Point read an item

The simplest way to retrieve an item in Azure Cosmos DB is to perform a point read. Point reads use a small and predictable number of RUs as compared to queries. Here, you'll point read the *helmets* single category item you created.

1. Open the **Program.cs** file.

1. Create a new **PartitionKey** instance for ``gear-climb-helmets``.

    ```csharp
    PartitionKey readKey = new ("gear-climb-helmets");
    ```

1. Use **Container.ReadItemAsync** to point read a specific item by using the **id** field and the partition key value.

    ```csharp
    ItemResponse<Category> readResponse = await container.ReadItemAsync<Category>(
        id: "91f79374-8611-4505-9c28-3bbbf1aa7df7",
        partitionKey: readKey
    );
    ```

1. Get your serialized generic type using the **Resource** property of the **ItemResponse** class.

    ```csharp
    Category readItem = readResponse.Resource;
    ```

1. Output the unique identifier and request charge for the point read operation.

    ```csharp
    Console.WriteLine($"[Point read item]:\t{readItem.id}\t(RUs: {readResponse.RequestCharge})");    
    ```

1. **Save** the **Program.cs** file.

## Execute a SQL query

In situations where you need multiple items, you can use a SQL query to find and retrieve those items. Recall that we used the **categoryId** partition key field to group our items into specific categories. If we include that field in a query, we effectively build a query that's scoped to a single logical partition. Now, you'll use a SQL query to find all of the items in the *tents* category.

1. Create a new string for the SQL query ``SELECT * FROM products p WHERE p.categoryId = 'gear-camp-tents'``. However, use a parameter named ``@partitionKey`` for the **categoryId** filter.

    ```csharp
    string sql = "SELECT * FROM products p WHERE p.categoryId = @partitionKey";
    ```

1. Create a new instance of the **QueryDefinition** class with your SQL query string.

    ```csharp
    var query = new QueryDefinition(
        query: sql
    );
    ```

1. Use the fluent **WithParameter** method to assign the ``gear-camp-tents`` value to the ``@partitionKey`` parameter.

    ```csharp
    var parameterizedQuery = query.WithParameter("@partitionKey", "gear-camp-tents");
    ```

1. Use **Container.GetItemQueryIterator\<\>** to retrieve an iterator for your specific SQL query.

    ```csharp
    using FeedIterator<Product> feed = container.GetItemQueryIterator<Product>(
        queryDefinition: parameterizedQuery
    );
    ```

1. Write the SQL query to the console.

    ```csharp
    Console.WriteLine($"[Start SQL query]:\t{sql}");
    ```

1. **Save** the **Program.cs** file.

## Paginate SQL query results

Azure Cosmos DB will automatically break up your query results into pages that can be retrieves asynchronously. To manage these pages, you'll need to write your C# code in a specific way to ensure that you retrieve all pages of results that are available. Here, you'll use a *while* and *foreach* loop in C# to iterate over result pages.

1. Create a new *double* variable named **totalRequestCharge** set to a value of ``0``.

    ```csharp
    double totalRequestCharge = 0d;
    ```

1. Create a *while* loop that will iterate until the **FeedIterator.HasMoreResults** property of your feed iterator is false.

    ```csharp
    while (feed.HasMoreResults)
    {
    }
    ```

1. Inside of the *while* loop, get a new page of results using the **FeedIterator.ReadNextAsync** method.

    ```csharp
    FeedResponse<Product> page = await feed.ReadNextAsync();
    ```

1. Still inside of the *while* loop, increment the total request charge using the value of **FeedResponse.RequestCharge**.

    ```csharp
    totalRequestCharge += page.RequestCharge;
    ```

1. Still inside of the *while* loop, create a new **foreach** loop to iterate over the actual items in the page.

    ```csharp
    foreach (Product item in page)
    {
    }
    ```

1. Inside of the *foreach* loop, write to the console the **id** and **name** fields of the returned item.

    ```csharp
    Console.WriteLine($"[Returned item]:\t{item.id}\t(Name: {item.name})");
    ```

1. Outside of the *while* loop, write to the console the total request charge you calculated.

    ```csharp
    Console.WriteLine($"[SQL query metrics]:\t(RUs: {totalRequestCharge})");
    ```

    > [!TIP]
    > If you are confused about what code should be inside or outside of the *while* and *foreach* loops, go to the **review code** section in [Check your work](#check-your-work).

1. **Save** the **Program.cs** file.

## Check your work

Your app now reads and queries items from the container. Here, you'll run the application so you can observe the results of both operations.

### [Run application](#tab/run-app)

1. Run the .NET application in the terminal

    ```dotnetcli
    dotnet run
    ```  

1. Observe the output of running the application. The output should match the example here.

    ```output
    ...
    [Point read item]:      91f79374-8611-4505-9c28-3bbbf1aa7df7    (RUs: 1)
    [Start SQL query]:      SELECT * FROM products p WHERE p.categoryId = @partitionKey
    [Returned item]:        5df21ec5-813c-423e-9ee9-1a2aaead0be4    (Name: )
    [Returned item]:        e8dddee4-9f43-4d15-9b08-0d7f36adcac8    (Name: Cirroa Tent)
    [Returned item]:        6e3b7275-57d4-4418-914d-14d1baca0979    (Name: Nimbolo Tent)
    [Returned item]:        f7653468-c4b8-47c9-97ff-451ee55f4fd5    (Name: Mammatin Tent)
    [Returned item]:        e6f87b8d-8cd7-4ade-a005-14d3e2fbd1aa    (Name: Kuloar Tent)
    [SQL query metrics]:    (RUs: 2.94)
    ```

    > [!TIP]
    > The RUs shown in this example output may vary from your output.

    Did you notice that your *category* item successfully deserialized into the type you use for *products*? Since the category item didn't have a **name** property, that field was left to its default value. Type checking, schema management, and serialization/deserialization are all things your application can manage entirely client-side.

### [Review code](#tab/review-code)

1. Review the **Program.cs** code file to make sure that the code you added matches this sample.

    ```csharp
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
