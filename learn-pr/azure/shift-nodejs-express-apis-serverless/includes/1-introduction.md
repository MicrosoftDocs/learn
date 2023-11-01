Suppose you're responsible for an application on your company's vacation planning website that helps customers add, edit, view, and remove plans on their vacation wish lists. Your API, which is hosted on a server running Node.js and Express, is critical to the success of the application. It's challenging to manage the server and scale the application up and down as needed while minimizing costs.

To reduce the burden of maintaining servers, you can migrate your application to a serverless model that scales up and down as needed, reduces costs, and requires less code. You can use Azure Functions to shift your API to a serverless model without having to rewrite your application.

## Learning objectives

In this module, you refactor Express APIs to a serverless architecture by following these steps:

1. Explore a sample project that uses Node.js Express APIs.
1. Create an Azure Functions application and APIs.
1. Refactor the Express routes and data calls to use the Functions application.
1. Debug the serverless app and API in Visual Studio Code.

## Prerequisites

- Some knowledge of JavaScript and TypeScript
- Some familiarity with Node.js Express and Azure Functions
- [Visual Studio Code](https://code.visualstudio.com/) with the [Azure Functions](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions) extension installed
- [Azure Functions Core Tools](https://github.com/Azure/azure-functions-core-tools) installed
- [Node.js v14](https://nodejs.org/) installed

  >[!IMPORTANT]
  >You must install and use Node.js v14 to compile and run the app for this module. Later Node.js versions have compatibility issues.
