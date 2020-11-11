In some cases, when a request reaches a web application, you might need to verify that the user is logged in or that they are allowed to see the particular resource.

## Request steps

Think of handling a request as a series of steps. If the user needs to be logged in to handle a resource, the steps might look like this:

1. **Pre request**: Investigate whether the user sent the proper credentials through a request header. If the credentials are verified, send the request to the next step.
1. **Construct the response**: Talk to some kind of data source, like a database or an endpoint. This step returns the resource, as long as the request asks for the resource correctly.
1. **Post request**: This is an optional step to run a piece of code after the request is handled. You might run this step for logging purposes.

The Express framework has built-in support for handling a request in this way. To run a pre or post request, implement the **use()** method on your Express instantiated object. A pre or post request in Express is known as a *middleware*, and has the following shape:

```javascript
app.use((req, res, next) => {})
```

The method passed into **use()** has three parameters, **req**, **res**, and **next**. The parameters have the following meanings:

- **req**: This parameter is the incoming request. It contains request headers and the calling URL. It might also have a body of data if the client sent data with their request.
- **res**: This parameter is a response stream. Use this stream to write information such as headers and data that you want to send back to the calling client.
- **next**: This parameter signals that the request is OK and that you are ready to process it. If **next()** isn't called, processing of the request stops. Also, it's good practice to tell the client why the request is not processed. For example, call **res.send('<specify a reason why the request is stopped>')**.

## Request pipeline

If you have routes that could benefit from having middleware run pre or post a request, set it up so that:

1. Middleware that needs to run before the request (pre request) is defined before the actual request.
1. Middleware that needs to run after the request (post request) is defined after the actual request.

Take a look at this example:

```javascript
app.use((req, res, next) => {
  // pre request
})
app.get('/protected-resource', () => {
  // handling the actual request
})
app.use((req, res, next) => {
  // post request
})

app.get('/login', () => {})
```

You can also run pre request middleware code as an argument to the request handling, like this:

```javascript
app.get(
  '/<some route>',
 () => {
   // pre request middleware
 }, () => {
   // handling the actual request
 })
```
