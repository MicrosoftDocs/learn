In this exercise we will learn how to

- Work with readable and writable streams
- Learn how to work with File streaming
- Discover how you can work with File Streams and HTTP Streams together

## Work with readable and writable streams

In this exercise, we will learn how we can work with readable and writable streams.

Start by creating a file for your application, suggestion is to call it `app.js`. Thereafter add the following to the top of your file:

```javascript
const Stream = require('stream')
```

Now add the following to create a Readable stream:

```javascript
const readableStream = new Stream.Readable()
```

Next, we need to implement the property `_read` on our `readableStream`, like so:

```javascript
readableStream._read = () => {}
```

Follow this up by pushing some data to our stream, like so:

```javascript
readableStream.push('some data');
```

NOTE, because this is readable stream, everything we push into it will be buffered.

To read data from the stream, we have two options:

1. Listen to the `readable` event
2. Connect the readable stream to a writable stream using the method `pipe()`

### Listen to the `readable` event

Add the following code:

```javascript
let times = 0;
readableStream.on('readable', () => {
  times++;
  console.log(`${times} Data: ${readableStream.read()}`)
});

setTimeout(() => {
  readableStream.push('even more data');
}, 500);
```

Now run this code with the following command:

```bash
node <name of your app file>.js
```

This should produce the following output

```bash
1 Data: some data
2 Data: even more data
```

### Connect the readable stream to a writable stream

For this we will need to do the following:

1. Create a writable stream
2. Implement the `_write` property
3. Connect the readable stream to the writable stream

```javascript
const writeableStream = new Stream.Writable();
```

Now implement the `_write` property on the `writableStream` instance:

```javascript
writeableStream._write = (chunk, encoding, next) => {
  console.log(`Write: ${chunk.toString()}`)
  next()
}
```

Lastly connect the two streams:

```javascript
readableStream.pipe(writeableStream)
```

Now run this code with the following command:

```bash
node <name of your app file>.js
```

This should produce the following output

```bash
Write: some data
1 Data: some datas
Write: even more data
2 Data: even more data
```

## Learn how to work with File streaming

In this exercise, we are looking to learn how to read a file using the stream API and also control how many bytes are read.

Prerequisites:

1. Create an application file, suggestion is to name it `app-file-streaming.js`
2. Create a file in the same directory and call it `orders.csv`. Give it the following content:

```bash
1 420 Joe
2 120 Lisa
```

Now add the following code at the top:

```javascript
const fs = require('fs');
```

Next, add the following code to create a file stream:

```javascript
const readStream = fs.createReadStream('orders.csv', {
  encoding: 'utf8',
  highWaterMark: 10
})
```

Let's explain what we are doing above. We are opening a file `orders.csv`. Additionally we are setting the encoding `utf8`. Finally, we are setting a property `highWaterMark`, this property decided how many bytes we read in per read. We will change this value in this exercise so you will be able to see the difference.

Next we need to listen to the event `data`, like so:

```javascript
readStream.on('data', (data) => {
  console.log(`${++times}: ${data}`)
})
```

This will ensure we log out every time the file stream presents new data. Lastly we will listen to the event `close`. It's always nice if we an feed back to the user when we are done:

```javascript
readStream.on('close', () => {
  console.log('finished reading file')
})
```

Now run this code with the following command:

```bash
node <name of your app file>.js
```

This should produce the following output

```bash
1: 1 420 Joe
2: 2 120 Lisa
finished reading file
```

### Change `highWaterMark`

At this point, we have explicitly set our `highWaterMark` to 10 bytes per read. Let's not set it and see what happens. Set that part of the code to:

```javascript
const readStream = fs.createReadStream('orders.csv', {
  encoding: 'utf8'
})
```

Now run this code with the following command:

```bash
node <name of your app file>.js
```

This should produce the following output

```bash
1: 1 420 Joe
2 120 Lisa
finished reading file
```

Observe how we are able to read the entire file in one read. This is because the default value of `highWaterMark` is 16 bytes.  

### Key takeaway

So why are we doing this? Well we know that streaming is better technology over just reading the file, so when will we notice this? The answer is at around 16 MB the streaming version of reading a file will outperform a file read in terms of both speed but also memory consumption:

![Graph showing when stream is paying off](https://miro.medium.com/max/1200/1*cbwiLw312iZxrC7lO7nlrw.png)

All credit to the following article [Read file vs Streams article](https://medium.com/@dalaidunc/fs-readfile-vs-streams-to-read-text-files-in-node-js-5dd0710c80ea)

## Working with Streams and HTTP

In this exercise, we will create an HTTP Server and serve up a file.

Prerequisites

- Create a directory `static` with the following content:

```bash
file.txt
image.jpg
```

NOTE, you can take any image file and name it `image.jpg`.

- Create an application file where our app will live

Now add the following code to our application file:

```javascript
var http = require('http');
var fs = require('fs');
var path = require('path');

http.createServer(function (req, res) {
  
  // constructing a url
  var filename = path.join( __dirname, 'static', req.url);

  var readStream = fs.createReadStream(filename);

  // This will wait until we know the readable stream is actually valid before piping
  readStream.on('open', function () {
    readStream.pipe(res);
  });

  readStream.on('error', function (err) {
    res.end(err);
  });
}).listen(8080);
```

Above we are creating an HTTP server by invoking `createServer()` and giving it a callback. Then we construct a `filename` by combining `__dirname`, our subdirectory `static`, and the request URL `req.url`:

```javascript
var filename = path.join( __dirname, 'static', req.url);
```

Next, we are creating a read stream:

```javascript
var readStream = fs.createReadStream(filename);
```

After that we are listening to the event `open`. The only thing we are doing in there is to connect our file stream `readStream` with our response stream `res`, like so:

```javascript
readStream.on('open', function () {
  readStream.pipe(res);
});
```

Finally we are setting up an error handler like so:

```javascript
readStream.on('error', function (err) {
  res.end(err);
});
```

Now run this code with the following command:

```bash
node <name of your app file>.js
```

Go to your browser at `http://localhost:8080/file.txt`. It should display the file content of `file.txt`.

This will only work for text files though. The reason is that the response header is set to text format. We can easily change that by adding the following code at the top of our callback to:

```javascript
res.writeHead(200, {
  'Content-Type': 'image/jpeg'
});
```

Now run this code with the following command:

```bash
node <name of your app file>.js
```

Go to your browser at `http://localhost:8080/image.jpg`. It should display your image file `image.jpg`.

### Summary

We can easily connect a file stream to an HTTP stream. This will make your web server more responsive. Just ensure that you are able to serve up different content by setting the correct header on the response.
