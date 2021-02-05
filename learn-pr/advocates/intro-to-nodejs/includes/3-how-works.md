As you learned in the previous unit, the Node.js JavaScript runtime is a wrapper around a JavaScript engine called V8. Because Node.js can interpret and run JavaScript code on a host machine outside of a browser, the runtime has direct access to the operating system I/O, file system, and network. This unit explains how Node.js handles incoming tasks.

Node.js is based on a single-threaded event loop. This architecture model efficiently handles concurrent operations. *Concurrency* means the ability of the event loop to perform JavaScript callback functions after completing other work.

In this architecture model:

- *Single-threaded* means that JavaScript has only one call stack and can do only one thing at a time.
- The *event loop* runs the code, collects and processes events, and runs the next subtasks in the event queue.

A *thread* in this context is a single sequence of programmed instructions that the operating system can manage independently.

In Node.js, I/O operations such as reading or writing to a file on the disk, or making a network call to a remote server, are considered blocking operations. A *blocking operation* blocks all subsequent tasks until the operation is finished before the next operation can proceed. In a *non-blocking* model, the event loop can run multiple I/O operations at the same time.

The name *event loop* describes the use of the "busy-waiting" mechanism that waits synchronously for a message to arrive before processing it. The following shows an event loop implementation:

```js
while (queue.wait()) {
  queue.process();
}
```

## Node.js architecture

Node.js uses an event-driven architecture where an event loop handles orchestration and a worker pool blocks tasks. The event loop makes it possible for Node.js to handle concurrent operations. The following diagram illustrates how an event loop works, at a high level:

:::image type="content" source="../media/event-loop.svg" alt-text="Diagram showing how Node.js uses an event-driven architecture where an event loop handles orchestration and a worker pool blocks tasks.":::

The main phases of an event loop are:

- **Timers** processes callbacks scheduled by `setTimeout()` and `setInterval()`.
- **Callbacks** runs pending callbacks.
- **Poll** retrieves incoming I/O events and runs I/O-related callbacks.
- **Check** allows callbacks to be run immediately after the poll phase is completed.
- **Close callbacks** closes events (for example, `socket.destroy()`) and callbacks (for example, `socket.on('close', ...)`).

Node.js uses the worker pool to handle blocking tasks. This includes blocking I/O operations and CPU-intensive tasks.

In summary, the event loop runs the JavaScript callbacks registered for events, and is also responsible for fulfilling non-blocking asynchronous requests like network I/O.

### Performance

JavaScript can produce the same performance results as low-level languages such as C because of performance boosts made possible by the V8 engine. Node.js also takes advantage of the unique event-driven nature of JavaScript. This makes composing server tasks fast and high-performing.

### Asynchronous programming

To support the powerful event-based programming model, Node.js has a built-in set of non-blocking I/O APIs to handle common tasks such as file-system and database manipulation. These APIs are provided by the libuv library. When you make a request for Node.js to read file content from a disk, Node.js doesn't block waiting for the disk and file descriptors to be ready. Instead, the non-blocking I/O interface notifies Node.js when the file is ready. The non-blocking I/O works the same way when the browser notifies your code that a mouse or keyboard event has been triggered, or when an XMLHttpRequest (XHR) response is received from a remote endpoint.

:::image type="content" source="../media/architecture.svg" alt-text="Diagram showing the built-in set of non-blocking I/O APIs that Node.js uses to handle common tasks.":::

## Install and use Node.js

There are many ways to install Node.js. Here are a few of the most common options:

- **Install via executable**: The Node.js **Downloads** page at `https://nodejs.org/en/download/` provides installation packages for different operating systems.
- **Install via Brew**: Brew is a popular package manager for Linux and macOS.
- **Install via NVM**: Node Version Manager (NVM) not only helps you install the version of Node.js you want, but also helps manage your installation. We won't cover this option in this section.

Let's take a more detailed look at the steps required to download and install Node.js and verify successful installation.

### Install via executable

Here's an excerpt from the Install page found at `https://nodejs.org/en/download/`:

:::image type="content" source="../media/install-page.png" alt-text="Screen capture of the Node.js installation page showing available installers and source code.":::

Notice the various installers available for different operating systems like Windows, macOS, and Linux. You can also download two different source code versions:

- **LTS** stands for Long-Term Support. Note that LTS is described as "Recommended for most users." LTS is designed for enterprise usage where frequent updates might not be possible or aren't wanted.

- **Current** means source code that's under active development. Feature additions and breaking changes might happen. The code should adhere to semantic versioning.

Base your choice of version on your company's requirements. For example, if you update often, the Current version might be right for you.

To learn more about the different release types, see [Release types](https://github.com/nodejs/node#release-types).

### Install via the Brew package manager

If you don't have Brew installed, run this command in your macOS/Linux terminal:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

After you've downloaded Brew, type the following command in your terminal to start installation:

```bash
brew install node
```

This downloads all the needed binaries and installs Node.js on your system.

### Verify installation

After installation of Node.js has finished, run the following command in your terminal to verify successful installation:

```bash
node --version
```

The command should print out the current version in the following format:

```bash
v[major version].[minor version].[patch version]
```

The `[]` brackets in this example indicate that results might vary depending on the version you've installed on your system.
