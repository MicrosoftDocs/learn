The Express application runs the APIs on a server. In this exercise, you create a serverless Azure Functions application that runs the APIs instead. You then migrate the application logic from the Node.js Express application to the Functions application. You don't have to rewrite the code. You need only a few small code changes to make the transition.

## Create a new Azure Functions app

Make sure you have the [Visual Studio Code Extension for Azure Functions](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions) installed.

1. In Visual Studio Code, open the command palette by pressing **F1**
1. Type and select **Azure Functions: Create New Project**.

   :::image type="content" source="../media/5-create-function-app.png" alt-text="Screenshot of Visual Studio Code creating a new function app.":::

1. Choose **Browse** to find your project folder, and create a new folder in the project called _functions_.
1. Select **TypeScript**.
1. When prompted to create a function, select **Skip for Now**.

The Functions app is now created to serve the application's API endpoints. In the next unit, you create the functions that list, add, update, and delete vacations.

> [!NOTE]
> You created the Functions app in a _functions_ folder, which separates it from the Angular app in the same project. You can decide how to structure your applications, but for learning purposes it helps to see both apps in one place.

## Copy and refactor the code

All the Node.js Express logic that returns data is in the _server/services_ folder. You can copy this code from the Node.js Express application to the Functions application, and then do some minor refactoring to make the code work with Functions instead of Node.js Express.

The following table lists the main differences between the Node.js Express application and the Functions application:

| Component                                | Node.js Express | Functions                 |
| ---------------------------------------- | --------------- | ------------------------------- |
| Imported npm package to serve the application | `express`       | `@azure/functions`              |
| Request and response objects         | `req` and `res` | `context.req` and `context.res` |

First you refactor the code to import the appropriate npm package. Then you refactor to handle the differences between how Express and Functions pass the request and response objects.

### Copy the code

In Visual Studio Code, copy the _server/services_ folder from the Express application and paste it into the _functions_ folder.

### Change the npm package

Open the _functions/services/vacation.service.ts_ file, and replace the first line, `import { Request, Response } from 'express';`, with the following line:

```typescript
import { Context } from '@azure/functions';
```

This change makes the Functions app responsible for managing request and response messages.

>[!NOTE]
> The Functions `Context` object also contains other APIs, such as `log`. For example, you can use `context.log('hello')` in place of the common `console.log` you use in Node.js applications.

### Change the request and response objects

In the Node.js Express application, the request and response parameters for the `getVacations`, `postVacation`, `putVacation`, and `deleteVacation` functions use `req` and `res`. The Functions application contains the request and response objects in a `Context` object, and uses destructuring to access the objects.

In _functions/services/vacation.service.ts_, find and replace all four instances of the code `(req: Request, res: Response)` with the following code:

```typescript
({ req, res }: Context)
```

When you're done refactoring, your changed code lines should look like the following example:

```typescript
import { Context } from '@azure/functions';
import * as data from './data';

async function getVacations({ req, res }: Context) {
  // ...
}

async function postVacation({ req, res }: Context) {
  // ...
}

async function putVacation({ req, res }: Context) {
  // ...
}

async function deleteVacation({ req, res }: Context) {
  // ...
}

export default { getVacations, postVacation, putVacation, deleteVacation };
```

Save the file. You've now refactored the code to handle HTTP requests. Continue to the next unit to create the functions and refactor the endpoints and routes.

