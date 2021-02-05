The online retailer needs their application to have some basic security. At this point, it needs to differentiate between users that have access, and those that don't. Other features, like role management, might be added at a later date.

## Add basic authorization to an Express framework

Most applications have parts that anyone can access. But, some parts need to be protected. There are different ways to protect an application. In this exercise, implement a simple protection system to understand how the mechanism of *middleware* works in the Express framework.

1. Clone the repo at **https://github.com/MicrosoftDocs/node-essentials** with the following command:

   ```bash
   git clone https://github.com/MicrosoftDocs/node-essentials
   ```

   This starter project contains the product files and some starter application code. All you need to do is to fill in the missing parts.

1. To inspect the repo you cloned, enter the following command:

   ```bash
   cd node-essentials/nodejs-http/exercise-express-middleware
   ```

   The outline of the directory should look like so:

   ```bash
   -| app.js
   -| client.js
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

   app.get('/', (req, res) => res.send('Hello World!'))

   app.get('/users', (req,res) => {
     res.json([{
       id: 1,
       name: 'User Userson'
     }])
   })

   app.get('/products', (req, res) => {
     res.json([{
       id: 1,
       name: 'The Bluest Eye'
     }])
   })

   app.listen(port, () => console.log(`Example app listening on port ${port}!`))
   ```

   The code contains a functioning Express application containing the routes **/**, **/users**, and **/products**.

1. Open the file **client.js**. It should look like this:

   ```javascript
   const http = require('http');

   http.get({
     port: 3000,
     hostname: 'localhost',
     path: '/users',
     headers: {}
   }, (res) => {
     console.log("connected");
     res.on("data", (chunk) => {
       console.log("chunk", "" + chunk);
     });
     res.on("end", () => {
       console.log("No more data");
     });
     res.on("close", () => {
       console.log("Closing connection");
     });
   });
   ```

   The code connects to the address **http://localhost:3000/users**, and then listens to different events: **chunk**, **end**, and **close**. Use the client to verify that the server application works as expected.

1. In the terminal, run the server application by entering the following command:

   ```bash
   node app.js
   ```

1. In a separate terminal window, run the client by entering this command:

   ```bash
   node client.js
   ```

   You should see the following output from the client:

   ```output
   connected
   chunk [{"id":1,"name":"User Userson"}]
   No more data
   Closing connection
   ```

   The server application responds with some user data. All the parts work. To protect this route, add some code on the server application.

1. Open **app.js**. After the row that says **const app = expres()**, add the following code:

   ```javascript
   function isAuthorized(req,res, next) {
     const auth = req.headers.authorization;
     if (auth === 'secretpassword') {
       next();
     } else {
       res.status(401);
       res.send('Not permitted');
     }
   }
   ```

1. Locate this part of the code:

   ```javascript
   app.get('/users', (req,res) => {
     res.json([{
       id: 1,
       name: 'User Userson'
     }])
    })
   ```

1. Replace that code with this code:

   ```javascript
   app.get('/users', isAuthorized, (req,res) => {
     res.json([{
       id: 1,
       name: 'User Userson'
     }])
    })
   ```

   In the code, **isAuthorized** is added as the second argument.

1. In the terminal, enter the following command to restart the **app.js** file:

   ```bash
   node app.js
   ```

1. In the terminal window where you previously ran the client, enter the following command:

   ```bash
   node client.js
   ```

   You should see the following output:

   ```output
   connected
   chunk Not permitted
   No more data
   Closing connection
   ```

   This time, the middleware **isAuthorized()** is invoked and looks for an **authorization** header that has a specific value. Because you didn't provide a value as part of your request, the code didn't respond with user data. Add an **authorization** header next.

1. Open **client.js** and locate the part of the code that looks like this:

   ```javascript
   headers: {}
   ```

1. Change it to this code:

   ```javascript
   headers: {
     authorization: 'secretpassword'
   }
   ```

1. In the terminal, enter the following command to run the client again:

   ```bash
   node client.js
   ```

   You should now see the following output:

   ```output
   connected
   chunk [{"id":1,"name":"User Userson"}]
   No more data
   Closing connection
   ```

   The user data is returned because you passed an **authorization** header with an accepted value.

Congratulations, you learned how to use the middleware construct in Express to add some basic authorization to your Express app.

> [!CAUTION]
> Be aware that an authentication/authorization meant for real world usee needs to be a bit more robust than our example. It's worth looking up concepts such as OAuth, JSON Web Tokens, JWT and the library **bcrypt** to make sure your app has a decent level of protection.
