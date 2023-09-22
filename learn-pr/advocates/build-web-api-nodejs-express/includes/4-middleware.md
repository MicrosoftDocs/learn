In some cases, when a request reaches a web application, you might need to verify that the user is logged in or that they're allowed to see the particular resource.

## Request steps

Think of handling a request as a series of steps. If the user needs to be logged in to handle a resource, the steps might look like this:

1. **Preprocessing**: An optional step to run code before the request is processed. An example is to determine that the user sent the proper credentials through a request header. If the credentials are verified, send the request to the next step. If the logging fails, the server returns a 401 HTTP response.
1. **Processing**: Process the request such as talk to some kind of data source, like a database or an API endpoint. This step returns the resource, as long as the request asks for the resource correctly.
1. **Postprocessing**: An optional step to run code after the request is complete. An example is logging the results for monitoring purposes.

The Express framework has built-in support for handling a request in this way. To run a preprocessing or post processing for a request, implement the `use()` method on your Express instantiated object. A pre or post processing in Express is known as a *middleware*, and has the following syntax form:

```javascript
app.use((req, res, next) => {})
```

The method passed into the `use()` method has three parameters, `req`, `res`, and `next`. The parameters have the following meanings:

- `req`: The incoming request that contains request headers and the calling URL. It might also have a body of data if the client sent data with their request.
- `res`: A response stream to use for writing information, such as headers and data that you want to send back to the calling client.
- `next`: A parameter that signals the request is OK and is ready to be processed. If the `next()` parameter isn't called, processing of the request stops. Also, it's good practice to tell the client why the request isn't processed, such as call `res.send('\<specify a reason why the request is stopped>'\)`.

## Request pipeline

If you have routes that benefit from having middleware (programmatic functionality), run before or after a request, set it up so that:

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