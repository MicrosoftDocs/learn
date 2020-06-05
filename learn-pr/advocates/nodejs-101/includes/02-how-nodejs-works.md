As you might know, Node.js is a JavaScript runtime. It can interpret and run JavaScript code outside the browser, on the host machine.
This means that Node.js has direct access to the operating system I/O, filesystem, network, etc. But how does Node.js handle incoming tasks? Let's find out.

Node.js is based on a "single threaded event loop model" architecture, which allows Node.js to handle multiple concurrent operations in a efficient way:

- single threaded: JavaScript has only one call stack and can do only one thing at a time.
- event loop: executes the code, collect and process events, and execute the next subtasks from the event queue.

I/O operations in Node.js, such as reading or writing to a file on the disk, or doing a network call to a remote server, are considered as blocking operations. This means that an I/O task would block all the subsequent tasks. When the I/O operation is finished, then the next one can proceed.

A non-blocking model would mean that we can execute multiple I/O operations at the same time. This is made possible thanks to the event loop.

Node.js uses the event-driven architecture: it has an event loop for orchestration and a worker pool for blocking tasks. The event loop is what enables Node.js to handle concurrent operations. Here is a high-level diagram illustrating how an event loop works under the hood:

:::image type="content" source="../media/nodejs-event-loop.png" alt-text="Node.js event loop diagram":::

Main phases overview:

- **Timers:** processes callbacks scheduled by `setTimeout()` and `setInterval()`.
- **Callbacks:** this is where pending callbacks are executed.
- **Poll:** retrieve incoming I/O events and execute I/O related callbacks.
- **Check:** allows callbacks to be executed immediately after the poll phase has completed.
- **Close callbacks:** close events (for example, `socket.destroy()`) and callbacks (for example, `socket.on('close', ...)`).

Node.js uses the Worker Pool to handle blocking tasks. This includes blocking I/O operations, as well as CPU-intensive tasks.

In summary, the event loop executes the JavaScript callbacks registered for events, and is also responsible for fulfilling non-blocking asynchronous requests like network I/O.

## Performance

Thanks to V8 and the modern techniques in the Compiler Optimizations space such as [JIT](http://en.wikipedia.org/wiki/Just-in-time_compilation), [Concurrent Speculative Optimization](https://ponyfoo.com/articles/an-introduction-to-speculative-optimization-in-v8), etc. JavaScript, which is considered to be a high-level programming language is now capable of producing the same performance results as the low-level languages such as C. In addition to this performance boost introduced by V8, Node takes advantage of the JavaScript language capabilities: The Event-Driven model. Implementing server-side async tasks has become an easy task thanks to Node and JavaScript.

## Asynchronous programming

In order to support the powerful event-based programming model, Node has a built-in set of non-blocking I/O APIs (provided by the [libuv](https://github.com/libuv/libuv) library) to deal with common tasks such as filesystem or database manipulation: When you request Node to read some file content from disk, Node doesn't block waiting for the disk and the file descriptors to be ready; instead, the non-blocking I/O interface notifies Node when the file is ready. This non-blocking I/O works the same way when the browser notifies your code when a mouse or keyboard event has been triggered or when an XHR response has been received from a remote endpoint.

:::image type="content" source="../media/nodejs-architecture.png" alt-text="Node.js high level architecture":::
