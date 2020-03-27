Congratulations! You completed your Azure Functions application by shifting your Node.js Express code and making minimal changes. Next, let's review the structure of your application.

## Azure Functions and Folders

The Azure Functions application has folders that map to each of their appropriate endpoints, as shown below.

| methods | route endpoints | folders          |
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
