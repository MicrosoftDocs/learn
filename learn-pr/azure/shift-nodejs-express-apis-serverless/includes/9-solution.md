Congratulations! You completed your Azure Functions application by shifting your Node.js Express code and making minimal changes. Next, review the structure of your application.

## What You Learned About Shifting from Express to Azure Functions

Now, reflect on what steps you followed to refactor your code from Node.js Express to Azure Functions.

1. You created the Azure Functions application
1. You created a function for every route endpoint
1. You set the method appropriately for each route endpoint in each function's _function.json_ file
1. You named each route endpoint in each function's _function.json_ file
1. You copied Node.js Express services from the _server/services_ folder to the _functions_ folder
1. You refactored the services in the functions to import `Context` from `@azure/functions`
1. You refactored the services in the functions to use destructuring to access the `Context.req` and `Context.res`
1. You added code to each function to call the appropriate service

## Azure Functions and Folders

The Azure Functions application has folders that map to each of their appropriate endpoints, as shown below.

| Methods | Route endpoints | Folders          |
| ------- | --------------- | ---------------- |
| GET     | `vacations`     | vacations-get    |
| POST    | `vacations`     | vacations-post   |
| PUT     | `vacations:id`  | vacations-put    |
| DELETE  | `vacations/:id` | vacations-delete |

## File Structure

The structure of the Azure Functions application contained in the _functions_ folder should look like the following file structure.

```files
functions
 | - vacations-delete
 | | - function.json
 | | - index.ts
 | - vacations-get
 | | - function.json      👈 The vacation route's configuration
 | | - index.ts           👈 The vacation routes
 | - vacations-post
 | | - function.json
 | | - index.ts
 | - vacations-put
 | | - function.json
 | | - index.ts
 | - services              👈 The same folder that the Express app has
 | | - data.ts             👈 The vacation data (could be database API calls)
 | | - index.ts
 | | - vacation.service.ts 👈 The logic to get the vacation data
 | - .funcignore
 | - .gitignore
 | - host.json
 | - local.settings.json
 | - package.json
 | - proxies.json
 | - tsconfig.json
```

Next, you'll run and debug your Angular application and Azure Functions application together.
