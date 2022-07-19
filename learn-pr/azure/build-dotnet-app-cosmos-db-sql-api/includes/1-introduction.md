The .NET SDK client library for the Azure Cosmos DB SQL API enables client applications to connect to Azure Cosmos via the SQL API endpoint. Many of the SQL API's resources, such as containers, databases, and items, can be created using the SDK.

The SDK is available using the NuGet package manager and is also open-source on GitHub:

| Source | Description | Link |
| --- | --- | --- |
| NuGet | Client library package for .NET applications | [github.com/azure/azure-cosmos-dotnet-v3](https://github.com/azure/azure-cosmos-dotnet-v3) |
| GitHub | Open-source repository | [nuget.org/packages/microsoft.azure.cosmos](https://www.nuget.org/packages/microsoft.azure.cosmos) |
| Microsoft Docs | API reference and code samples | [docs.microsoft.com/azure/cosmos-db/sql/samples-dotnet](/azure/cosmos-db/sql/samples-dotnet) |

## Example scenario

Suppose you're a developer at a sporting goods retail company. You're working on software to import new inventory into your database. One of the requirements of your software is to perform a quick query after the import to identify, to the user of the software, the items they imported. The application you'll build will add multiple items using the .NET SDK for Azure Cosmos DB SQL API. Although the version you build in this project is the first version of the application, you'll try to use the documented best practices when using the SDK.

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
