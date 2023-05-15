The Azure Cosmos DB service (`CosmosDbService`) manages querying, creating, deleting, and updating sessions and messages in your AI assistant application. To manage all of these operations, the service is required to implement multiple methods for each potential operation using various features of the .NET SDK.

There are multiple key requirements to tackle in this exercise:

- Implement operations to create a session or message
- Implement queries to retrieve multiple sessions or messages
- Implement an operation to update a single session or batch update multiple messages
- Implement an operation to query and delete multiple related sessions and messages

## Create a session or message

Azure Cosmos DB for NoSQL stores data in JSON format allowing us to store many types of data in a single container. This application stores both a chat *"session"* with the AI assistant and the individual *"messages"* within each session. With the API for NoSQL, the application can store both types of data in the same container and then differentiate between these types using a simple `type` field.

1. Open the **Services/CosmosDbService.cs** file.

1. Within the `GetSessionsAsync` method, remove any existing placeholder code:

    ```csharp
    public async Task<List<Session>> GetSessionsAsync()
    {
    }
    ```

1. Create a new variable named `query` of type [`QueryDefinition`](/dotnet/api/microsoft.azure.cosmos.querydefinition) with the SQL query `SELECT DISTINCT * FROM c WHERE c.type = @type`. Use the fluent `WithParameter` method to assign the name of the `Session` class as the value for the parameter.

    ```csharp
    QueryDefinition query = new ("SELECT DISTINCT * FROM c WHERE c.type = @type")
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
    FeedResponse<Message> response = await results.ReadNextAsync();
    output.AddRange(response);
    ```

1. Outside the while loop, return the `output` variable with a list of sessions as the result of the `GetSessionsAsync` method.

    ```csharp
    return output;
    ```

1. Within the `GetSessionMessagesAsync` method, remove any existing placeholder code:

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
    FeedIterator<Message> results = _container.GetItemQueryIterator<Message>(query);
    ```

1. Use a *while loop* to iterate through all pages of results and store the results in a single `List<Message>` variable named `output`.

    ```csharp
    List<Message> output = new();
    while (results.HasMoreResults)
    {
        FeedResponse<Message> response = await results.ReadNextAsync();
        output.AddRange(response);
    }
    ```

1. Return the `output` variable as the result of the `GetSessionMessagesAsync` method.

    ```csharp
    return output;
    ```

1. Save the **Services/CosmosDbService.cs** file.

## Retrieve multiple sessions or messages

There are two main use cases where the application needs to retrieve multiple items from our container. First, the application retrieves all sessions for the current user by filtering the items to ones where `type = Session`. Second, the application retrieves all messages for a session by performing a similar filter where `type = Session & sessionId = <current-session-id>`. Implement both queries here using the .NET SDK and a feed iterator.

1. Within the `` method, remove any existing placeholder code:

    ```csharp

    ```

1. Within the `` method, remove any existing placeholder code:

    ```csharp

    ```

1.

1. Save the **Services/CosmosDbService.cs** file.

## Update one or more sessions or messages

There are scenarios when either a single session requires an update or more than one message requires an update. For the first scenario, use the `ReplaceItemAsync` method of the SDK to replace an existing item with a modified version. For the second scenario, use the transactional batch capability of the SDK to modify multiple messages in a single batch.

1. Within the `` method, remove any existing placeholder code:

    ```csharp

    ```

1. Within the `` method, remove any existing placeholder code:

    ```csharp

    ```

1.

1. Save the **Services/CosmosDbService.cs** file.

## Remove a session and all related messages

Finally, combine the query and transactional batch functionality to remove multiple items. In this example, get the session item and all related messages by querying for all items with a specific session identifier regardless of type. Then, create a transactional batch to delete all matched items as a single transaction.

1. Within the `` method, remove any existing placeholder code:

    ```csharp

    ```

1.

1. Save the **Services/CosmosDbService.cs** file.

## Check your work

Now, your application has a full implementation of Azure OpenAI and Azure Cosmos DB. You can test the application end-to-end by debugging the solution.

### [Validate application](#tab/validate-app)

### [Review code](#tab/review-code)

---
