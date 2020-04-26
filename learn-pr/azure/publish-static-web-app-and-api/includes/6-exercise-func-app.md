You can create an Azure Functions project to develop your shopping list API. In this exercise, you'll create the Azure Functions project using the [Visual Studio Code Extension for Azure Functions](https://marketplace.visualstudio.com/items?itemName=ms-azuretools.vscode-azurefunctions).

## Create the Function app and your HTTP GET function

Once the extension is installed, follow these steps to create the Azure Functions on your computer.

1. In Visual Studio Code, open the command palette by pressing **F1**
1. Type and select **Azure Functions: Create New Project**
1. Choose **Browse** to find the folder to create the functions
1. Create a new folder in your project called _api_
1. Select **JavaScript**
1. When prompted to create a function, select **HTTP Trigger**
1. Enter **products-get** as the name of the function
1. Select **Anonymous** as the authentication level

Congratulations, you just created an Azure Function app and your first function!

You may recall that your app needs four endpoints. In this exercise, you'll create the function for the first of these endpoints. You'll create the other endpoints in a future exercise.

> [!NOTE]
> You created the function app in the _api_ folder, which separates it from the web apps. All of the web apps using the front-end frameworks can hit the same API. You can decide how to structure your application, but for this sample it helps to see them separated.

### Set the HTTP Method and route endpoint name

Notice that there's now a folder api/products-get\_ that contains a few files.

The _function.json_ contains the configuration for the function.

1. Open the file _api/products-get/function.json_
1. Notice the methods allow both `GET` and `POST`
1. Change the methods array to only allow `GET` requests
1. Go to the `bindings` section's `req` properties
1. Add a `route: "products"` entry

By convention, the route endpoint has the same name as the folder that contains the function. Since the function is created in the _products-get_ folder, the route endpoint is generated as **products-get**. Now the function is executed when an HTTP `GET` on **/products** is requested.

Your _function.json_ should look like the following code.

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

The other important file here in the _api/products-get_ folder is _index.ts_. This file is your function. Your function contains the logic that runs when the route endpoint is requested.

You'll need to refactor the logic to call another module to get your products. You'll create the other module that gets the products shortly.

1. Open the file _api/products-get/index.ts_
1. Replaced its contents with the following code

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

### Create the product data

Your app needs to store its data. You could create a database, but for now you'll store the shopping list in an array.

The shopping list array will go in a JavaScript module. You'll also need functions to read and modify the array.

1. Create a file _api/services/product.data.js_
1. Add the following code to the file for a starter set of products

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
         quantity: 8,
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

1. Add the following code to the file to read the shopping list of products

   ```javascript
   const getProducts = () => {
     return data.products;
   };

   module.exports = { getProducts };
   ```

This code exports a function named `getProducts`, which gets the products from the array. This function is then imported by the function in the file _api/products-get/index.ts_ (that you previously created).

### Run the API

Run the Azure Functions project locally.

1. Open a terminal
1. Open the _api_ folder

   ```bash
   cd api
   ```

1. Run the Azure Functions app locally

   ```bash
   npm start
   ```

### Run the web app

Run your web app.

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

1. Now install the application dependencies.

   ```bash
   npm install
   ```

1. Finally, run the front-end client application.

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

## Browse to your app

It's time to see your application running locally against the Azure Functions API.

Select your preferred front-end application and click the link to browse to the application.

::: zone pivot="angular"

# [Angular](#tab/angular)

Browse to <http://localhost:4200>

:::image type="content" source="../media/my-shopping-list-app-angular.png" alt-text="Browsing to your Angular app":::

::: zone-end

::: zone pivot="react"

# [React](#tab/react)

Browse to <http://localhost:3000>

:::image type="content" source="../media/my-shopping-list-app-react.png" alt-text="Browsing to your React app":::

::: zone-end

::: zone pivot="svelte"

# [Svelte](#tab/svelte)

Browse to <http://localhost:5000>

:::image type="content" source="../media/my-shopping-list-app-svelte.png" alt-text="Browsing to your Svelte app":::

::: zone-end

::: zone pivot="vue"

# [Vue](#tab/vue)

Browse to <http://localhost:8080>

:::image type="content" source="../media/my-shopping-list-app-vue.png" alt-text="Browsing to your Vue app":::

::: zone-end

You built your application and now it's running locally making HTTP GET requests to your API.

## Next steps

- Set the proxy port (pivot on VARS)
- Run the app locally in two terminals
