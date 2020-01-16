1. Open the Command Palette in VS Code by pressing <kbd>F1</kbd>.

1. Type "create function".

1. Select "Azure Functions: Create Function".

1. Select "api".

1. When prompted, enter the following values

   | Name          | Value         |
   | ------------- | ------------- |
   | Template      | HTTP trigger  |
   | Name          | DeleteProduct |
   | Authorization | Function      |

   VS Code will create a new folder in the "api" project called "DeleteProduct". The `index.ts` file in this folder will be opened in the editor.

1. Replace all of the code in the `api/DeleteProduct/index.ts` file with the following...

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

       const id = req.body.id;

       const result = await container.item(id, undefined).delete();

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

1. Modify the "methods" property so that the function only accepts a "delete".

   ```json
   {
     "bindings": [
       {
         "authLevel": "function",
         "type": "httpTrigger",
         "direction": "in",
         "name": "req",
         "methods": ["delete"]
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

## Modify the route

1. Add a "route" property directly below the "methods" property and specify "product/{id}" as the route.

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

You have now finished the products API. The next step is to deploy it to Azure so you can call it from the frontend website.
