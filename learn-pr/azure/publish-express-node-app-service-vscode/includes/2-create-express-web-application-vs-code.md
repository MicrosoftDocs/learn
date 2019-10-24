The combination of Node.js and Express.js provides a framework that JavaScript developers can use to build custom webapps.

Suppose the launch date for your new video game is imminent and you still don't have the marketing website up and running. You want to know how your team of JavaScript developers can create that site as fast as possible. You've heard about Node.js and you want to find out if it will help you deliver a site quickly.

Here, you'll learn about Node.js and Express.js and how to use them on development computers, servers, and Azure App Service.

## What is Node.js?

JavaScript is a language that became popular for adding client-side interaction to webpages because it's supported by many browsers. If you incorporate JavaScript into HTML pages, you can use it to do things like animations, which are not possible with HTML itself. Many developers became familiar with JavaScript in this context. 

What if you want to run JavaScript outside of the browser? Node.js is a runtime environment that you can use for this purpose. It's a popular way, for example, to create command-line tools written in JavaScript and that run without the need for a browser. 

In a webapp, you can use Node.js to run the server-side code. That approach enables you to use JavaScript for all the code in the webapp - both on the server and in the client browser. You don't have to learn an alternative language, such as PHP or C#. If you have a team of developers who already know JavaScript, this architecture can save you a large investment in training.

Node.js is open-source, free to use, and runs on many operating systems, including Windows, Linux, and macOS.

Node.js runs all its code asynchronously, which means that long-running requests don't block execution for other tasks. For example, if a user has requested a webpage that takes a long time to render, other users can request and receive other webpages while the original user is waiting. 

## What is Express.js?

With Node.js alone, you could build an entire web app. However, it would take much work and would replicate what many developers have already done. If you want to build a Node.js web server quickly and with minimal custom code, you can install Express.js. 

Express.js includes functions that make it easy to intercept HTTP requests, such as GET, POST, and DELETE requests, and then route them to code that formulates responses. It also implements an HTTP server on your local machine, which you can start when you want to try out your code. 

For example, a version of **Hello World** in Express.js might look like this:

```JavaScript
var express = require('express')
var app = express()

app.get('/', (req, res) => res.send('Hello World!'))
 
app.listen(3000) 
```

In this code, Express.js is initiated and then the `app.get()` method is called to intercept any GET requests and respond with the "Hello World!" message. The last line configures the app to listen for requests on port 3000. 

You can create web pages by formulating more complex HTML than "Hello World!" in this above code. However, most developers use a templating engine such as Pug (which used to be known as Jade). Templates are HTML files with extra placeholders. The engine makes it easy to insert values, such as data from a database, into the HTML to create dynamic pages.

When you want to create a skeleton webapp in Express.js, as a starting point for a customized site, you can use the Express Generator tool. With this command, you specify a templating engine and whether to support `git` and stylesheets. It creates a default set of views, routes, styles, and other infrastructure.

## Installing Node.js for development or hosting

If you're building a Node.js application, you'll need to install it on your development machine and servers that will host the application for testing, staging, and production. The method of installation depends on the platform you use. For Windows computers, you can download and run a .msi file. In Linux, you can use your prefer package manager tool, such as `apt` in Ubuntu or `yum` in Red Hat:

```bash
sudo apt-get update
sudo apt-get install nodejs
```

In Azure, you can use a virtual machine to host a Node.js application. Choose an image from the gallery that includes Node.js, or install it in the same way that you did on your development machine.

Alternatively, consider hosting the webapp in Azure App Service, which is a Platform-as-a-Service (PaaS) web host that you can use to service websites and web APIs. An instance of Azure App Service includes Node.js by default and you don't have to perform any installation on it. You'll use the App Service later in this module.

## Installing Express.js

Express.js is a Node.js package, so you can install it by using Node's `npm` package manager tool. 

Change to the app's root folder and then run these commands:

```bash
npm init
npm install express --save
```

## Use Express Generator to create a webapp scaffold

Once Express.js is installed in an app, you can use the Express Generator to create the scaffolding for the app. In Node.js version 8.2.0 and later, you can use the `npx` package runner to execute this task:

```bash
npx express-generator --pug --css
```

This example includes both the **pug** templating engine, and support for **css** stylesheets. For earlier versions of Node.js, use these commands instead:

```bash
npm install -g express-generator
express --pug --css
```

Once the generator has completed, you'll see a default set of files in your webapp, including views, routes, stylesheets, and the **app.js** entry point.