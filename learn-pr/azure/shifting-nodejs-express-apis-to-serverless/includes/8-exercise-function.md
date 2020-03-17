You may recall that we have eight endpoints in the Express app. Follow these steps to create a function for the first of these endpoints. We'll come back and create the other seven endpoints soon.

1. Open the command palette by pressing **F1**
1. Type and select **Azure Functions: Create Function**
1. Choose **HTTP Trigger** for the type of function
1. Enter **vacations-get** as the name of the function
1. Select **Anonymous** for the authentication level

Notice that there is now a folder _functions/vacations-get_ that contains a few files. The _function.json_ contains the configuration for the function. Open _function.json_ and notice that the methods allow both GET and POST. Change this to only allow GET.

By default the route to execute the function will be **vacations-get**. The route in the Express app is simply **vacations**. We want these routes to be the same, so add a `route: "vacations"` entry in the **bindings** section in the _function.json_. Now the function will be executed when an HTTP GET on **/vacations** is called.

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

The other important file here in the _functions/vacations-get_ folder is _index.ts_. This file contains the logic that runs when the route is invoked. We already have all this logic from our Express app. We'll go get that next.
