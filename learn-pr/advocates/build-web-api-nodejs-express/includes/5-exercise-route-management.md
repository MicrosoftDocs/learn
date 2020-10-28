The online retailer is impressed with your first web application. Now they want you to build an API that you can read and write from. Their data might be stored in a database and might contain millions of records. For that reason, the retailer wants to see an app that uses different techniques that limit how much data is asked for.

## Implement support to read and write data

It's common to construct an API with a number of resources. Each resource can have a several operations available on it to read and write. Organizing by resource and by operations like read/write is called *create*, *read*, *update*, *delete* (CRUD). Implement the CRUD API on the resource **products**:

1. Clone the repo at https://github.com/MicrosoftDocs/node-essentials by using this command:

   ```bash
   git clone https://github.com/MicrosoftDocs/node-essentials
   ```

   This starter project contains the product files and some starter application code. All you need to do is to fill in the missing parts.

1. To inspect the repo you cloned and go to the files you need, enter this command:

   ```bash
   cd node-essentials/nodejs-http/exercise-express-routing/reading-writing
   ```

   The outline of the directory should look like this:

   ```bash
   -| app.js
   -| client-get.js
   -| client-post.js
   -| client-put.js
   -| client-delete.js
   -| client-delete-route.js
   -| package.json
   ```

1. The **package.json** file contains a dependency **express**. In the terminal, enter the following command to install it:

   ```bash
   npm install
   ```

   **npm** reads from the **dependencies** section in the **package.json**.

1. Open **app.js** to inspect it. The file should look like this:

   ```javascript
   const express = require('express')
   const app = express()
   const port = 3000

   let bodyParser = require('body-parser');
   app.use(bodyParser.json());

   let products = [];

   app.post('/products', function(req, res) {
     // implement
   });

   app.put('/products', function(req, res) {
     // implement
   });

   app.delete('/products/:id', function(req, res) {
     // implement
   });

   app.get('/products', (req, res) => {
     // implement
   })
   app.listen(port, () => console.log(`Example app listening on port ${port}!`));
   ```

   The **app.js** file shows a skeleton of a program. Your next job is to implement the routes.

### Implement the routes

To implement the routes, add a little code, and then test it. Do this method by method until you have a fully functional API.

1. First support reading from the API. Locate the part of the code that looks like this:

   ```javascript
   app.get('/products', (req, res) => {
     // implement
   })
   ```

1. Replace that code with this code:

   ```javascript
   app.get('/products', (req, res) => {
     res.json(products);
   })
   ```

1. To check that the code works, start the API by using this command:

   ```bash
   node app.js
   ```

1. In a separate terminal enter:

   ```javascript
   node client-get.js
   ```

   That command should give you the following output:

   ```output
   Received data []
   Connection closed
   ```

The API responds with an empty array because you haven't written any data to it yet. Lets change that up next.

### Implement writing

1. To implement writing, locate this code:

   ```javascript
   app.post('/products', function(req, res) {
     // implement
   });
   ```

1. Replace that code with this code:

   ```javascript
   app.post('/products', function(req, res) {
     const newProduct = { ...req.body, id: products.length + 1 }
     products = [ ...products, newProduct]
     res.json(newProduct);
   });
   ```

   The code reads incoming data from **req.body** and constructs a JavaScript object from it. Next, it's added to the array **products**. Finally the new product is returned back to the user.

1. To test the code, run the server program by using this command:

   ```bash
   node app.js
   ```

1. In a separate terminal run this command:

   ```bash
   node client-post.js
   ```

   You should see an output like this:

   ```output
   response {"name":"product","id":1}
   Closed connection
   ```

1. To check that the data is written to the API, enter the following command:

   ```bash
   node client-get.js
   ```

   You should see the following output:

   ```output
   Received data [{"name":"product","id":1}]
   Connection closed
   ```

   The response tells you that when you ran **client-post.js** you wrote data to the API. Also, you ran **client-get.js** to query the API for data. The API responded with the data that you just wrote to it.

### Implement the ability to update data

1. To implement the ability to update your data, locate the code that looks like this:

   ```javascript
   app.put('/products', function(req, res) {});
   ```

1. Replace that code with this code:

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

   The code locates the record in the **products** array that matches the **id** property and updates that record.

1. To test the code, start the server application:

   ```bash
   node app.js
   ```

1. In the other terminal run this command to create a record:

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

1. To check that the updates works, run this command:

   ```bash
   node client-get.js
   ```

   You should see this update:

   ```output
   Received data [{"name":"product-updated","id":1}]
   Connection closed
   ```

### Implement delete

1. To implement delete, locate the code that looks like this:

   ```javascript
   app.delete('/products/:id', function(req, res) {});
   ```

1. Replace that code with this code:

   ```javascript
   app.delete('/products/:id', function(req, res) {
     const deletedProduct = products.find(p => p.id === +req.params.id);
     products = products.filter(p => p.id !== +req.params.id);
     res.json(deletedProduct);
   });
   ```

   The code finds the product item to be deleted. Then it filters out that item from the **products** array and responds with a filtered version of **products**.

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
   Received data {"name":"product","id":1}
   Connection closed
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

   Congratulations, you've managed to implement a resource **products** by using a full CRUD.

