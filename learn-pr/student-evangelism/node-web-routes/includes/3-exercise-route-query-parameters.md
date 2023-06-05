Data usually resides in a database or an endpoint. The size of the data can be enormous. When a user asks for all the data for a specific resource, the response can be thousands or even millions of records. A request like this can cause a massive strain on a database. It also takes a long time to serve the response.

To avoid that scenario, it's a good practice to limit the size of the response:

- Use route parameters to ask for specific records.
- Use query parameters to specify a subset of records.

This exercise teaches both techniques.

## Set up files in the repository

1. Clone the [node-essentials repo](https://github.com/MicrosoftDocs/node-essentials) by using the following command:

      ```bash
   git clone https://github.com/MicrosoftDocs/node-essentials
   ```

   This starter project contains the product files and some starter application code. All you need to do is to fill in the missing parts.

1. To inspect the repo that you cloned, run the following command:

   ```bash
   cd node-essentials/nodejs-http/exercise-express-routing/parameters
   ```

  The *parameters* directory should contain these files:

  - app.js
  - package.json
  - package-lock.json

1. The *package.json* file contains the dependency `express`. In the terminal, run the following command to install it:

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

   app.get('/', (req, res) => res.send('Hello API!'));

   app.get("/products/:id", (req, res) => {});

   app.get('/products', (req, res) => {});

   app.listen(port, () => console.log(`Example app listening on port ${port}!`));
   ```

   The *app.js* file shows a skeleton of a program. Your next job is to implement the routes.

## Implement two routes

The code contains an Express application. The next step is to implement two routes:

- `/products/:id`: This route should return a single product.
- `/products`: This route should return all products, or as many products that query parameters ask for.

1. To implement the route `/products/:id`, locate the following code in the *app.js* file in the *parameters* directory:

   ```javascript
   app.get("/products/:id", (req, res) => {});
   ```

   Replace it with this code:

   ```javascript
   app.get("/products/:id", (req, res) => {
     res.json(products.find(p => p.id === +req.params.id));
   });
   ```

1. In the terminal, run the following command to run the app:

   ```output
   node app.js
   ```

1. Open a browser and go to `http://localhost:3000/products/1`. You should see the following output:

   ```bash
   {
     "id": 1,
     "name": "Ivanhoe",
     "author": "Sir Walter Scott"
   }
   ```

   Congratulations! You implemented the route correctly. The app uses the route parameter `id` to find a specific product.

1. To implement the route `/products`, locate the following code:

   ```javascript
   app.get("/products", (req, res) => {});
   ```

   Replace it with this code:

   ```javascript
   app.get("/products", (req, res) => {
     const page = +req.query.page;
     const pageSize = +req.query.pageSize;
  
     if (page && pageSize) {
       const start = (page - 1) * pageSize;
       const end = start + pageSize;
       res.json(products.slice(start, end));
     } else {
       res.json(products);
     }
   });
   ```

1. In the terminal, run the following command to start the app and test the code:

   ```bash
   node app.js
   ```

1. Open a browser and go to `http://localhost:3000/products?page=1&pageSize=2`. You should see the following output in the browser:

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

   The response shows the first two of three records. This response means that the query parameters, `page` and `pageSize`, filtered down the response size.

1. Change the URL to `http://localhost:3000/products?page=2&pageSize=2` to change the number of pages from one to two. The response should look like this:

   ```output
   [{
     "id": 3,
     "name": "The Bluest eye",
     "author": "Toni Morrison"
   }]
   ```

   Because the code contains only three records, the second page should contain only one record. 
   
   You've now successfully applied query parameters to limit the response.
