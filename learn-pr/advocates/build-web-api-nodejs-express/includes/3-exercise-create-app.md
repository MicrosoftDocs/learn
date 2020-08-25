You've been tasked with creating a simple API using the framework Express. The online retailer wants to evaluate Express to see if it's easy to work with. As part of that evaluation, they want you to build a web application that serves different routes. 

## Create a basic web app with Express

Create a basic application that handles requests.

1. Create a file **app.js**.
1. Go to the terminal and enter **npm init -y**. This command creates a default **package.json** file for your Node.js project.
1. In the terminal enter **npm install express**. This command installs the Express framework.
1. Open the file **package.json**. In the **dependencies** section, there is an **express** entry. This entry means that Express framework is installed.
1. Add the following code to **app.js**:

   ```javascript
   const express = require('express');
   const app = express();
   const port = 3000;

   app.get('/', (req, res) => res.send('Hello World!'));
   app.listen(port, () => console.log(`Example app listening on port ${port}!`));
   ```

   The code creates an instance of an Express app by invoking **express()**.
   
   See how the code sets up a route to **/** with:

   ```javascript
   app.get('/', (req, res) => res.send('Hello World!'));
   ```

   Then, it starts the web application by invoking the **listen()** method:

   ```javascript
   app.listen(port, () => console.log(`Example app listening on port ${port}!`));
   ```

1. In the terminal, enter the following command to start the web application:

   ```bash
   node app.js
   ```

   You should see the following output. This output means your app is up and running and ready to receive requests.

   ```output
   Example app listening on port 3000!
   ```

1. Open a browser and go to **http://localhost:3000**. In the browser window, you should see the following text displayed **Hello World!**.
1. Select the **Ctrl**+**C** keys in the terminal to stop the program.

## Create a web app that returns JSON data

Use the same **app.js** file you created to add a new route.

1. Open the **app.js** file and add the following code to it:

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

1. Make sure the **app.js** file looks like this:

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

1. Save your changes and enter the following command in the terminal:

   ```javascript
   node app.js
   ```

   You should see the following output in the terminal:

   ```bash
   Example app listening on port 3000!
   ```

1. Open a browser and go to **http://localhost:3000/products**. The following should render:

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

   Congratulations! You've managed to implement a second route that can serve up static content.
