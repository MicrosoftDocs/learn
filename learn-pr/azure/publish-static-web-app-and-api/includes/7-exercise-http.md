You can read the products but you can't write them yet. That's because your API has an HTTP GET endpoint for products, but lacks any endpoints for POST, PUT, and DELETE.

## Create the POST, PUT, and DELETE functions

You need all four endpoints and you just created the first one. Now, follow these steps to create an Azure Function for the rest of the route endpoints. Here are the endpoints you'll create.

| Methods | Route endpoints   |
| ------- | ----------------- |
| POST    | _products-post_   |
| PUT     | _products-put_    |
| DELETE  | _products-delete_ |

### Create the HTTP Post Function

Follow the following steps to create a function that handles adding a product.

1. Open the command palette by pressing **F1**
1. Type and select **Azure Functions: Create Function**
1. Choose **HTTP Trigger** for the type of function
1. Enter the name **products-post** for the function
1. Select **Anonymous** for the authentication level
1. Open the file _function.json_
1. Set the method to **post**
1. Go to the bindings section's **req** object and add `route: "products"` entry
1. Open the _api/products-post/index.js_ file
1. Replace its contents with the following code:

   ```javascript
   const data = require('../shared/product-data');

   module.exports = async function (context, req) {
     const product = {
       id: undefined,
       name: req.body.name,
       description: req.body.description,
     };

     try {
       const newProduct = data.addProduct(product);
       context.res.status(201).json(newProduct);
     } catch (error) {
       context.res.status(500).send(error);
     }
   };
   ```

#### Create the HTTP Put Function

Follow the following steps to create a function that handles updating a product.

1. Open the command palette by pressing **F1**
1. Type and select **Azure Functions: Create Function**
1. Choose **HTTP Trigger** for the type of function
1. Enter the name **products-put** for the function
1. Select **Anonymous** for the authentication level
1. Open the file _function.json_
1. Set the method to **put**
1. Go to the bindings section's **req** object and add `route: "products/{id}"` entry
1. Open the _api/products-put/index.js_ file
1. Replace its contents with the following code:

   ```javascript
   const data = require('../shared/product-data');

   module.exports = async function (context, req) {
     const product = {
       id: parseInt(req.params.id, 10),
       name: req.body.name,
       description: req.body.description,
     };

     try {
       const updatedProduct = data.updateProduct(product);
       context.res.status(200).json(updatedProduct);
     } catch (error) {
       context.res.status(500).send(error);
     }
   };
   ```

#### Create the HTTP Delete Function

Follow the following steps to create a function that handles deleting a product.

1. Open the command palette by pressing **F1**
1. Type and select **Azure Functions: Create Function**
1. Choose **HTTP Trigger** for the type of function
1. Enter the name **products-delete** for the function
1. Select **Anonymous** for the authentication level
1. Open the file _function.json_
1. Set the method to **delete**
1. Go to the bindings section's **req** object and add `route: "products/{id}"` entry
1. Open the _api/products-delete/index.js_ file
1. Replace its contents with the following code:

   ```javascript
   const data = require('../shared/product-data');

   module.exports = async function (context, req) {
     const id = parseInt(req.params.id, 10);

     try {
       data.deleteProduct(id);
       context.res.status(200).json({});
     } catch (error) {
       context.res.status(500).send(error);
     }
   };
   ```

Next, you'll review the Azure Functions application you created.
