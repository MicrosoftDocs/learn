# Guided project - Build an app that queries and adds data to Azure Cosmos DB SQL API

## Role(s)

- [developer](https://review.docs.microsoft.com/help/contribute/metadata-taxonomies?branch=main#role)

## Level

- [beginner](https://review.docs.microsoft.com/help/contribute/metadata-taxonomies?branch=main#level)

## Product(s)

- [azure-cosmos-db](https://review.docs.microsoft.com/help/contribute/metadata-taxonomies?branch=main#level)

## Prerequisites

- Experience with Azure Cosmos DB concepts such as databases, containers, and items
- Experience writing SQL queries for Azure Cosmos DB SQL API
- Ability to execute scripts with Azure CLI
- Experience with top-level statement projects in .NET 6 or later
- Ability to write C# at an intermediate level

## Summary

Connect to an Azure Cosmos DB SQL API account using C# and .NET to perform common operations. Your code will create resources, coordinate multiple operations, and query items using SQL.

## Learning objectives

1. Connect to an Azure Cosmos DB SQL API account using the .NET SDK
1. Create Azure Cosmos DB SQL API database, container, and item resources
1. Execute multiple Azure Cosmos DB SQL API .NET SDK operations either as a transaction
1. Query Azure Cosmos DB SQL API items and iterate through the result set

## Subtasks

| Subtask | What part of the introduction scenario does this subtask satisfy? | How will you assess it? (Exercise or Knowledge check) | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Connect to account | "use best practices" | Knowledge check | 1 | yes |
| Create resources | "perform common tasks" | Exercise | 2 | yes |
| Orchestrate multiple operations | "perform common tasks" | Exercise | 3 | no, combine with "create resources" |
| Query results | "query data" | Exercise | 4 | yes |

## Outline

1. Introduction
    - Prose table-of-contents
        - This module walks through the steps to connect to an Azure Cosmos DB SQL API account from a .NET application. Your application will create a database and container resource if they don't already exist. You will then use both individual and orchestrated operations to create multiple items within the container. Once the data is populated, you will query the items.
    - Scenario
        - Suppose you are a developer at a sporting goods retail company. You are working on software to import new inventory into your database. One of the requirements of your software is to perform a quick query after the import to identify, to the user of the software, the items they just imported. The application you will build will add multiple items using the .NET SDK for Azure Cosmos DB SQL API. Although this is the first version of the application, you will try to use the documented best practices when using the SDK.
    - Terminal learning objective (goal)
        - By the end of this module, you will be able to create a .NET application that connects to Azure Cosmos DB SQL API and perform standard operations and queries.
1. Prepare
    - Project overview
    - Setup
        - Use Azure Cloud Shell (50/50 split)
        - Create account using CLI
        - Get endpoint
        - Get connection string
1. Exercise: Create .NET app and import library
    - Create .NET console application
    - Import Microsoft.Azure.Cosmos library
    - Create CosmosClient
1. Exercise: Create account resources
    - Create database with shared throughput
    - Create container with specific throughput and partition key
    - Create a single item
    - Create a multi-transaction batch
1. Exercise: Query and read items
    - Read a single item
    - Execute a SELECT query
    - Projecting query results to C# types
1. Exercise: Enumerate items using language-intergrated query (LINQ)
    - Using LINQ
    - Paginate results
1. Knowledge check
    - Create CosmosClient with endpoint and key
    - Create container parameters
    - Project results to serialize as C# type
    - Parse LINQ and identify SQL equivalent
1. Summary
    - Your developer team needed a .NET applications that connects to Azure Cosmos DB SQL API. This application implements common operations using the SDK and illustrate best practices for your team to follow.
    - You create an application that created and managed databases, containers, and items. Your application also used the SQL query language and LINQ to perform queries on items in Azure Cosmos DB.
    - With the .NET SDK for Azure Cosmos DB SQL API, you were able to illustrate the best way to create, manage, and query data. The .NET SDK made it possible to share a concise sample with your development team that focused solely on the code necessary for them to be successful.

## Timing

| Unit | Minutes |
| --- | --- |
| Introduction | 2 |
| Prepare | 4 |
| Exercise: Configure an Azure Cosmos DB account | 6 |
| Exercise: Connect to Azure Cosmos DB account | 6 |
| Exercise: Create account resources | 10 |
| Exercise: Query and read items | 10 |
| Exercise: Enumerate items using language-intergrated query | 10 |
| Knowledge check | 5 |
| Summary | 2 |
| **TOTAL** | **55** |
