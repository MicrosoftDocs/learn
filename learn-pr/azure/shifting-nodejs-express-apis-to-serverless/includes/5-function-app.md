Now it's time for you to plan the shift to serverless. The Node.js Express app can be broken down into its three main areas:

1. The Express server, which is mostly in _server.ts_
1. The routes, which are in _routes/_
1. The data access logic, which is in _services/vacation.service.ts_

Let's think through the steps you'll follow to refactor your code from Node.js Express to Azure Functions.

1. You'll create the Azure Functions application
1. You'll create a function for every route endpoint
1. You'll set the method appropriately for each route endpoint in each function's _function.json_ file
1. You'll name each route endpoint in each function's _function.json_ file
1. You'll copy Node.js Express services from the _server/services_ folder to the _functions_ folder
1. You'll refactor the services in the functions to import `Context` from `@azure/functions`
1. You'll refactor the services in the functions to use destructuring to access the `Context.req` and `Context.res`
1. You'll add code to each function to call the appropriate service

Over the next few exercises, you'll take each one of these areas, one at a time, as you make the shift. Start with shifting from the Express server to Azure Functions.
