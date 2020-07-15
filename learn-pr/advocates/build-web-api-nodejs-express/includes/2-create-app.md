Companies often have much data stored in many places like file systems or databases for example. A way to access that data is by serving it through web applications and APIs using HTTP. 

So what things are important things to consider when building web applications and APIs?

- **Routing**: routing is a concept in which your application is divided into different sections based on parts of the URL address.
- **Supporting different content types**: the data to serve up might exist in different formats such as plain text, JSON, HTML, CSV, and more.
- **Authentication/Authorization**: some data might be sensitive and might need the user to be logged in or even have a specific role or permission level to be able to access it.
- **Reading/Writing data**: users will most likely need to both display data as well as be able to add data to the system by, for example, enter data in a form or by uploading files.
- **Time to market**: the chosen tools and libraries to create web applications and APIs should include solutions to common problems to ensure the developer can spend as much time as possible on implementing business requirements.  

## HTTP module in Node.js

Node.js comes with a built-in http module. It's a fairly small module that is competent in handling most types of requests. It's able to work with important topics such as headers, the URL, and payloads being sent across.

The below classes help with managing a request from start to finish:

- **http.Server**: this object represents an instance of an HTTP Server. This object needs to be instructed to listen to different events on a specific port and address.
- **http.IncomingMessage**: this object is a readable stream created either by `http.Server` or `http.ClientRequest`. You can use it to access things such as status, headers, and data.
- **http.ServerResponse**: this object is a stream created internally by the HTTP Server. This class enables you to define what the response should look like in terms of what headers it should have, what the response should be, and so on.

## An example web application

Below is an example of what a web application can look like:

```javascript

const http = require('http');
const PORT = 3000;

const server = http.createServer((req, res) => {
  res.writeHead(200, {'Content-Type': 'text/plain'});
  res.end('hello world');
});

server.listen(PORT, () => {
  console.log(`listening on port ${PORT}`)
})
```

There are several interesting things that go on above:

1. **Creating the server**:  what you see above is how the call to `createServer()` creates an instance of `http.Server`.
1. **Implementing the callback**: the method `createServer()` expects a function, a so-called callback that when invoked is supplied with instances of `http.IncomingMessage`and `http.ServerResponse`, here they are called `res` and `req`.
   1. **The client request**: the `req` instance can then investigate what headers and data have been sent as part of the client's request.
   1. **The server response**: it's up to the server to construct a response by instructing the `res` object with what data and response headers it should answer back with.
1. **Start listening to requests**: the server created from the call to `createServer()` can then be listened to by invoking the method `listen()` while specifying a port. After calling `listen()`, the server is now ready to accept client requests.

## Streams

The way data is transported back and forth is by using something called streams. It means data is sent, chunk by chunk, from client to server and, chunk by chunk, from server to client. This approach is so the server is capable of handling many concurrent requests.

Streams are not a Node.js concept but rather an Operating system concept. The way *streaming* is implemented in the http module is by having classes that are streams. A stream is a fundamental data structure in Node.js that can read and write data and send and receive messages, or *events*.

The `req` and `res` parameters from the example you saw above are streams. Where you to listen to incoming data from a client request you would use the method `on()`, like so:

```javascript
req.on('data', (chunk) => {
  console.log('You received a chunk of data', chunk)
})
```

Conversely, the way data is sent back to the client is by data being placed in the response stream `res` by invoking the `end()` method like so:

```javascript
res.end('some data')
```

Streams are somewhat of a complicated topic and most web frameworks that sit on top of the http module tries to abstract away this concept. Which brings us to the next topic, the framework Express.

## Express

So far you've learned about the capabilities of the http module in Node.js. It's a perfectly valid choice for smaller web applications. As soon as applications grow large, comes the need to be able to architect your application in a scalable way. Sometimes a framework can help with architecture. Additionally, once you've built a few web applications you'll notice how you seem to solve the same problems over and over again. Problems like route management, authentication and authorization, error management, and more. When you come to this point, you start looking for a library or framework that addresses some or all of these problems.

Why should you go with Express as framework for your next app?

