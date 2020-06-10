Tailwind Traders are impressed with your first Web Application and want you to improve it. So far you've been serving up all the data without thinking about the size of the data you serve. Imagine this static data instead is served up from a Database. A database could contain millions of records and you need to take into account. The below teaches you some techniques on limiting the size of your response.

## Leverage route parameters and query parameters to limit response size

Data usually resides in a database or an endpoint. The size of that data can potentially be enormous. When a user then asks for all the data for a specific resource that could be a huge response like thousands or even millions of records. This can cause a massive strain on a database but it would also take a long time to serve that response. To avoid that scenario, it's considered good practice to *limit* the size of the response. A way to do that is by using route parameters so you can ask for specific records. Another way is to use query parameters to specify a subset of records. You will be taught both these techniques in this exercise.  

1. Clone the repo at URL with the following command:

   ```bash
   git clone <REPO url>
   ```

   Now you have a good starter project. The project contains the product files and some starter application code. All you need to do is to fill in the missing parts.

1. Let's inspect the repo you cloned. Type the following:

   ```bash
   cd <repo dir>
   ```

   The outline of the directory should look like so:

   ```bash
   -| app.js
   -| package.json
   ```

   The `package.json` file contains a dependency `express`. Type the following command in the terminal to install that:

   ```bash
   npm install
   ```

   `npm` reads from the `dependencies` section in our `package.json` and you should be ready to continue.

1. Time to inspect `app.js`. Open up said file. You should be seeing the following:

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

1. Let's test this out by first starting our app by typing the following command in the terminal:

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

   What you see is the first two records out of the total three. This means the query parameters `page` and `pageSize` is working to filter down the response size. Change the URL to `http://localhost:3000/products?page=2&pageSize=2`. Now you've changed page from one to two. The response should now look like this:

   ```output
   [{
     "id": 3,
     "name": "The Bluest eye",
     "author": "Toni Morrison"
   }]
   ```

   As there are only three records in total, the second page should only contain one record so what you see is correct. Congrats you successfully applied query parameters and used that to limit the response.
