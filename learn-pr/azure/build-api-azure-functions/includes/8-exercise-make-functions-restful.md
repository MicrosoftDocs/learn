The Products Manager API is about to get serious style upgrade courtesy of you - fake Tailwind Traders developer extraordinaire. In this exercise, you'll turn all of the functions you created earlier into RESTful ones by modifying their configuration files.

1. Open the `api/GetProducts/function.json` file.

1. Modify the "methods" property so that it only contains the value "get".

   ```json
   "methods": ["get"]
   ```

1. Below the "methods" line, add a line that specifies a route of "products" for the *GetProducts* method.

   ```json
   "route": "products"
   ```

   Your `function.json` file for *GetProducts* should now look like this.

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

   > [!NOTE]
   > Saving the file will cause the Azure Functions process to terminate the debugger, and it will disconnect. Don't be alarmed. You didn't break anything. It's just that you've made fundamental changes to how the functions are served up, so you'll have to restart the project when you're done with all this REST spring cleaning.

## Make the CreateProduct function RESTful

1. Open the `api/CreateProduct/function.json` file.

1. Restrict the allowed "methods" to just "post".

   ```json
   "methods": ["post"]
   ```

1. Below the "methods" line, add a line that specifies a new route for the *CreateProduct* method as "product".

   ```json
   "route": "product"
   ```

   Your `function.json` file for *CreateProduct* should now look like this.

   ```json
   {
     "bindings": [
       {
         "authLevel": "function",
         "type": "httpTrigger",
         "direction": "in",
         "name": "req",
         "methods": ["post"],
         "route": "product"
       },
       {
         "type": "http",
         "direction": "out",
         "name": "res"
       }
     ],
     "scriptFile": "../dist/CreateProduct/index.js"
   }
   ```

## Make the UpdateProduct function RESTful

1. Open the `api/UpdateProduct/function.json` file.

1. Restrict the allowed "methods" to just "put".

   ```json
    "methods": ["put"]
   ```

1. Below the "methods" line, add a line that specifies a new route for the *UpdateProduct* method as "product".

   ```json
   "route": "product"
   ```

   Your `function.json` file for *UpdateProduct* should now look like this.

   ```json
   {
     "bindings": [
       {
         "authLevel": "function",
         "type": "httpTrigger",
         "direction": "in",
         "name": "req",
         "methods": ["put"],
         "route": "product"
       },
       {
         "type": "http",
         "direction": "out",
         "name": "res"
       }
     ],
     "scriptFile": "../dist/UpdateProduct/index.js"
   }
   ```

## Make the DeleteProduct function RESTful

1. Open the `api/DeleteProduct/function.json` file.

1. Restrict the allowed "methods" to just "delete".

   ```json
    "methods": ["delete"]
   ```

1. Below the "methods" line, add a line that specifies a new route for the *DeleteProduct* method.

   ```json
   "route": "product/{id}"
   ```

   Your `function.json` file for DeleteProduct should now look like this.

   ```json
   {
     "bindings": [
       {
         "authLevel": "function",
         "type": "httpTrigger",
         "direction": "in",
         "name": "req",
         "methods": ["delete"],
         "route": "product/{id}"
       },
       {
         "type": "http",
         "direction": "out",
         "name": "res"
       }
     ],
     "scriptFile": "../dist/DeleteProduct/index.js"
   }
   ```

## Start the project

1. Start the Azure Functions project by pressing <kbd>F5</kbd>.

1. Notice that the URLs for your function endpoints are now different.

   :::image type="content" source="../media/restful-endpoints.png" alt-text="Screenshot of the Visual Studio Code terminal showing endpoints running on new routes." loc-scope="vs-code":::

Look at that stunning API. It's simply gorgeous. Notice how you specified the same exact same route for the CreateProduct, UpdateProduct, and DeleteProduct functions. Only the HTTP request method is different. You've turned three URLs into one, while still having three endpoints. You're a magician.
