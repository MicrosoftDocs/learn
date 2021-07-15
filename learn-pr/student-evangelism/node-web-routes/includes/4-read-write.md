So far you've seen examples of requests made toward a web application when the client wants to read data. However, you are likely to want to write data as well.  To write data, you want to use an HTTP verb that matches your intention. You also need to know that incoming data can come in various forms, so you need to configure your Express application to match how the data arrives to your app.

```javascript
app.get('/<path>', (req, res) => {
  // handling the request
})
```

## Configure your app to receive data

To handle a client sending data to the web application, configure Express differently depending on the format of the incoming data. For example, data from an HTML form, or data in JSON format. These are common steps, regardless of the data format:

> [!NOTE]
> Data is sent through the body of the request.

1. **Import a body parser**. You need to convert the incoming data into a format that's readable. Import the library `body-parser` (it's installed with Express):

   ```javascript
   let bodyParser = require('body-parser');
   ```

1. **Configure data type**. Configure Express to parse the incoming body data into the intended format. Below you are converting the data to JSON:

   ```javascript
   app.use(bodyParser.json({ extended: false }));
   ```

The data sent by a client, is now available on the property `body` on the request object `req`. You can now read this data and talk to a data source and either create a resource from it or update a resource, depending on the request using POST or PUT verb.

## Handle the request data

To handle an incoming request, use either the **post()** or **put()** method on the Express instance.  Both methods work, but **post()** is used to tell Express that you want to create a resource. The **put()** method is used to convey that a resource should be updated using the incoming data. Here's an example:

```javascript
app.post('/<path>', (req, res) => {
  console.log('req.body', req.body) // contains incoming data
})
```
