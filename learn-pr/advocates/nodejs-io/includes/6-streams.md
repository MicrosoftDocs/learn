Streams are a fundamental concept in Node.js. They are a representation of data that flow continuously over time. This makes streams ideal to use when doing I/O operations like reading files, or doing network communication.

## Why streams

You have a construct that expresses that data flows from one point to the next, but why do you need it?

Imagine that you are trying to read a really large file from your disk. What happens if you don't use streams is that entire file is being read into memory before you're shown its content. That's not a great user experience and it also puts a lot of strain on the OS, using up a lot of resources. For network communications using Streams is a must as you need to send data, little by little and report successfully transmitted data as it progresses.

You've therefore identified two major advantages to using streams

- Memory - there's no need to put large amounts of data into memory
- Time - you are able to process the data right away, as it arrives, instead of waiting for the whole operation to finish.

## Streams are everywhere

- Input/ Output, whether you read from the terminal or writing to it, you are dealing with streams in the form of `process.stdin` and `process.stdout`
- File streams, going down the route of using stream for file operations, you can easily create streams using `createReadStream()` and `createWriteStream()`
- HTTP, dealing with HTTP requests, those come in the form of streams, `http.request()` is a stream.

There are many more examples like network connections and working with compression, cryptography and more.

## Stream types

Streams can interact with one another by being *piped*. This means two or more streams gets connected. You can for example connect a file stream to an HTTP stream.

There are four types of streams.

- Readable, you can *push* data into a stream, the data is then buffered until something starts reading from a stream a *Consumer*. A Readable stream can receive data but not send data into it.
- Writeable, you can send data to such a stream but not receive from it
- Duplex, this is a combination of the above two streams and you can send and receive data.
- Transform, this is similar to the Duplex stream but the output is always a transform of the input

## Stream example

Now, to use a stream you need to use the built-in module `stream`, like so:

```javascript
const Stream = require('stream')
```

Next, create a Readable stream, like so:

```javascript
const readableStream = new Stream.Readable()
```

Now, to be able to read from it, you need to either implement `_read`, like so:

```javascript
readableStream._read = () => {}
```

OR

pass in an object, like so:

```javascript
const readableStream = new Stream.Readable({ read() {} })
```

At this point you can start pushing data into the stream, like so:

```javascript
readableStream.push('some data');
```

You now have two ways to read that data:

1. Listen to the `readable` event
2. Connect it to a writeable stream

### Listen to `readable` event

To listen to `readable` we write the following code:

```javascript
readableStream.on('readable', () => {
  console.log(`Content: ${readableStream.read()}`)
})
```

This will read everything from the buffer and you should get a result like this:

```bash
Content: some data
```

### Connect/pipe to a writeable stream

To connect to a writeable stream, go ahead and:

1. Create a Writeable Stream
2. Define the `_write` property
3. Connect/pipe it to the Readable stream

```javascript
const writeableStream = new Stream.Writable();

writeableStream._write = (chunk, encoding, next) => {
  console.log(`Write: ${chunk.toString()}`)
  next()
}

readableStream.pipe(writeableStream)
```

This should produce the following output:

```javascript
Write: some data
```
