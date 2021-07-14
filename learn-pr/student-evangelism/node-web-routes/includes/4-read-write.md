So far you've seen examples of requests made toward a web application when the client wants to read data. It roughly looks like this using the **get()** method:

```javascript
app.get('/<path>', (req, res) => {
  // handling the request
})
```

To handle a client sending data to the web application, configure Express differently depending on the format of the incoming data. For example, data from an HTML form, or data in JSON format. These are common steps, regardless of the data format:

1. Import the library **body-parser** (it's installed with Express):

   ```javascript
   let bodyParser = require('body-parser');
   ```

1. Configure Express to parse the incoming data:

   ```javascript
   app.use(bodyParser.json({ extended: false }));
   ```

   The **bodyParser()** function is passed to the Express instance by calling **app.use()**. The **bodyParser** function also calls **.json()** to determine how the incoming data is parsed. In this case, it's parsed as JSON, but can be parsed to some other format. The **bodyParser** function listens to the incoming data while it's being streamed, a few bytes at a time. Once data is transmitted, it's placed on the **body** property of the request object.
1. To handle an incoming request, use either the **post** or **put()** method on the Express instance.  Both methods work, but **post()** is used to express that you want to create a resource. The **put()** method is used to convey that a resource should be updated using the incoming data. Here's an example:

   ```javascript
   app.post('/<path>', (req, res) => {
     console.log('req.body', req.body) // contains incoming data
   })
   ```
