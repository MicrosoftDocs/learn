Tailwind Traders planned on building a traditional API, but you deftly pointed out that serverless is perfect for APIs that experience unexpected traffic spikes. It can also be done without disturbing their existing codebase. You're already doing so well. You have a long career in online hardware sales in your future.

It's time to deliver on those lofty buzzwords. Now, you need to create a new project in Azure Functions to be the HTTP API for the *Products Manager* app. That means creating the Azure Functions project, complete with all the endpoints that the Products Manager app is going to need to be able to create, read, update, and delete products.

## Create a project with existing code

This exercise provides you with a partially completed code base. When you create the new Azure Functions app, you need to leave the existing **`package.json`** file in place. The **`package.json`** file is the file that contains the project's dependencies. If you overwrite it, you lose the existing dependencies.

This workflow was selected to give you a head start on the project. You can focus on the serverless code and the database integration code, rather than setting up the project from scratch.

## Create a new Azure Functions project

1. In Visual Studio Code, open the Command Palette.

1. Enter *create new project*.

1. Select **Azure Functions: Create New Project**.

1. Select the **api** folder.

1. When prompted, enter the following values. **Do not** overwrite the *package.json* file when prompted.

   | Name          | Value        |
   | ------------- | ------------ |
   | Language      | TypeScript   |
   | Select a TypeScript Programming Model | Model V4 |
   | Template      | HTTP trigger |
   | Name          | GetProducts  |
   | Overwrite `package.json` | No |

1. When asked to overwrite the `.gitignore` or `package.json` file, make sure you select **No**.

    The _functions_ folder in _api/src_ now contains a new Azure Functions app with a function at _api/src/functions/GetProducts.ts_. Several other required project files are also added, including `host.json` and `local.settings.json`.

1. In the `src/index.ts`, add this import statement.

    ```typescript
    import { GetProducts } from "./functions/GetProducts";
    ```
    
1. In the `src/index.ts`, add the handler for the route definition.

    ```typescript
    app.http('GetProducts', {
        methods: ['GET', 'POST'],
        authLevel: 'anonymous',
        handler: GetProducts
    });
    ```

## Examine the Create, Update, and Delete functions

The Create, Update, and Delete functions were already created for you. They were created with the same process that you used to create the *GetProducts* function and, they already contain database access code.

- Notice that the *api* project already contains *CreateProduct*, *DeleteProduct* and *UpdateProduct* functions.

## Run the Azure Functions project

You can run and debug Azure Functions projects locally from within Visual Studio Code.

1. Open the Command Palette.

1. Enter *debug select*.

1. Select **Debug: Select and Start Debugging**.
  
1. Select **Attach to Node Functions**.

   The Azure Functions project launches. The terminal shows you the function app URL.

   :::image type="content" source="../media/functions-in-terminal.png" alt-text="Screenshot of the Visual Studio Code integrated terminal showing functions URLs." loc-scope="other"::: <!-- no-loc -->

Visual Studio Code generates the following error, "Cannot read property 'endpoint' of undefined". That's OK! That's because you haven't set up the database connection string yet. Notice that the four endpoints are listed above that error, and that if you select any of them, you get the same error.
