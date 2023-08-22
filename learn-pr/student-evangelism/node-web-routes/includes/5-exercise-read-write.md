The online retailer is impressed with your first web application. Now it wants you to create an API that you can read and write from. The data might be stored in a database and might contain millions of records. For that reason, the retailer wants to see an app that uses techniques that limit how much data is asked for.

## Implement support to read and write data

It's common to construct an API with many resources. Each resource can have several operations available on it to read and write. Organizing by resource and by operations like read/write is called *create*, *read*, *update*, *delete* (CRUD). Implement the CRUD API on the `products` resource:

1. Clone the [node-essentials repo](https://github.com/MicrosoftDocs/node-essentials) by running the following command.

   > [!NOTE]
   > If you completed this step in the earlier exercise, you don't need to do it again.

   ```bash
   git clone https://github.com/MicrosoftDocs/node-essentials
   ```

   This starter project contains the product files and some starter application code. All you need to do is to fill in the missing parts.

1. To inspect the repo that you cloned and go to the files that you need, run this command:

   ```bash
   cd node-essentials/nodejs-http/exercise-express-routing/reading-writing
   ```

   The *reading-writing* directory should contain these files:

   - app.js
   - client-get.js
   - client-post.js
   - client-put.js
   - client-delete.js
   - client-delete-route.js
   - package.json
   - package-lock.json

1. The *package.json* file contains an `express` dependency. In the terminal, run the following command to install it:

   ```bash
   npm install
   ```

   `npm` reads from the `dependencies` section in *package.json*.

   > [!NOTE]
   > If you see a warning about an old version of `npm`, follow the instructions to fix the issue before you move to the next step.

1. Open *app.js* to inspect it. The file should look like this:

   ```javascript
    const express = require('express')
    const app = express()
    const port = 3000
    
    let bodyParser = require('body-parser');
    app.use(bodyParser.json());
    
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
    })
    
    app.listen(port, () => console.log(`Example app listening on port ${port}!`))
   ```

   The *app.js* file shows a skeleton of a program. Your next job is to implement the routes.

## Implement routes

To implement routes, add a little code and then test it. Continue method by method until you have a fully functional API. Make your changes in the *app.js* file in the *reading-writing* directory.

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

1. To check that the code works, start the API by running this command:

   ```bash
   node app.js
   ```

1. In a separate terminal, run this command:

   ```javascript
   node client-get.js
   ```

   You should get the following output:

   ```output
   Received data []
   Connection closed
   ```

The API responds with an empty array because you haven't written any data to it yet. Let's change that next.

## Implement writing

1. To implement writing, locate this code:

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

   The new code reads incoming data from `req.body` and constructs a JavaScript object from it. Next, it's added to the `products` array. Finally, the new product is returned to the user.

1. To test the code, run the server program by running this command:

   ```bash
   node app.js
   ```

1. In a separate terminal, run this command:

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

   The response tells you that when you ran *client-post.js*, you wrote data to the API. Also, you ran *client-get.js* to query the API for data. The API responded with the data that you just wrote to it.

## Implement the ability to update data

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

   The new code locates the record in the `products` array that matches the `id` property, and it updates that record.

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

## Implement deleting

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

   The new code finds the product item to be deleted. Then it filters out that item from the `products` array and responds with a filtered version of `products`.

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

   Congratulations! You've implemented a `products` resource by using a full CRUD.

## Implement CRUD

Implementing CRUD for a resource is a common task. Express has a `route()` method just for this purpose. When you use the `route()` method, your code is grouped so that it's easier to read.

1. To implement CRUD, replace the code in *app.js* with this code:

   ```javascript
   const express = require('express')
   const app = express()
   const port = 3000

   let bodyParser = require('body-parser');
   app.use(bodyParser.json());

   let products = [];

   app.route('/products')
    .get((req, res) => {
      res.json(products);
    })
    .post((req, res) => {
      const newProduct = { ...req.body, id: products.length + 1 }
      products = [...products, newProduct]
      res.json(newProduct);
    })
   .put((req, res) => {
      let updatedProduct;
      products = products.map(p => {
        if (p.id === req.body.id) {
          updatedProduct = { ...p, ...req.body };
          return updatedProduct;
        }
        return p;
      })
      res.json(updatedProduct);
    })
    .delete((req, res) => {
      const deletedProduct = products.find(p => p.id === +req.body.id);
      products = products.filter(p => p.id !== +req.body.id);
      res.json(deletedProduct);
    })

   app.listen(port, () => console.log(`Example app listening on port ${port}!`))
   ```

1. To test this new implementation, restart the server by running this command:

   ```bash
   node app.js
   ```

1. In a separate terminal window, run this command:

   ```bash
   node client-post.js
   ```

1. Run this command to delete the record:

   ```bash
   node client-delete-route.js
   ```

1. To check that the record is removed, run this command:

   ```bash
   node client-get.js
   ```

   You should see the following output:

   ```output
   Received data []
   Connection closed
   ```

You used *client-delete-route.js* instead of *client-delete.js* in the previous exercise. The difference lies in how the route is implemented. The first version of *app.js* relies on deletions being done toward a route like `/products/<id>`, with the unique identifier being sent as a route parameter.

When you use the `route()` method, it implements the deletion route differently. It wants you to send unique identifier through the body instead of as a route parameter. There's no right or wrong way to implement a deletion route.

## Cleanup development container

After completing the project, you may wish to clean up your development environment or return it to its typical state.

### [GitHub Codespaces](#tab/github-codespaces)

Deleting the GitHub Codespaces environment ensures that you can maximize the amount of free per-core hours entitlement you get for your account.

> [!IMPORTANT]
> For more information about your GitHub account's entitlements, see [GitHub Codespaces monthly included storage and core hours](https://docs.github.com/billing/managing-billing-for-github-codespaces/about-billing-for-github-codespaces#monthly-included-storage-and-core-hours-for-personal-accounts).

1. Sign into the GitHub Codespaces dashboard (<https://github.com/codespaces>).

1. Locate your currently running codespaces sourced from the [`azure-samples/node-essentials`](https://github.com/azure-samples/node-essentials) GitHub repository.

    :::image type="content" source="../media/codespaces/codespace-dashboard.png" alt-text="Screenshot of all the running codespaces including their status and templates.":::

1. Open the context menu for the codespace and select **Delete**.

    :::image type="content" source="../media/codespaces/codespace-delete.png" alt-text="Screenshot of the context menu for a single codespace with the delete option highlighted.":::

#### [Visual Studio Code](#tab/visual-studio-code)

You aren't necessarily required to clean up your local environment, but you can stop the running development container and return to running Visual Studio Code in the context of a local workspace.

1. Open the **Command Palette**, search for the **Dev Containers** commands, and then select **Dev Containers: Reopen Folder Locally**.

    :::image type="content" source="../media/codespaces/reopen-local-command-palette.png" alt-text="Screenshot of the Command Palette option to reopen the current folder within your local environment.":::

> [!TIP]
> Visual Studio Code will stop the running development container, but the container still exists in Docker in a stopped state. You always have the option to deleting the container instance, container image, and volumes from Docker to free up more space on your local machine.

---