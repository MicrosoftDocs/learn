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

By convention, the route endpoint has the same name as the folder that contains the function. Since the function is created in the _vacations-get_ folder, the route endpoint is generated as **vacations-get**. By adding the `route` property, the route now matches the expected **vacations** route in the Node.js Express app.

Now the function is executed when an HTTP `GET` on **/vacations** is requested.

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

The other important file here in the _functions/vacations-get_ folder is _index.ts_. This file contains the logic that runs when the route endpoint is requested. The Node.js Express app already includes the logic that you'll move into this file.

In the next unit, we'll shift our endpoint's logic from the Node.js Express application to our Azure Functions application.
