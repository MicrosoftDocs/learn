This unit explains how Node.js handles incoming tasks to the JavaScript runtime.

## Types of tasks

JavaScript applications have two type of tasks: 

* **Synchronous tasks**: These tasks happen in order. They aren't dependent on another resource to complete. Examples are mathematical operations or string manipulation.
* **Asynchronous**: These tasks may not complete immediately and so they may not happen in order. Examples are network requests or file system operations. 

Because you want your program to run as fast as possible, you want the JavaScript engine to be able to continue working while it waits for a response from an asynchronous operation. In order to do that, it adds the asynchronous task to a task queue and continues working on the next task. 

## Manage task queue with event loop 

Node.js uses the JavaScript engine's event-driven architecture: an event loop manages the queue of tasks. The **event loop** runs the code, collects and processes events, and runs the next subtasks in the event queue.

The following diagram illustrates how an event loop works, at a high level:

:::image type="content" source="../media/event-loop.svg" alt-text="Diagram showing how Node J S uses an event-driven architecture where an event loop handles orchestration and a worker pool blocks tasks.":::

Once a task is in the task queue, it's managed by a worker pool. The worker pool allows the task to complete and then returns the result to the event loop. The event loop then returns the result to the application.

### Performance

Node.js takes advantage of the unique event-driven nature of JavaScript that makes composing server tasks fast and high-performing. JavaScript can produce the same performance results as low-level languages like **C** because of performance boosts made possible by the V8 engine. 

### Asynchronous programming

Because Node.js is an asynchronous-first runtime, Node.js has a built-in set of nonblocking, asynchronous APIs to handle common tasks such as file-system and database interactions. These APIs are nonblocking because they return immediately, allowing the program to continue. When the task is complete, the program is notified and the appropriate callback function is called.

### Callbacks

When Node.js was originally released, asynchronous programming was handled by using callback functions. Callbacks are functions that are passed as arguments to other functions. When the task is complete, the callback function is called.

```javascript
// callback asynchrounous example

const fs = require('fs');
const filePath = './file.txt';

// request to read a file
fs.readFile(filePath, 'utf8', (error, data) => {
    if (error) {
        console.log('An error occurred...: ', error);
    } else {
        console.log(data);
        console.log('Done!');
    }
});
```

Because the execution continues while the file is being read, the `console.log('done')` statement is executed before the file is read.

### Promises

Because nested callbacks can be difficult to manage, Node.js added support for promises. A promise is an object that represents the eventual completion (or failure) of an asynchronous operation. 

The same example using promises looks like this:

```javascript
// promises asynchronous example

const fs = require('fs').promises;
const filePath = './file.txt';

// request to read a file
fs.readFile(filePath, 'utf8')
    .then((data) => {
        console.log(data);
        console.log('Done!');
    })
    .catch((error) => {
        console.log('An error occurred...: ', error);
    });
```

The `then` method is called when the promise is fulfilled and the `catch` method is called when the promise is rejected.

Because the execution continues while the file is being read, the `console.log('done')` statement is executed before the file is read.

### Async/await

Async/await is a newer way to handle asynchronous programming. Async/await is built on top of promises and makes asynchronous code look more like synchronous code.

The same example using async/await looks like this:

```javascript
// async/await asynchronous example

const fs = require('fs').promises;
const filePath = './file.txt';

async function readFileAsync() {
    try {
        // request to read a file
        const data = await fs.readFile(filePath, 'utf8');
        console.log(data);
        console.log('Done!');
    } catch (error) {
        console.log('An error occurred...: ', error);
    }
}

readFileAsync();
```

## Synchronous APIs

Node.js also has a set of synchronous APIs. These APIs block the execution of the program until the task is complete. Synchronous APIs are useful when you want to read a file and then immediately use the data in the file. 

```javascript
// synchronous example

const fs = require('fs');
const filePath = './file.txt';

try {
    // request to read a file
    const data = fs.readFileSync(filePath, 'utf8');
    console.log(data);
    console.log('Done!');
} catch (error) {
    console.log('An error occurred...: ', error);
}
```

The naming convention of JavaScript, as an asynchronous-first language, is that synchronous APIs end with `Sync`. For example, the asynchronous `readFile` API has a synchronous counterpart named `readFileSync`. It's important to uphold this standard in your own projects so your code is easy to read and understand.
