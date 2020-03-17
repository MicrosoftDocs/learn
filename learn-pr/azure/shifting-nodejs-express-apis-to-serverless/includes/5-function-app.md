Now that you've run the app and explored the Node.js Express API application, you can plan the shift to serverless. Start by breaking down the Node.js Express app can be broken down into its three main areas:

1. The Express server, which is mostly in _server.ts_
1. The routes, which are in _routes/_
1. The data access logic, which is in _services/_.service.ts

You'll take each one of the steps, one at a time as you make the shift. Start with shifting from the Express server to Azure Functions.
