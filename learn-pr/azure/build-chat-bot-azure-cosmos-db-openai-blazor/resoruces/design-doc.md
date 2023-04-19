# Guided project: Build a chat bot using Azure OpenAI, Azure Cosmos DB for NoSQL, and ASP.NET Blazor

## Role(s)

- [`developer`](https://review.learn.microsoft.com/help/contribute/metadata-taxonomies?branch=main#role)

## Level

- [`beginner`](https://review.learn.microsoft.com/help/contribute/metadata-taxonomies?branch=main#level)

## Product(s)

- [`azure-cosmos-db`](https://review.learn.microsoft.com/help/contribute/metadata-taxonomies?branch=main#level)
- [`azure-openai`](https://review.learn.microsoft.com/help/contribute/metadata-taxonomies?branch=main#level)
- [`blazor`](https://review.learn.microsoft.com/help/contribute/metadata-taxonomies?branch=main#level)

## Prerequisites

- Ability to execute scripts with Azure CLI
- Ability to deploy templates using Azure Resource Manager
- Experience with Azure Cosmos DB concepts such as databases, containers, and items
- Experience with Azure OpenAI concepts such as models, deployments, and prompts
- Experience writing queries for Azure Cosmos DB for NoSQL
- Ability to write C# at an intermediate level
- Experience running ASP.NET Blazor web applications

## Summary

Connect an existing ASP.NET Core Blazor web application to Azure Cosmos DB for NoSQL and Azure OpenAI using their .NET SDKs. Your code manages and queries items in the API for NoSQL container. Your code also sends prompts to Azure OpenAI and parses the responses.

## Learning objectives

01. Connect to an Azure Cosmos DB for NoSQL account using the .NET SDK
01. Create, update, query, and delete items in an API for NoSQL container
01. Connect to an Azure OpenAI account using the .NET SDK
01. Send prompts to a model deployment and parse the responses

## Subtasks

| Subtask | What part of the introduction scenario does this subtask satisfy? | How do you assess it? (Exercise or Knowledge check) | Which learning objective(s) does this help meet? | Does the subtask have enough learning content to justify an entire unit? If not, which other subtask do you combine it with? |
| ---- | ---- | ---- | ---- | ---- |
| Connect to Azure Cosmos DB for NoSQL | "connect to Azure Cosmos DB" | Exercise | 1 | yes |
| Perform common API for NoSQL operations | "store conversation sessions and individual messages" | Exercise | 2 | yes |
| Connect to Azure OpenAI | "connect to Azure OpenAI" | Exercise | 3 | yes |
| Interface with conversational interface | "send prompts, parse responses, and summarize conversations" | Exercise | 4 | yes |

## Outline

01. Introduction
    - Prose table-of-contents
        - This module walks through the steps to connect an existing ASP.NET Core Blazor WebAssembly application to an Azure Cosmos DB for NoSQL account and an Azure OpenAI account. Your application sends prompts to the ChatGPT model in Azure OpenAI and parses the responses. Your application also stores various conversation sessions and their corresponding messages as items colocated in a single container within Azure Cosmos DB for NoSQL.
    - Scenario
        - Your development team has built a chat bot interface with ASP.NET Core Blazor that can handle multiple conversations with message history for each conversation. With .NET best practices in mind, your team has stubbed out a basic implementation for a service to connect to Azure Cosmos DB and store conversation sessions and individual messages. Your team has also stubbed out an implementation of a service to connect to Azure OpenAI to send prompts, parse responses, and summarize conversations. You build an application that imports the .NET SDK for Azure Cosmos DB and Azure OpenAI and then implement these services using the SDKs.
    - Terminal learning objective (goal)
        - By the end of this module, you're able to author .NET classes that connect to Azure Cosmos DB for NoSQL or Azure OpenAI. The classes you author implement common operations using their respective SDKs. Finally, the classes you author are then used in an ASP.NET Core Blazor WebAssembly application.
01. Prepare
    - Project overview
    - Setup
        - Use Azure Cloud Shell (50/50 split)
        - Deploy template using the CLI and the `main` branch
        - Observe the running sample application
        - Get the Azure Cosmos DB for NoSQL endpoint and key
        - Get the Azure OpenAI endpoint and key
01. Exercise: Setup and run the starter web application
    - Open the environment using the `main` branch
      - Visual Studio Code development container
      - GitHub Codespaces
    - Use [CodeTour](https://github.com/microsoft/codetour) to walk through the project's highlights
      - Model classes
      - Current service implementations
      - Options classes
      - Bicep template
        - Azure Cosmos DB resource
        - Azure OpenAI resource
        - Azure App Service resource
    - Switch to the `start` branch
    - Build the project
    - Use `dotnet watch` to test the application with no connection
01. Exercise: Connect to Azure Cosmos DB for NoSQL
    - Import the [`Microsoft.Azure.Cosmos` (v3.32.3)](https://www.nuget.org/packages/Microsoft.Azure.Cosmos/3.32.3) package from NuGet
    - Add the Azure Cosmos DB for NoSQL endpoint and key to a new `appsettings.development.json` file
    - Configure custom serialization options to use [camel case](https://en.wikipedia.org/wiki/Camel_case)
    - Create a new `CosmosClient` instance using the builder pattern
    - Retrieve the container instance with appropriate null checks
    - If the container is null, throw an exception
1. Exercise: Implement the Azure Cosmos DB for NoSQL service
    - Implement methods to use a query string to get a list of sessions or messages
    - Implement methods to create a new session or message
    - Implement a method to update an existing session
    - Implement a method to upsert (create or update) multiple messages using a transactional batch operation
    - Implement a method to delete all sessions or messages by partition key using a transactional batch operation
1. Exercise: Connect to Azure OpenAI ChatGPT
    - Import the [`Azure.AI.OpenAI` (v1.0.0-beta.5)](https://www.nuget.org/packages/Azure.AI.OpenAI/1.0.0-beta.5) package from NuGet
    - Add the Azure OpenAI endpoint and key to the existing `appsettings.development.json` file
    - Create static strings for the AI context and summary prefix prompts
    - Create a new `OpenAIClient` instance
1. Exercise: Implement the Azure OpenAI ChatGPT service
    - Implement a method to send a prompt to the AI to ask a question
    - Implement a method to send a conversation to the AI and ask for a brief summary
1. Knowledge check
    - Get existing container using the Azure Cosmos DB for NoSQL client
    - Insert multiple Azure Cosmos DB for NoSQL items using a transactional batch
    - Send a prompt to the Azure OpenAI conversational interface
    - Parse the Azure OpenAI response for the number of tokens used in a completion
1. Summary
    - Your developer team needed you to implement various methods in pre-existing stubbed out services to connect their chat bot ASP.NET Core Blazor web application to Azure OpenAI's conversational interface and Azure Cosmos DB for NoSQL data storage.
    - You implemented service classes using the `Microsoft.Azure.Cosmos` and `Azure.AI.OpenAI` packages on NuGet. You sent prompts to the Azure OpenAI conversational interface along with contextual prefixes and parsed the usage and body properties of the response. You also used Azure Cosmos DB for NoSQL to store the conversation sessions and messages within a single container.
    - With the .NET SDKs for Azure Cosmos DB for NoSQL and Azure OpenAI, you were able to add these services to your application with little friction. The services you implemented illustrate the best practices for using each SDK across various operations. The .NET SDKs for each service made it possible to add the required functionality to your ASP.NET Core Blazor web application with lightweight method implementations.

## Timing

| Unit | Minutes |
| --- | --- |
| Introduction | 2 |
| Prepare | 12 |
| Exercise: Setup and run the starter web application | 6 |
| Exercise: Connect to Azure Cosmos DB for NoSQL | 7 |
| Exercise: Implement the Azure Cosmos DB for NoSQL service | 13 |
| Exercise: Connect to Azure OpenAI ChatGPT | 5 |
| Exercise: Implement the Azure OpenAI ChatGPT service | 8 |
| Knowledge check | 5 |
| Summary | 2 |
| **TOTAL** | **60** |
