Tailwind Traders is very pleased with the routing app and wants to leverage Node.js for other parts of the business as well. The invoicing department wants to *digitize* invoice management and go from paper to using the Web. Your job is therefore to create a Web application capable of providing a form a user can enter data into and also have the entered data to be managed on the server side. This will be great proof of concept that you can later improve.

## Create and process forms

The application has two parts:

- A form where a user can enter data
- A route capable of receiving data submitted from the form

Now, let's build the application.

1. Clone the repo at URL with the following command:

   ```bash
   git clone <REPO url>
   ```

   Now you have a good starter project. The project contains the product files and some starter application code. All you need to do is to fill in the missing parts.

1. Let's inspect the repo you just cloned. Type the following:

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

   app.get('/', (req, res) => res.send('Hello API!'))
   app.get('/form', (req, res) => {
     // implement
   })
   app.post("/submit", (req, res) => {
     // implement
   });

   app.listen(port, () => console.log(`Example app listening on port ${port}!`))
   ```

1. You need to implement the `app.get('/form')`. This should render back a HTML form the user can fill data into. Locate that part of the code and replace:

   ```javascript
   app.get('/form', (req, res) => {
     // implement
   })
   ```

   With this:

   ```javascript
   app.get('/form', (req, res) => {
     res.type('html');
     res.send(`
      <html>
        <body>
          <form action="/submit" method="POST">
            <input type="text" name="name" />
            <button>Submit</button>
          </form>
        </body>
      </html>
     `)
   })
   ```

1. Start up the application at this point by typing the following command in the terminal:

   ```javascript
   node app.js
   ```

   Open up a browser and navigate to the URL `http://localhost:3000/form`. You should see the following being rendered:

   :::image type="content" source="../media/node-http-form.png" alt-text=" A Form":::

1. You need to setup and configure the library `body-parser`. This library will help you parse the incoming data from the form. Add the following code right after `const app = express()`:

   ```javascript
   var bodyParser = require('body-parser');
   app.use(bodyParser.urlencoded({ extended: false }));
   ```

   This will instruct Express to parse the incoming as URL encoded.

1. Now that you've setup your Express app to parse an incoming submission let's implement the route `/submit`. Replace the following code:

   ```javascript
   app.post('/submit', (req, res) => {
     // implement
   })
   ```

   With this:

   ```javascript
   app.post('/submit', function (req, res) {
     console.log('body', req.body);
     res.json(req.body);
   })
   ```

1. Start up your application by typing the following at the terminal:

   ```bash
   node app.js
   ```

   Open up a browser and navigate to `http://localhost:3000/form`. Fill in the form like so:

   :::image type="content" source="../media/node-http-form-filled-in.png" alt-text="Filled in form":::

   Now hit the `Submit` button. Note how the terminal now outputs something like this:

   ```output
   body [Object: null prototype] { name: 'test' }
   ```

   The browser should now render the following:

   ```output
   {
     "name": "test"
   }
   ```

Congrats, you've managed to create a form that users can interact with. Additionally you've configured an Express app to receive and parse a submitted form.
