You've been tasked with creating a simple API using the framework Express. Tailwind Traders would like to evaluate Express and see if it's easy to work with. As part of that evaluation, they would like you to build a web application that serves different routes. 

## Create a basic Web app with Express

You will create a basic application that will be able to handle requests.

1. Create a file `app.js`.
1. Go to the terminal and enter `npm init -y`. This command will create a default `package.json` file for your Node.js project.
1. In the terminal type `npm install express`. This command installs the Express framework.
1. Open up the file `package.json` and note how the `dependencies` section now has an `express` entry. That means Express has been correctly installed.
1. Add the following code to `app.js`:

   ```javascript
   const express = require('express');
   const app = express();
   const port = 3000;

   app.get('/', (req, res) => res.send('Hello World!'));
   app.listen(port, () => console.log(`Example app listening on port ${port}!`));
   ```

   The code above creates an instance of an Express app by invoking `express()`. It also sets up a route to `/` with:

   ```javascript
   app.get('/', (req, res) => res.send('Hello World!'));
   ```

   Finally it starts up the web application by invoking the `listen()` method:

   ```javascript
   app.listen(port, () => console.log(`Example app listening on port ${port}!`));
   ```

1. Start up the web application by typing the following command in the terminal:

   ```bash
   node app.js
   ```

   You should see the following output:

   ```output
   Example app listening on port 3000!
   ```

   This output means your app is up and running and ready to receive requests.

1. Open up a browser and navigate to `http://localhost:3000`. In the browser window, you should now see the following text displayed `Hello World!`.
1. Type `Ctrl-C` in the terminal to stop the program.

## Create a Web App that returns JSON data

You will continue to work with the same `app.js` file and add a new route.

1. Open up `app.js` file and add the following code to it:

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
     ,
     {
       id: 3,
       name: "wrench",
     },
    ];

    res.json(products);
   });
   ```

   Ensure the `app.js` file looks like this:

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

1. Save your changes and type the following command in the terminal:

   ```javascript
   node app.js
   ```

   You should see the following output in the terminal:

   ```bash
   Example app listening on port 3000!
   ```

1. Open up your browser and navigate to `http://localhost:3000/products`. You should see something like this being rendered:

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

   Congrats! You've managed to implement a second route that is able to serve up static content.
