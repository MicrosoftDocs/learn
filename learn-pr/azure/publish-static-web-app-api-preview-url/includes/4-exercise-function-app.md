Your shopping list web app needs an API. In this exercise, you'll build and run your API using an Azure Functions project. From there, you'll extend the API with a new function using the Azure Functions extension for Visual Studio Code.

In this exercise, you'll complete the following steps:

1. Create a branch as you prepare to make changes to your web app.
1. Explore the Azure Function project.
1. Create the HTTP GET function.
1. Replace the function starter code with logic to get products.
1. Configure the web app to proxy HTTP requests to the API.
1. Run the API and the web app.

## Get the Function app

Now, you'll add an API and connect it to your front-end app. The _api-starter_ folder includes an incomplete Azure Functions project. You'll complete that now.

### Create an API branch

Before making changes to an app, it's good practice to create a new branch for the changes. You're about to complete the API for your app, so now is a good time to create a branch.

1. In Visual Studio Code, open the command palette by pressing <kbd>F1</kbd>.

1. Enter and select **Git: Checkout to...**.

1. Select **Create new branch**.

1. Enter *api* for the new branch name, and press <kbd>Enter</kbd>.

You just created the **api** git branch.

### Complete the Azure Functions API

To complete the API, you'll start by moving the starter API code to a folder named _api_. This is the folder name you entered for the **api_location** when you created the Static Web Apps instance.

1. In Visual Studio Code, open the command palette by pressing <kbd>F1</kbd>.

1. Enter and select **Terminal: Create New Terminal (In Active Workspace)**.

1. Make sure you are in the root folder of the project.

1. Run the following git command to rename the _api-starter_ folder to _api_.

   ```bash
   git mv api-starter api
   ```

1. Open the command palette by pressing <kbd>F1</kbd>.

1. Enter and select **Git: Commit All**.

1. Enter the commit message **api** and press <kbd>Enter</kbd>.

You'll now see an **api** folder in the Visual Studio Code explorer. The **api** folder contains your Azure Functions project, along with three functions.

| Folder and file       | Method | Route          |
| --------------------- | ------ | -------------- |
| _api/products-post_   | POST   | `products`     |
| _api/products-put_    | PUT    | `products/:id` |
| _api/products-delete_ | DELETE | `products/:id` |

## Create the HTTP GET function

Your API has routes for manipulating the products for the shopping list, but it lacks a route for getting the products. You'll add that now.

### Install the Azure Functions extension for Visual Studio Code

You can create and manage Azure Functions applications the Azure Functions extension for Visual Studio Code.

1. Go to the [Visual Studio Marketplace](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions&azure-portal=true), and install the **Azure Functions** extension for Visual Studio Code.

1. When the extension tab loads in Visual Studio Code, select **Install**.

1. After installation is complete, select **Reload**.

> [!NOTE]
> Be sure to install the [Azure Functions Core Tools](/azure/azure-functions/functions-run-local), which will allow you to run Azure Functions locally.

### Create the function

Now you'll extend your Azure Function app with a function to get your products.

1. In Visual Studio Code, open the command palette by pressing <kbd>F1</kbd>.

1. Enter and select **Azure Functions: Create Function**.

1. When prompted to create a function, select **HTTP Trigger**.

1. Enter **products-get** as the name of the function.

1. Select **Anonymous** as the authentication level.

> [!NOTE]
> The Functions app is in the _api_ folder, which separates it from the individual web app projects. All of the web apps using the front-end frameworks make calls to the same API. You can decide how to structure your application, but for this sample it helps to see them separated.

### Configure the HTTP Method and route endpoint

Notice the folder _api/products-get_ contains the file _function.json_. This file contains the configuration for your function.

The route endpoint has the same name as the folder that contains the function, by convention. Because the function is created in the _products-get_ folder, the route endpoint is generated as **products-get**, by default. However, you want the endpoint to be **products**.

Configure your function:

1. Open the file _api/products-get/function.json_.

1. Notice the methods allow both `GET` and `POST`.

1. Change the methods array to only allow `GET` requests.

1. Add a `"route": "products"` entry after the methods array.

Now your function is triggered on an HTTP `GET` request to **products**. Your _function.json_ should look like the following code:

```json
{
  "bindings": [
    {
      "authLevel": "anonymous",
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
  ]
}
```

### Update the function logic

The file _index.js_ in the folder _api/products-get_ contains logic that runs when your make an HTTP request to the route.

You'll need to update the logic to get your products. There is data access logic in the JavaScript module _/shared/product-data.js_. The `product-data` module exposes a function `getProducts` to get the products for the shopping list.

Now, change the function endpoint to return the products:

1. Open the file _api/products-get/index.js_.

1. Replace its contents with the following code:

   ```javascript
   const data = require('../shared/product-data');

   module.exports = async function (context, req) {
     try {
       const products = data.getProducts();
       context.res.status(200).json(products);
     } catch (error) {
       context.res.status(500).send(error);
     }
   };
   ```

