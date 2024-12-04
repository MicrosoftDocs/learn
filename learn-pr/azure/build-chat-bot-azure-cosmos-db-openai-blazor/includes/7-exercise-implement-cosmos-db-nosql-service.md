The Azure Cosmos DB service (`CosmosDbService`) manages querying, creating, deleting, and updating sessions and messages in your AI assistant application. To manage all of these operations, the service is required to implement multiple methods for each potential operation using various features of the .NET SDK.

There are multiple key requirements to tackle in this exercise:

- Implement operations to create a session or message
- Implement queries to retrieve multiple sessions or messages
- Implement an operation to update a single session or batch update multiple messages
- Implement an operation to query and delete multiple related sessions and messages

## Create a session or message

Azure Cosmos DB for NoSQL stores data in JSON format allowing us to store many types of data in a single container. This application stores both a chat *"session"* with the AI assistant and the individual *"messages"* within each session. With the API for NoSQL, the application can store both types of data in the same container and then differentiate between these types using a simple `type` field.

1. Open the **Services/CosmosDbService.cs** file.

1. Within the `InsertSessionAsync` method, remove any existing placeholder code.

    ```csharp
    public async Task<Session> InsertSessionAsync(Session session)
    {
    }
    ```

1. Create a new variable named `partitionKey` of type [`PartitionKey`](/dotnet/api/microsoft.azure.cosmos.partitionkey) using the current session's `SessionId` property as the parameter.

    ```csharp
    PartitionKey partitionKey = new(session.SessionId);
    ```

1. Invoke the `CreateItemAsync` method of the container passing in the `session` parameter and `partitionKey` variable. Return the response as the result of the `InsertSessionAsync` method.

    ```csharp
    return await _container.CreateItemAsync<Session>(
        item: session,
        partitionKey: partitionKey
    ); 
    ```

1. Within the `InsertMessageAsync` method, remove any existing placeholder code.

    ```csharp
    public async Task<Message> InsertMessageAsync(Message message)
    {
    }
    ```

1. Create a `PartitionKey` variable using `session.SessionId` as the value of the partition key.

    ```csharp
    PartitionKey partitionKey = new(message.SessionId);
    ```

1. Create a new message variable named `newMessage` with the `Timestamp` property updated to the current UTC timestamp.

    ```csharp
    Message newMessage = message with { TimeStamp = DateTime.UtcNow };
    ```

1. Invoke `CreateItemAsync` passing in both the new message and partition key variables. Return the response as the result of `InsertMessageAsync`.

    ```csharp
    return await _container.CreateItemAsync<Message>(
        item: newMessage,
        partitionKey: partitionKey
    );
    ```

1. Save the **Services/CosmosDbService.cs** file.

## Retrieve multiple sessions or messages

There are two main use cases where the application needs to retrieve multiple items from our container. First, the application retrieves all sessions for the current user by filtering the items to ones where `type = Session`. Second, the application retrieves all messages for a session by performing a similar filter where `type = Session & sessionId = <current-session-id>`. Implement both queries here using the .NET SDK and a feed iterator.

1. Within the `GetSessionsAsync` method, remove any existing placeholder code.

    ```csharp
    public async Task<List<Session>> GetSessionsAsync()
    {
    }
    ```

1. Create a new variable named `query` of type [`QueryDefinition`](/dotnet/api/microsoft.azure.cosmos.querydefinition) with the SQL query `SELECT DISTINCT * FROM c WHERE c.type = @type`. Use the fluent `WithParameter` method to assign the name of the `Session` class as the value for the parameter.

    ```csharp
    QueryDefinition query = new QueryDefinition("SELECT DISTINCT * FROM c WHERE c.type = @type")
        .WithParameter("@type", nameof(Session));
    ```

1. Invoke the generic `GetItemQueryIterator<>` method on the `_container` variable passing in the generic type `Session` and the `query` variable as a parameter. Store the result in a variable of type `FeedIterator<Session>` named `response`.

    ```csharp
    FeedIterator<Session> response = _container.GetItemQueryIterator<Session>(query);
    ```

1. Create a new generic list variable named `output`.

    ```csharp
    List<Session> output = new();
    ```

