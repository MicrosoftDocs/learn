With Azure Functions, you can rapidly build HTTP APIs for your web apps without the headache of web frameworks. Azure Functions is serverless, so you're only charged when an HTTP endpoint is called. When the endpoints aren't being used, you aren't being charged. These two things combined make serverless platforms like Azure Functions an ideal choice for APIs.

Pretend for a moment, if you will, that you work for a large online hardware retailer called, "Tailwind Traders."

Tailwind Traders is a global corporation with a massive online retail operation. You also have brick-and-mortar stores in just about every major city in the world. One of your most critical tasks is keeping up with the inventory of products that you carry.

Tailwind Traders' inventory is stored in Azure Cosmos DB. Logistics specialists need to manage this backend data store from all over the globe. During peak holiday seasons, the system gets heavy usage because new products are being added specifically for holiday shoppers. Nearly 80% of the entire year's worth of business is done in the months between October and December. During other parts of the year, the inventory changes much less frequently, and the system isn't used as often.

Your mission is to create an HTTP API that can be consumed by a lightweight web front end. The whole app needs to be fast and global. It also needs to scale when holiday traffic spikes, but without costing a fortune during the slower times.

## Learning objectives

In this module, you will:

- Build an HTTP API using the Azure Functions extension for Visual Studio Code.
- Connect the API to a Azure Cosmos DB database.
- Secure the API with keys and implement CORS.
- Consume the API from a web app.

## Prerequisites

Must have:
- basic knowledge of Azure Functions
- basic knowledge of Azure Cosmos DB
- [Node.js](https://nodejs.org/en/) installed
- [Visual Studio Code](https://code.visualstudio.com/) installed
- [Azure Functions Core Tools](https://github.com/Azure/azure-functions-core-tools) installed
- [Azure Functions](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions) extension installed
- [Azure Cosmos DB](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-cosmosdb) extension installed
