Suppose you're responsible for an application that helps customers add, edit, view, and remove plans from their wish lists on your company's vacation planning website. Your Application Programming Interface (API), which is hosted on a server running Node.js and Express, is critical to the success of the application. It's challenging to scale the application up and down as needed while minimizing costs.

To reduce the burden of maintaining servers, you can use a serverless model to scale your application up and down as needed, reduce costs, and write less code. You can use Azure Functions to shift your API to a serverless model without having to rewrite your app.

## Learning objectives

In this module, you refactor an Express API to a serverless architecture by following these steps:

1. Explore and run the Node.js Express APIs in the sample project.
1. Create an Azure Functions application.
1. Refactor the Express routes and data calls to use the Functions application.
1. Debug the serverless API by using Visual Studio Code.

## Prerequisites

- Some knowledge of JavaScript and TypeScript
- Some familiarity with Node.js Express and Azure Functions
- [Node.js v14](https://nodejs.org/) installed
- [Visual Studio Code](https://code.visualstudio.com/) with the [Azure Functions](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions) extension installed
- [Azure Functions Core Tools](https://github.com/Azure/azure-functions-core-tools) installed
