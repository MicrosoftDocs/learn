In this exercise, you create a serverless Azure Functions application that runs the APIs instead of the Express application. You then migrate the application logic from the Node.js Express application to the Functions application. You don't have to rewrite the code. You need only a few small code changes to make the transition.

## Create a new Azure Functions app

Make sure you have the [Visual Studio Code Extension for Azure Functions](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions) installed.

1. In Visual Studio Code, open the command palette by pressing **F1**
1. Type and select **Azure Functions: Create New Project**.

   :::image type="content" source="../media/5-create-function-app.png" alt-text="Screenshot of Visual Studio Code creating a new function app.":::

1. Select the root of the repository as the location for the new project.
1. When prompted, enter the following values. 

   | Name          | Value        |
   | ------------- | ------------ |
   | Language      | TypeScript   |
   | Select a TypeScript Programming Model | Model V4 |
   | Template      | HTTP trigger |
   | Name          | getVacations  |

The Functions app is now created to serve the application's API endpoints. In the next unit, you create the functions that list, add, update, and delete vacations.

> [!NOTE]
> You created the Functions app in a _functions_ folder, which separates it from the Angular app. You can decide how to structure your applications, but for learning purposes it helps to see both apps in one place.

## Copy and refactor the route handler code

All the Node.js Express logic that returns data is in the _server/services_ folder. You can copy this code from the Node.js Express application to the Functions application, and then do some minor refactoring to make the code work with Functions instead of Node.js Express.

The following table lists the main differences between the Node.js Express application and the Functions application:

| Component                                | Node.js Express | Functions                 |
| ---------------------------------------- | --------------- | ------------------------------- |
| Imported npm package to serve the application | `express`       | `@azure/functions`              |
| Request and response objects         | `req` and `res` | `request` and `context` |

First you refactor the code to import the appropriate npm package. Then you refactor to handle the differences between how Express and Functions pass the request and response objects.

### Copy over existing code from Express project

In Visual Studio Code, copy the following subfolders from the _server_ folder in the Express application and paste it into the _functions/_ folder:

* data
* models
* services

You don't need to copy the _routes_ folder because you're going to create new functions for each route in the Azure Functions app.

Continue to the next unit to create the functions and refactor the endpoints and routes.

