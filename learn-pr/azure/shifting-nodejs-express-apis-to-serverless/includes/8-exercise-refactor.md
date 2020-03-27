All of the logic that executes to interact with the data store is contained in the _server/services_ folder of the Express app. We can lift that code and shift it over to the Azure Functions app and make a few small adjustments. This may seem like it wouldn't work, but let's consider what is different about the Express app and the Azure Functions app. Here are some main differences in the services.

1. The Express app uses the npm package `express` while the Azure Functions app uses the npm package `@azure/functions`
2. Express has `req` and `res` parameters representing Request and Response. Azure Functions puts these inside of a `context` object variable.

That is all we have to know. So armed with this information, it makes sense that we can copy the code for the services from the Express app to the Azure Functions app with minimal changes. Let's do this now.

#### Shift the Code from Express to Functions

Why write everything from scratch and throw away your hard work if you do not have to, right? Well, we can take the services code from our Express app and copy it to our Azure Functions app.

1. Copy the _server/services_ folder
1. Paste into the _functions_ folder

Now we have some minor refactoring to make the code work with Azure Functions instead of Express. The one thing that changes here is that the routing API and how request and response are passed. Let's refactor for this API difference.

1. Open the _functions/services/vacation.service.ts_ file
1. Replace `import { Request, Response } from 'express';` with `import { Context } from '@azure/functions';`
1. Replace every instance of `(req: Request, res: Response)` with `({ req, res }: Context)`.

Your code will look like the following when you are done refactoring. Notice the places that changed are commented.

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

The parameters to every function in the Express app contain `req` and `res`. The Azure Functions app can still get to the request and response objects, but they are contained within a `context` object. We use destructuring to access them.

> The `Context` object also contains other APIs, such as `log` (ex: `context.log('hello')`). This could be used in place of the common `console.log` you use in Node apps.

#### Refactor the Route

Now point your route to the service in your _functions/vacations-get/index.ts_ file. Open that file and replace it with the following code.

```typescript
import { AzureFunction, Context, HttpRequest } from '@azure/functions';
import { vacationService } from '../services';

const httpTrigger: AzureFunction = async function(context: Context, req: HttpRequest): Promise<void> {
  await vacationService.getVacations(context); // 👈 This calls the vacation service
};

export default httpTrigger;
```

The code that you add calls the asynchronous function `vacationService.getVacations` and passes in the `context` which contain the request and response objects.

### Create the Remaining Functions

Remember, there are eight total endpoints in the Express app and we just created the first one. Now, follow these steps to create an Azure Function for the rest of the endpoints.

1. Open the command palette by pressing **F1**
1. Type and select **Azure Functions: Create Function**
1. Choose **HTTP Trigger** for the type of function
1. Enter the name of the function for vacations. I recommend three additional functions name **vacations-post**, **vacations-put**, **vacations-delete**
1. Select **Anonymous** for the authentication level
1. Open _function.json_ and set the method to the appropriate value of get, post, put or delete.
1. In the bindings section, for the `GET` and `POST`, add a `route: "vacations"` entry.
1. In the bindings section, for the `DELETE` and `PUT`, add a`route: "vacations/{id}"` entry.
1. Add the code in each function's _index.ts_ file to call the appropriate vacation service function.
