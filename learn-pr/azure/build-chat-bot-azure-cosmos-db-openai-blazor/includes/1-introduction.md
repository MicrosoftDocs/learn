Applications can connect to Azure Cosmos DB for NoSQL or Azure OpenAI using their respective .NET software development kits (SDKs). These SDKs can extend existing .NET applications with NoSQL data storage and AI completion functionality with relatively low friction.

The .NET SDK for Azure Cosmos DB for NoSQL is useful for business applications that need to manage various account resources including databases, containers, and items. The SDK can perform queries that return multiple items, operations on specific items, and even transactions that batch operations together over multiple items.

The .NET SDK for Azure OpenAI provides a streamlined interface for interacting with the various models available for deployment. Specifically, the SDK includes classes to interface directly with the model, send prompts, fine tune the requests, and parse the completion responses.

## Example scenario

Your development team built a chat bot interface with Blazor that can handle multiple conversations with message history for each conversation. With .NET best practices in mind, your team stubbed out a basic implementation for a service to connect to Azure Cosmos DB and store conversation sessions and individual messages. Your team also stubbed out an implementation of a service to connect to Azure OpenAI to send prompts, parse responses, and summarize conversations.

## What are we doing?

This module walks through the steps to connect an existing Blazor application to an Azure Cosmos DB for NoSQL account and an Azure OpenAI account. Your application sends prompts to the model in Azure OpenAI and parses the responses. Your application also stores various conversation sessions and their corresponding messages as items colocated in a single container within Azure Cosmos DB for NoSQL.

In short, the application will:

- **Connect** to Azure OpenAI's model using the .NET SDK
- **Send** prompts to the model and parse the completion response
- **Connect** to Azure Cosmos DB for NoSQL using the .NET SDK
- **Manage** items with individual operations, queries, and transactional batches

## What is the main goal?

By the end of this module, you're able to author .NET classes that connect to Azure Cosmos DB for NoSQL or Azure OpenAI. The classes you author implement common operations using their respective SDKs. Finally, the classes you author are then used in a Blazor application.
