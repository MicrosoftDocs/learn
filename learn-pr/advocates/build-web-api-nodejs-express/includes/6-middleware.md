When a request reaches a web application, there might be a few things you need to do with it. Things like verifying that the user is logged in or that they are permitted to see this particular resource for example. 

Think of handling a request as a series of steps. Let's say you have a request where the user needs to be logged in to handle a resource. The steps might then need to look like in the following way:

1. **Pre request**: here you could investigate whether the user sent the proper credentials through a request header. If the credentials *checks out*, send the request to the next step.
1. **Construct the response**: this step would involve talking to some kind of data source that could be a database or an endpoint for example. This step ends with returning the resource, providing the request asks for the resource in a correct way.
1. **Post request**: there might be an optional step here where you run a piece of code after the request has been handled. The reason to do so could be for logging purposes for example.

The Express framework has built-in support for handling a request in this fashion. It has different methods for handling the request or running a pre or post request.  

To run a pre or post request you would utilize the `use()` method on your express instantiated object. A pre or post request in Express is known as a *middleware* and has the following shape:

```javascript
app.use((req, res, next) => {})
```

Note above how the method passed into `use()` has three parameters `req`, `res`, and `next`. The parameters have the following meaning:

- `req`: this parameter is the incoming request. It contains request headers, the calling URL, and optionally a body of data if the client sent some data with their request
- `res`: this parameter is a response stream, you will use this stream and write information to it like headers and data that you want to send back to the calling client.
- `next`: this parameter is a method that when called signals that the request is ok and that you are ready to process the request. If this method `next()` is not called in a middleware, any processing of the request is stopped there. If you do not call the method, it's good practice to communicate back to the client why the request can no longer be processed. You could do that by calling `res.send('<specify a reason why the request is stopped>')`

### A request pipeline

The way to set up middleware is by identifying whether you have routes that for some reason could benefit from having middleware run pre or post a request. Then you would set it up so that middleware that needs to be run before the request would be defined before the actual request and post request middleware would be defined after. Consider the below code example that does just that:  

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

It's also possible to run pre request middleware code as an argument to the request handling like so:

```javascript
app.get(
  '/<some route>',
 () => {
   // pre request middleware
 }, () => {
   // handling the actual request
 })
```
