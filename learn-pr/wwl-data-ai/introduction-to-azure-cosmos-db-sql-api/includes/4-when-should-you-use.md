Azure Cosmos DB for NoSQL is a fully managed NoSQL database service for modern and AI app development. It provides guaranteed single-digit millisecond response times, 99.999-percent availability and [vector database capabilities][azure/cosmos-db/vector-database], backed by SLAs with automatic and instant scalability.

For enterprise scenarios, Azure Cosmos DB for NoSQL has a comprehensive suite of financially backed [service level agreements (SLAs)][azure.microsoft.com/support/legal/sla/cosmos-db] that cover throughput, consistency, availability, and latency.

## Common use cases for the Azure Cosmos DB for NoSQL

As a fast NoSQL database with a flexible API and vector indexing and search capabilities, Azure Cosmos DB for NoSQL is well suited for many types and sizes of applications. From the very small scale, to high-performance applications with global ambition. Speed and flexibility make Azure Cosmos DB for NoSQL great for Generative AI, web, retail, IoT, gaming, and mobile applications. Azure Cosmos DB for NoSQL is a good fit for applications that require flexibility, low cost, fast response times, and the ability to scale to massive volume or velocity.

### Generative AI

Generative AI applications can be diverse and unpredictable. These workloads require a database platform that is cost-efficient, responsive and scalable. Users can store vectors directly in their documents with traditional schema-free data and high-dimensional vectors as other properties. This colocation of data and vectors allows for efficient indexing and searching, as the vectors are stored in the same logical unit as the data they represent. Keeping vectors and data together simplifies data management, AI application architectures, and the efficiency of vector-based operations.

![Architectural diagram for a Generative AI workload showing a multi-tenant AI Agent application for end users. New or updated data is ingested with Change Feed, vectorized and stored. Users interact through the AI Agents which perform vector search and generate responses with the chat history stored in Azure Cosmos DB.](../media/4-ai-case.png)

In this example, customers are taking transactional and operational data and vectorizing it to be used for vector search by multiple AI Agents serving customers. Azure Cosmos DB's Change Feed is used to handle ingestion and vectorization of new or updated data, making it available in near real-time for users. Customers interacting with these agents generate prompts and completions which are also stored as their chat history in Azure Comsos DB and used to provide a semantic cache for improved cost and performance.

### Retail/marketing

Azure Cosmos DB for NoSQL is a great fit for retail and marketing workloads that can experience dramatic and unexpected swings in usage at any point throughout the year. The elastic scale of Azure Cosmos DB for NoSQL ensures that the database platform can handle requests during peak usage, and save money during nonpeak times.

![Architectural diagram for a retail workload showing a user browser connecting to the website on Azure App Service supported by an Azure Blob Storage account containing static site data. Behind the scenes, an Azure Cosmos DB for NoSQL account with a container for inventory data and a container for shopping cart data is used by the App Service Web App and an Azure Search instance that builds a searchable catalog by indexing the Azure Cosmos DB for NoSQL account with inventory data.](../media/4-retail-case.png)

In this example, a JavaScript web application, built on content stored in Azure Blob Storage, uses Azure Cosmos DB for NoSQL as it's backing database. Multiple accounts are used to manage different facets of the solution such as the shopping cart, inventory, or catalog. The solution then uses Azure Search to index the Azure Cosmos DB for NoSQL data, providing a rich search experience to end users.

### Web/mobile

Many modern social applications generate a plethora of user-generated content that is diverse in quantity, shape, and volume. Azure Cosmos DB for NoSQL is a great candidate for this workload as this API can store data of varying schemas. Consider the NoSQL API for data that may have schemas that change or evolve over time as the company's initiatives expand into new areas.

![Architectural diagram for a web workload showing a user browser connecting to a URL that is connected to  Azure Traffic Manager to determine the correct redirect destination. Then three Azure App Service instances in three Azure regions (North Europe, West US, East US) are connected to a globally distributed Azure Cosmos DB for NoSQL account.](../media/4-web-case.png)

In this example, a user is using a URL to access a web site in their browser. The URL points to Azure Traffic Manager, which then uses a built-in algorithm to determine which Azure App Service endpoint to redirect the user to. Since Azure Cosmos DB for NoSQL is capable of global distribution, you only need one account that is replicated across multiple regions.

## Module Scenario

Consider the scenario from the beginning of this module:

> Suppose you work as the lead developer at a retail company. Your team is building your online storefront with support for AI Agents to provide a rich experience for users. You're designing the new storefront to be accessible across various devices including mobile. The team expects a spike in demand when the storefront is published and various "grand opening" sales begin.

One key part of your store's success is the ability for the company to notify users of shipping updates regardless of what device they place the order on or are currently using. Your team has worked hard on a sophisticated system to manage detailed order status tracking. The tight integration of Azure Cosmos DB with other Azure services, let's you consider building solutions that use order data in Azure Cosmos DB for NoSQL to send notification to your user's mobile devices. The notifications alert them when their package ships, or is out for delivery.

![Architectural diagram for a retail workload showing a growing number of users ordering products and a collection of compute resources handling requests from the storefront instances. Behind the compute resources, Azure Cosmos DB stores purchase data. Then, Azure Synapse Link connects Azure Cosmos DB to Azure Synapse Analytics for deeper analytics. Finally, Azure Functions, triggered off of change feed, processing data events that then trigger an Azure Logic Apps workflow to perform business operations such as notifying the user on their mobile device of new events.](../media/4-retail-scenario.png)

This example is similar to the example from the introduction of this module. To build on the first example, your team has decided to introduce Azure Cosmos DB for NoSQL as the database of choice. Now, your team can use Azure Synapse Link to prepare and aggregate data for deeper analysis using Azure Synapse Analytics. Your team can also use services such as Azure Functions to react to data events with Azure Cosmos DB, and then trigger an Azure Logic Apps workflow that sends notifications to mobile devices.

[azure/cosmos-db/vector-database]: /azure/cosmos-db/vector-database
[azure.microsoft.com/support/legal/sla/cosmos-db]: https://azure.microsoft.com/support/legal/sla/cosmos-db/
