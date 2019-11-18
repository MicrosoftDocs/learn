Every data-driven application has an API that connects it to a datasource. For web applications, this API is often a set of RESTful http endpoints. Serverless technologies like Azure Functions allow you to rapidly build API's for web applications without the headache of web frameworks.

Assume for a moment that you work for a large online hardware retailer. They are a global corporation with an online presence and brick-and-morter stores all over the globe. One of the most critical tasks is keeping up with the inventory of products that they carry. This is a backend internal system that admins will need to access sporadically from anywhere. During peak holiday seasons, the system gets heavy usage because new products are being added for the holiday season. During other parts of the year, it doesn't change much at all. You need to create a web-based admin interface that is lightweight, fast and can handle the increased user load during the busier times of the year but not costing a fortune during the slow times.

## Learning objectives

In this module, you will:

* Build an Azure Functions API in Visual Studio Code with the Azure Functions extension
* Connect the API to a Cosmos DB database 
* Consume the API from a web application
* Secure the API with keys and implement CORS

## Prerequisites

- Must have [Node.js](https://nodejs.org/en/) installed
- Must have [Visual Studio Code](https://code.visualstudio.com/) installed
- Must have [Azure Functions Core Tools](https://github.com/Azure/azure-functions-core-tools) installed
- Must have the [Azure Functions](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions) extension installed
