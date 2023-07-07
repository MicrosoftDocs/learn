The Express server runs the API on a server. In this exercise, you create an Azure Functions application to run the APIs instead.

## Create a new function app
Make sure you have the [Visual Studio Code Extension for Azure Functions](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions) installed.

1. In Visual Studio Code, open the command palette by pressing **F1**
1. Type and select **Azure Functions: Create New Project**.

   :::image type="content" source="../media/5-create-function-app.png" alt-text="Screenshot of Visual Studio Code creating a new function app.":::

1. Choose **Browse** to find the folder to create the functions.
1. Create a new folder in your project called _functions_.
1. Select **TypeScript**.
1. When prompted to create a function, select **Skip for Now**.

The Azure Functions app is created.

> [!NOTE]
> You created the function app in the _functions_ folder, which separates it from the Angular app in the same project. You can decide how to structure your applications, but for this module it helps to see them all in one place.

The Azure Functions app serves the application's API endpoints. Next, you create the function that fetches and returns the list of vacations.

## Create a new function

In this exercise, you create the function for the first endpoint in the Node.js Express app. You create the other endpoints in a future exercise.

To create a new function in your Azure Functions application:

1. In Visual Studio Code, open the command palette by pressing **F1**.
1. Type and select **Azure Functions: Create Function**.

    :::image type="content" source="../media/5-create-function.png" alt-text="Screenshot of Visual Studio Code creating a new function.":::

1. Choose **HTTP Trigger** as the type of function.
1. Enter *vacations-get* as the name of the function.
1. Select **Anonymous** as the authentication level.

## Set the HTTP method and route endpoint names

There's now a folder _functions/vacations-get_ that contains a few files.

The _function.json_ file contains the configuration for the function.

1. Open the file _functions/vacations-get/function.json_.
1. Notice the methods allow both `GET` and `POST`. Change the methods array to allow only `GET` requests.
1. Go to the `bindings` section's `req` properties.
1. Add a `route: "vacations"` entry.

By default, the route endpoint has the same name as the folder that contains the function. Since the function is created in the _vacations-get_ folder, the route endpoint is generated as `vacations-get`. Adding the `route` property makes the route match the expected `vacations` route in the Node.js Express app. The function executes when an HTTP `GET` is requested on `/vacations` is requested.

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

The other important file in the _functions/vacations-get_ folder is _index.ts_. This file contains the logic that runs when the route endpoint is requested. The Node.js Express app already includes the logic that you move into this file in the next exercise.
