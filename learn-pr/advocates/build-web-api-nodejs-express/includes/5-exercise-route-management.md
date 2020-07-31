Tailwind Traders are impressed with your first Web Application and want you to improve it. Tailwind Traders are interested in building Web Applications in the form of APIs. Therefore they would like you to build an API that you can write to and read from. Additionally they would like you to consider that data at Tailwind Traders might be stored in a database and may contain millions of records. For that reason they would like to see an app using different techniques to limit how much data is asked for.

## Implement support for reading and writing data

When building an API, it's common to construct it so that you have a number of resources. Each resource may have a number of operations available on them for reading and writing. Organizing by resource and by operations like read/write is referred to as CRUD or **C**reate, **R**ead, **U**pdate, **D**elete. You will implement such an API on the resource `products`.

1. Clone the repo at `https://github.com/MicrosoftDocs/node-essentials` with the following command:

   ```bash
   git clone https://github.com/MicrosoftDocs/node-essentials
   ```

   Now you have a good starter project. The project contains the product files and some starter application code. All you need to do is to fill in the missing parts.

1. Let's inspect the repo you cloned. Type the following command to navigate to the files you need:

   ```bash
   cd node-essentials/nodejs-http/exercise-express-routing/reading-writing
   ```

   The outline of the directory should look like so:

   ```bash
   -| app.js
   -| client-get.js
   -| client-post.js
   -| client-put.js
   -| client-delete.js
   -| package.json
   ```

   The `package.json` file contains a dependency `express`. Type the following command in the terminal to install that:

   ```bash
   npm install
   ```

   `npm` reads from the `dependencies` section in our `package.json` and you should be ready to continue.

