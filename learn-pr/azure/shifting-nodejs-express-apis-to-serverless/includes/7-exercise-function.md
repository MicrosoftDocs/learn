You may recall that we have four endpoints in the Node.js Express app. In this exercise, you'll create the function for the first of these endpoints. We'll come back and create the other endpoints in a future exercise.

## Create a New Function

Create a new function in your Azure Functions application.

1. In Visual Studio Code, open the command palette by pressing **F1**
1. Type and select **Azure Functions: Create Function**
1. Choose **HTTP Trigger** as the type of function
1. Enter **vacations-get** as the name of the function
1. Select **Anonymous** as the authentication level

### Set the HTTP Method and Route Endpoint Names

Notice that there's now a folder _functions/vacations-get_ that contains a few files.

The _function.json_ contains the configuration for the function.

1. Open the file _functions/vacations-get/function.json_
1. Notice the methods allow both `GET` and `POST`
1. Change the methods array to only allow `GET` requests
1. Go to the `bindings` section's `req` properties
1. Add a `route: "vacations"` entry

By convention, the route endpoint will have the same name as the folder that contains the function. Because the function is created in the folder _vacations-get_, the route endpoint for the function will be **vacations-get**. The route in the Node.js Express app is **vacations**. We want these route endpoints to be the same.

Now the function will be executed when an HTTP `GET` on **/vacations** is requested.

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

The other important file here in the _functions/vacations-get_ folder is _index.ts_. This file contains the logic that runs when the route endpoint is requested. We already have this logic from our Node.js Express application.

In the next unit, we'll shift our endpoint's logic from the Node.js Express application to our Azure Functions application.
