Now that we've run the app and explored where we started with Express, let's plan the shift from Express to serverless. I like to solve problems by breaking them down into smaller problems. In this case, et's start by breaking down the Node Express app can be broken down into its three main areas:

1. The Express server ( mostly in _server.ts_)
1. The routes (_routes/_\*)
1. The data access logic (_services/_.service.ts\*)

We'll take these one at a time as we make the shift for all of these. Let's start with shifting from the Express server to Azure Functions.