1. Time to inspect `app.js`. Open up said file. It should look like this:

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
   ```

   What you are getting above is a skeleton of a program. Your job is to implement the routes. You will do so by adding a little code and testing it out, method by method until you have a fully functional API. Let's begin.

1. First you will support reading from the API. Locate the part of the code looking like this:

   ```javascript
   app.get('/products', (req, res) => {
     // implement
   })
   ```

   Replace the above with this code:

   ```javascript
   app.get('/products', (req, res) => {
     res.json(products);
   })
   ```

   Let's verify that this code works by starting up the API with this command:

   ```bash
   node app.js
   ```

   In a separate terminal type:

   ```javascript
   node client-get.js
   ```

   That command should give you the following output:

   ```output
   Received data []
   Connection closed
   ```

    The API responds with an empty array because you haven't written any data to it yet. Lets change that up next.

1. Let' implement writing. Locate the part in the code looking like this:

   ```javascript
   app.post('/products', function(req, res) {
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

   Note how the above reads incoming data from `req.body` and constructs a JavaScript object from it. Next, it's added to the array `products`. Finally the new product is returned back to the user.

   Let's test out this code by first running the server program with the following command:

   ```bash
   node app.js
   ```

   In a separate terminal run this command:

   ```bash
   node client-post.js
   ```

   You should see an output like this:

   ```output
   response {"name":"product","id":1}
   Closed connection
   ```

   To verify that the data has been written to the API, enter the following command:

   ```bash
   node client-get.js
   ```

   You should see the following output:

   ```output
   Received data [{"name":"product","id":1}]
   Connection closed
   ```

   The above response tells you that when you ran `client-post.js` you successfully managed to write data to the API. By running `client-get.js`, you queried the API for data and it responded with the data you just wrote to it.

1. Next thing you want to implement is the ability to update your data. Locate the part of your code looking like this:

   ```javascript
   app.put('/products', function(req, res) {});
   ```

   Replace the above with the following code:

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

   What the above does is to locate the record in the `products` array that matches on the `id` property and update that record. Let's test out this code by starting the server application:

   ```bash
   node app.js
   ```

   In the other terminal run this command:

   ```bash
   node client-post.js
   ```

   This command will create a record. Next run this command to update the newly created record:

   ```bash
   node client-put.js
   ```

   You should see the following update in the terminal:

   ```output
   response {"name":"product-updated","id":1}
   Closed connection
   ```

   Let's verify that this update has worked by running this command as well:

   ```bash
   node client-get.js
   ```

   You should see this update:

   ```output
   Received data [{"name":"product-updated","id":1}]
   Connection closed
   ```

1. There's one thing left to do and that is to implement delete. Locate the part of the code that looks like this:

   ```javascript
   app.delete('/products/:id', function(req, res) {});
   ```

   Now replace it with this code:

   ```javascript
   app.delete('/products/:id', function(req, res) {
     const deletedProduct = products.find(p => p.id === +req.params.id);
     products = products.filter(p => p.id !== +req.params.id);
     res.json(deletedProduct);
   });
   ```

   The above code finds the product item to be deleted. Then it filters out that item from the `products` array and responds with a filtered version of `products`.

   Let's try out this code by starting the server application with this command:

   ```bash
   node app.js
   ```

   In a separate terminal, run this command to create a record:

   ```bash
   node client-post.js
   ```

   Now run this command to remove the record:

   ```bash
   node client-delete.js
   ```

   The above should give the following output:

   ```output
   Received data {"name":"product","id":1}
   Connection closed
   ```
  
   Verify by running this command:

   ```bash
   node client-get.js
   ```

   It should give this output:

   ```output
   Received data []
   Connection closed
   ```

Congratulations, you've managed to implement a resource `products` where you are able to do a full CRUD, that is **C**reate, **R**ead, **U**pdate, and **D**elete data.

1. Implementing *CRUD* for a resource is common thing to do. Express has a method `route()` meant just for this purpose. By using `route()` method, your code will be grouped so that it's easier to read. So let's replace all the code you have in `app.js` with this code:

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

1. Let's test out this new implementation. First restart the server with this command:

   ```bash
   node app.js
   ```

   In a separate terminal window run this command:

   ```bash
   node client-post.js
   ```

   Then run this command to delete the record:

   ```bash
   node client-delete-route.js
   ```

   Now run this command to verify that the record has been removed:

   ```bash
   node client-get.js
   ```

   You should see the following output:

   ```output
   Received data []
   Connection closed
   ```

   Note how you are using `client-delete-route.js` instead of `client-delete.js`. What's the difference? The difference lies in how the route is implemented. The first version of `app.js` relied on deletions being done towards a route like this `/products/<id>`, with the unique identifier being sent as a route parameter. When you use the `route()` method, it implements the deletion route differently and wants you to send unique identifier through the body instead of as a route parameter. There's no right or wrong way to implement a deletion route - you do you.

## Leverage route parameters and query parameters to limit response size

Data usually resides in a database or an endpoint. The size of that data can potentially be enormous. When a user then asks for all the data for a specific resource, that could be a huge response like thousands or even millions of records. A request like this can cause a massive strain on a database but it would also take a long time to serve that response. To avoid that scenario, it's considered good practice to *limit* the size of the response. A way to do that is by using route parameters so you can ask for specific records. Another way is to use query parameters to specify a subset of records. You will be taught both these techniques in this exercise.  

1. Clone the repo at URL with the following command (no need to this again if you completed the exercise above):

   ```bash
   git clone https://github.com/MicrosoftDocs/node-essentials
   ```

   Now you have a good starter project. The project contains the product files and some starter application code. All you need to do is to fill in the missing parts.

1. Let's inspect the repo you cloned. Type the following command:

   ```bash
   cd node-essentials/nodejs-http/exercise-express-routing/parameters
   ```

   The outline of the directory should look like so:

   ```bash
   -| app.js
   -| package.json
   -| package-lock.json
   ```

   The `package.json` file contains a dependency `express`. Type the following command in the terminal to install that:

   ```bash
   npm install
   ```

   `npm` reads from the `dependencies` section in our `package.json` and you should be ready to continue.

1. Time to inspect `app.js`. Open up said file. You should be seeing the following code:

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

   The above code contains an Express application. What you need to do is to implement two routes `/products/:id` and `/products`. The first route should only return a single product while the other one should return all products or as many products that are asked for by query parameters.

1. Implement the route `/products/:id` by replacing this code:

   ```javascript
   app.get("/products/:id", (req, res) => {});
   ```

   with this code:

   ```javascript
   app.get("/products/:id", (req, res) => {
     res.json(products.find(p => p.id === +req.params.id));
   });
   ```

1. Try running the app by typing the following command in the terminal:

   ```output
   node app.js
   ```

   Then navigate to `http://localhost:3000/products/1` in the Browser. You should now see the following output:

   ```bash
   {
     "id": 1,
     "name": "Ivanhoe",
     "author": "Sir Walter Scott"
   }
   ```

   Great, you implemented the route correctly. It's using the route parameter `id` to find a specific product.

1. Next, let's implement the route `/products`. Locate the following code:

   ```javascript
   app.get('/products', (req, res) => {})
   ```

   Replace it with this code:

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

1. Lets test out this code by first starting our app by typing the following command in the terminal:

   ```bash
   node app.js
   ```

1. Start up a Browser and navigate to `http://localhost:3000/products?page=1&pageSize=2`. You should see the following output in the browser:

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

   What you see is the first two records out of the total three. This response means the query parameters `page` and `pageSize` is working to filter down the response size. Change the URL to `http://localhost:3000/products?page=2&pageSize=2`. Now you've changed page from one to two. The response should now look like this:

   ```output
   [{
     "id": 3,
     "name": "The Bluest eye",
     "author": "Toni Morrison"
   }]
   ```

   As there are only three records in total, the second page should only contain one record so what you see is correct. Congrats you successfully applied query parameters and used that to limit the response.
