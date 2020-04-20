In this exercise you'll learn how to

- Work with readable and writable streams
- Learn how to work with File streaming
- Discover how you can work with File Streams and HTTP Streams together

## Work with readable and writable streams

In this exercise, you'll learn how we can work with readable and writable streams.

Start by creating a file for your application, suggestion is to call it `app.js`. Thereafter add the following to the top of your file:

```javascript
const Stream = require('stream')
```

Now add the following to create a Readable stream:

```javascript
const readableStream = new Stream.Readable()
```

Next, implement the property `_read` on the `readableStream`, like so:

```javascript
readableStream._read = () => {}
```

Follow this up by pushing some data to our stream, like so:

```javascript
readableStream.push('some data');
```

NOTE, because this is readable stream, everything you push into it will be buffered.

To read data from the stream, you have two options:

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

Do the following the connect the readable and writeable streams:

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

In this exercise, you'll learn how to read a file using the stream API and also control how many bytes are read.

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

You just told Node.js to open the file `orders.csv`. Additionally you're setting the encoding `utf8`. Finally, you're setting a property `highWaterMark`, this property decided how many bytes you read in per read. You'll change this value in this exercise so you'll be able to see the difference.

Next listen to the event `data`, like so:

```javascript
readStream.on('data', (data) => {
  console.log(`${++times}: ${data}`)
})
```

This will ensure we log out every time the file stream presents new data. Lastly you'll listen to the event `close`. It's always nice if you add feedback to the user when you're done:

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

At this point, you explicitly set `highWaterMark` to 10 bytes per read. Now see what happens if you do not set it. Set that part of the code to:

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

Observe how you can read the entire file in one read. This is because the default value of `highWaterMark` is 16 bytes.  

### Key takeaway

So why are you doing this? Streaming is a better choice than reading the file, but when will you notice this? The answer is at around 16 MB the streaming version of reading a file will outperform a file read in terms of both speed but also memory consumption:

![Graph showing when stream is paying off](https://miro.medium.com/max/1200/1*cbwiLw312iZxrC7lO7nlrw.png)

Credit to the following article [Read file vs Streams article](https://medium.com/@dalaidunc/fs-readfile-vs-streams-to-read-text-files-in-node-js-5dd0710c80ea)

## Working with Streams and HTTP

In this exercise, you'll create an HTTP Server and serve a file.

Prerequisites

- Create a directory `static` with the following content:

```bash
file.txt
image.jpg
```

NOTE, you can take any image file and name it `image.jpg`.

- Create an application file where our app will live

Now add the following code to your application file:

```javascript
const http = require('http');
const fs = require('fs');
const path = require('path');

http.createServer(function (req, res) {
  
  // constructing a url
  const filename = path.join( __dirname, 'static', req.url);

  const readStream = fs.createReadStream(filename);

  // This will wait until we know the readable stream is actually valid before piping
  readStream.on('open', function () {
    readStream.pipe(res);
  });

  readStream.on('error', function (err) {
    res.end(err);
  });
}).listen(8080);
```

Above you're creating an HTTP server by invoking `createServer()` and giving it a callback. Then you construct a `filename` by combining `__dirname`, our subdirectory `static`, and the request URL `req.url`:

```javascript
const  filename = path.join( __dirname, 'static', req.url);
```

After that you're listening to the event `open`. The only thing you're doing in there is to connect your file stream `readStream` with your response stream `res`, like so:

```javascript
readStream.on('open', function () {
  readStream.pipe(res);
});
```

Finally you're setting up an error handler like so:

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

This will only work for text files though. The reason is that the response header is set to text format. You can easily change that by adding the following code at the top of your callback to:

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

You can connect a file stream to an HTTP stream. This will make your web server more responsive. Just ensure that you are able to serve up different content by setting the correct header on the response.
