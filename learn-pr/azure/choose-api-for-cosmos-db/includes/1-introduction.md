Your company has begun a large-scale, multi-departmental project that requires data to be globally accessible, and it requires guarantees on throughput and resilience. 

The project consists of multiple components that include:
- Customer facing e-commerce web and mobile applications
- Back-office warehouse and operations systems
- Internal sales and marketing database with real-time reporting requirements

The architecture team has selected Azure Cosmos DB as the candidate data store for all of the scenarios that are listed above, and they've asked you to explore the different options that are available to store and access data. Your development teams have a wide range of experience with different database APIs, and you've been asked to provide guidance back the project team on which APIs to use for each area of the project.

Azure Cosmos DB was chosen because it is flexible. At the lowest level, Azure Cosmos DB stores data in atom-record-sequence (ARS) format. The data is then abstracted and projected as an API, which you specify when you are creating your database.

In this module, you'll learn how Azure Cosmos DB provides different APIs to access and interact with the data it stores. You'll see the benefits of having a globally distributed database that is built to scale, with guaranteed latencies and availability, and support for your development teams' existing database knowledge.

By the end of the module, you'll have learned about all the different APIs, and explored how data is accessed via each API or via the Azure portal. Using this knowledge, you can make an informed decision on which APIs are the right choice for your company.

## Learning objectives

At the end of this module, you will be able to:
- Explain the features of Core (SQL)
- Explain the features of MongoDB
- Explain the features of Cassandra
- Explain the features of Azure Table
- Explain the features of Gremlin (graph)
- Choose the appropriate API for your Azure Cosmos DB account

## Prerequisites

- Familiarity with database concepts
