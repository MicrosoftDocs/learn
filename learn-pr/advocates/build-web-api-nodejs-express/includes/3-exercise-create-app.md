You've been tasked with creating a simple API using the framework Express. The online retailer wants to evaluate Express to see if it's easy to work with. As part of that evaluation, they want you to build a web application that serves different routes. 

## Create a basic web app with Express

Create a basic application that handles requests.

1. Open a terminal, and enter the following commands:

   ```bash
   npm init -y
   npm install express

   ```
   
   The `init` command creates a default **package.json** file for your Node.js project. The `install` command installs the Express framework.

1. In a code editor, open the package.json file.

   In the `dependencies` section, locate the `express` entry:
   
   ```bash
   "dependencies": {
     "express": "^4.18.1"
   ```
  
   This entry indicates the Express framework is installed.
   
   - Close the file.

1. In a code editor, create a file named **app.js**, and add the following code:

   ```javascript
   const express = require('express');
   const app = express();
   const port = 3000;

   app.get('/', (req, res) => res.send('Hello World!'));

   app.listen(port, () => console.log(`Example app listening on port ${port}!`));
   ```

   The code creates an instance of an Express application by invoking the `express()` method.
  
   Notice how the code sets up a route to slash `/` with the syntax:
   
   > `app.get('/', (req, res) => res.send('Hello World!'));`

   After setting up the route, the code starts the web application by invoking the `listen()` method:

   > `app.listen(port, () => console.log(`Example app listening on port ${port}!`));`

1. Save your changes to the app.js file and close the file.

1. In the terminal, run the following command to start the Express web application:

   ```bash
   node app.js
   ```

   You should see the following output:

   ```output
   Example app listening on port 3000!
   ```

   This output means your app is up and running and ready to receive requests.

1. In a browser, go to `http://localhost:3000`. You should see the following output:
   
   ```output
   Hello World!
   ```

1. In the terminal, press Ctrl + C to stop the web Express program.


## Create a web app that returns JSON data

Use the same app.js file to add a new route.

1. In a code editor, open the app.js file. Add the following code after the existing `app.get` syntax:

   ```javascript
   app.get("/products", (req,res) => {
     const products = [
     {
       id: 1,
       name: "hammer",
     },
     {
       id: 2,
       name: "screwdriver",
     },
     {
       id: 3,
       name: "wrench",
     },
    ];

    res.json(products);
   });

   ```

1. Make sure your app.js file looks like this example:

   ```javascript
   const express = require("express");
   const app = express();
   const port = 3000;

   app.get("/", (req, res) => res.send("Hello World!"));

   app.get("/products", (req,res) => {
      const products = [
        {
          id: 1,
          name: "hammer",
        },
        {
          id: 2,
          name: "screwdriver",
        },
        ,
        {
          id: 3,
          name: "wrench",
        },
      ];

     res.json(products);
   })

   app.listen(port, () => console.log(`Example app listening on port ${port}!`));
   ```

1. Save your changes to the app.js file and close the file.

1. In the terminal, run the following command to restart the web Express app:

   ```bash
   node app.js
   ```

   You should see the following output:

   ```output
   Example app listening on port 3000!
   ```

1. In a browser, go to `http://localhost:3000/products`. You should see the following output:

   ```output
   [{"id":1,"name":"hammer"},{"id":2,"name":"screwdriver"},{"id":3,"name":"wrench"}]
   ```

1. In the terminal, press Ctrl + C to stop the web Express program.

Congratulations! You implemented a second route that can serve up static content.
