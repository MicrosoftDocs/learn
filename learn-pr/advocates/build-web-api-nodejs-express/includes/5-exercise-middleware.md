The online retailer needs their application to have some basic security. The app should differentiate between registered customers who have access, and other users who shouldn't have access. Other features, like role management, might be added at a later date.

## Add basic authorization to an Express framework

Most applications have parts that anyone can access. But, some parts need to be protected. There are different ways to protect an application. In this exercise, implement a simple protection system to understand how the mechanism of *middleware* works in the Express framework.

1. In a terminal, clone the sample repo for this example by running the following command:

   ```bash
   git clone https://github.com/MicrosoftDocs/node-essentials
   ```

   This example project contains the product files and some starter application code. All you need to do is to fill in the missing parts.

1. To inspect the cloned repo, run the following command:

   ```bash
   cd node-essentials/nodejs-http/exercise-express-middleware
   ```

   The structure of the directory should look like this:

   ```output
   -| app.js
   -| client.js
   -| package.json
   ```

1. The **package.json** file contains a dependency named `express`. Run the following command to install the dependency:

   ```bash
   npm install
   ```

   `npm` reads from the `dependencies` section in the package.json file and installs the required packages.

1. In a code editor, open the **app.js** file and inspect the contents:

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

   The code contains a functioning Express application with the routes slash `/`, `/users`, and `/products`.

   Close the file.

1. In a code editor, open the **client.js** file and inspect the contents:

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

   The code connects to the address `http://localhost:3000/users`, and listens to different events: `data`, `end`, and `close`.
   
   1. Use the client to verify that the server application works as expected.

   1. Close the file.

1. In the terminal, run the server application by entering this command:

   ```bash
   node app.js
   ```

1. In a **second** terminal window, run the client by entering this command:

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

   The server application responds with some user data. All the parts work.
   
   To protect this route, we'll add some code on the server application.

1. Open the app.js file again. Locate the row with the `const app = express()` statement. After this row, add the following code:

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

1. Next, locate this section of code in the file:

   ```javascript
   app.get('/users', (req,res) => {
     res.json([{
       id: 1,
       name: 'User Userson'
     }])
    })
   ```

1. Replace this section with the following code:

   ```javascript
   app.get('/users', isAuthorized, (req,res) => {
     res.json([{
       id: 1,
       name: 'User Userson'
     }])
    })
   ```

   In this code, the `isAuthorized` middleware is added as the second argument.

1. In the **first** terminal, run the following command to restart the app.js file:

   ```bash
   node app.js
   ```

1. In the **second** terminal where you ran the client, run the following command:

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

   This time, the `isAuthorized()` middleware is invoked and looks for an `authorization` header that has a specific value. Because you didn't provide a value as part of your request, the code didn't respond with user data.
   
   We need to add an `authorization` header next.

1. Open the client.js file again, and locate this section of code:

   ```javascript
   headers: {}
   ```

1. Replace this section with the following code:

   ```javascript
   headers: {
     authorization: 'secretpassword'
   }
   ```

1. In the **second** terminal, run the following command to run the client again:

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

   The user data is returned because you passed an `authorization` header with an accepted value.

Congratulations! You learned how to use the middleware construct in Express to add some basic authorization to your Express app.

> [!CAUTION]
> Be aware that an authentication/authorization meant for real world use needs to be a bit more robust than our example. It's worth looking up concepts such as OAuth, JSON Web Tokens, JWT and the library **bcrypt** to make sure your app has a decent level of protection.