- **Great features**: Express has a set of features that makes you as a developer fast and productive
- **Abstracts away complexity**: Express abstracts away complicated concepts like Streams, for example, and thereby make the whole development experience a lot easier.
- **Solves common Web problems**: Express helps you with common problems such as route management, caching, redirection, and more.
- **Trusted by millions of developers**: according to GitHub, 6.8 million developers are currently using Express for their web applications. Such a significant number implies that there are many developers invested in its success.

### Route management in Express

When a client makes a request towards a web application they do so using a URL, an address that points to a specific server. A URL might look like this:

```bash
http://localhost:3000/products
```

The term `localhost` refers to your own machine but a more production looking URL might have switched out the term `localhost` for a domain name like `microsoft.com`. The end part of the URL is the route. It decides a specific place to go on the server, to `/products` in this case. Together with HTTP Verbs like POST, PUT, GET, and so on, the routes and the verbs constitute a way to understand, not only where to go, but what the client wants done. Each HTTP verb has a semantic meaning, an intention of what should happen to the data, should it be read or changed in some way. This topic will be covered more in detail later on in the module.

Express helps with registering routes and pairing these routes to appropriate HTTP verbs to make it simpler to organize the web application.

How does Express help us with route management and HTTP verbs? The Express framework has dedicated methods for handling both different HTTP Verbs but also a smart system for associating different routes with different pieces of your code. Consider the below code example:

```javascript
app.get('/products', (req, res) => {
  // handle the request
})
```

Note above how the `get()` method is used. Express helps you handle requests that are not only aimed towards a route with address `/products` but also with HTTP Verb GET. Express has dedicated methods for all HTTP Verbs. That means Express sees a POST towards `/products` as different from a GET towards `/products`, as shown in the below code example:

```javascript
app.get('/products', (req, res) => {
  // handle the request
})

app.post('/products', (req, res) => {
  // handle the request
})
```

`GET` means that a user wants to read data and `POST` that they want to write data. Dividing your app up so different route, verb pairings executes different pieces of code therefore makes sense.

## Serving different content types

Express comes with *batteries included* in the sense that it supports many different content formats to be returned back to a calling client. The Response object comes with a set of helper functions able to return different types of data. To return plain text, you would use the `send()` method like so:

```javascript
res.send('plain text')
```

For other types of data like JSON, there are dedicated methods that ensure the correct content type as well as data conversions are made. To return JSON, you would use the method `json()` like so:

```javascript
res.json({ id: 1, name: "Catcher in the Rye" })
```

This code above is equivalent to the following code, if we were using the http module over the Express module:

```javascript
res.writeHead(200, { 'Content-Type': 'application/json' });
res.end(JSON.stringify({ id: 1, name: "Catcher in the Rye" }))
```

Above the `Content-Type` header is set and the response is also converted from a JavaScript object to a *stringified* version before being returned back to the calling client. In conclusion, Express saves us a few lines of typing by creating this kind of helper methods for common types like JSON, HTML, and more.

## Create an Express application

To start developing a Node.js application using the Express framework, you need to install it as a dependency. It's also recommended that you first initialize a Node.js project so that any downloaded dependencies end up in the `package.json` file. It's a general recommendation for any apps developed for the Node.js runtime. The benefits of doing so comes when pushing the code to a repository like GitHub. Anyone fetching the code from GitHub could easily use the code you write by first installing its dependencies.  

### Steps

There are steps involved when creating a web application using the Express framework. Those steps are:

1. **Instantiate the app**: at this step, a web application instance is created. It's not runnable at this point, but you have something you can extend.
1. **Define routes and route handlers**: a route is a part of URL. For example, in the URL `http://localhost:8000/products`. The route part is the `/products`. Express has the concept of thinking in routes and the different routes should execute different pieces of code. At this step, you define what routes the application should listen to. Other examples of routes are  `/`, also known as the default route and `/orders`. Routes are a concept that will be explored further in the upcoming routes unit in this module.
1. **Configure middleware**: middleware is a piece of code that can run before or after a request. Additionally, it can be used to handle things like authentication/authorization or adding a capability to your app.
1. **Start the app**: to start the app, you define a port and instruct it to listen to that port. Now the app is ready to receive requests.
