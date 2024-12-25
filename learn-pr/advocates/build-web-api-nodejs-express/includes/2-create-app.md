Companies often store a large amount of data in file systems and databases. They access that data by serving it through web applications from APIs by using HTTP.

## Web servers and web applications

A web server is a piece of software that responds to requests from clients. A web application sits on top of the web server. Some environments, like Node.js, provide both the web server and the web application in a framework. In this module, the web server is provided by the `HTTP` module. The web application is provided by the Express.js framework and includes the web server.

Learn more:

- **Web applications**: The application delivers a web app to the client:
  - Visually with HTML, CSS, and JavaScript
  - Data with APIs
  - Both visual and data with a combination of HTML, CSS, JavaScript, and APIs. This is considered a monolithic application.
- **URL Routing**: URL routing is a mechanism to provide functionality of the web server when a specific URL address is requested. For example, the URL `/products` might be associated with a function that returns a list of products. The URL `/products/1` might be associated with a function that returns a specific product.
- **HTTP Headers**: These are key-value pairs that are sent from the client to the server. They contain information about the request or response. 
    - **Support for different content types**: A client can request data in a specific format and may return in that format such as plain text, JSON, HTML, or CSV. 
    - **Authentication/Authorization**: Some data might be sensitive. A user might need to sign in or have a specific role or permission level to access the data. This is handled in the HTTP header.
- **Data exchange**: Users may need to view and add data to the system. To add data, users might enter data in a **form** or **upload** files.
- **Time to market**: To create web applications and APIs efficiently, choose tools and frameworks that provide solutions to common problems. These choices help the developer quickly meet the business requirements of the job.  

## HTTP module in Node.js

Node.js comes with a built-in HTTP module. It's a fairly small module that handles most types of requests. It supports common types of data like headers, the URL, and data.

The following code example is a simple web server that listens to incoming requests on port 3000. It responds with a simple text message `hello world` to the client, regardless of the URL route or HTTP headers used.

```javascript
// Include the HTTP module
const http = require('http');

// Set the port to 3000
const PORT = 3000;

// 1. Process incoming requests (req), reply with response (res)
const requestHandler = (req, res) => {

  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('hello world');
}

// 2. Create a server with the requestHandler
const server = http.createServer(requestHandler);

// 3. Start listening for incoming requests on port
server.listen(PORT, () => {
  console.log(`listening on port ${PORT}`)
})
```

This example configures the web application with the following steps:

1. **requestHandler**: The function reads the request (`req`) and determines what response (`res`) to send. 
1. **server**: The `createServer()` method is defined with the request handler. Because there is only one request handler, the server will always respond with the same response. In a real-world application, you would have multiple request handlers to handle different types of requests and different routes. This will be covered in more detail later.
1. **server.listen**: The `listen()` method is invoked with a specified port. After the call to the `listen()` method, the server is ready to accept client requests. When run locally, the app will be available on `http://localhost:3000`. The `console.log` statement is executed to let the developer know that the server is ready to use.

This Express.js code example uses multiple styles of functions: 

* callback in `server.listen(PORT string, callback_function)`
* [arrow function](https://developer.mozilla.org/en-US/docs/Web/JavaScript/Reference/Functions/Arrow_functions) in `requestHandler = (req, res) => {}` which has different scope rules than a regular function

## Express.js framework

So far you've learned about the capabilities of the HTTP module in Node.js. It's a perfectly valid choice for smaller web applications. If an application becomes large, a framework such as Express can help you build your architecture in a scalable way.  

After you've built a few web applications, you'll notice that you solve the same problems over and over again. Problems like route management, authentication and authorization, and error management are common. At this point, you start looking for a framework like Express that addresses some or all of these problems.

### Route management in Express

When a client makes a request to a web application, they use a URL, which is an address that points to a specific server. A URL might look like this:

```bash
http://localhost:3000/products
```

The term `localhost` in the URL refers to your own machine. A more production-looking URL might have switched out the term `localhost` for a domain name like `microsoft.com`. The end part of the URL is the *route*. It decides a specific logical place to go on the server. In this case, the route is `/products`.

The Express framework uses the URL, route, and *HTTP verbs* for route management. HTTP verbs like `post`, `put`, and `get` describe the action desired by the client. Each HTTP verb has a specific meaning for what should happen to the data. Express helps register routes and pair them to appropriate HTTP verbs to organize the web application. Express has dedicated methods for handling different HTTP verbs, and has a smart system to associate different routes with different pieces of your code. 

In the following example, Express helps you handle requests aimed toward a route with the address `/products` that is associated with the HTTP verb `get`:

```javascript
app.get('/products', (req, res) => {
  // handle the request
})
```

Express sees `app.get` for `/products` as different from `app.post` for `/products`, as shown in this next code example:

```javascript
app.get('/products', (req, res) => {
  // handle the request
})

app.post('/products', (req, res) => {
  // handle the request
})
```

The HTTP verb `get` means that a user wants to read data. The HTTP verb `post` means that they want to write data. Dividing up your app so that different route and verb pairings execute different pieces of code is common. This concept will be covered in more detail later.

## Serve different content types

Express supports many different content formats that can be returned back to a calling client. The `res` object comes with a set of helper functions to return different types of data. To return plain text, you would use the `send()` method like so:

```javascript
res.send('plain text')
```

For other types of data, like JSON, there are dedicated methods that ensure the correct content type and data conversions are made. To return JSON in Express, use the `json()` method, like this:

```javascript
res.json({ id: 1, name: "Catcher in the Rye" })
```

The previous Express code method is equivalent to this HTTP module code:

```javascript
res.writeHead(200, { 'Content-Type': 'application/json' });
res.end(JSON.stringify({ id: 1, name: "Catcher in the Rye" }))
```

The `Content-Type` header in HTTP is set and the response is also converted from a JavaScript object to a string before being returned back to the calling client.

Comparing the two code examples, you can see that Express saves a few lines of typing by using helper methods for common file types, like JSON and HTML.

## Create an Express application

To start developing a Node.js application using the Express framework, you need to install it as a dependency. It's also recommended that you first initialize a Node.js project so that any downloaded dependencies end up in the **package.json** file. It's a general recommendation for any apps developed for the Node.js runtime. The benefits of doing so come when pushing the code to a repository like GitHub. Anyone fetching the code from GitHub can easily use the code you write by first installing its dependencies.  

To create a web application with the Express framework, typical steps include:

1. **Create the web app**: Create a web application instance. At this point, the web server can't be run, but you have something you can extend.
1. **Define routes and route handlers**: Define what routes the application should listen to. Typical route management includes:
    * root route: '/'
    * feature routes: '/products'
    * catch-all route: '*'
1. **Configure middleware**: Middleware is a piece of code that can run before or after a request. Examples include authentication, data validation, and logging.
1. **Start the app**: Define a port, and then instruct the app to listen to that port. Now the app is ready to receive requests.
