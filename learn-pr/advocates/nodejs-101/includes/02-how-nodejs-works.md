# How Node.js works

As you might know, Node.js is a JavaScript runtime. It can interpret and run JavaScript code outside the browser, on the host machine.
This means that Node.js has direct access to the operating system I/O, filesystem, network, etc. But how does Node.js handle incoming tasks? Let's find out.

Node.js is based on a "single threaded event loop model" architecture which allows Node.js to handle multiple concurrent operations in a very efficient way:

- single threaded: JavaScript has only one call stack and can do only one thing at a time.
- event loop: executes the code, collect and process events, and execute the next sub-tasks from the event queue.

I/O operations in Node.js, using JavaScript, such as reading or writing to a file on the disk, or doing a network call to a remote server, are considered as blocking operations. This means that an I/O task would block all the subsequent tasks. When the I/O operation is finished, then the next one can proceed.

A non-blocking model would mean that we can execute multiple I/O operations at the same time. This is made possible thanks to the event loop.

Node.js uses the event-driven architecture: it has an event loop for orchestration and a worker pool for blocking tasks. The event loop is what enables Node.js to handle concurrent operations. Here is a high level diagram illustrating how an event loop works under the hood:

:::image type="content" source="../media/node-js-event-loop.png" alt-text="Node.js event loop diagram":::

Main phases overview:

- **Timers:** this phase processes callbacks scheduled by `setTimeout()` and `setInterval()`.
- **Callbacks:** this is where pending callbacks are executed.
- **Poll:** retrieve incoming I/O events and execute I/O related callbacks.
- **Check:** this allows callbacks to be executed immediately after the poll phase has completed.
- **Close callbacks:** close events, e.g. `socket.destroy()` and callbacks, e.g. `socket.on('close', ...)`.

Node.js uses the Worker Pool to handle blocking tasks. This includes blocking I/O operation, as well as CPU-intensive tasks.

In summary, the event loop executes the JavaScript callbacks registered for events, and is also responsible for fulfilling non-blocking asynchronous requests like network I/O.
