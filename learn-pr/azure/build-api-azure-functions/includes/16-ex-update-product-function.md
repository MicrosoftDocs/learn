In this exercise, you'll create the three remainin endpoints for the API - CreateProduct, UpdateProduct and DeleteProduct. You'll use your knowledge of HTTP request methods and custom routes to make them RESTful.

## Create the UpdateProduct function

1. Open the Command Palette in VS Code by pressing <kbd>F1</kbd>.

1. Type "create function".

1. Select "Azure Functions: Create Function".

1. Select "api".

1. When prompted, enter the following values

   | Name          | Value         |
   | ------------- | ------------- |
   | Template      | HTTP trigger  |
   | Name          | UpdateProduct |
   | Authorization | Function      |

   VS Code will create a new folder in the "api" project called "UpdateProduct". The `index.ts` file in this folder will be opened in the editor.

1. Replace all of the code in the `api/UpdateProduct/index.ts` file with the following...

   ```typescript
   import { AzureFunction, Context, HttpRequest } from "@azure/functions";
   import { CosmosClient } from "@azure/cosmos";

   const httpTrigger: AzureFunction = async function(
     context: Context,
     req: HttpRequest
   ): Promise<void> {
     try {
       const client = new CosmosClient(process.env.CONNECTION_STRING);

       const database = client.database("tailwind");
       const container = database.container("products");

       const product = req.body;
       const id = product.id;

       let result = await container.item(id, undefined).replace(product);

       context.res = {
         // status: 200, /* Defaults to 200 */
         body: result.resource
       };
     } catch (err) {
       context.res = {
         status: 500,
         body: err.message
       };
     }
   };

   export default httpTrigger;
   ```

## Modify HTTP request method

1. Open the `api/UpdateFunction/function.json` file.

1. Modify the "methods" property so that the function only accepts a "post".

   ```json
   {
     "bindings": [
       {
         "authLevel": "function",
         "type": "httpTrigger",
         "direction": "in",
         "name": "req",
         "methods": ["post"]
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

## Modify the route

1. Add a "route" property directly below the "methods" property and specify "product" as the route.

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

In the next exercise, you'll create the `DeleteProduct` endpoint.
