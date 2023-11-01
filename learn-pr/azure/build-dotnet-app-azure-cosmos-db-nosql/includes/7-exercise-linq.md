Although the application already meets all of the requirements, there's still one more change we can make. C# developers use the language-integrated query (LINQ) syntax to perform queries over collections of data. The .NET SDK for Azure Cosmos DB for NoSQL comes with a built-in mechanism to build your query using the LINQ method syntax.

There are two key requirements at this time:

1. Build a new query using LINQ syntax
1. Convert the query to a feed iterator to get results

:::image type="content" source="../media/project-visual-query-linq.svg" alt-text="Illustration of icons indicating data being queried using a LINQ expression." border="false":::

After you complete this exercise, your queries will now use the LINQ syntax to make it easier for developers to maintain your application moving forward.

## Query using LINQ expressions

Your team wants a unique query that returns all *products* within the container regardless of category. Recall that we used the **type** property to separate our category items from the individual product items. Here, we're going to create a cross-partition query using the LINQ method syntax.

> [!TIP]
> Because we're querying across multiple categories, this will make our query cross-partition. This query could potentially use more RUs than a query that's scoped to a single logical partition key value.

1. Open the *Program.cs* file one last time.

1. Create a new LINQ queryable by using the <xref:Microsoft.Azure.Cosmos.Container.GetItemLinqQueryable%2A> method.

    ```csharp
    IOrderedQueryable<Product> queryable = container.GetItemLinqQueryable<Product>();
    ```

1. Build a LINQ expression using the **Where** and **OrderBy** methods and store the expression in a new variable.

    ```csharp
    var matches = queryable
        .Where(p => p.Type == nameof(Product))
        .Where(p => !p.Archived)
        .OrderBy(p => p.Price);
    ```

1. Use the **IOrderedQueryable\<\>.ToFeedIterator** method to get a feed iterator from the LINQ expression.

    ```csharp
    using FeedIterator<Product> linqFeed = matches.ToFeedIterator();
    ```

1. Output a message to the console.

    ```csharp
    Console.WriteLine($"[Start LINQ query]");
    ```

1. **Save** the *Program.cs* file.

## Paginate LINQ query results

Because we're querying across multiple logical partitions, we need to make sure that we return all results even if a logical partition doesn't have any matching results. For example, the *helmets* category doesn't have any matching products. If we didn't return all possible pages, our application may inadvertently halt when it sees an empty page of results for the *helmets* category. Here, you again use a *while* and *foreach* loop in C# to iterate over *all* result pages. The code should be similar to how you used a feed iterator previously.

1. In *Program.cs*, create a *while* loop that iterates until the feed iterator doesn't have any more pages.

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

1. **Save** the *Program.cs* file.

## Check your work

Your app now uses LINQ to build a cross-partition query that your developer team natively understands. Here, you run the application one last time to ensure that all queries return the results you expected.

### [Run application](#tab/run-app)

1. Run the .NET application in the terminal:

    ```dotnetcli
    dotnet run
    ```  

1. Observe the output of running the application. The output should match the example here:

    ```output
    [Start LINQ query]
    [Page RU charge]:       3
    [Returned item]:        Product { Id = 6e3b7275-57d4-4418-914d-14d1baca0979, CategoryId = gear-camp-tents, Type = Product, Name = Nimbolo Tent, Price = 330, Archived = False, Quantity = 35 }
    [Returned item]:        Product { Id = e8dddee4-9f43-4d15-9b08-0d7f36adcac8, CategoryId = gear-camp-tents, Type = Product, Name = Cirroa Tent, Price = 490, Archived = False, Quantity = 15 }
    [Returned item]:        Product { Id = e6f87b8d-8cd7-4ade-a005-14d3e2fbd1aa, CategoryId = gear-camp-tents, Type = Product, Name = Kuloar Tent, Price = 530, Archived = False, Quantity = 8 }
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

    // Code to create items omitted for brevity

    // Code to query items omitted for brevity

    IOrderedQueryable<Product> queryable = container.GetItemLinqQueryable<Product>();
    
    var matches = queryable
        .Where(p => p.Type == nameof(Product))
        .Where(p => !p.Archived)
        .OrderBy(p => p.Price);
    
    using FeedIterator<Product> linqFeed = matches.ToFeedIterator();
    
    Console.WriteLine($"[Start LINQ query]");
    
    while (linqFeed.HasMoreResults)
    {
        FeedResponse<Product> page = await linqFeed.ReadNextAsync();
        Console.WriteLine($"[Page RU charge]:\t{page.RequestCharge}");
        foreach (Product item in page)
        {
            Console.WriteLine($"[Returned item]:\t{item}");
        }
    }
    ```

---
