So far, you've seen examples of requests made toward a web application when the client wants to read data. However, you likely want to write data too. 

To write data, use an HTTP verb that matches your intention. Because incoming data can have various forms, configure your Express application to match how the data arrives to your app:

```javascript
app.get('/<path>', (req, res) => {
  // handling the request
})
```

## Configure your app to receive data

To handle a client sending data to the web application, configure Express differently depending on the format of the incoming data. For example, data might be in HTML or JSON format. These are common steps, regardless of the data format.

> [!NOTE]
> Data is sent through the body of the request.

1. **Import a body parser**. You need to convert the incoming data into a format that's readable. Import the `body-parser` library that's installed with Express:

   ```javascript
   let bodyParser = require('body-parser');
   ```

1. **Configure data type**. Configure Express to parse the incoming body data into the intended format. The following code converts the data to JSON:

   ```javascript
   app.use(bodyParser.json({ extended: false }));
   ```

The data that a client sends is now available on the `body` property on the `req` request object. You can now read this data and talk to a data source. You can then either create a resource from that data or update a resource, depending on whether the request uses a POST or a PUT verb.

## Handle the request data

To handle an incoming request, use either the `post()` or the `put()` method on the Express instance. Both methods work, but `post()` tells Express that you want to create a resource. The `put()` method is used to convey that a resource should be updated using the incoming data. Here's an example:

```javascript
app.post('/<path>', (req, res) => {
  console.log('req.body', req.body) // contains incoming data
})
```
