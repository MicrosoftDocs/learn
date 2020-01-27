Serverless technologies like Azure Functions allow you to rapidly build HTTP APIs (sometimes called "Web Services") for your web applications without the headache of web frameworks. Additionally, Azure Functions only charges when an HTTP endpoint is called, which means that when the endpoints aren't being used, you aren't being charged. These two things combined make Serverless platforms like Azure Functions an ideal choice for API's.

Pretend for a moment, if you will, that you work for a large online hardware retailer called, "Tailwind Traders".

Tailwind Traders is a global corporation with a massive online presence and brick-and-morter stores all over the globe. One of the most critical tasks they have is keeping up with the inventory of products that they carry. Their inventory is stored in Azure Cosmos DB; a NoSQL database. Logistics specialists need to be able to manage this backend data store from all over the globe. During peak holiday seasons, the system gets heavy usage because new products are being added specifically for holiday shoppers and nearly 80% of the entire year's worth of business is done in the months between October and December. During other parts of the year, the inventory changes much less frequently and the system is not used often.

Your mission is to create an HTTP API that can be consumed by a lightweight web frontend. The whole application needs to be fast, global and able to handle the increased user load during the busier times of the year but without costing a fortune during the slow times.

## Learning objectives

In this module, you will:

- Build an HTTP API using the Azure Functions extension for VS Code
- Connect the API to a Cosmos DB database
- Secure the API with keys and implement CORS
- Consume the API from a web application

## Prerequisites

- Must have basic knowledge of Azure Functions
- Must have basic knowledge of Azure Cosmos DB
- Must have [Node.js](https://nodejs.org/en/) installed
- Must have [Visual Studio Code](https://code.visualstudio.com/) installed
- Must have [Azure Functions Core Tools](https://github.com/Azure/azure-functions-core-tools) installed
- Must have the [Azure Functions](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions) extension installed
- Must have the [Cosmos DB](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-cosmosdb) extension installed
