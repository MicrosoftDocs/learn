By default, any HTTP trigger function responds to GET and POST requests. Depending on the use case, we want it to react to a single specific HTTP verb only.

## Objective

Change the HTTP action verb a function reacts to.

## Instructions

To change the HTTP action verb a function reacts to:

1. In Visual Studio Code, locate the folder `GetProduct` in the functions project, and expand it.

1. Open the file named `function.json`.

1. Remove the verb `post` from the `methods` array.

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
            "get"
          ],
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

1. Build and run the project, and go to the URL shown in the output panel. You'll be able to access it with your browser. You can use cURL or PostMan to try and access the same URL using a `post` action, but it will fail.
