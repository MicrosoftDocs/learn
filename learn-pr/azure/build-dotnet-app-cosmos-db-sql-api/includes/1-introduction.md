The .NET SDK client library for the Azure Cosmos DB SQL API enables client applications to connect to Azure Cosmos via the SQL API endpoint. Many of the SQL API's resources, such as containers, databases, and items, can be created using the SDK. The .NET SDK is useful for business applications that need to perform common create, read, update, and delete (CRUD) operations from code. The .NET SDK also supports querying and batching of operations.

## Example scenario

Suppose you're a developer at a sporting goods retail company. You're working on software to import new inventory into your database. Your application will add multiple items using the .NET SDK for Azure Cosmos DB SQL API. After you import your data, the application will run a query, and display the results so you can validate the correct items were added.

[![Illustration of icons indicating data being uploaded to the cloud and then queried using common search techniques.](../media/project-visual.png)](../media/project-visual.png)

## What will we be doing?

This module walks through the steps to connect to an Azure Cosmos DB SQL API account from a .NET application. Your application will create a database and container resource if they don't already exist. You'll then use both individual and orchestrated operations to create multiple items within the container. Once the data is populated, you'll query the items.

In short, the application will:

- **Connect** to the SQL API using a connection string
- **Create** the necessary databases and containers
- **Insert** new items into a container
- **Orchestrate** multiple item operations together within the same container
- **Query** the resulting items in the container

## What is the main goal?

By the end of this module, you'll be able to create a .NET application that connects to Azure Cosmos DB SQL API and perform standard operations and queries.
