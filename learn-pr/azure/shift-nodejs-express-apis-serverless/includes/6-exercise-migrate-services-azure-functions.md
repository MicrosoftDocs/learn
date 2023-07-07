In this exercise, you migrate the logic that gets data to the Azure Functions application from the Node.js Express application. All the Node.js Express logic that returns data is in the _server/services_ folder, and you move code from this folder to the Azure Functions application.

You don't have to rewrite the code. You need only a few small code changes to make the transition.

The following table lists the main differences between the Node.js Express application and the Azure Functions application:

| Component                                | Node.js Express | Azure Functions                 |
| ---------------------------------------- | --------------- | ------------------------------- |
| npm package to serve the application | `express`       | `@azure/functions`              |
| Request and Response objects         | `req` and `res` | `context.req` and `context.res` |

## Copy the code

You can copy the services code from the Node.js Express application to the Azure Functions application, and then make minimal changes.

1. Open Visual Studio Code.
1. Copy the _server/services_ folder.
1. Paste into the _functions_ folder.

Now you have some minor refactoring to make the code work with Azure Functions instead of Node.js Express. First, you refactor the code to handle importing the appropriate npm package. Then, you refactor to handle the differences between how the request and response are passed.

## Refactor the Request and Response code

There are four functions where request and response are parameters, one each for `getVacations`, `postVacation`, `putVacation`, and `deleteVacation`.

The parameters to every function in the Node.js Express application contain `req` and `res`. The Azure Functions application can access the request and response objects, but they're contained within a `context` object. You use destructuring to access the objects.

### Change the npm package

1. Open the _functions/services/vacation.service.ts_ file.
1. Remove the following code:

   ```typescript
   import { Request, Response } from 'express';
   ```

1. Add the following code in its place:

   ```typescript
   import { Context } from '@azure/functions';
   ```

Now the Functions app is responsible for managing request and response messages.

### Change the Request and Response objects

1. In _functions/services/vacation.service.ts_, find every instance of the following code:

   ```typescript
   (req: Request, res: Response)
   ```

1. Replace every instance with the following code:

   ```typescript
   ({ req, res }: Context)
   ```

When you're done refactoring, your code looks like the following example. The places that changed are commented.

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

>[!NOTE]
> The `Context` object also contains other APIs, such as `log`. For example, you could use `context.log('hello')` in place of the common `console.log` you use in Node.js applications.

You refactored the code to handle HTTP requests. Next you refactor the route.

## Refactor the route

When the Angular application makes an HTTP `GET` request to `vacations`, your route endpoint must get the vacations data. Refactor the route logic in your function to get vacations from the `getVacations` function in your service.

1. Open the _functions/vacations-get/index.ts_ file.
1. Replace the contents with the following code.

   ```typescript
   import { AzureFunction, Context, HttpRequest } from '@azure/functions';
   import { vacationService } from '../services';

   const httpTrigger: AzureFunction = async function (context: Context, req: HttpRequest): Promise<void> {
     await vacationService.getVacations(context); // 👈 This calls the vacation service
   };

   export default httpTrigger;
   ```

The code you eliminated was the default code the Azure Functions extension generates. The code wasn't calling the vacation service, so it can be safely removed.

The code that you added calls the asynchronous function `vacationService.getVacations` and passes in the `context`, which contains the request and response objects.

## Create the remaining functions

There are four endpoints in the Node.js Express application, and you just created the `GET` endpoint. Follow these steps to create functions for the remaining route endpoints:

| Methods | Route endpoints    |
| ------- | ------------------ |
| `POST`    | `vacations-post`   |
| `PUT`     | `vacations-put`    |
| `DELETE`  | `vacations-delete` |

### Create the HTTP POST function

Follow these steps to create a function that handles adding a vacation.

1. Open the command palette by pressing **F1**.
1. Type and select **Azure Functions: Create Function**.
1. Choose **HTTP Trigger** for the type of function.
1. Enter the name *vacations-post* for the function.
1. Select **Anonymous** for the authentication level.
1. Open the file _function.json_.
1. Set the method to **post**.
1. Go to the bindings section's **req** object and add a `route: "vacations"` entry.
1. Open the _functions/vacations-post/index.ts_ file.
1. Add the code to call the `vacationService.postVacations` function.

   Your code should look like the following example when you finish refactoring this function.

   ```typescript
   import { AzureFunction, Context, HttpRequest } from '@azure/functions';
   import { vacationService } from '../services';
   
   const httpTrigger: AzureFunction = async function (context: Context, req: HttpRequest): Promise<void> {
     await vacationService.postVacation(context);
   };
   
   export default httpTrigger;
   ```

### Create the HTTP PUT function

Follow these steps to create a function that handles updating a vacation.

1. Open the command palette by pressing **F1**.
1. Type and select **Azure Functions: Create Function**.
1. Choose **HTTP Trigger** for the type of function.
1. Enter the name *vacations-put* for the function.
1. Select **Anonymous** for the authentication level.
1. Open the file _function.json_.
1. Set the method to **put**.
1. Go to the bindings section's **req** object and add `route: "vaca.tions/{id}"` entry.
1. Open the _functions/vacations-put/index.ts_ file
1. Add the code to call the `vacationService.putVacations` function.

   Your code should look like the following example when you finish refactoring this function.

   ```typescript
   import { AzureFunction, Context, HttpRequest } from '@azure/functions';
   import { vacationService } from '../services';
   
   const httpTrigger: AzureFunction = async function (context: Context, req: HttpRequest): Promise<void> {
     await vacationService.putVacation(context);
   };
   
   export default httpTrigger;
   ```

### Create the HTTP DELETE function

Follow these steps to create a function that handles deleting a vacation.

1. Open the command palette by pressing **F1**.
1. Type and select **Azure Functions: Create Function**.
1. Choose **HTTP Trigger** for the type of function.
1. Enter the name *vacations-delete* for the function.
1. Select **Anonymous** for the authentication level.
1. Open the file _function.json_.
1. Set the method to **delete**.
1. Go to the bindings section's **req** object and add `route: "vacations/{id}"` entry.
1. Open the _functions/vacations-delete/index.ts_ file.
1. Add the code to call the `vacationService.deleteVacations` function.

   Your code should look like the following example when you finish refactoring this function.

   ```typescript
   import { AzureFunction, Context, HttpRequest } from '@azure/functions';
   import { vacationService } from '../services';
   
   const httpTrigger: AzureFunction = async function (context: Context, req: HttpRequest): Promise<void> {
     await vacationService.deleteVacation(context);
   };
   
   export default httpTrigger;
   ```

In the next unit, you review the Azure Functions application you created.
