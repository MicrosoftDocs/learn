## 💻 Exercise - Create a function endpoint that reacts to a HTTP Request using an HTTP trigger

With our freshly gained knowledge we can now create a function that returns product data in response to an HTTP request.

## Objective

By the end of this exercise you will create a locally running Functions app and a function endpoint called “products” that returns a simple, hard-coded Json structure.

## Instructions

1. Open Vscode
1. Click the Azure extension icon in side bar
1. Explore the “Functions” section to locate the following options:
    - Create a new function project – similar to what we did in the portal
    - Add a function to the project
    - Manually publish to Azure
1. Click the folder icon to create a new project.
1. Select where to store the project files
1. Select **TypeScript** as the language to use
   - You get to choose our preferred dev language
   - There is one language per project, you cannot mix and match
1. Select **HttpTrigger**
1. Use **“GetProduct”** as the function name.
1. Use **“anonymous”** for the authorization level
   - This is feature that can help is adding some protection while we’re developing our project but not when it’s productive.
   - We cover authorization later in the series
1. Select where to open the folder if you are prompted to.
1. Inspect the folder structure of the project.
    - For every function a sub-folder is created. Ours is called “GetProduct”
    - Every folder contains an `index.ts` file with our code
    - There is a `function.json` file with meta data which we will look into later. It contains among other things the type of trigger our function is using.
    - The `sample.dat` file is only used when test-executing a function in the portal (https://github.com/Azure/Azure-Functions/issues/1241) and not relevant for us. You can delete it if you prefer to.
1. Inspect the code that was generated. Do you notice how it is similar to what we saw earlier on the portal?
1. Switch to “Run” in the side bar
1. Click the run arrow next to “Attach top Node Functions” that state "Start debugging"
1. Locate the local URL of the products function in the output (the URL will be similar to `localhost:7071/api/GetProduct`) and navigate to it in the browser to run the function.
