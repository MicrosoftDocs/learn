To change the route of a function, we can add the *route* attribute to the configuration. It supports placeholders that enable us to make a portion of the URL dynamic.

In the context of Azure functions, these placeholders are called *binding expressions*, and can be identified by curly braces.

## Objective

Change the route of a function to support a dynamic binding expression.

## Instructions

To change the route of a function to support a dynamic binding expression:

1. In Visual Studio Code, locate the folder `GetProduct` in the functions project and expand it.

1. Open the file named `function.json`.

1. Change it to include a route definition of `product/{productId}`.

    The file's content should look like this:

    ```json
    {
      "bindings": [
        {
          "authLevel": "anonymous",
          "type": "httpTrigger",
          "direction": "in",
          "name": "req",
          "methods": [
            "get, post"
          ],
          "route": "product/{productId}"
        },
        {
          "type": "http",
          "direction": "out",
          "name": "res"
        }
      ],
      "scriptFile": "../dist/GetProduct/index.js"
    }
    ```

1. Build and run the project and navigate to the URL shown in the output panel.

    Before the change, our function was hosted at `/api/GetProduct`. Now, the new URL will be similar to `localhost:7071/api/product/{productId}`.

1. Make sure to replace `{productId}` with an arbitrary character sequence.
