1. Open the `api/GetProducts/function.json` file.

1. Directly below the "methods" property and value, add a line that sets the route to "products".

   ```json
   {
     "bindings": [
       {
         "authLevel": "function",
         "type": "httpTrigger",
         "direction": "in",
         "name": "req",
         "methods": ["get"],
         "route": "products"
       },
       {
         "type": "http",
         "direction": "out",
         "name": "res"
       }
     ],
     "scriptFile": "../dist/GetProducts/index.js"
   }
   ```

1. Save the file.

   Saving the file will cause the Azure Functions process to terminate the debugger will disconnect.

1. Start the Azure Functions project by pressing <kbd>F5</kbd>.

1. Notice that the "GetProducts" function is now exposed to an HTTP GET request method at the "api/products" route.

![VS Code integrated terminal showing GetProducts function running at the new route](../media/new-product-url.png)

## Test the endpoint

1. Open the `api/tests.http` file.

1. Add the following line to the file.

   ```http
   GET http://127.0.0.1:/api/products
   ```

1. Click "Send Request".

1. Note that the function now responds at the new route which you specified in the `function.json` file.

The "GetProducts" method is now a RESTful endpoint. In the next section, you'll learn how to modify data in Cosmos DB. This will enable you to create the final endpoints needed to complete the API.
