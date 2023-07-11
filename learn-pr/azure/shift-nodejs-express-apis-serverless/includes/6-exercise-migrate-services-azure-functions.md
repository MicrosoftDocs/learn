In this unit, you create and configure Azure Functions functions for the `GET`, `POST`, `PUT`, and `DELETE` endpoints in the Node.js Express app.

## Create the GET function

To create the new `GET` function:

1. In Visual Studio Code, open the command palette by pressing **F1**.
1. Type and select **Azure Functions: Create Function**.

   :::image type="content" source="../media/5-create-function.png" alt-text="Screenshot of Visual Studio Code creating a new function.":::

1. Choose **HTTP Trigger** as the type of function.
1. Enter *vacations-get* as the name of the function.
1. Select **Anonymous** as the authentication level.

The new function has a folder called _functions/vacations-get_ with a _function.json_ file that contains the configuration for the function.

### Set the HTTP method and route endpoint name

By default, the route endpoint has the same name as the folder that contains the function. Since the function is created in the _vacations-get_ folder, the route endpoint is generated as `vacations-get`. Adding the `route` property makes the route match the `vacations` route from the Node.js Express app. The function executes when an HTTP `GET` is requested on `/vacations`.

1. Open the file _functions/vacations-get/function.json_, and notice that the methods list both `GET` and `POST`. Remove the `post` listing to allow only `get` requests.
1. In the `bindings` section's `req` properties, add a `"route": "vacations"` entry.

Your _function.json_ should look like the following code.

```json
{
  "disabled": false,
  "bindings": [
    {
      "authLevel": "anonymous",
      "type": "httpTrigger",
      "direction": "in",
      "name": "req",
      "methods": ["get"],
      "route": "vacations"
    },
    {
      "type": "http",
      "direction": "out",
      "name": "res"
    }
  ],
  "scriptFile": "../dist/vacations-get/index.js"
}
```

### Refactor the route

The other important file in the _functions/vacations-get_ folder is _index.ts_. This file contains the logic that runs when the route endpoint is requested.

When the Angular application makes an HTTP `GET` request to `vacations`, your route endpoint must get the vacations data. You refactor the route logic in your function to get vacations from the `getVacations` function in your service. The Node.js Express app already includes the logic that you move into this file.

Open the _functions/vacations-get/index.ts_ file, and replace the contents with the following code:

```typescript
import { AzureFunction, Context, HttpRequest } from '@azure/functions';
import { vacationService } from '../services';

const httpTrigger: AzureFunction = async function (context: Context, req: HttpRequest): Promise<void> {
  await vacationService.getVacations(context); // 👈 This calls the vacation service
};

export default httpTrigger;
```

The code you eliminated was the default code that the Azure Functions extension generates. The code doesn't call the vacation service, so you can safely remove it. The code that you added calls the asynchronous function `vacationService.getVacations` and passes in the `context`, which contains the request and response objects.

## Create the remaining functions

There are four endpoints in the Node.js Express application, and you just created the `GET` endpoint. Use the following steps to create functions for the remaining route endpoints.

| Methods | Route endpoints    |
| ------- | ------------------ |
| `POST`    | `vacations-post`   |
| `PUT`     | `vacations-put`    |
| `DELETE`  | `vacations-delete` |

For each remaining endpoint, follow the same steps you used for the `GET` endpoint to create and configure the function.

### Create the HTTP POST function

Create the `POST` function that handles adding a vacation.

1. Create a new function named *vacations-post*, and select **Anonymous** as the authentication level.
1. In the new _vacations-post_ folder, open _function.json_ and set the method to `post` only.
1. In the `bindings` section's `req` properties, add a `"route": "vacations"` entry.
1. Replace the contents of the _functions/vacations-post/index.ts_ file to call the `vacationService.postVacations` function with the following code:

   ```typescript
   import { AzureFunction, Context, HttpRequest } from '@azure/functions';
   import { vacationService } from '../services';
   
   const httpTrigger: AzureFunction = async function (context: Context, req: HttpRequest): Promise<void> {
     await vacationService.postVacation(context);
   };
   
   export default httpTrigger;
   ```

### Create the HTTP PUT function

Create the `PUT` function to handle updating a vacation.

1. Create a new function named *vacations-put*, and select **Anonymous** as the authentication level.
1. In the new _vacations-put_ folder, open _function.json_ and set the method to `put`.
1. In the `bindings` section's `req` properties, add a `"route": "vacations/{id}"` entry.
1. Replace the contents of the _functions/vacations-put/index.ts_ file to call the `vacationService.putVacations` function with the following code:

   ```typescript
   import { AzureFunction, Context, HttpRequest } from '@azure/functions';
   import { vacationService } from '../services';
   
   const httpTrigger: AzureFunction = async function (context: Context, req: HttpRequest): Promise<void> {
     await vacationService.putVacation(context);
   };
   
   export default httpTrigger;
   ```

### Create the HTTP DELETE function

Create the `DELETE` function to handle deleting a vacation.

1. Create a new function named *vacations-delete*, and select **Anonymous** as the authentication level.
1. In the new _vacations-delete_ folder, open _function.json_ and set the method to `put` only.
1. In the `bindings` section's `req` properties, add a `"route": "vacations/{id}"` entry.
1. Replace the contents of the _functions/vacations-put/index.ts_ file to call the `vacationService.deleteVacations` function with the following code:

   ```typescript
   import { AzureFunction, Context, HttpRequest } from '@azure/functions';
   import { vacationService } from '../services';
   
   const httpTrigger: AzureFunction = async function (context: Context, req: HttpRequest): Promise<void> {
     await vacationService.deleteVacation(context);
   };
   
   export default httpTrigger;
   ```

In the next unit, you review the Azure Functions application you created.
