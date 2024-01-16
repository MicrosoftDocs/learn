Tailwind Traders would like to secure their web API. In some cases, when a request reaches a web application, you might need to verify:

* Authentication: who the user is
* Authorization: what the user is allowed to see or do

## Request steps

Think of handling a request as a series of steps. If the user needs to be logged in to handle a resource, the steps might look like this:

1. **Preprocessing**: An optional step to run code before the request is processed. 
    
    An example is to determine that the user sent the proper credentials through a request header. If the credentials are verified, send the request to the next step. If the logging fails, the server returns a 401 HTTP response.
1. **Processing**: Process the request such as talk to some kind of data source, like a database or an API endpoint. 

    This step returns the resource, as long as the request asks for the resource correctly.
1. **Postprocessing**: An optional step to run code after the request is complete. 

    An example is logging the results for monitoring purposes.

The Express framework has built-in support for handling a request in this way. To run a preprocessing or post processing for a request, implement the `use()` method on your Express `app` object with the following syntax form:

```javascript
app.use((req, res, next) => {})
```

The method passed into the `use()` method has the following parameters:

- `req`: The incoming request that contains request headers and the calling URL. It might also have a body of data if the client sent data with their request.
- `res`: A response stream to use for writing information, such as headers and data that you want to send back to the calling client.
- `next`: The _next_ middleware function in the stack. If the `next()` function isn't called, processing of the request stops. If the request succeeded, you may want to call _next()_ to make changes to the response or log the results.

## Request pipeline

If you have routes that benefit from having pre or post processing middleware, set up the functions in the source code file so that:

- Middleware that needs to run before the request (preprocessing) is defined before the actual request.
- Middleware that needs to run after the request (postprocessing) is defined after the actual request.

Take a look at this example:

```javascript
app.use((req, res, next) => {
  // Pre request
})
app.get('/protected-resource', () => {
  // Handle the actual request
})
app.use((req, res, next) => {
  // Post request
})

app.get('/login', () => {})
```

You can also run preprocessing middleware as an argument to the request handler:

```javascript
app.get(
  '/<some route>',
 () => {
   // Pre request middleware
 }, () => {
   // Handle the actual request
 })
```

The order of middleware functions in Express.js is crucial because they're executed sequentially, in the order they're defined in the code. This means that if a middleware function is placed after a route handler, it will not be executed for that route.

## Route management best practices

Here are some best practices to manage the order of middleware functions:

* Place global middleware at the top: Middleware functions that apply to all routes should be placed at the top of your code, before any route handlers. This ensures they're executed for every request.

* Order middleware by specificity: More specific middleware functions should be placed after more general ones. This way, the general middleware functions can handle common tasks for all routes, and the specific ones can handle tasks for specific routes.

* Place error-handling middleware last: Middleware functions with four arguments are treated as error-handling middleware. They should be placed at the end of your middleware stack, after all other middleware and route handlers.

Here's an example:

```javascript
const express = require('express');
const app = express();

// Global middleware
app.use((req, res, next) => {
  console.log('This is a global middleware');
  next();
});

// Route handler
app.get('/', (req, res, next) => {
  console.log('This is a route handler');
  next();
});

// Specific middleware
app.use((req, res, next) => {
  console.log('This is a specific middleware');
  next();
});

// Error-handling middleware
app.use((err, req, res, next) => {
  console.error(err.stack);
  res.status(500).send('Something broke!');
});

app.listen(3000);
```