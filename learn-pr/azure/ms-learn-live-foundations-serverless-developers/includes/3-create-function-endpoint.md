With our freshly gained knowledge, we can now create a function that returns product data in response to an HTTP request.

## Objective

By the end of this exercise, you will have created a locally-running functions app and a function endpoint called *products* that returns a simple, hard-coded JSON structure.

## Instructions

 To create a function that returns product data in response to an HTTP request:

1. Open Visual Studio Code.

1. Select the Azure extension icon in the sidebar.

1. Explore the *Functions* section to locate the following options:
    - **Create New Project** – similar to what we did in the portal
    - **Create Function** to add it to the project
    - **Deploy to Function App**
    - Manually publish to Azure

1. Select the folder icon to create a new project.

1. Select where to store the project files.

1. Select **TypeScript** as the language to use.
   - You get to choose our preferred dev language.
   - There is one language per project. You cannot mix and match.

1. Select **HTTP trigger**.

1. Enter *GetProduct* as the function name.

1. Use *Anonymous* for the authorization level.
   - This is a feature that can add some protection while we're developing our project, but not when it's productive.
   - We cover authorization later in the series.

1. Select where to open the folder if you are prompted.

1. Inspect the folder structure of the project.
    - For every function, a sub-folder is created. Ours is called *GetProduct*.
    - Every folder contains an `index.ts` file with our code.
    - There is a `function.json` file with metadata, which we will look into later. It contains, among other things, the type of trigger our function is using.
    - The `sample.dat` file is only used when test-running a function in the portal (https://github.com/Azure/Azure-Functions/issues/1241), and not relevant for us. You can delete it, if you prefer.

1. Inspect the code that was generated. Do you notice how it is similar to what we saw earlier in the portal?

1. Select **Run and Debug**" in the sidebar.

1. To the left of **Attach to Node Functions**, select the run arrow labeled **Start Debugging**.

1. Locate the local URL of the products function in the output (the URL will be similar to `localhost:7071/api/GetProduct`), and go to it in the browser to run the function.
