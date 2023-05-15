The Azure Cosmos DB service (`CosmosDbService`) manages querying, creating, deleting, and updating sessions and messages in your AI assistant application. To manage all of these operations, the service is required to implement multiple methods for each potential operation using various features of the .NET SDK.

There are multiple key requirements to tackle in this exercise:

- Implement operations to create a session or message
- Implement queries to retrieve multiple sessions or messages
- Implement an operation to update a single session or batch update multiple messages
- Implement an operation to query and delete multiple related sessions and messages

## Create a session or message

Azure Cosmos DB for NoSQL stores data in JSON format allowing us to store many types of data in a single container. This application stores both a chat *"session"* with the AI assistant and the individual *"messages"* within each session. With the API for NoSQL, the application can store both types of data in the same container and then differentiate between these types using a simple `type` field.

1.

## Retrieve multiple sessions or messages

There are two main use cases where the application needs to retrieve multiple items from our container. First, the application retrieves all sessions for the current user by filtering the items to ones where `type = Session`. Second, the application retrieves all messages for a session by performing a similar filter where `type = Session & sessionId = <current-session-id>`. Implement both queries here using the .NET SDK and a feed iterator.

1.

## Update one or more sessions or messages

There are scenarios when either a single session requires an update or more than one message requires an update. For the first scenario, use the `ReplaceItemAsync` method of the SDK to replace an existing item with a modified version. For the second scenario, use the transactional batch capability of the SDK to modify multiple messages in a single batch.

1.

## Remove a session and all related messages

Finally, combine the query and transactional batch functionality to remove multiple items. In this example, get the session item and all related messages by querying for all items with a specific session identifier regardless of type. Then, create a transactional batch to delete all matched items as a single transaction.

1.

1. Save the **Services/CosmosDbService.cs** file.

## Check your work

Now, your application has a full implementation of Azure OpenAI and Azure Cosmos DB. You can test the application end-to-end by debugging the solution.

### [Validate application](#tab/validate-app)

### [Review code](#tab/review-code)

---