1. Create a *while loop* that runs until `response.HasMoreResults` is no longer true.

    ```csharp
    while (response.HasMoreResults)
    {
    }
    ```

    > [!NOTE]
    > Using a while loop here will effectively loop through all pages of your response until there are no pages left.

1. Within the while loop, asynchronously get the next page of results by invoking `ReadNextAsync` on the `response` variable and then add those results to the list variable named `output`.

    ```csharp
    FeedResponse<Session> results = await response.ReadNextAsync();
    output.AddRange(results);
    ```

1. Outside the while loop, return the `output` variable with a list of sessions as the result of the `GetSessionsAsync` method.

    ```csharp
    return output;
    ```

1. Within the `GetSessionMessagesAsync` method, remove any existing placeholder code.

    ```csharp
    public async Task<List<Message>> GetSessionMessagesAsync(string sessionId)
    {
    }
    ```

1. Create a `query` variable of type `QueryDefinition`. Use the SQL query `SELECT * FROM c WHERE c.sessionId = @sessionId AND c.type = @type`. Use the fluent `WithParameter` method to assign the `@sessionId` parameter to the session identifier passed in as a parameter, and the `@type` parameter to the name of the `Message` class.

    ```csharp
    QueryDefinition query = new QueryDefinition("SELECT * FROM c WHERE c.sessionId = @sessionId AND c.type = @type")
        .WithParameter("@sessionId", sessionId)
        .WithParameter("@type", nameof(Message));
    ```

1. Create a `FeedIterator<Message>` using the `query` variable and the `GetItemQueryIterator<>` method.

    ```csharp
    FeedIterator<Message> response = _container.GetItemQueryIterator<Message>(query);
    ```

1. Use a *while loop* to iterate through all pages of results and store the results in a single `List<Message>` variable named `output`.

    ```csharp
    List<Message> output = new();
    while (response.HasMoreResults)
    {
        FeedResponse<Message> results = await response.ReadNextAsync();
        output.AddRange(results);
    }
    ```

1. Return the `output` variable as the result of the `GetSessionMessagesAsync` method.

    ```csharp
    return output;
    ```

1. Save the **Services/CosmosDbService.cs** file.

## Update one or more sessions or messages

There are scenarios when either a single session requires an update or more than one message requires an update. For the first scenario, use the `ReplaceItemAsync` method of the SDK to replace an existing item with a modified version. For the second scenario, use the transactional batch capability of the SDK to modify multiple messages in a single batch.

1. Within the `UpdateSessionAsync` method, remove any existing placeholder code.

    ```csharp
    public async Task<Session> UpdateSessionAsync(Session session)
    {
    }
    ```

1. Create a `PartitionKey` variable using `session.SessionId` as the value of the partition key.

    ```csharp
    PartitionKey partitionKey = new(session.SessionId);
    ```

1. Invoke `ReplaceItemAsync` passing in the new message's unique identifier and partition key. Return the response as the result of `UpdateSessionAsync`.

    ```csharp
    return await _container.ReplaceItemAsync(
        item: session,
        id: session.Id,
        partitionKey: partitionKey
    );
    ```

1. Within the `UpsertSessionBatchAsync` method, remove any existing placeholder code.

    ```csharp
    public async Task UpsertSessionBatchAsync(params dynamic[] messages)
    {
    }
    ```

1. validate that all messages contain a single session identifier (`SessionId`) using language-integrated query (LINQ). If any of the messages contain a different value, throw an `ArgumentException`.

    ```csharp
    if (messages.Select(m => m.SessionId).Distinct().Count() > 1)
    {
        throw new ArgumentException("All items must have the same partition key.");
    }
    ```

1. Create a new `PartitionKey` variable using the `SessionId` property of the first message.

    ```csharp
    PartitionKey partitionKey = new(messages.First().SessionId);
    ```

    > [!NOTE]
    > Remember, you can safely assume that all messages have the same session identifier if the application has moved to this point in the method's code.

1. Create a new variable named `batch` of type [`TransactionalBatch`](/dotnet/api/microsoft.azure.cosmos.transactionalbatch) by invoking the `CreateTransactionalBatch` method of the `_container` variable. Use the current partition key variable for the batch operations.

    ```csharp
    TransactionalBatch batch = _container.CreateTransactionalBatch(partitionKey);
    ```

    > [!IMPORTANT]
    > Remember, all transactions within this batch should be in the same logical partition.

