To plan the shift to serverless, you can break down the Node.js Express app into three main areas:

- The Express server, which is mostly in _server.ts_
- The routes, which are in the _routes/_ folder
- The data access logic, which is in _services/vacation.service.ts_

To refactor your code from Node.js Express to Azure Functions, you follow these steps:

1. Create the Azure Functions application.
1. Copy the Node.js Express services from the _server/services_ folder to the _functions_ folder.
1. Import the `Context` object from `@azure/functions`.
1. Use destructuring to access `Context.req` and `Context.res`.
1. Create a function for each route endpoint.
1. Name and set the method for each route endpoint in each function's _function.json_ file.
1. Add code to each function to call the appropriate service.

In the next exercise, you create the Functions app and shift the code from the Express server to Functions.
