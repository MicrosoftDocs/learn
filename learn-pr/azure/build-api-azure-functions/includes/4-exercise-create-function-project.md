Tailwind Traders had planned on building a traditional API, but you deftly pointed out that serverless is perfect for APIs that experience unexpected traffic spikes. It can also be done without disturbing their existing codebase. You're already doing so well. You have a long career in online hardware sales in your future.

It's time to deliver on those lofty buzzwords. Now, you need to create a new project in Azure Functions that will be the HTTP API for the *Products Manager* app. That means creating the Azure Functions project, complete with all of the endpoints that the Products Manager app is going to need to be able to create, read, update, and delete products.

## Create a new Azure Functions project

1. In Visual Studio Code, open the Command Palette.

1. Enter *create new project*.

1. Select **Azure Functions: Create New Project**.

1. Select the **api** folder.

1. When prompted, enter the following values. Do **not** overwrite the *package.json* file when prompted.

   | Name          | Value        |
   | ------------- | ------------ |
   | Language      | TypeScript   |
   | Select a TypeScript Programming Model | Model V3 |
   | Template      | HTTP trigger |
   | Name          | GetProducts  |
   | Authorization | Function     |

1. When asked to overwrite the `package.json` file, make sure you select **no**.

    The *api* folder in Visual Studio Code will now contain an Azure Functions project along with a new function called *GetProducts*. Several other required project files are also added, including `host.json` and `local.settings.json`.

1. Replace the code in the *GetProducts/index.ts* file with the following code.

   ```typescript
   import { AzureFunction, Context, HttpRequest } from "@azure/functions";
   import productsService from "../services/productsService";

   const httpTrigger: AzureFunction = async function (
     context: Context,
     req: HttpRequest
   ): Promise<void> {
     let response;

     try {
       let products = await productsService.read();
       response = { body: products, status: 200 };
     } catch (err) {
       response = { body: err.message, status: 500 };
     }

     context.res = response;
   };

   export default httpTrigger;
   ```

## Examine the Create, Update, and Delete functions

The Create, Update and Delete functions have been created for you already. They were created with the same process that you used to create the *GetProducts* function and they already contain database access code.

- Notice that the *api* project already contains *CreateProduct*, *DeleteProduct* and *UpdateProduct* functions.

## Run the Azure Functions project

Azure Functions projects can be run and debugged locally from within Visual Studio Code.

1. Open the Command Palette.

1. Enter *debug select*.

1. Select **Debug: Select and Start Debugging**.
  
1. Select **Attach to Node Functions**.

   The Azure Functions project will launch. Note that the terminal shows you what URL the function is running on. 

   :::image type="content" source="../media/functions-in-terminal.png" alt-text="Screenshot of the Visual Studio Code integrated terminal showing functions URLs." loc-scope="other"::: <!-- no-loc -->

Visual Studio Code generates the following error, "Cannot read property 'endpoint' of undefined". That's OK! That's because you haven't set up the database connection string yet. Notice that the four endpoints are listed above that error, and that if you select on a any of them, you'll get the same error.