1. Iterate over each message in the `messages` array using a *foreach loop*.

    ```csharp
    foreach (var message in messages)
    {
    }
    ```

1. Within the foreach loop, add each message as an **upsert** operation to the batch.

    ```csharp
    batch.UpsertItem(
        item: message
    );
    ```

    > [!NOTE]
    > **Upsert** tells Azure Cosmos DB to determine, server-side, whether an item should be replaced or updated. Azure Cosmos DB will make this determination with the `id` and partition key of each item.

1. Outside of the foreach loop, asynchronously invoke the `ExecuteAsync` method of the batch to execute all operations within the batch.

    ```csharp
    await batch.ExecuteAsync();
    ```

1. Save the **Services/CosmosDbService.cs** file.

## Remove a session and all related messages

Finally, combine the query and transactional batch functionality to remove multiple items. In this example, get the session item and all related messages by querying for all items with a specific session identifier regardless of type. Then, create a transactional batch to delete all matched items as a single transaction.

1. Within the `DeleteSessionAndMessagesAsync` method, remove any existing placeholder code.

    ```csharp
    public async Task DeleteSessionAndMessagesAsync(string sessionId)
    {
    }
    ```

1. Create a variable named `partitionKey` of type `PartitionKey` using the `sesionId` string value passed in as a parameter to this method.

    ```csharp
    PartitionKey partitionKey = new(sessionId);
    ```

1. Using the same `sessionId` method parameter, build a `QueryDefinition` object that finds all items that match the session identifier. Use a query parameter for the `sessionId` and ensure that you don't filter the query on the type of item.

    ```csharp
    QueryDefinition query = new QueryDefinition("SELECT VALUE c.id FROM c WHERE c.sessionId = @sessionId")
        .WithParameter("@sessionId", sessionId);
    ```

    > [!NOTE]
    > If you apply a `type` filter in this query, you may inadvertently miss related messages or sessions that should be bulk removed as part of this operation.

1. Create a new `FeedIterator<string>` using `GetItemQueryIterator` and the query you built.

    ```csharp
    FeedIterator<string> response = _container.GetItemQueryIterator<string>(query);
    ```

1. Create a `TransactionalBatch` named `batch` using `CreateTransactionalBatch` and the partition key variable.

    ```csharp
    TransactionalBatch batch = _container.CreateTransactionalBatch(partitionKey);
    ```

1. Create a *while loop* to iterate through all pages of results. Within the while loop, get the next page of results and use a *foreach loop* to iterate through all item identifiers per page. Within the foreach loop, add a batch operation to delete the item using `batch.DeleteItem`.

    ```csharp
    while (response.HasMoreResults)
    {
        FeedResponse<string> results = await response.ReadNextAsync();
        foreach (var itemId in results)
        {
            batch.DeleteItem(
                id: itemId
            );
        }
    }
    ```

1. After the while loop, execute the batch using `batch.ExecuteAsync`.

    ```csharp
    await batch.ExecuteAsync();
    ```

1. Save the **Services/CosmosDbService.cs** file.

## Check your work

Now your application has a full implementation of Azure OpenAI and Azure Cosmos DB. You can test the application end-to-end by debugging the solution.

### [Validate application](#tab/validate-app)

1. Open a new terminal.

1. Start the application with hot reloads enabled using `dotnet watch`.

    ```bash
    dotnet watch run --non-interactive
    ```

1. Visual Studio Code launches the in-tool simple browser again with the web application running. In the web application, create a new chat session and ask the AI assistant a question. Then, close the running web application.

1. Close the terminal. Now, open a new terminal.

1. Start the application one more time with hot reloads enabled using `dotnet watch`.

    ```bash
    dotnet watch run --non-interactive
    ```

1. Visual Studio Code launches the in-tool simple browser yet again with the web application running. For this iteration, observe that your chat sessions are persisted between debugging sessions.

    :::image type="content" source="../media/openai-cosmosdb-impelmented-application.png" lightbox="../media/openai-cosmosdb-impelmented-application.png" alt-text="Screenshot of the application with both Azure Cosmos DB and Azure OpenAI services implemented.":::

1. Close the terminal.

### [Review code](#tab/review-code)

