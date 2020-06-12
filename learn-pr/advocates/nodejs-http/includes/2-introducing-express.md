Node.js comes with a built-in http module. It's a fairly small module that is competent in handling most types of requests. It's able to work with important topics such as headers, the URL, and payloads being sent across.

The below classes help with managing a request from start to finish:

- **http.Server**, this represents an instance of an HTTP Server. This is what we will work with most to start listening to different events on a specific port and address.
- **http.IncomingMessage**, this is a readable stream created either by `http.Server` or `http.ClientRequest`. You can use it to access things such as status, headers, and data.
- **http.ServerResponse**, this is a stream created internally by the HTTP Server. This class enables you to define what the response should look like in terms of what headers it should have, what the response should be and so on.

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

There are several interesting things that goes on above:

1. **Creating the server**,  What you see above is how the call to `createServer()` creates an instance of `http.Server`.
1. **Implementing the callback**, the method `createServer()` expects a method, a so called callback that when invoked is supplied with instances of `http.IncomingMessage`and `http.ServerResponse`, here they are called `res` and `req`.
   1. **The client request**, the `req` instance can then investigate what headers and data has been sent as part of the client's request.
   1. **The server response**, it's up to the server to construct a response by instructing the `res` object with what data and response headers it should answer back with.
1. **Start listening to requests**, the server created from the call to `createServer()` can then be listened to by invoking the method `listen()` while specifying a port. This means the server is now ready to accept client requests.

## Streams

The way data is transported back and forth is by using something called streams. It means data is sent little by little from client to server and little by little from server to client. This is so the server is capable of handling many concurrent requests.

Streams are not a Node.js concept but rather an Operating system concept. The way *streaming* is implemented in the http module is by having classes that are streams. A stream is fundamental data structure in Node.js that can read and write data and send and receive messages, or *events*.

The `req` and `res` parameters from the example you saw above are streams. Where you to listen to incoming data from a client request you would use the method `on()`, like so:

```javascript
req.on('data', (chunk) => {
  console.log('You received a chunk of data', chunk)
})
```

Conversely the way data is sent back to the client is by data being placed in the response stream `res` by invoking the `end()` method like so:

```javascript
res.end('some data')
```

Streams are somewhat of a complicated topic and most web frameworks that sit on top of the http module tries to abstract away this concept. Which brings us to the next topic, the framework Express.

## Express

So far you've been educated on the capabilities of the http module in Node.js. It's a perfectly valid choice for smaller web applications. As soon as applications grows big comes the need to be able to architect your application in a scalable way. Sometimes a framework can help with that. Additionally, once you've built a few web applications you'll notice how you seem to solve the same problems over and over again. Problems like route management, authentication and authorization, error management and more. When you come to this point you start looking for a library or framework that addresses or some or all of these problems.

Why should you go with Express as framework for your next app?

- **Great features**, Express has a set of features that makes you as a developer fast and productive
- **Abstracts away complexity**, Express abstracts away complicated concepts like Streams for example and thereby makes the whole development experience a lot easier.
- **Solves common Web problems**, Express helps you with common problems such as route management, caching, redirection and more.
- **Trusted by millions of developers**, according to GitHUb 6.8 million developers are currently using Express for their web applications. This implies that there are many developers invested in its success.

### Route management in Express

How does Express help us with route management and HTTP verbs? The Express framework has dedicated methods for handling both different HTTP Verbs but also a smart system for associating different routes with different pieces of your code. Consider the below code example:

```javascript
app.get('/products', (req, res) => {
  // handle the request
})
```

Note above how the `get()` method is used. This means that Express helps you handle requests that are not only aimed towards a route with address `/products` but also with HTTP Verb GET. Express has dedicated methods for all HTTP Verbs. That means Express sees a POST towards `/products` as different from a GET towards `/products`, as shown in the below code example:

```javascript
app.get('/products', (req, res) => {
  // handle the request
})

app.post('/products', (req, res) => {
  // handle the request
})
```

GET means that a user wants to read data and POST that they want to write data. Dividing your app up so different route, verb pairings executes different pieces of code therefore makes sense.

## Create an Express application

To start developing a Node.js application using Express framework you need to install it as a dependency. It's also recommended that you first initialize a Node.js project so that any downloaded dependencies end up the `package.json` file. This is a general recommendation for any apps developed for the Node.js runtime. The benefits of doing so comes when pushing the code to a repository like GitHub. Anyone fetching the code from GitHub could easily use the code you write by first installing it's dependencies.  

### Steps

There are steps involved when creating a web application using the Express framework. Those are:

1. **Instantiate the app**, this involves creating an web application instance. At this point it's not runnable but you have something you can extend.
1. **Route definitions**, a route is a part of URL. For example in the URL `http://localhost:8000/products`. The route part is the `/products`. Express has the concept of thinking in routes and the different routes should execute different pieces of code. This is the step where you would define what routes the application should listen to. Other examples of routes are  `/`, also known as the default route and `/orders`. Routes is a concept that will be explored further in the upcoming routes unit in this module.
1. **Configure middleware**, middleware is a piece of code that can before or after a request and can be used to handling things like authentication/authorization or adding a capability to your app.
1. **Start the app**, to start the app you define a port and instruct it to listen to that port. Now the app is ready to receive requests.
