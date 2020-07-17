As you learned in the previous section, Node.js is a wrapper around a JavaScript engine called V8. This means that Node.js is a  "JavaScript runtime". It can interpret and run JavaScript code outside the browser, on the host machine.
This means that Node.js has direct access to the operating system I/O, filesystem, network, etc. But how does Node.js handle incoming tasks? Let's find out.

Node.js is based on a "single threaded event loop model" architecture, which allows Node.js to handle multiple concurrent operations (operations that can be executed at nearly the same time) in an efficient way:

- single threaded: JavaScript has only one call stack and can do only one thing at a time.
- event loop: executes the code, collect and process events, and execute the next subtasks from the event queue.

A "thread" is a single sequence of programmed instructions that can be managed independently by the operating system.

I/O operations in Node.js, such as reading or writing to a file on the disk, or doing a network call to a remote server, are "blocking operations". A blocking operation would block all the subsequent tasks. When the operation is finished, then the next one can proceed.

A non-blocking model would mean that we can execute multiple I/O operations at the same time. This is made possible thanks to the event loop.

The name "event loop" is simply a way to describe the implementation of the "busy-waiting" mechanism that waits synchronously for a message to arrive and process it. We could illustrate such an implementation as follow:

```js
while (queue.wait()) {
  queue.process();
}
```

In Node, concurrency refers to the ability of the event loop to perform JavaScript callback functions after other work has been completed.

## Node.js architecture

Node.js uses the event-driven architecture: it has an event loop for orchestration and a worker pool for blocking tasks. The event loop is what enables Node.js to handle concurrent operations. Here is a high-level diagram illustrating how an event loop works under the hood:

:::image type="content" source="../media/event-loop.svg" alt-text="Node.js event loop diagram":::

Main phases overview:

- **Timers:** processes callbacks scheduled by `setTimeout()` and `setInterval()`.
- **Callbacks:** this is where pending callbacks are executed.
- **Poll:** retrieve incoming I/O events and execute I/O related callbacks.
- **Check:** allows callbacks to be executed immediately after the poll phase has completed.
- **Close callbacks:** close events (for example, `socket.destroy()`) and callbacks (for example, `socket.on('close', ...)`).

Node.js uses the Worker Pool to handle blocking tasks. This includes blocking I/O operations, as well as CPU-intensive tasks.

In summary, the event loop executes the JavaScript callbacks registered for events, and is also responsible for fulfilling non-blocking asynchronous requests like network I/O.

### Performance

Thanks to performance boosts made possible by V8, JavaScript is now capable of producing the same performance results as the low-level languages such as C. In addition, Node.js takes advantage of the unique event-driven nature of JavaScript. This makes composing server tasks fast and performant.

### Asynchronous programming

In order to support the powerful event-based programming model, Node has a built-in set of non-blocking I/O APIs (provided by the libuv library) to deal with common tasks such as filesystem or database manipulation: When you request Node to read some file content from disk, Node doesn't block waiting for the disk and the file descriptors to be ready; instead, the non-blocking I/O interface notifies Node when the file is ready. This non-blocking I/O works the same way when the browser notifies your code when a mouse or keyboard event has been triggered or when an XHR response has been received from a remote endpoint.

:::image type="content" source="../media/architecture.svg" alt-text="Node.js high-level architecture":::

## Install and use Node.js

There are many ways to install Node.js. Here are a few of the most common options:

- Install via executable, `https://nodejs.org/en/download/`. Here you can find different installation packages for your Operating System.
- Install via Brew, Brew is a popular package manager for Linux and Mac.
- Install via NVM, NVM stands for Node Version Manager. NVM will not only help you install a desired version of Node.js but help you manage your installation. We will not cover this option in this section.

Above you have three great options for install Node.js on your system. Let's now delve into more detail on what the required steps are to download it but also install it and verify that everything went well.

### Install via executable

Here's an excerpt from the Install page found at `https://nodejs.org/en/download/`

:::image type="content" source="../media/install-page.png" alt-text="Node.js install page":::

As you can see above there are various installers available to cater to different OSs like Windows, Mac and Linux. There's even source code available. What it also shows is how there are two different versions LTS and Current. What's that and which one should you choose?

- `LTS`, LTS stands for **L**ong-**T**erm **S**upport. Worth noting is how it comes with the description text `Recommended for most users`. LTS is meant for enterprise usage where frequent updates might not be possible or for various reasons are undesired.

- Current, this means it's under active development. Feature additions as well as breaking changes might happen. It should adhere to semantic versioning.

So which one to go with? Well you know your company best. Can you update often and is there a desired feature in the Current version you need - then Current version might be for you.

To learn more about the different release types read the *Release types* section in the Summary page.

### Install via package manager Brew

If you don't have Brew installed, then run this command in your Mac/Linux terminal:

```bash
/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install.sh)"
```

Once you have Brew installed, you can type the following command in your terminal to get the installation started:

```bash
brew install node
```

This will download all the needed binaries and also install Node.js on your system.

### Verify installation

Once Node.js has finished installing, we can verify that everything is ok. One command we can run in our terminal is this command:

```bash
node --version
```

It should print out the current version in the following format:

```bash
v[major version].[minor version].[patch version]
```

The brackets `[]` above are to indicate that results may vary depending on what version you have installed on your system.