### Implement CRUD

Implementing CRUD for a resource is common thing to do. Express has a method **route()** meant just for this purpose. By using the **route()** method, your code is grouped so that it's easier to read.

1. To implement CRUD, replace the code in **app.js** with this code:

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

1. To test this new implementation, restart the server with this command:

   ```bash
   node app.js
   ```

1. In a separate terminal window run this command:

   ```bash
   node client-post.js
   ```

1. Then run this command to delete the record:

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

   You used **client-delete-route.js** instead of **client-delete.js** in the previous exercise. The difference lies in how the route is implemented. The first version of **app.js** relies on deletions being done toward a route like this **/products/<id>**, with the unique identifier being sent as a route parameter.

   When you use the **route()** method, it implements the deletion route differently and wants you to send unique identifier through the body instead of as a route parameter. There's no right or wrong way to implement a deletion route.

## Leverage route and query parameters to limit response size

Data usually resides in a database or an endpoint. The size of the data can be enormous. When a user asks for all the data for a specific resource, the response can be thousands or even millions of records. A request like this can cause a massive strain on a database. It also takes a long time to serve the response.

To avoid that scenario, it's good practice to *limit* the size of the response.

- Use route parameters to ask for specific records.
- Use query parameters to specify a subset of records.

Both techniques are taught in this exercise.  

1. Clone the repo at the URL with the following command:

    > [!NOTE]
    > If you completed the previous exercise, you don't need to do this again.

   ```bash
   git clone https://github.com/MicrosoftDocs/node-essentials
   ```

   This starter project contains the product files and some starter application code. All you need to do is to fill in the missing parts.

1. To inspect the repo you cloned, enter the following command:

   ```bash
   cd node-essentials/nodejs-http/exercise-express-routing/parameters
   ```

   The outline of the directory should look like this:

   ```bash
   -| app.js
   -| package.json
   -| package-lock.json
   ```

 1. The **package.json** file contains the dependency **express**. In the terminal, enter the following command to install it:

    ```bash
    npm install
    ```

    **npm** reads from the **dependencies** section in the **package.json**.

1. Open **app.js** to inspect it. The file should look like this:

   ```javascript
   const express = require('express')
   const app = express()
   const port = 3000

   const products = [
   {
     id: 1,
     name: "Ivanhoe",
     author: "Sir Walter Scott",
   },
   {
     id: 2,
     name: "Colour Magic",
     author: "Terry Pratchett",
   },
   {
     id: 3,
     name: "The Bluest eye",
     author: "Toni Morrison",
   },
   ];

   app.get('/', (req, res) => res.send('Hello API!'))

   app.get("/products/:id", (req, res) => {
     res.json(products.find(p => p.id === +req.params.id));
   });

   app.get('/products', (req, res) => {})

   app.listen(port, () => console.log(`Example app listening on port ${port}!`))
   ```

### Implement two routes

The code contains an Express application. The next step is to implement two routes:

- **/products/:id**: This route should return a single product.
- **/products**: The route should return all products, or as many products that are asked for by query parameters.

1. Implement the route **/products/:id** by replacing this code:

   ```javascript
   app.get("/products/:id", (req, res) => {});
   ```

   with this code:

   ```javascript
   app.get("/products/:id", (req, res) => {
     res.json(products.find(p => p.id === +req.params.id));
   });
   ```

1. In the terminal, enter the following command to run the app:

   ```output
   node app.js
   ```

1. Open a browser and go to http://localhost:3000/products/1. You should see the following output:

   ```bash
   {
     "id": 1,
     "name": "Ivanhoe",
     "author": "Sir Walter Scott"
   }
   ```

   Great, you implemented the route correctly. The app uses the route parameter **id** to find a specific product.

1. To implement the route **/products**, locate the following code:

   ```javascript
   app.get('/products', (req, res) => {})
   ```

1. Replace that code with this code:

   ```javascript
   app.get('/products', (req, res) => {
     const page = +req.query.page;
     const pageSize = +req.query.pageSize;
  
     if (page && pageSize) {
       const start = (page - 1) * pageSize;
       const end = start + pageSize;
       res.json(products.slice(start, end));
     } else {
       res.json(products);
     }
   })
   ```

1. In the terminal, enter the following command to start the app and test the code:

   ```bash
   node app.js
   ```

1. Open a browser and go to http://localhost:3000/products?page=1&pageSize=2. You should see the following output in the browser:

   ```output
   [{
     "id": 1,
     "name": "Ivanhoe",
     "author": "Sir Walter Scott"
   },
   {
     "id": 2,
     "name": "Colour Magic",
     "author": "Terry Pratchett"
   }]
   ```

   The response shows the first two of three records. This response means the query parameters, **page** and **pageSize**, filtered down the response size.

1. Change the URL to http://localhost:3000/products?page=2&pageSize=2 to change the number of pages from 1 to 2. The response should look like this:

   ```output
   [{
     "id": 3,
     "name": "The Bluest eye",
     "author": "Toni Morrison"
   }]
   ```

   Because there are only three records, the second page should only contain one record. Congratulations. You successfully applied query parameters to limit the response.
