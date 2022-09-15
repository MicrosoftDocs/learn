
You can build a web application using various programming languages such Node, .NET, PHP, Java and Python, but in the eCommerce organization scenario, you're launching a new Node web application. 

Here, you'll learn Node.js concepts that will enable you to build the Node.js web application.

## What is Node.js?

Node.js is an open-source, server-side JavaScript runtime environment. You use Node.js to run JavaScript applications and code in many places outside of a browser, such as on a server. When building web applications, you'll often use Node.js based web frameworks. One such framework is ExpressJS. Express is a minimal and flexible Node.js web application framework that provides a robust set of features for web applications. It does so without obscuring Node.js features.

## How to create a Node.js project

To create your Node.js app, you start with a folder, and then you can create the app using a terminal window.

You start by configuring the **package.json** file inside the folder. Use `npm init -y` command to create the **package.json** file. This file contains metadata that you use to describe your application to the Node.js runtime. Here's an example:

```json
{
  "name": "auth-app",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [],
  "author": "",
  "license": "ISC"
}
```

You can edit the file to change the **name** of your app or add a better **description** for your app. If the JavaScript file that will hold your application code has a different name, you can replace **index.js** in the **main** property with it. You need to create this file inside the application folder.

## Node.js packages

Node.js comes with many core libraries to use in building your application. However, there's a huge ecosystem of third-party libraries. You use npm, a package manager, to easily install and use the libraries in your application.

To install a library, you run `npm install <name of package>` command, where `<name of package>` is the name of your package. For example, to install ExpressJS, you run `npm install express`. After you install the package, it's listed in the **dependencies** section of your package.json file. Here's an example:

```json
{
  "name": "auth-app",
  "version": "1.0.0",
  "description": "",
  "main": "index.js",
  "scripts": {
    "test": "echo \"Error: no test specified\" && exit 1"
  },
  "keywords": [],
  "author": "",
  "license": "ISC",
  "dependencies": {
    "express": "^4.18.1"
  }
}
```

## Express routing

Routing refers to how your application URIs respond to client's HTTP requests. ExpressJS defines application routes using the HTTP verbs such as GET and POST. The following example shows how you create an express instance and then use it to create a basic route:

```javascript
    const express = require('express')
    //create express instance    
    const app = express()
    
    // respond with "hello world" when a GET request is made to the homepage
    app.get('/', (req, res) => {
      res.send('hello world')
    })

    // POST method route
    app.post('/', (req, res) => {
      res.send('POST request to the homepage')
    })

    // POST method route matching '/callback'
    app.post('/callback', (req, res) => {
      res.send('POST request to callback URI')
    })
```

From the example, you can see that route definition takes the following structure:

```javascript
    app.METHOD(PATH, HANDLER)
```

Where:

* **app** is an express instance.
* **METHOD** is an HTTP request method, in lowercase.
* **PATH** is a path on the server.
* **HANDLER** is the function to be executed when the route is matched.



## HandleBars templating language

Handlebars is a templating engine. You use it to build your app's UI components. A templating engine takes a static HTML file, fills it with the data on the server side, and then sends it as an ordinary HTML file to the client such as a browser. To use handlebars in express, you need to store HTML code into a `.hbs` extension in the `views` folder in the source directory as HandleBars looks for the files in the views folder.

To start using Handlebars for express, you need to install the handlebars package. In your terminal, run `npm install express-handlebars` command to install Handlebars fo express.  

Handlebars uses `{{some content here}}`expressions to add data into the HTML. To insert a control structure, you proceed `#` to the name of the control structure or helper and it requires a matching closing `/` of the same name. Here's an example:

```html
      {{#if message}}
          <h5>{{message}}</h5>
      {{else}}
           <h5>Say something else</h5>
      {{/if}}
```

However, if you want to insert HTML and make it remain intact, use the `{{{}}}` token. HandleBars uses this syntax to implement layouts. Here's how it works:

1. Create a folder `views` with a subdirectory `layouts` inside your project folder.

1. Inside the `layouts` subfolder, create a file called `main.hbs`. The `main.hbs` file is your default layout and it contains any HTML code that's required throughout your application.

1. Add your HTML code into the `main.hbs` file and include the `{{{body}}}` token where HTML for UI that changes from one view to another. *Body* is a reserved word for handlebars. If you've a HandleBars file inside `view` folder, such as `signin.hbs` and you want to view it as shown below, HandleBars searches for `{{{body}}}` within `main.hbs` and replaces it with content of `signin.hbs`.

```javascript
    app.get('/', (req, res) => {
      res.send(signin)
    })
```

## Run a Node express application

To run an express application, you use the `node` command from the terminal window or Visual Studio Code terminal. For example, to run a file named `index.js`, run `node index.js`.

When you run your express application, you want the express server to listen to incoming http requests. For example, if you want your express server to listen on port `3000`, you need to add the following line to your JavaScript file:

```javascript
    app.listen(3000, () => {
        //Do something when the server starts successfully.
    });
```