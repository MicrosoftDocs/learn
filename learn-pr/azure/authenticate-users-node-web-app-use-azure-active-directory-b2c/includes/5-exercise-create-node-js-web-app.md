Now that you've understood the important Node.js concepts that you need to create a web app, here, you'll build the Node.js web application.

## Create a Node project

1. Create a folder in any location on your computer, such as `auth-app`, to hold your Node web app.

1. Start Visual Studio Code (VS Code) editor, and use it to open the Node web app folder you created, such as `auth-app`.

1. From your VS Code editor terminal, run `npm init -y` command. This command creates a default package.json file for your Node.js project.

## Install app dependencies

From your VS Code editor terminal, run the following commands:

```text
npm install express
npm install dotenv
npm install express-handlebars
npm install express-session
```

Apart from  `express` and `express-handlebars` that we explained earlier, the commands install two other packages:

* `dotenv`- loads environment variables from a `.env` file into `process.env`, so that you keep app configurations in an environment separate from code.

* `express-session` - implements user sessions in Node express framework.

## Add app UI components

The Node web app uses HandleBars to implement the UI components.

Use the following steps to build the web app's UI:

1. In the `auth-app` folder, create `views` folder. The `views` folder will hold Handlebars files for the app's UI elements.

1. In the `views` folder, create `layouts` folder and `signin.hbs` file. In the `layouts` create `main.hbs` file.

1. In VS Code, open the `main.hbs` file, and add the following code:

    ```html
    <!DOCTYPE html>
    <html lang="en">
      <head>
        <meta charset="UTF-8">
        <meta name="viewport" content="width=device-width, initial-scale=1.0, shrink-to-fit=no">
        <title>Tutorial | Authenticate users with MSAL for B2C</title>
    
        <!-- adding Bootstrap 4 for UI components  -->
        <!-- CSS only -->
        <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.1.3/dist/css/bootstrap.min.css" rel="stylesheet" integrity="sha384-1BmE4kWBq78iYhFldvKuhfTAU6auU8tT94WrHftjDbrCEXSU1oBoqyl2QvZ6jIW3" crossorigin="anonymous">
        <link rel="SHORTCUT ICON" href="https://c.s-microsoft.com/favicon.ico?v2" type="image/x-icon">
      </head>
      <body>
        <nav class="navbar navbar-expand-lg navbar-dark bg-primary">
          <a class="navbar-brand" href="/">Microsoft Identity Platform</a>
            {{#if showSignInButton}}
                <div class="ml-auto">
                    <a type="button" id="SignIn" class="btn btn-secondary" href="/signin" aria-haspopup="true" aria-expanded="false">
                        Sign in
                    </a>
                </div>
            {{else}}
                    <p class="navbar-brand d-flex ms-auto">Hi {{givenName}}</p>
    
                    <a class="navbar-brand d-flex ms-auto" href="/signout">Sign out</a>
            {{/if}}
        </nav>
        <br>
        <h5 class="card-header text-center">MSAL Node Confidential Client application with Auth Code Flow</h5>
        <br>
        <div class="row" style="margin:auto" >
          {{{body}}}
        </div>
        <br>
        <br>
      </body>
    </html>
    ```

    The `main.hbs` file implements the UI built with the Bootstrap 5 CSS framework. We use `showSignInButton` boolean variable to control what a user sees when they sign in or sign out, but this feature will be clear once we add authentication to the web app.

1. In VS Code, open the `signin.hbs` file, and add the following code:

    ```html
    <div class="col-md-3" style="margin:auto">
      <div class="card text-center">
        <div class="card-body">
          {{#if showSignInButton}}
              <h5 class="card-title">Please sign in to acquire an ID token</h5>
          {{else}}
               <h5 class="card-title">You have signed in</h5>
          {{/if}}
        </div>
      </div>
    </div>
    ```

## Add environment variables

To keep app configurations, which can change from one environment to another, we separate them from the application's source code, so we put it in a separate file:

1. In the `auth-app` folder, create `.env` file.

1. In VS Code, open the `.env` file, and add the following code:

```text
#HTTP port
SERVER_PORT=3000
#session secret
#This is the secret used to sign the session ID cookie
SESSION_SECRET=sessionSecretHere
```

## Configure express server

1. In the `auth-app` folder, create `index.js` file.

1. In VS Code, open the `index.js` file, add the following code:

```javascript
    /*
     * Copyright (c) Microsoft Corporation. All rights reserved.
     * Licensed under the MIT License.
     */    
    require('dotenv').config();
    const express = require('express');
    const session = require('express-session');
    const {engine}  = require('express-handlebars');
      
    /**
     * Using express-session middleware. Be sure to familiarize yourself with available options
     * and set them as desired. Visit: https://www.npmjs.com/package/express-session
     */
     const sessionConfig = {
        secret: process.env.SESSION_SECRET,
        resave: false,
        saveUninitialized: false,
        cookie: {
            secure: false, // set this to true in production
        }
    }
     
    //Create an express instance
    const app = express();
    
    //Set handlebars as your view engine
    app.engine('.hbs', engine({extname: '.hbs'}));
    app.set('view engine', '.hbs');
    app.set("views", "./views");
    
    //usse session configuration 
    app.use(session(sessionConfig));
    
     app.get('/', (req, res) => {
        res.render('signin', { showSignInButton: true });
    });
    
    app.get('/signin',(req, res)=>{
        res.send('We haven\'t configure authentication!');
    });
    
    /**
     * Sign out end point
    */
    app.get('/signout',async (req, res)=>{    
        //TODO
    });
    
    app.get('/redirect',(req, res)=>{
        //TODO
    });
    
    //start app server to listen on set port
    
    app.listen(process.env.SERVER_PORT, () => {
        console.log(`App listening on port !` + process.env.SERVER_PORT);
    });
```

In the `index.js` file, we've added the following code components:

* Import `dotenv`, `express`, `express-sessions` and `express-handlebars` Node packages.

* Configure HandleBars templating engine. HandleBars files will use `.hbs` extension.

* Add the `/` express route, which is the entry point to the application. It sends the `signin.hbs` file and `showSignInButton` boolean variable to the view. The rest of the express routes will be implemented later when we add authentication to the web app.

* Start the express server to listen on the port number specified in the `.env` file.

At this point, your project should've a directory structure like the one shown below:

```text
    auth-app/
    ├── index.js
    └── package.json
    └── .env
    └── views/
        └── layouts/
            └── main.hbs
        └── signin.hbs
```

## Run Node web app

At this point, we can start our express server and access the web app in the browser:

1. From your VS Code terminal, run `node index.js` command to start the express server.

1. In your browser, go to http://localhost:3000. You should see the page with a **Sign in** button:

    :::image type="content" source="../media/tutorial-login-page.png" alt-text="Screenshot of a Node web app sign in page.":::

At the moment, the web app can't authenticate users, so if you select **Sign in** button, you see a message, **We haven't configured authentication!** In the next unit, we'll configure the web app to authenticate users.