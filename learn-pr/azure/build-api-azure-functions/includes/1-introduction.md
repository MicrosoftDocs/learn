Every data-driven application has an API that connects it to a datasource. For web applications, this API is often a set of HTTP endpoints that return data. Serverless technologies like Azure Functions allow you to rapidly build HTTP API's for web applications without the headache of web frameworks. Additionally, Azure Functions only charges when an HTTP endpoint is called, which means that when the endpoints are not being used, you are not being charged.

Pretend, if you will, that you work for a large online hardware retailer. They are a global corporation with a fairly massive online presence and brick-and-morter stores all over the globe. One of the most critical tasks they face is keeping up with the inventory of products that they carry. Their inventory is stored in a backend NoSQL database. Logistics specialists need to be able to manage this backend data store from all over the globe. During peak holiday seasons, the system gets heavy usage because new products are being added specifically for holiday shoppers and nearly 80% of the entire year's worth of business is done in the months between October and December. During other parts of the year, the inventory changes much less frequently and the system is not used often. You need to create a web-based admin interface that is lightweight, fast and can handle the increased user load during the busier times of the year but not costing a fortune during the slow times.

## Learning objectives

In this module, you will:

- Build an Azure Functions API in Visual Studio Code with the Azure Functions extension
- Connect the API to a Cosmos DB database
- Consume the API from a web application
- Secure the API with keys and implement CORS

## Prerequisites

- Must have [Node.js](https://nodejs.org/en/) installed
- Must have [Visual Studio Code](https://code.visualstudio.com/) installed
- Must have [Azure Functions Core Tools](https://github.com/Azure/azure-functions-core-tools) installed
- Must have the [Azure Functions](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions) extension installed
- Must have the [Cosmos DB](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-cosmosdb) extension installed
