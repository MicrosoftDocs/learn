# Design Document

## Title

Store and access graph data in Azure Cosmos DB with the Graph API

## Role(s)

- Developer

## Level

- Intermediate

## Product(s)

- Azure Cosmos DB
- Gremlin graph API

## Prerequisites

- Familiarity with creating and using Azure Cosmos DB

## Summary

Create an application that that uses an Azure Cosmos DB as a graph database. Store, retrieve and manipulate graph data and visualize it using Data Explorer.

## Learning objectives

1. Determine if a graph database fits the data needs of your application
1. Store data in a graph database from an application using the Gremlin API
1. Query data in a graph database from an application using the Gremlin API

## Chunk your content into subtasks

| Subtask                                                                  | What part of the introduction scenario does this subtask satisfy? | How will you assess it: **Exercise or Knowledge check**? | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask will you combine it with? |
|--------------------------------------------------------------------------|-------------------------------------------------------------------|----------------------------------------------------------|--------------------------------------------------|--------------------------------------------------------------------------------------------------------------------------------|
| Determine if a graph database fits the data needs of your application    | Uncertainty of fit                                                | Knowledge check                                          | 1                                                | Yes                                                                                                                            |
| Store data in a graph database from an application using the Gremlin API | Business need to store data                                       | Exercise                                                 | 2                                                | Yes                                                                                                                            |
| Query data in a graph database from an application using the Gremlin API | Business need to query data                                       | Exercise                                                 | 3                                                | Yes                                                                                                                            |

## Outline the units

1. **Introduction**

    *See the notes below.* Work with the author of "Choose the appropriate API for Azure Cosmos DB storage" to expand on the scenario used in the graph DB unit from that module. The overall concept should be that you, as a developer, are doing a "spike" to see if a graph database is a fit for your data, how to accomplish it on Azure, and exploration of how to use a graph database from an application. The scenario needs to justify the first pair of units (introduction to graph databases/determine if it fits your needs), so should include something along the lines of "you've heard a little bit about graph database technology and decide to explore and see if it's the right fit (it will be), and how you can make it work on Azure".

1. **Determine if a graph database fits the data needs of your application**

    - Foundational concepts of graph databases
        - Strengths and weaknesses of graph databases as compared to other database models
        - Example scenarios, plus some detail about how it fits this module's scenario
    - Determining if a graph database is a fit for your application
        - Examining the data model for fit
        - Mapping from data model to graph database entities

1. **Knowledge check**

    - In which of the following scenarios would a graph database, as opposed to another database model, be the best fit?
    - Which of the following is a primary strength of graph databases, as compared to other database models?
    - How would you model (some aspect) of this module's scenario in a graph database? (2x)

1. **Build an application that stores graph data using the Gremlin API**

    - General concepts
        - Like most other databased applications: connect to the database and run queries
        - No Azure Cosmos DB specific libraries or concepts. The graph API presentAzure ed by Azure Cosmos DB is entirely standards-based. The .NET Core app in this module's exercise uses the Gremlin.Net open source library.
    - Using Azure Cosmos DB as a graph database
        - Features
        - Creating a graph-mode Azure Cosmos DB
    - Establishing the connection in the app code
    - Using Gremlin query language to store data in the app code

1. **Exercise - Build an application that stores graph data using the Gremlin API**

    1. Use the portal to create a graph-model Azure Cosmos DB. Don't spend a lot of time/space explaining the details; the user should generally be familiar with Azure Cosmos DB creation.
    1. Locally clone a sample .NET Core starter app from GitHub. Similar to https://github.com/Azure-Samples/azure-cosmos-db-graph-gremlindotnet-getting-started, the app should be scaffolded to connect to a graph database. The linked sample app is not a good fit in terms of trying to fit a scenario - it just runs a bunch of queries. The sample app for the module should at least try to superficially fit to the scenario and do something simple but interesting in response to user input. For example, maybe the user will be able to create products in the database, create relationships between them, then modify properties of the relationships. The work done should be a fit for the scenario.
    1. Update the application's connection string.
    1. Fill in the Gremlin queries in the sections where data is written to the database.
    1. Run the application and store data in the database.
    1. Use Data Explorer in the portal to visualize the data that's been added.

1. **Query graph data from an application using the Gremlin API**

    - General concepts
        - Like most other database applications: connect to the database and run queries
        - No Azure Cosmos DB specific libraries or concepts. The graph API presented by Azure Cosmos DB is entirely standards-based. The .NET Core app in this module's exercise uses the Gremlin.Net open source library.
    - Establishing the connection
    - Using Gremlin query language to store data

1. **Exercise - Query graph data from an application using the Gremlin API**

    1. Fill in the Gremlin queries in the parts of the application that require querying data.
    1. Run the application and use it to query the graph data.

1. **Summary**

    - Explored graph-model databases and found them to be a good fit for your scenario.
    - Created a graph-model Azure Cosmos DB database and built a small application to see how to store and query data.

## Notes
- The Gremlin graph API for Azure Cosmos DB should not be confused with the [Microsoft Graph API](https://developer.microsoft.com/graph). They are entirely separate things.
- Working with the author of the ["Choose the appropriate API for Azure Cosmos DB storage"](https://microsoft.sharepoint.com/:w:/t/ContentMaster-IgniteTripleCrown/EcJpzJlc9wFJuYKrsLkJjL8BuRqXZlGCSXVwKDMEruXG2A?e=Mczfwb) to make use of the scenario there. Expand on it and turn it into a full scenario for this module.
- This module is not about the overall advantages of Azure Cosmos DB or globally distributing data in general. It should focus primarily on the concepts of graph databases and using Azure Cosmos DB as a graph database with Gremlin.
- This module requires development of a small, simple .NET Core application, fit to the domain of the scenario. A simple console application is probably a good start. Please don't spend substantial amounts of time building a flashy user experience.
- This module should require a local installation of VS Code and .NET Core for local development. Azure components will use the sandbox.
