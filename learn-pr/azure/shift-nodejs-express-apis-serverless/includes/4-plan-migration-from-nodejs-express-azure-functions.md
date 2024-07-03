To plan the shift off the backend Express app to serverless, you can break down the Express app into three main areas:

- The Express server, which is mostly in _server.ts_
- The routes, which are in the _routes/_ folder
- The data access logic, which is in _services/_ folder

To refactor your code from Express to Azure Functions, you plan these actions, which you will begin implementing in the next unit:

1. Create a new Azure Functions application.
1. Copy the _services_ folder from Node.js Express to the Azure Functions app. This works because the data services are not tied to the Express server.
1. Create a new function API for each route endpoint.
    - Get vacations
    - Add vacations
    - Update a vacation
    - Delete a vacation
1. Update function code to use data access logic in _services/_ folder.
1. Update function routes to match the original Express routes.

## Express route example

This is a simple example of an Express route that gets vacations from the vacation service. Notice the parameters for the route handler are the `req` and `res` objects.

```typescript
import * as express from 'express';
import { vacationService } from '../services';

const router = express.Router();

router.get('/vacations', (req, res) => {    // API route
  vacationService.getVacations(req, res);   // Data access logic
});
```

## Azure Functions route example

This is a simple example of an Azure Functions route handler and route definition that gets vacations from the vacation service. Notice the parameters for the route handler are the `request` and `context` objects.

```typescript
import { app } from '@azure/functions';
import { HttpRequest, HttpResponseInit, InvocationContext } from '@azure/functions';
import * as vacationService from '../services';

export async function getVacations(request, context) {
    return {
        status: 200,
        jsonBody: vacationService.getVacations(); // Data access logic
    };
};

app.http('get-vacations', {  // API route
    methods: ['GET'],
    route: 'vacations',
    authLevel: 'anonymous',
    handler: getVacations
});
```

Once you understand the structure of the Azure Functions app, you can organize your code to match the structure of the original Node.js Express app.

In the next exercise, you create the Functions app and shift the code from the Express server to Functions.
