Tailwind Traders have realized they need an application that has some basic level of security. It doesn't need to be anything fancy at this point just a way to differentiate between users that have access and don't have access. This security can be improved later to be more efficient and you could at later stage add more features like role management etc. For now, make it simple, make it work.

## Add basic authorization to an Express

Most applications have parts that it's ok for anyone to access but there are also parts that should be protected. There are different ways to accomplish this protection. You will implement a simple protection system to understand how the mechanism of *middleware* works in the Express framework.

1. Clone the repo at `https://github.com/MicrosoftDocs/node-essentials` with the following command:

   ```bash
   git clone https://github.com/MicrosoftDocs/node-essentials
   ```

   Now you have a good starter project. The project contains the product files and some starter application code. All you need to do is to fill in the missing parts.

1. Let's inspect the repo you cloned. Type the following command:

   ```bash
   cd node-essentials/nodejs-http/exercise-express-middleware
   ```

   The outline of the directory should look like so:

   ```bash
   -| app.js
   -| client.js
   -| package.json
   ```

   The `package.json` file contains a dependency `express`. Type the following command in the terminal to install that:

   ```bash
   npm install
   ```

   `npm` reads from the `dependencies` section in our `package.json` and you should be ready to continue.

1. Time to inspect `app.js`. Open up said file. You should see the following code:

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

   The above application contains a functioning Express application containing the routes `/`, `/users`, and, `/products`.

1. Open up the file `client.js`. It should look like this:

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

   What the above code does, is to connect to the address `http://localhost:3000/users` and then listen to different events `chunk`, `end`, and `close`. You will use the client to verify that the server application works as expected.

1. Run the server application by typing the following command in the terminal:

   ```bash
   node app.js
   ```

   Now run the client by typing the following command in a separate terminal window:

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

   The server application responds with some user data above. All the parts work. Now you need to protect this route. So let's look at adding some code on the server application.

1. Open up `app.js` and add the following code right after the row that says `const app = expres()`:

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

   Locate this part of the code:

   ```javascript
   app.get('/users', (req,res) => {
     res.json([{
       id: 1,
       name: 'User Userson'
     }])
    })
   ```

   And replace it with this code:

   ```javascript
   app.get('/users', isAuthorized, (req,res) => {
     res.json([{
       id: 1,
       name: 'User Userson'
     }])
    })
   ```

   Note how `isAuthorized` is added as the second argument.

1. Restart the `app.js` file by typing the following command in the terminal:

   ```bash
   node app.js
   ```

1. Now in the same terminal window as you ran the client before, type the following command:

   ```bash
   node client.js
   ```

   You should now see the following output:

   ```output
   connected
   chunk Not permitted
   No more data
   Closing connection
   ```

   This time around the middleware `isAuthorized()` is being invoked and is looking for an `authorization` header having a specific value. You didn't provide that as part of your request and that's why you get the response above. Next, let's add said `authorization` header.

1. Open up `client.js` and locate the part of the code looking like this:

   ```javascript
   headers: {}
   ```

   Change it to this code:

   ```javascript
   headers: {
     authorization: 'secretpassword'
   }
   ```

1. Run the client again by typing the following command in the terminal:

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

   The user data is now returned because you passed an `authorization` header with an accepted value.

Congrats you learned how to use the middleware construct in Express to add some rudimentary authorization to your Express app.

> [!CAUTION]
> Be mindful though that an authentication/authorization meant for real world usage needs to be a bit more robust than the above. It's worth looking up concepts such as OAuth, JSON Web Tokens, JWT and the library `bcrypt` to ensure your app has a decent level of protection.
