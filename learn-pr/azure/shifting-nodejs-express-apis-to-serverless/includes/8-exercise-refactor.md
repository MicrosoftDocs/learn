All of the Node.js Express logic that gets the data is contained in the _server/services_ folder. We'll lift the code and shift it to the Azure Functions application. And we'll only make a few small changes along the way.

In this exercise, you'll migrate the logic that gets the data from the Node.js Express application to the Azure Functions application.

## Migrating from Node.js Express to Azure Functions

At first glance you might think migrating the code wouldn't work, but let's consider what is different about the Node.js Express application and the Azure Functions application. Here are some main differences in the services.

|                                      | Node.js Express | Azure Functions                 |
| ------------------------------------ | --------------- | ------------------------------- |
| npm package to serve the application | `express`       | `@azure/functions`              |
| Request and Response objects         | `req` and `res` | `context.req` and `context.res` |

Once we're armed with this information, we can copy the services code from the Node.js Express application to the Azure Functions application with minimal changes. Let's copy the code now.

### Shift the Code from Express to Functions

Why write everything from scratch and throw away your hard work if you don't have to, right? We can take the services code from our Express application and copy it to our Azure Functions application.

1. Open Visual Studio Code
1. Copy the _server/services_ folder
1. Paste into the _functions_ folder

### Refactor the Request and Response Code

Now we have some minor refactoring to make the code work with Azure Functions instead of Node.js Express. Let's refactor the code to handle importing the appropriate npm package. Then we'll refactor to handle the differences between how the request and response are passed.

1. Open the _functions/services/vacation.service.ts_ file
1. Remove the following code

   ```typescript
   import { Request, Response } from 'express';
   ```

1. Add the following code in its place

   ```typescript
   import { Context } from '@azure/functions';
   ```

1. Find every instance of the following code

   ```typescript
   (req: Request, res: Response)
   ```

1. Replace every instance with the following code

   ```typescript
   ({ req, res }: Context)
   ```

Your code will look like the following when you're done refactoring. Notice the places that changed are commented.

```typescript
// This was import { Request, Response } from 'express';
// 👇
import { Context } from '@azure/functions';
import * as data from './data';

// This was async function getVacations(req: Request, res: Response) {
// 👇
async function getVacations({ req, res }: Context) {
  // ...
}

// This was async function postVacation(req: Request, res: Response) {
// 👇
async function postVacation({ req, res }: Context) {
  // ...
}

// async function putVacation(req: Request, res: Response) {
// 👇
async function putVacation({ req, res }: Context) {
  // ...
}

// This was async function deleteVacation(req: Request, res: Response) {
// 👇
async function deleteVacation({ req, res }: Context) {
  // ...
}

export default { getVacations, postVacation, putVacation, deleteVacation };
```

There are four functions where request and response are parameters. One each for `getVacations`, `postVacation`, `putVacation`, and `deleteVacation`.

The parameters to every function in the Node.js Express application contain `req` and `res`. The Azure Functions application can access the request and response objects, but they're contained within a `context` object. We use destructuring to access them.

> The `Context` object also contains other APIs, such as `log` (ex: `context.log('hello')`). This could be used in place of the common `console.log` you use in Node.js applications.

You've refactored the code to handle your HTTP requests. Next you'll refactor the route.

### Refactor the Route

When the Angular application makes an HTTP GET request to `vacations`, your route endpoint must go get the vacations data. Let's refactor the route logic now.

Modify the code in your function to point get the vacations from the `getVacations` function in your service.

1. Open the _functions/vacations-get/index.ts_ file
1. Replace the contents with the following code

   ```typescript
   import { AzureFunction, Context, HttpRequest } from '@azure/functions';
   import { vacationService } from '../services';

   const httpTrigger: AzureFunction = async function(context: Context, req: HttpRequest): Promise<void> {
     await vacationService.getVacations(context); // 👈 This calls the vacation service
   };

   export default httpTrigger;
   ```

The code that you add calls the asynchronous function `vacationService.getVacations` and passes in the `context`, which contains the request and response objects.

### Create the Remaining Functions

There are four endpoints in the Node.js Express application and we just created the first one. Now, follow these steps to create an Azure Function for the rest of the route endpoints.

1. Open the command palette by pressing **F1**
1. Type and select **Azure Functions: Create Function**
1. Choose **HTTP Trigger** for the type of function
1. Enter the name of the function for vacations. I recommend three additional functions named

   | methods | route endpoints      |
   | ------- | -------------------- |
   | POST    | **vacations-post**   |
   | PUT     | **vacations-put**    |
   | DELETE  | **vacations-delete** |

1. Select **Anonymous** for the authentication level
1. Open the file _function.json_
1. Set the method to the appropriate value of **post**, **put**, or **delete**
1. Go to the bindings section's **req** object and for the `POST` add a `route: "vacations"` entry
1. Go to the bindings section's **req** object and for the `DELETE` and `PUT` add a `route: "vacations"` entry
1. Add the code in each function's _index.ts_ file to call the appropriate vacation service function

Next, you'll review the Azure Functions application you created.
