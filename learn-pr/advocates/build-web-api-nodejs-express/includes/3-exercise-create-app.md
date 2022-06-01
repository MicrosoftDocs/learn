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

   In the `dependencies` section, locate the `express` entry. This entry indicates the Express framework is installed.
   
  - Close the file.

1. Create a file named **app.js**, and add the following code:

   ```javascript
   const express = require('express');
   const app = express();
   const port = 3000;

   app.get('/', (req, res) => res.send('Hello World!'));
   app.listen(port, () => console.log(`Example app listening on port ${port}!`));
   ```

   The code creates an instance of an Express app by invoking the `express()` method.
  
   Notice how the code sets up a route to slash `/` with this syntax:

   ```javascript
   app.get('/', (req, res) => res.send('Hello World!'));
   ```

   Then, the code starts the web application by invoking the `listen()` method:

   ```javascript
   app.listen(port, () => console.log(`Example app listening on port ${port}!`));
   ```

1. Save your changes to the app.js file and close the file.

1. In the terminal, run the following command to start the web application:

   ```bash
   node app.js
   ```

   You should see the following output. This output means your app is up and running and ready to receive requests.

   ```output
   Example app listening on port 3000!
   ```

1. In a browser, go to `http://localhost:3000`. You should see the following output:
   
   ```output
   Hello World!
   ```

1. In the terminal, press Ctrl + C to stop the program.


## Create a web app that returns JSON data

Use the same app.js file you created to add a new route.

1. Open the app.js file and add the following code:

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

1. In the terminal, run the following command:

   ```bash
   node app.js
   ```

   You should see the following output:

   ```output
   Example app listening on port 3000!
   ```

1. Open a browser and go to `http://localhost:3000/products`. You should see the following output:

   ```output
   [
     {
       "id": 1,
       "name": "hammer"
     },
     {
       "id": 2,
       "name": "screwdriver"
     },
     {
      "id": 3,
      "name": "wrench"
     }
   ]
   ```

Congratulations! You implemented a second route that can serve up static content.