Your function will get the products and return them with a status code of 200, when successful.

### Configure Cross-Origin Resource Sharing (CORS) locally

You won't have to worry about CORS when you publish to Azure Static Web Apps. Azure Static Web Apps automatically configures your app so it can communicate with your API on Azure using a reverse proxy. But when running locally, you need to configure CORS to allow your web app and API to communicate.

Now, tell Azure Functions to allow your web app to make HTTP requests to the API, on your computer.

1. Create a file named _api/local.settings.json_.

1. Add the following contents to the file:

   ::: zone pivot="angular"

   ```json
   {
     "Host": {
       "CORS": "http://localhost:4200"
     }
   }
   ```

   ::: zone-end

   ::: zone pivot="react"

   ```json
   {
     "Host": {
       "CORS": "http://localhost:3000"
     }
   }
   ```

   ::: zone-end

   ::: zone pivot="svelte"

   ```json
   {
     "Host": {
       "CORS": "http://localhost:5000"
     }
   }
   ```

   ::: zone-end

   ::: zone pivot="vue"

   ```json
   {
     "Host": {
       "CORS": "http://localhost:8080"
     }
   }
   ```

   ::: zone-end

> [!NOTE]
> The _local.settings.json_ file is listed in the _.gitignore_ file, which prevents this file from being pushed to GitHub. This is because you could store secrets in this file you would not want that in GitHub. This is why you had to create the file when you created your repo from the template.

### Run the API

Now it's time to watch your web app and Azure Functions project work together. Start by running your Azure Functions project locally by following these steps:

> [!NOTE]
> Be sure to install the [Azure Functions Core Tools](/azure/azure-functions/functions-run-local), which will allow you to run Azure Functions locally.

1. Open a git terminal and go to the _api_ folder:

   ```bash
   cd api
   ```

1. Run the Azure Functions app locally:

   ```bash
   npm install
   ```

   ```bash
   npm start
   ```

## Run the web app

Your API is running. Now you need to configure your front-end app to make its HTTP request to your API. The front-end app runs on one port, and the API runs on a different port (7071). Each front-end framework can be configured to proxy HTTP requests to a port safely.

### Configure your proxy port

Configure the proxy for your front-end app with the following steps:

::: zone pivot="angular"

1. Open the file _angular-app/proxy.conf.json_.

1. Locate the `target: 'http://localhost:7071'` setting.

1. Notice that the target's port points to 7071.

::: zone-end

::: zone pivot="react"

1. Open the file _react-app/package.json_.

1. Locate the `"proxy": "http://localhost:7071/",` setting.

1. Notice that the proxy's port points to 7071.

::: zone-end

::: zone pivot="svelte"

1. Open the file _svelte-app/rollup.config.js_.

1. Locate the line of code `const api = 'http://localhost:7071/api';`.

1. Notice that the api's port points to 7071.

::: zone-end

::: zone pivot="vue"

1. Open the file _vue-app/vue.config.js_.

1. Locate the `target: 'http://localhost:7071',` setting.

1. Notice that the target's port points to 7071.

::: zone-end

### Run your front-end web app

Your API is already running on port 7071. Now, when you run your web app, it will make its HTTP requests to your API. Run your web app by following these steps:

1. Open a second git terminal instance.

1. Next, go to the folder of your preferred front-end framework, as follows:

   ::: zone pivot="angular"

   ```bash
   cd angular-app
   ```

   ::: zone-end

   ::: zone pivot="react"

   ```bash
   cd react-app
   ```

   ::: zone-end

   ::: zone pivot="svelte"

   ```bash
   cd svelte-app
   ```

   ::: zone-end

   ::: zone pivot="vue"

   ```bash
   cd vue-app
   ```

   ::: zone-end

1. Run the front-end client application:

   ::: zone pivot="angular"

   ```bash
   npm start
   ```

   ::: zone-end

   ::: zone pivot="react"

   ```bash
   npm start
   ```

   ::: zone-end

   ::: zone pivot="svelte"

   ```bash
   npm run dev
   ```

   ::: zone-end

   ::: zone pivot="vue"

   ```bash
   npm run serve
   ```

   ::: zone-end

### Browse to your app

It's time to see your application running locally against the Azure Functions API.

::: zone pivot="angular"

1. Browse to `http://localhost:4200`.

::: zone-end

::: zone pivot="react"

1. Browse to `http://localhost:3000`.

::: zone-end

::: zone pivot="svelte"

1. Browse to `http://localhost:5000`.

::: zone-end

::: zone pivot="vue"

1. Browse to `http://localhost:8080`.

::: zone-end

  You built your application, and now it's running locally making HTTP GET requests to your API.

2. Now, stop your running app and API by pressing <kbd>Ctrl-C</kbd> in the terminals.

## Next steps

Your app works locally, and your next step is to publish the app with the API.
