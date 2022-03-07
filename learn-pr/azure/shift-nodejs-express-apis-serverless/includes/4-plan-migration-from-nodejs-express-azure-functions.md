Now it's time for you to plan the shift to serverless. The Node.js Express app can be broken down into its three main areas:

- The Express server, which is mostly in _server.ts_
- The routes, which are in _routes/_
- The data access logic, which is in _services/vacation.service.ts_

Here are the steps you'll follow to refactor your code from Node.js Express to Azure Functions.

1. Create the Azure Functions application
1. Create a function for every route endpoint
1. Set the method for each route endpoint in each function's _function.json_ file
1. Name each route endpoint in each function's _function.json_ file
1. Copy Node.js Express services from the _server/services_ folder to the _functions_ folder
1. Import the `Context` object from `@azure/functions`
1. Use destructuring to access the `Context.req` and `Context.res`
1. Add code to each function to call the appropriate service

Over the next few exercises, you'll take each one of these areas, one at a time, as you make the shift. Start with shifting from the Express server to Azure Functions.