1. Make sure that your code matches this sample by reviewing the `InsertSessionAsync` method of the *CosmosDbService.cs* code file.

    ```csharp
    public async Task<Session> InsertSessionAsync(Session session)
    {
        PartitionKey partitionKey = new(session.SessionId);

        return await _container.CreateItemAsync<Session>(
            item: session,
            partitionKey: partitionKey
        ); 
    }
    ```

1. Make sure that your code matches this sample by reviewing the `InsertMessageAsync` method of the *CosmosDbService.cs* code file.

    ```csharp
    public async Task<Message> InsertMessageAsync(Message message)
    {
        PartitionKey partitionKey = new(message.SessionId);

        Message newMessage = message with { TimeStamp = DateTime.UtcNow };

        return await _container.CreateItemAsync<Message>(
            item: newMessage,
            partitionKey: partitionKey
        );  
    }
    ```

1. Make sure that your code matches this sample by reviewing the `GetSessionsAsync` method of the *CosmosDbService.cs* code file.

    ```csharp
    public async Task<List<Session>> GetSessionsAsync()
    {
        QueryDefinition query = new QueryDefinition("SELECT DISTINCT * FROM c WHERE c.type = @type")
            .WithParameter("@type", nameof(Session));

        FeedIterator<Session> response = _container.GetItemQueryIterator<Session>(query);

        List<Session> output = new();
        while (response.HasMoreResults)
        {
            FeedResponse<Session> results = await response.ReadNextAsync();
            output.AddRange(results);
        }
        return output;
    }
    ```

1. Make sure that your code matches this sample by reviewing the `GetSessionMessagesAsync` method of the *CosmosDbService.cs* code file.

    ```csharp
    public async Task<List<Message>> GetSessionMessagesAsync(string sessionId)
    {
        QueryDefinition query = new QueryDefinition("SELECT * FROM c WHERE c.sessionId = @sessionId AND c.type = @type")
            .WithParameter("@sessionId", sessionId)
            .WithParameter("@type", nameof(Message));

        FeedIterator<Message> response = _container.GetItemQueryIterator<Message>(query);

        List<Message> output = new();
        while (response.HasMoreResults)
        {
            FeedResponse<Message> results = await response.ReadNextAsync();
            output.AddRange(results);
        }
        return output;
    }
    ```

1. Make sure that your code matches this sample by reviewing the `UpdateSessionAsync` method of the *CosmosDbService.cs* code file.

    ```csharp
    public async Task<Session> UpdateSessionAsync(Session session)
    {
        PartitionKey partitionKey = new(session.SessionId);

        return await _container.ReplaceItemAsync(
            item: session,
            id: session.Id,
            partitionKey: partitionKey
        );
    }
    ```

1. Make sure that your code matches this sample by reviewing the `UpsertSessionBatchAsync` method of the *CosmosDbService.cs* code file.

    ```csharp
    public async Task UpsertSessionBatchAsync(params dynamic[] messages)
    {
        if (messages.Select(m => m.SessionId).Distinct().Count() > 1)
        {
            throw new ArgumentException("All items must have the same partition key.");
        }

        PartitionKey partitionKey = new(messages.First().SessionId);

        TransactionalBatch batch = _container.CreateTransactionalBatch(partitionKey);
        foreach (var message in messages)
        {
            batch.UpsertItem(
                item: message
            );
        }
        await batch.ExecuteAsync();
    }
    ```

1. Make sure that your code matches this sample by reviewing the `DeleteSessionAndMessagesAsync` method of the *CosmosDbService.cs* code file.

    ```csharp
    public async Task DeleteSessionAndMessagesAsync(string sessionId)
    {
        PartitionKey partitionKey = new(sessionId);

        QueryDefinition query = new QueryDefinition("SELECT VALUE c.id FROM c WHERE c.sessionId = @sessionId")
            .WithParameter("@sessionId", sessionId);

        FeedIterator<string> response = _container.GetItemQueryIterator<string>(query);

        TransactionalBatch batch = _container.CreateTransactionalBatch(partitionKey);
        while (response.HasMoreResults)
        {
            FeedResponse<string> results = await response.ReadNextAsync();
            foreach (var itemId in results)
            {
                batch.DeleteItem(
                    id: itemId
                );
            }
        }
        await batch.ExecuteAsync();
    }
    ```

---
