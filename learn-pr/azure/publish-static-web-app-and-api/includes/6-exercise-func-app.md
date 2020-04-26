You can create an API for your shopping list app. In this exercise, you'll create your API with an Azure Functions project using the [Visual Studio Code Extension for Azure Functions](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions).

## Create the Function app and your HTTP GET function

Once the extension is installed, follow these steps to create the Azure Functions project on your computer.

1. In Visual Studio Code, open the command palette by pressing **F1**
1. Type and select **Azure Functions: Create New Project**
1. Choose **Browse** to find the folder to create the functions
1. Create a new folder in your project called _api_
1. Select **JavaScript**
1. When prompted to create a function, select **HTTP Trigger**
1. Enter **products-get** as the name of the function
1. Select **Anonymous** as the authentication level

Congratulations, you just created an Azure Function app and your first function!

> [!NOTE]
> You created the function app in the _api_ folder, which separates it from the web apps. All of the web apps using the front-end frameworks can hit the same API. You can decide how to structure your application, but for this sample it helps to see them separated.

### Set the HTTP Method and route endpoint name

You may recall that your app needs four endpoints. Next, you'll configure and code the function for the first of these endpoints. You'll create the other endpoints in a future exercise.

Notice that there's now a folder _api/products-get_ that contains a few files. Once of these files is _function.json_, which contains the configuration for the function.

By convention, the route endpoint has the same name as the folder that contains the function. Since the function is created in the _products-get_ folder, the route endpoint is generated as **products-get**. You want the endpoint to be **products**.

Configure your function by following these steps:

1. Open the file _api/products-get/function.json_
1. Notice the methods allow both `GET` and `POST`
1. Change the methods array to only allow `GET` requests
1. Go to the `bindings` section's `req` properties
1. Add a `route: "products"` entry

Now your function will be triggered on an HTTP `GET` request to **products**. Your _function.json_ should look like the following:

```json
{
  "disabled": false,
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
  ],
  "scriptFile": "../dist/products-get/index.js"
}
```

### Refactor the route logic

The other important file here in the _api/products-get_ folder is _index.js_. This file contains the logic that runs when the route endpoint is requested.

You'll need to refactor the logic to get your products. Assume for now that the data access logic will be in a JavaScript module in _/services/product-data.js_ and that it exposes a function `getProducts` to get the products for the shopping list. You'll create the `product-data` module shortly.

Now, refactor the function endpoint to return the products:

1. Open the file _api/products-get/index.js_
1. Replace its contents with the following code:

   ```javascript
   const data = require('../services/product-data');

   module.exports = async function (context, req) {
     try {
       const products = data.getProducts();
       context.res.status(200).json(products);
     } catch (error) {
       context.res.status(500).send(error);
     }
   };
   ```

Your function will get the products and return them with a status code of 200, if successful.

### Create the product data

Your app needs to store its data. You could create a database, but for now you'll store the shopping list in an array.

You'll create the data access logic and the shopping list array in the JavaScript module _services/product.data.js_. You'll also need functions to read and modify the array.

1. Create a file _services/product.data.js_
1. Add the following code to the file for a starter set of products:

   ```javascript
   const data = {
     products: [
       {
         id: 10,
         name: 'Strawberries',
         description: '16oz package of fresh organic strawberries',
         quantity: '1',
       },
       {
         id: 20,
         name: 'Sliced bread',
         description: 'Loaf of fresh sliced wheat bread',
         quantity: 1,
       },
       {
         id: 30,
         name: 'Apples',
         description: 'Bag of 7 fresh McIntosh apples',
         quantity: 1,
       },
     ],
   };
   ```

1. Add the following code to read the shopping list of products:

   ```javascript
   const getProducts = () => {
     return data.products;
   };

   module.exports = { getProducts };
   ```

This code exports a function named `getProducts`, which gets the products from the array. This function is then imported by the function in the file _api/products-get/index.js_ (that you previously created).

