Tailwind Traders is impressed with your APIs, which return existing products. Now you need to create an API that can insert and update products. The data is typically stored in a database and contain millions of records. For that reason, you need to use techniques that limit how much data is passed into the API and returned from the API.

## Implement support to write data

Implement the CRUD API on the `products` resource:

This starter project at `nodejs-route\exercise-express-routing\reading-writing`contains the product files and some starter application code. All you need to do is fill in the missing parts.

1. Right-click the **reading-writing** folder name and select **Open in integrated terminal**. 
1. In the terminal, run the following command to install it:

   ```bash
   npm install
   ```

1. Open *app.js* to inspect it. The file should look like this:

   ```javascript
    const express = require('express');
    const app = express();
    const port = 3000;
    
    app.use(express.json());
    
    let products = [];
    
    app.post('/products', function (req, res) {
      // implement
    });
    
    app.put('/products', function (req, res) {
      // implement
    });
    
    app.delete('/products/:id', function (req, res) {
      // implement
    });
    
    app.get('/products', (req, res) => {
      // implement
    });
    
    app.listen(port, () =>
      console.log(`Example app listening at http://localhost:${port}`),
    );
   ```

   The *app.js* file shows the skeleton of a program. Your next job is to implement the routes.

## Implement route to read data

To implement routes, the process is to add a little code and then test it. Continue adding each route's method until you have a fully functional API. Make your changes in the *app.js* file in the *reading-writing* directory. All files that start with `client` are client applications that you can use to test your API.

1. To support reading from the API, locate the part of the code that looks like this:

   ```javascript
   app.get('/products', (req, res) => {
     // implement
   })
   ```

   Replace it with this code:

   ```javascript
   app.get('/products', (req, res) => {
     res.json(products);
   })
   ```

1. To check that the code works, start the Node application by running this command:

   ```bash
   node app.js
   ```

1. In a separate terminal for the same folder, **reading-writing**, run the following command. It's important to have two terminal open because you need to run the server and the client at the same time.

   ```javascript
   node client-get.js
   ```

   You should get the following output:

   ```output
   Received data []
   Connection closed
   ```

   The API responds with an empty array because you haven't written any data to it yet. Let's change that next.

1. In the first terminal, select Ctrl+C to stop the application.

## Implement route to write data

1. To implement writing data to in-memory database, locate this code:

   ```javascript
   app.post('/products', function (req, res) {
      // implement
   });
   ```

   Replace it with this code:

   ```javascript
   app.post('/products', function(req, res) {
     const newProduct = { ...req.body, id: products.length + 1 }
     products = [ ...products, newProduct]
     res.json(newProduct);
   });
   ```

   The new code reads incoming data from `req.body` and constructs a JavaScript object from it. Next, it's added to the `products` in-memory database array. Finally, the new product is returned to the user.

1. To test the code, run the server program by running this command:

   ```bash
   node app.js
   ```

1. In a separate terminal for the same folder, **reading-writing**, run the following command. It's important to have two terminal open because you need to run the server and the client at the same time.

   ```bash
   node client-post.js
   ```

   You should see an output like this:

   ```output
   response {"name":"product","id":1}
   Closed connection
   ```

1. To check that the data is written to the API, run the following command:

   ```bash
   node client-get.js
   ```

   You should see the following output:

   ```output
   Received data [{"name":"product","id":1}]
   Connection closed
   ```

    Your requests so far:
    
    * **client-post.js**: The response tells you that when you ran *client-post.js*, you wrote data to the API. 
    * **client-get.js**: You ran *client-get.js* to query the API for data. The API responded with the data that you just wrote to it.

1. In the first terminal, select Ctrl+C to stop the application.


## Implement route to update data

1. To implement the ability to update your data, locate the code that looks like this:

   ```javascript
   app.put('/products', function (req, res) {
     // implement
   });
   ```

   Replace it with this code:

   ```javascript
   app.put('/products', function(req, res) {
     let updatedProduct;
     products = products.map(p => {
       if (p.id === req.body.id) {
         updatedProduct = { ...p, ...req.body };
         return updatedProduct;
       }
       return p;
     })
     res.json(updatedProduct);
   });
   ```

   The new code locates the record in the `products` in-memory database array that matches the `id` property, and updates that record.

1. To test the code, start the server application:

   ```bash
   node app.js
   ```

1. In the other terminal, run this command to create a record:

   ```bash
   node client-post.js
   ```

1. Run this command to update the newly created record:

   ```bash
   node client-put.js
   ```

   You should see the following update in the terminal:

   ```output
   response {"name":"product-updated","id":1}
   Closed connection
   ```

1. To check that the update works, run this command:

   ```bash
   node client-get.js
   ```

   You should see this update:

   ```output
   Received data [{"name":"product-updated","id":1}]
   Connection closed
   ```

1. In the first terminal, select Ctrl+C to stop the application.


## Implement route to delete data

1. To implement deleting, locate the code that looks like this:

   ```javascript
   app.delete('/products/:id', function (req, res) {
     // implement
   });
   ```

   Replace it with this code:

   ```javascript
   app.delete('/products/:id', function(req, res) {
     const deletedProduct = products.find(p => p.id === +req.params.id);
     products = products.filter(p => p.id !== +req.params.id);
     res.json(deletedProduct);
   });
   ```

   The new code finds the product to be deleted. Then it filters out that item from the `products` in-memory database array and returns the deleted product.

1. To test the code, start the server application:

   ```bash
   node app.js
   ```

1. In a separate terminal, run this command to create a record:

   ```bash
   node client-post.js
   ```

1. Run this command to remove the record:

   ```bash
   node client-delete.js
   ```

   You should see the following output:

   ```output
   response {"name":"product","id":1}
   Closed connection
   ```
  
1. To check the code, run this command:

   ```bash
   node client-get.js
   ```

   It should give this output:

   ```output
   Received data []
   Connection closed
   ```

   Congratulations! You've implemented a `products` resource by using a full CRUD (create, read, update, delete actions).

1. In the first terminal, select Ctrl+C to stop the application.

## Cleanup development container

After completing the project, you may wish to clean up your development environment or return it to its typical state.

### [Remote development (browser)](#tab/github-codespaces)

Deleting the GitHub Codespaces environment ensures that you can maximize the amount of free core hours entitlement you get for your account.

> [!IMPORTANT]
> For more information about your GitHub account's entitlements, see [GitHub Codespaces monthly included storage and core hours](https://docs.github.com/billing/managing-billing-for-github-codespaces/about-billing-for-github-codespaces#monthly-included-storage-and-core-hours-for-personal-accounts).

1. Sign into the GitHub Codespaces dashboard (<https://github.com/codespaces>).

1. Locate your currently running Codespaces sourced from the [`MicrosoftDocs/node-essentials`](https://github.com/MicrosoftDocs/node-essentials) GitHub repository.

    :::image type="content" source="../media/codespaces/codespace-dashboard.png" alt-text="Screenshot of all the running Codespaces including their status and templates.":::

1. Open the context menu for the codespace and select **Delete**.

    :::image type="content" source="../media/codespaces/codespace-delete.png" alt-text="Screenshot of the context menu for a single codespace with the delete option highlighted.":::

#### [Local development (Docker)](#tab/visual-studio-code)

You aren't necessarily required to clean up your local environment, but you can stop the running development container and return to running Visual Studio Code in the context of a local workspace.

1. Open the **Command Palette**, search for the **Dev Containers** commands, and then select **Dev Containers: Reopen Folder Locally**.

    :::image type="content" source="../media/codespaces/reopen-local-command-palette.png" alt-text="Screenshot of the Command Palette option to reopen the current folder within your local environment.":::

> [!TIP]
> Visual Studio Code will stop the running development container, but the container still exists in Docker in a stopped state. You always have the option to deleting the container instance, container image, and volumes from Docker to free up more space on your local machine.

---