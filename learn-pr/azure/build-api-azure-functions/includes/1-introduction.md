With Azure Functions, you can rapidly build HTTP APIs for your web apps without the headache of web frameworks. Azure Functions is serverless, so you're only charged when an HTTP endpoint is called. When the endpoints aren't being used, you aren't being charged. These two things combined make serverless platforms like Azure Functions an ideal choice for APIs where you experience unexpected spikes in traffic.

Pretend for a moment, if you will, that you work for a large online hardware retailer called, "Tailwind Traders."

Tailwind Traders is a global corporation with a massive online retail operation. You also have brick-and-mortar stores in just about every major city in the world. One of your most critical tasks is keeping up with the inventory of products that you carry.

Logistics specialists need to manage the inventory from all over the globe. You never know when the buying mood will strike, so customer demand can dramatically increase and decrease without warning. When that happens, usage of the inventory management tool spikes as well as thousands of inventor managers use the tool to keep up with demand. Your mission is to create an HTTP API that can be consumed by a lightweight web front end. The whole app needs to be fast and global. It also needs to scale-up automatically when traffic unexpectedly spikes, without costing a fortune when traffic is low.

## Learning objectives

In this module, you will:

- Build an HTTP API using the Azure Functions extension for Visual Studio Code.
- Securely store sensitive data like database connection strings.
- Learn how to modify Azure Functions to make them RESTful.
- Specify who can access the API using CORS.

## Prerequisites

Must have:

- Basic understanding of web services and API concepts, including HTTP Methods and REST
- Knowledge of Azure Functions, including HTTP Triggers
- [Node.js](https://nodejs.org/en/) installed
- [Visual Studio Code](https://code.visualstudio.com/) installed
- [Azure Functions Core Tools](https://github.com/Azure/azure-functions-core-tools) installed
- [Azure Functions](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions) extension installed