### Run the API

Now its time to see if your web app and Azure Functions project work together. Start by running your Azure Functions project locally by following these steps:

1. Open a terminal
1. Go to the _api_ folder

   ```bash
   cd api
   ```

1. Run the Azure Functions app locally

   ```bash
   npm start
   ```

## Run the web app

Now that your API is running, you need to configure your front-end app to make its HTTP request to your API. The front-end app runs on one port and the API runs on a different port (7071). Each front-end framework can be configured to proxy HTTP requests to another port safely.

### Configure your proxy port

Configure the proxy for your front-end app with the following steps:

::: zone pivot="angular"

# [Angular](#tab/angular)

1. Open the file _proxy.conf.json_
1. Locate the `target: 'http://localhost:7010'` setting
1. Change the target's port to point to port 7071 `target: 'http://localhost:7071',`

::: zone-end

::: zone pivot="react"

# [React](#tab/react)

1. Open the file _package.json_
1. Locate the `"proxy": "http://localhost:7020/",'` setting
1. Change the proxy's port to point to port 7071 `proxy: 'http://localhost:7071',`

::: zone-end

::: zone pivot="svelte"

# [Svelte](#tab/svelte)

1. Open the file _rollup.config.js_
1. Locate the line of code `const api = 'http://localhost:7030/api';`
1. Change the api's port to point to port 7071 `const api = 'http://localhost:7071/api';`

::: zone-end

::: zone pivot="vue"

# [Vue](#tab/vue)

1. Open the file _vue.config.js_
1. Locate the `target: 'http://localhost:7040',` setting
1. Change the target's port to point to port 7071 `target: 'http://localhost:7071',`

::: zone-end

### Run your front-end web app

Your API is already running on port 7071. Now when you run your web app it will make its HTTP requests to your API. Run your web app by following these steps:

1. Open a new terminal
1. Next, go to the folder of your preferred front-end framework, as shown below:

   ::: zone pivot="angular"

   # [Angular](#tab/angular)

   ```bash
   cd angular-app
   ```

   ::: zone-end

   ::: zone pivot="react"

   # [React](#tab/react)

   ```bash
   cd react-app
   ```

   ::: zone-end

   ::: zone pivot="svelte"

   # [Svelte](#tab/svelte)

   ```bash
   cd svelte-app
   ```

   ::: zone-end

   ::: zone pivot="vue"

   # [Vue](#tab/vue)

   ```bash
   cd vue-app
   ```

   ::: zone-end

1. Run the front-end client application

   ::: zone pivot="angular"

   # [Angular](#tab/angular)

   ```bash
   npm start
   ```

   ::: zone-end

   ::: zone pivot="react"

   # [React](#tab/react)

   ```bash
   npm start
   ```

   ::: zone-end

   ::: zone pivot="svelte"

   # [Svelte](#tab/svelte)

   ```bash
   npm run dev
   ```

   ::: zone-end

   ::: zone pivot="vue"

   # [Vue](#tab/vue)

   ```bash
   npm run serve
   ```

   ::: zone-end

### Browse to your app

It's time to see your application running locally against the Azure Functions API. Select your preferred front-end application and click the link to browse to the application.

::: zone pivot="angular"

# [Angular](#tab/angular)

Browse to <http://localhost:4200>

::: zone-end

::: zone pivot="react"

# [React](#tab/react)

Browse to <http://localhost:3000>

::: zone-end

::: zone pivot="svelte"

# [Svelte](#tab/svelte)

Browse to <http://localhost:5000>

::: zone-end

::: zone pivot="vue"

# [Vue](#tab/vue)

Browse to <http://localhost:8080>

::: zone-end

You built your application and now it's running locally making HTTP GET requests to your API.

## Next steps

Your app can get products, but it cannot edit them. You're missing your HTTP PUT, POST, and DELETE endpoints. You'll add those next.
